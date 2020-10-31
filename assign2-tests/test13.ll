; ModuleID = '../assign2-tests/test13.bc'
source_filename = "test13.c"
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
  ret i32 (i32, i32)* %name11, !dbg !31
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 (i32, i32)* @clever(i32 %name13, i32 %name14, i32 (i32, i32)* %name15, i32 (i32, i32)* %name16) #0 !dbg !32 {
  call void @llvm.dbg.value(metadata i32 %name13, metadata !33, metadata !DIExpression()), !dbg !34
  call void @llvm.dbg.value(metadata i32 %name14, metadata !35, metadata !DIExpression()), !dbg !34
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %name15, metadata !36, metadata !DIExpression()), !dbg !34
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %name16, metadata !37, metadata !DIExpression()), !dbg !34
  ret i32 (i32, i32)* %name16, !dbg !38
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @moo(i8 signext %name17, i32 %name18, i32 %name19) #0 !dbg !39 {
  call void @llvm.dbg.value(metadata i8 %name17, metadata !43, metadata !DIExpression()), !dbg !44
  call void @llvm.dbg.value(metadata i32 %name18, metadata !45, metadata !DIExpression()), !dbg !44
  call void @llvm.dbg.value(metadata i32 %name19, metadata !46, metadata !DIExpression()), !dbg !44
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @plus, metadata !47, metadata !DIExpression()), !dbg !44
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @minus, metadata !48, metadata !DIExpression()), !dbg !44
  call void @llvm.dbg.value(metadata i32 (i32, i32)* null, metadata !49, metadata !DIExpression()), !dbg !44
  %name20 = sext i8 %name17 to i32, !dbg !50
  %name21 = icmp eq i32 %name20, 43, !dbg !52
  br i1 %name21, label %1, label %2, !dbg !53

1:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i32 (i32, i32)* (i32, i32, i32 (i32, i32)*, i32 (i32, i32)*)* @foo, metadata !54, metadata !DIExpression()), !dbg !44
  br label %5, !dbg !56

2:                                                ; preds = %0
  %name22 = sext i8 %name17 to i32, !dbg !58
  %name23 = icmp eq i32 %name22, 45, !dbg !60
  br i1 %name23, label %3, label %4, !dbg !61

3:                                                ; preds = %2
  call void @llvm.dbg.value(metadata i32 (i32, i32)* (i32, i32, i32 (i32, i32)*, i32 (i32, i32)*)* @clever, metadata !54, metadata !DIExpression()), !dbg !44
  br label %4, !dbg !62

4:                                                ; preds = %3, %2
  call void @llvm.dbg.value(metadata i32 (i32, i32)* (i32, i32, i32 (i32, i32)*, i32 (i32, i32)*)* @clever, metadata !54, metadata !DIExpression()), !dbg !44
  br label %5

5:                                                ; preds = %4, %1
  %.1 = phi i32 (i32, i32)* (i32, i32, i32 (i32, i32)*, i32 (i32, i32)*)* [ @foo, %1 ], [ @clever, %4 ], !dbg !64
  call void @llvm.dbg.value(metadata i32 (i32, i32)* (i32, i32, i32 (i32, i32)*, i32 (i32, i32)*)* %.1, metadata !54, metadata !DIExpression()), !dbg !44
  %name24 = call i32 (i32, i32)* %.1(i32 %name18, i32 %name19, i32 (i32, i32)* @plus, i32 (i32, i32)* @minus), !dbg !65
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %name24, metadata !49, metadata !DIExpression()), !dbg !44
  %name25 = call i32 %name24(i32 %name18, i32 %name19), !dbg !66
  ret i32 0, !dbg !67
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata %name26, metadata %name27, metadata %name28) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test13.c", directory: "/home/free/workspace/compiler/assign2/assign2-tests")
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
!32 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 13, type: !23, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!33 = !DILocalVariable(name: "a", arg: 1, scope: !32, file: !1, line: 13, type: !10)
!34 = !DILocation(line: 0, scope: !32)
!35 = !DILocalVariable(name: "b", arg: 2, scope: !32, file: !1, line: 13, type: !10)
!36 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !32, file: !1, line: 13, type: !25)
!37 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !32, file: !1, line: 13, type: !25)
!38 = !DILocation(line: 14, column: 4, scope: !32)
!39 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 17, type: !40, scopeLine: 17, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!40 = !DISubroutineType(types: !41)
!41 = !{!10, !42, !10, !10}
!42 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!43 = !DILocalVariable(name: "x", arg: 1, scope: !39, file: !1, line: 17, type: !42)
!44 = !DILocation(line: 0, scope: !39)
!45 = !DILocalVariable(name: "op1", arg: 2, scope: !39, file: !1, line: 17, type: !10)
!46 = !DILocalVariable(name: "op2", arg: 3, scope: !39, file: !1, line: 17, type: !10)
!47 = !DILocalVariable(name: "a_fptr", scope: !39, file: !1, line: 18, type: !25)
!48 = !DILocalVariable(name: "s_fptr", scope: !39, file: !1, line: 19, type: !25)
!49 = !DILocalVariable(name: "t_fptr", scope: !39, file: !1, line: 21, type: !25)
!50 = !DILocation(line: 23, column: 9, scope: !51)
!51 = distinct !DILexicalBlock(scope: !39, file: !1, line: 23, column: 9)
!52 = !DILocation(line: 23, column: 11, scope: !51)
!53 = !DILocation(line: 23, column: 9, scope: !39)
!54 = !DILocalVariable(name: "goo_ptr", scope: !39, file: !1, line: 20, type: !55)
!55 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!56 = !DILocation(line: 25, column: 5, scope: !57)
!57 = distinct !DILexicalBlock(scope: !51, file: !1, line: 23, column: 19)
!58 = !DILocation(line: 26, column: 14, scope: !59)
!59 = distinct !DILexicalBlock(scope: !51, file: !1, line: 26, column: 14)
!60 = !DILocation(line: 26, column: 16, scope: !59)
!61 = !DILocation(line: 26, column: 14, scope: !51)
!62 = !DILocation(line: 28, column: 5, scope: !63)
!63 = distinct !DILexicalBlock(scope: !59, file: !1, line: 26, column: 24)
!64 = !DILocation(line: 0, scope: !51)
!65 = !DILocation(line: 30, column: 14, scope: !39)
!66 = !DILocation(line: 31, column: 5, scope: !39)
!67 = !DILocation(line: 33, column: 5, scope: !39)
