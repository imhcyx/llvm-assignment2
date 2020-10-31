//===- Hello.cpp - Example code from "Writing an LLVM Pass" ---------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements two versions of the LLVM "Hello World" pass described
// in docs/WritingAnLLVMPass.html
//
//===----------------------------------------------------------------------===//

#include <llvm/Support/CommandLine.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/Support/ToolOutputFile.h>

#include <llvm/Transforms/Scalar.h>
#include <llvm/Transforms/Utils.h>

#include <llvm/IR/Function.h>
#include <llvm/IR/Instructions.h>
#include <llvm/Pass.h>
#include <llvm/Support/raw_ostream.h>

#include <llvm/Bitcode/BitcodeReader.h>
#include <llvm/Bitcode/BitcodeWriter.h>

#include <queue>
#include <sstream>

//#define DEBUG_PRINT

using namespace llvm;
static ManagedStatic<LLVMContext> GlobalContext;
static LLVMContext &getGlobalContext() { return *GlobalContext; }
/* In LLVM 5.0, when  -O0 passed to clang , the functions generated with clang will
 * have optnone attribute which would lead to some transform passes disabled, like mem2reg.
 */
struct EnableFunctionOptPass: public FunctionPass {
    static char ID;
    EnableFunctionOptPass():FunctionPass(ID){}
    bool runOnFunction(Function & F) override{
        if(F.hasFnAttribute(Attribute::OptimizeNone))
        {
            F.removeFnAttr(Attribute::OptimizeNone);
        }
        return true;
    }
};

char EnableFunctionOptPass::ID=0;

#ifdef DEBUG_PRINT
// Name unnamed values for debug purpose
struct NameAnonymousValuePass : public ModulePass {
  static char ID; // Pass identification, replacement for typeid
  NameAnonymousValuePass() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    for (Function &F : M) {
      processFunction(F);
    }
    return false;
  }

private:
  unsigned int mNumber = 0;

  void checkAndNameValue(Value &v) {
    if (!v.hasName() && !v.getType()->isVoidTy()) {
      v.setName("name" + std::to_string(mNumber++));
    }
  }

  void processFunction(Function &F) {
    for (Argument &A : F.args()) {
      checkAndNameValue(A);
    }
    for (BasicBlock &BB : F) {
      for (Instruction &I : BB.getInstList()) {
        checkAndNameValue(I);
      }
    }
  }
};

char NameAnonymousValuePass::ID=0;
#endif

// Returns true if a new use is inserted
template <typename KT, typename VT>
bool insertRecordToMap(std::map<KT, std::set<VT>> &map, KT key, VT value) {
  auto it = map.find(key);
  if (it == map.end()) {
    std::set<VT> s = {value};
    map.insert(std::make_pair(key, s));
  }
  else {
    return it->second.insert(value).second;
  }
  return true;
}

#ifdef DEBUG_PRINT
template <typename KT, typename VT>
void dumpMap(std::map<KT, std::set<VT>> &map) {
  for (auto pair : map) {
    if (Value *v = dyn_cast<Value>(pair.first))
      errs() << v->getName() << '\n';
    for (auto val : pair.second)
      if (Value *v = dyn_cast<Value>(val))
        errs() << " -> " << v->getName() << '\n';
  }
}
#endif

///!TODO TO BE COMPLETED BY YOU FOR ASSIGNMENT 2
///Updated 11/10/2017 by fargo: make all functions
///processed by mem2reg before this pass.
struct FuncPtrPass : public ModulePass {
  static char ID; // Pass identification, replacement for typeid
  FuncPtrPass() : ModulePass(ID) {}

  
  bool runOnModule(Module &M) override {

    scanModule(M);
    propagateFunctionUses();
  
  #ifdef DEBUG_PRINT
    errs() << "---------- mUseChains ----------\n";
    dumpMap(mUseChains);
    errs() << "---------- mFuncMap ----------\n";
    dumpMap(mFuncMap);
    errs() << "---------- mReturnMap ----------\n";
    dumpMap(mReturnMap);
    errs() << "---------- mCallMap ----------\n";
    dumpMap(mCallMap);
    errs() << "--------------------\n";
  #endif

    dumpResult();

    return false;
  }

private:
  std::vector<std::pair<unsigned int, Value*>> mCalleeList; // (line number, callee)
  std::map<Value*, std::set<Value*>> mUseChains; // variable -> {user variables}
  std::map<Value*, std::set<Function*>> mFuncMap; // variable -> {possible functions}
  std::map<Function*, std::set<Value*>> mReturnMap; // function -> {return values}
  std::map<Value*, std::set<CallInst*>> mCallMap; // variable -> {calls to this pointer}

  bool insertUse(Value *src, Value *dst) {
    if (Function *f = dyn_cast<Function>(src)) {
      return insertRecordToMap(mFuncMap, dst, f);
    }
    else {
      return insertRecordToMap(mUseChains, src, dst);
    }
  }

