; ModuleID = '../assign2-tests/test12.bc'
source_filename = "test12.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @plus(i32 %name0, i32 %name1) #0 !dbg !7 {
  call void @llvm.dbg.value(metadata i32 %name0, metadata !11, metadata !DIExpression()), !dbg !12
  call void @llvm.dbg.value(metadata i32 %name1, metadata !13, metadata !DIExpression()), !dbg !12
  %name2 = add nsw i32 %name0, %name1, !dbg !14
  ret i32 %name2, !dbg !15
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata %name3, metadata %name4, metadata %name5) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @minus(i32 %name6, i32 %name7) #0 !dbg !16 {
  call void @llvm.dbg.value(metadata i32 %name6, metadata !17, metadata !DIExpression()), !dbg !18
  call void @llvm.dbg.value(metadata i32 %name7, metadata !19, metadata !DIExpression()), !dbg !18
  %name8 = sub nsw i32 %name6, %name7, !dbg !20
  ret i32 %name8, !dbg !21
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 (i32, i32)* @foo(i32 %name9, i32 %name10, i32 (i32, i32)* %name11, i32 (i32, i32)* %name12) #0 !dbg !22 {
  call void @llvm.dbg.value(metadata i32 %name9, metadata !26, metadata !DIExpression()), !dbg !27
  call void @llvm.dbg.value(metadata i32 %name10, metadata !28, metadata !DIExpression()), !dbg !27
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %name11, metadata !29, metadata !DIExpression()), !dbg !27
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %name12, metadata !30, metadata !DIExpression()), !dbg !27
  ret i32 (i32, i32)* %name12, !dbg !31
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @clever(i32 %name13, i32 %name14, i32 (i32, i32)* %name15, i32 (i32, i32)* %name16) #0 !dbg !32 {
  call void @llvm.dbg.value(metadata i32 %name13, metadata !35, metadata !DIExpression()), !dbg !36
  call void @llvm.dbg.value(metadata i32 %name14, metadata !37, metadata !DIExpression()), !dbg !36
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %name15, metadata !38, metadata !DIExpression()), !dbg !36
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %name16, metadata !39, metadata !DIExpression()), !dbg !36
  %name17 = call i32 (i32, i32)* @foo(i32 %name13, i32 %name14, i32 (i32, i32)* %name15, i32 (i32, i32)* %name16), !dbg !40
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %name17, metadata !41, metadata !DIExpression()), !dbg !36
  %name18 = call i32 %name17(i32 %name13, i32 %name14), !dbg !42
  ret i32 %name18, !dbg !43
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @moo(i8 signext %name19, i32 %name20, i32 %name21) #0 !dbg !44 {
  call void @llvm.dbg.value(metadata i8 %name19, metadata !48, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i32 %name20, metadata !50, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i32 %name21, metadata !51, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @plus, metadata !52, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @minus, metadata !53, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i32 (i32, i32)* null, metadata !54, metadata !DIExpression()), !dbg !49
  %name22 = sext i8 %name19 to i32, !dbg !55
  %name23 = icmp eq i32 %name22, 43, !dbg !57
  br i1 %name23, label %1, label %2, !dbg !58

1:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @plus, metadata !54, metadata !DIExpression()), !dbg !49
  br label %5, !dbg !59

2:                                                ; preds = %0
  %name24 = sext i8 %name19 to i32, !dbg !61
  %name25 = icmp eq i32 %name24, 45, !dbg !63
  br i1 %name25, label %3, label %4, !dbg !64

3:                                                ; preds = %2
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @minus, metadata !54, metadata !DIExpression()), !dbg !49
  br label %4, !dbg !65

4:                                                ; preds = %3, %2
  %.0 = phi i32 (i32, i32)* [ @minus, %3 ], [ null, %2 ], !dbg !49
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %.0, metadata !54, metadata !DIExpression()), !dbg !49
  br label %5

