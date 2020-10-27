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

// Returns true if a new use is inserted
template <typename KT, typename VT>
bool insertUseToMap(std::map<KT, std::set<VT>> &map, KT key, VT value) {
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

///!TODO TO BE COMPLETED BY YOU FOR ASSIGNMENT 2
///Updated 11/10/2017 by fargo: make all functions
///processed by mem2reg before this pass.
struct FuncPtrPass : public ModulePass {
  static char ID; // Pass identification, replacement for typeid
  FuncPtrPass() : ModulePass(ID) {}

  
  bool runOnModule(Module &M) override {
    for (Function &F : M) {
      if (!F.getName().startswith("llvm.dbg")) {
        for (BasicBlock &BB : F) {
          for (BasicBlock::iterator i = BB.begin(); i != BB.end(); ++i) {
            processInstruction(dyn_cast<Instruction>(i));
          }
        }
      }
    }

    propagateFunctionUse();

    for (auto callee : mCalleeList) {
      errs() << callee.first << " : ";
      if (isa<Function>(callee.second)) {
        errs() << callee.second->getName();
      }
      else {
        auto it = mFuncMap.find(callee.second);
        if (it != mFuncMap.end()) {
          bool first = true;
          for (Value *v : it->second) {
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

    return false;
  }

private:
  std::vector<std::pair<unsigned int, Value*>> mCalleeList; // (line number, callee)
  std::map<Value*, std::set<Value*>> mValueMap; // variable -> {user variables}
  std::map<Value*, std::set<Value*>> mFuncMap; // variable -> {possible functions}

  void processInstruction(Instruction *inst) {
    if (PHINode *phi = dyn_cast<PHINode>(inst)) {
      if (phi->getType()->isPointerTy()) {
        for (Value *in : phi->incoming_values()) {
          insertUseToMap(mValueMap, in, cast<Value>(inst));
        }
      }
    }

    else if (CallInst *call = dyn_cast<CallInst>(inst)) {
      Value *callee = call->getCalledOperand();
      if (!callee->getName().startswith("llvm.dbg")) {
        mCalleeList.push_back(std::make_pair(inst->getDebugLoc().getLine(), callee));
        for (unsigned int i = 0; i < call->getNumArgOperands(); i++) {
          Value *arg = call->getArgOperand(i);
          if (arg->getType()->isPointerTy()) {
            Function *f = dyn_cast<Function>(callee);
            // TODO: f is null (multiple possible callee functions)
            insertUseToMap(mValueMap, arg, cast<Value>(f->getArg(i)));
          }
        }
      }
    }

    else if (ReturnInst *ret = dyn_cast<ReturnInst>(inst)) {
      if (ret->getType()->isPointerTy()) {
        Function *f = ret->getFunction();
        // TODO: indirect calls to this function
        for (Value *user : f->users()) {
          insertUseToMap(mValueMap, ret->getReturnValue(), user);
        }
      }
    }
  }

  void propagateFunctionUse() {
    std::queue<Value*> pending;

    // add direct function uses to mFuncMap
    for (auto it : mValueMap) {
      if (isa<Function>(it.first)) {
        for (Value *var : it.second) {
          insertUseToMap(mFuncMap, var, it.first);
        }
      }
    }

    // start from initial uses in mFuncMap
    for (auto it : mFuncMap) {
      pending.push(it.first);
    }

    // propagate until all values have been processed
    while (!pending.empty()) {
      Value *var = pending.front();
      pending.pop();
      auto vit = mValueMap.find(var);
      if (vit != mValueMap.end()) {
        for (Value *newvar : vit->second) {
          bool inserted = false;
          auto fit = mFuncMap.find(var);
          if (fit != mFuncMap.end()) {
            for (Value *v : fit->second) {
              inserted |= insertUseToMap(mFuncMap, newvar, v);
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

   /// Your pass to print Function and Call Instructions
   Passes.add(new FuncPtrPass());
   Passes.run(*M.get());
}