  void processInstruction(Instruction *inst) {
    if (PHINode *phi = dyn_cast<PHINode>(inst)) {
      if (phi->getType()->isPointerTy()) {
        for (Value *in : phi->incoming_values()) {
          insertUse(in, phi);
        }
      }
    }

    else if (CallInst *call = dyn_cast<CallInst>(inst)) {
      Value *callee = call->getCalledOperand();
      if (!callee->getName().startswith("llvm.dbg")) {
        mCalleeList.push_back(std::make_pair(inst->getDebugLoc().getLine(), callee));
        if (Function *f = dyn_cast<Function>(callee)) {
          for (unsigned int i = 0; i < call->getNumArgOperands(); i++) {
            Value *arg = call->getArgOperand(i);
            if (arg->getType()->isPointerTy()) {
              insertUse(arg, f->getArg(i));
            }
          }
        }
        else {
          insertRecordToMap(mCallMap, callee, call);
        }
      }
    }

    else if (ReturnInst *ret = dyn_cast<ReturnInst>(inst)) {
      Value *v = ret->getReturnValue();
      if (v->getType()->isPointerTy()) {
        insertRecordToMap(mReturnMap, ret->getFunction(), v);
      }
    }
  }

  void scanModule(Module &M) {
    for (Function &F : M) {
      if (!F.getName().startswith("llvm.dbg")) {
        for (BasicBlock &BB : F) {
          for (BasicBlock::iterator i = BB.begin(); i != BB.end(); ++i) {
            processInstruction(dyn_cast<Instruction>(i));
          }
        }
      }
    }
  }

  void updateUseChainsForCall(std::queue<Value*> &workQ, Value *callee) {
    auto cit = mCallMap.find(callee); // all calls to callee
    auto fit = mFuncMap.find(callee); // possible functions which callee points to
    if (cit != mCallMap.end() && fit != mFuncMap.end()) {
      for (CallInst *call : cit->second) {
        for (Function *f : fit->second) {
          for (unsigned int i = 0; i < call->getNumArgOperands(); i++) {
            Value *arg = call->getArgOperand(i);
            if (arg->getType()->isPointerTy()) {
              if (insertUse(arg, f->getArg(i))) {
                workQ.push(arg); // repropagate if updated
              }
            }
          }
          auto rit = mReturnMap.find(f);
          if (rit != mReturnMap.end()) {
            for (Value *v: rit->second) {
              if (insertUse(v, call)) {
                workQ.push(v); // repropagate if updated
              }
            }
          }
        }
      }
    }
  }

  void propagateFunctionUses() {
    std::queue<Value*> pending;

    // start from initial uses in mFuncMap
    for (auto it : mFuncMap) {
      pending.push(it.first);
    }

    // propagate until all values have been processed
    while (!pending.empty()) {
      Value *var = pending.front();
      pending.pop();
      // try finding indirect calls using this variable
      updateUseChainsForCall(pending, var);
      // propagate from var to newvar according to mUseChains
      auto vit = mUseChains.find(var);
      if (vit != mUseChains.end()) {
        for (Value *newvar : vit->second) {
          bool inserted = false;
          auto fit = mFuncMap.find(var); // fit->second: possible values for var
          if (fit != mFuncMap.end()) {
            for (Function *v : fit->second) {
              inserted |= insertRecordToMap(mFuncMap, newvar, v);
            }
          }
          // if a value is updated, repropagate it
          if (inserted) {
            pending.push(newvar);
          }
        }
      }
    }
  }

  void dumpResult() {
    for (auto callee : mCalleeList) {
      errs() << callee.first << " : ";
      if (isa<Function>(callee.second)) {
        errs() << callee.second->getName();
      }
      else {
        auto it = mFuncMap.find(callee.second);
        if (it != mFuncMap.end()) {
          bool first = true;
          for (Function *v : it->second) {
            if (first) {
              first = false;
            }
            else {
              errs() << ", ";
            }
            errs() << v->getName();
          }
        }
        else {
          errs() << "NULL";
        }
      }
      errs() << '\n';
    }
  }
};


char FuncPtrPass::ID = 0;
static RegisterPass<FuncPtrPass> X("funcptrpass", "Print function call instruction");

static cl::opt<std::string>
InputFilename(cl::Positional,
              cl::desc("<filename>.bc"),
              cl::init(""));


int main(int argc, char **argv) {
   LLVMContext &Context = getGlobalContext();
   SMDiagnostic Err;
   // Parse the command line to read the Inputfilename
   cl::ParseCommandLineOptions(argc, argv,
                              "FuncPtrPass \n My first LLVM too which does not do much.\n");


   // Load the input module
   std::unique_ptr<Module> M = parseIRFile(InputFilename, Err, Context);
   if (!M) {
      Err.print(argv[0], errs());
      return 1;
   }

   llvm::legacy::PassManager Passes;
   	
   ///Remove functions' optnone attribute in LLVM5.0
   Passes.add(new EnableFunctionOptPass());
   ///Transform it to SSA
   Passes.add(llvm::createPromoteMemoryToRegisterPass());

#ifdef DEBUG_PRINT
   Passes.add(new NameAnonymousValuePass());
#endif

   /// Your pass to print Function and Call Instructions
   Passes.add(new FuncPtrPass());
   Passes.run(*M.get());
}