5:                                                ; preds = %4, %1
  %.1 = phi i32 (i32, i32)* [ @plus, %1 ], [ %.0, %4 ], !dbg !67
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %.1, metadata !54, metadata !DIExpression()), !dbg !49
  %name26 = call i32 @clever(i32 %name20, i32 %name21, i32 (i32, i32)* @plus, i32 (i32, i32)* %.1), !dbg !68
  call void @llvm.dbg.value(metadata i32 %name26, metadata !69, metadata !DIExpression()), !dbg !49
  ret i32 0, !dbg !71
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata %name27, metadata %name28, metadata %name29) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test12.c", directory: "/home/free/workspace/compiler/assign2/assign2-tests")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 10.0.0-4ubuntu1 "}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 1, type: !8, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 1, type: !10)
!12 = !DILocation(line: 0, scope: !7)
!13 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 1, type: !10)
!14 = !DILocation(line: 2, column: 12, scope: !7)
!15 = !DILocation(line: 2, column: 4, scope: !7)
!16 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 5, type: !8, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!17 = !DILocalVariable(name: "a", arg: 1, scope: !16, file: !1, line: 5, type: !10)
!18 = !DILocation(line: 0, scope: !16)
!19 = !DILocalVariable(name: "b", arg: 2, scope: !16, file: !1, line: 5, type: !10)
!20 = !DILocation(line: 6, column: 12, scope: !16)
!21 = !DILocation(line: 6, column: 4, scope: !16)
!22 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 9, type: !23, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!23 = !DISubroutineType(types: !24)
!24 = !{!25, !10, !10, !25, !25}
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!26 = !DILocalVariable(name: "a", arg: 1, scope: !22, file: !1, line: 9, type: !10)
!27 = !DILocation(line: 0, scope: !22)
!28 = !DILocalVariable(name: "b", arg: 2, scope: !22, file: !1, line: 9, type: !10)
!29 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !22, file: !1, line: 9, type: !25)
!30 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !22, file: !1, line: 9, type: !25)
!31 = !DILocation(line: 10, column: 4, scope: !22)
!32 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 13, type: !33, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!33 = !DISubroutineType(types: !34)
!34 = !{!10, !10, !10, !25, !25}
!35 = !DILocalVariable(name: "a", arg: 1, scope: !32, file: !1, line: 13, type: !10)
!36 = !DILocation(line: 0, scope: !32)
!37 = !DILocalVariable(name: "b", arg: 2, scope: !32, file: !1, line: 13, type: !10)
!38 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !32, file: !1, line: 13, type: !25)
!39 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !32, file: !1, line: 13, type: !25)
!40 = !DILocation(line: 15, column: 13, scope: !32)
!41 = !DILocalVariable(name: "s_fptr", scope: !32, file: !1, line: 14, type: !25)
!42 = !DILocation(line: 16, column: 11, scope: !32)
!43 = !DILocation(line: 16, column: 4, scope: !32)
!44 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 20, type: !45, scopeLine: 20, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!45 = !DISubroutineType(types: !46)
!46 = !{!10, !47, !10, !10}
!47 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!48 = !DILocalVariable(name: "x", arg: 1, scope: !44, file: !1, line: 20, type: !47)
!49 = !DILocation(line: 0, scope: !44)
!50 = !DILocalVariable(name: "op1", arg: 2, scope: !44, file: !1, line: 20, type: !10)
!51 = !DILocalVariable(name: "op2", arg: 3, scope: !44, file: !1, line: 20, type: !10)
!52 = !DILocalVariable(name: "a_fptr", scope: !44, file: !1, line: 21, type: !25)
!53 = !DILocalVariable(name: "s_fptr", scope: !44, file: !1, line: 22, type: !25)
!54 = !DILocalVariable(name: "t_fptr", scope: !44, file: !1, line: 23, type: !25)
!55 = !DILocation(line: 25, column: 9, scope: !56)
!56 = distinct !DILexicalBlock(scope: !44, file: !1, line: 25, column: 9)
!57 = !DILocation(line: 25, column: 11, scope: !56)
!58 = !DILocation(line: 25, column: 9, scope: !44)
!59 = !DILocation(line: 27, column: 5, scope: !60)
!60 = distinct !DILexicalBlock(scope: !56, file: !1, line: 25, column: 19)
!61 = !DILocation(line: 28, column: 14, scope: !62)
!62 = distinct !DILexicalBlock(scope: !56, file: !1, line: 28, column: 14)
!63 = !DILocation(line: 28, column: 16, scope: !62)
!64 = !DILocation(line: 28, column: 14, scope: !56)
!65 = !DILocation(line: 30, column: 5, scope: !66)
!66 = distinct !DILexicalBlock(scope: !62, file: !1, line: 28, column: 24)
!67 = !DILocation(line: 0, scope: !56)
!68 = !DILocation(line: 32, column: 23, scope: !44)
!69 = !DILocalVariable(name: "result", scope: !44, file: !1, line: 32, type: !70)
!70 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!71 = !DILocation(line: 33, column: 5, scope: !44)
