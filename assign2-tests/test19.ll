; ModuleID = '../assign2-tests/test19.bc'
source_filename = "../assign2-tests/test19.c"
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
define dso_local i32 @foo(i32 %name9, i32 %name10, i32 (i32, i32)* %name11) #0 !dbg !22 {
  call void @llvm.dbg.value(metadata i32 %name9, metadata !26, metadata !DIExpression()), !dbg !27
  call void @llvm.dbg.value(metadata i32 %name10, metadata !28, metadata !DIExpression()), !dbg !27
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %name11, metadata !29, metadata !DIExpression()), !dbg !27
  %name12 = call i32 %name11(i32 %name9, i32 %name10), !dbg !30
  ret i32 %name12, !dbg !31
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @clever() #0 !dbg !32 {
  call void @llvm.dbg.value(metadata i32 (i32, i32, i32 (i32, i32)*)* null, metadata !35, metadata !DIExpression()), !dbg !37
  call void @llvm.dbg.value(metadata i32 (i32, i32)* null, metadata !38, metadata !DIExpression()), !dbg !37
  call void @llvm.dbg.value(metadata i32 (i32, i32, i32 (i32, i32)*)* @foo, metadata !35, metadata !DIExpression()), !dbg !37
  call void @llvm.dbg.value(metadata i32 1, metadata !39, metadata !DIExpression()), !dbg !37
  call void @llvm.dbg.value(metadata i32 2, metadata !40, metadata !DIExpression()), !dbg !37
  %name13 = icmp sgt i32 1, 0, !dbg !41
  br i1 %name13, label %1, label %2, !dbg !43

1:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @plus, metadata !38, metadata !DIExpression()), !dbg !37
  br label %3, !dbg !44

2:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @minus, metadata !38, metadata !DIExpression()), !dbg !37
  br label %3

3:                                                ; preds = %2, %1
  %.0 = phi i32 (i32, i32)* [ @plus, %1 ], [ @minus, %2 ], !dbg !45
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %.0, metadata !38, metadata !DIExpression()), !dbg !37
  %name14 = call i32 @foo(i32 1, i32 2, i32 (i32, i32)* %.0), !dbg !46
  call void @llvm.dbg.value(metadata i32 %name14, metadata !47, metadata !DIExpression()), !dbg !37
  ret i32 0, !dbg !49
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata %name15, metadata %name16, metadata %name17) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../assign2-tests/test19.c", directory: "/home/free/workspace/compiler/assign2/build")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 10.0.0-4ubuntu1 "}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 3, type: !8, scopeLine: 3, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!12 = !DILocation(line: 0, scope: !7)
!13 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 3, type: !10)
!14 = !DILocation(line: 4, column: 12, scope: !7)
!15 = !DILocation(line: 4, column: 4, scope: !7)
!16 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 7, type: !8, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!17 = !DILocalVariable(name: "a", arg: 1, scope: !16, file: !1, line: 7, type: !10)
!18 = !DILocation(line: 0, scope: !16)
!19 = !DILocalVariable(name: "b", arg: 2, scope: !16, file: !1, line: 7, type: !10)
!20 = !DILocation(line: 9, column: 13, scope: !16)
!21 = !DILocation(line: 9, column: 5, scope: !16)
!22 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 12, type: !23, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!23 = !DISubroutineType(types: !24)
!24 = !{!10, !10, !10, !25}
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!26 = !DILocalVariable(name: "a", arg: 1, scope: !22, file: !1, line: 12, type: !10)
!27 = !DILocation(line: 0, scope: !22)
!28 = !DILocalVariable(name: "b", arg: 2, scope: !22, file: !1, line: 12, type: !10)
!29 = !DILocalVariable(name: "fptr", arg: 3, scope: !22, file: !1, line: 12, type: !25)
!30 = !DILocation(line: 14, column: 12, scope: !22)
!31 = !DILocation(line: 14, column: 5, scope: !22)
!32 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 16, type: !33, scopeLine: 16, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!33 = !DISubroutineType(types: !34)
!34 = !{!10}
!35 = !DILocalVariable(name: "af_ptr", scope: !32, file: !1, line: 18, type: !36)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!37 = !DILocation(line: 0, scope: !32)
!38 = !DILocalVariable(name: "pf_ptr", scope: !32, file: !1, line: 19, type: !25)
!39 = !DILocalVariable(name: "op1", scope: !32, file: !1, line: 21, type: !10)
!40 = !DILocalVariable(name: "op2", scope: !32, file: !1, line: 21, type: !10)
!41 = !DILocation(line: 23, column: 13, scope: !42)
!42 = distinct !DILexicalBlock(scope: !32, file: !1, line: 23, column: 9)
!43 = !DILocation(line: 23, column: 9, scope: !32)
!44 = !DILocation(line: 24, column: 9, scope: !42)
!45 = !DILocation(line: 0, scope: !42)
!46 = !DILocation(line: 28, column: 23, scope: !32)
!47 = !DILocalVariable(name: "result", scope: !32, file: !1, line: 28, type: !48)
!48 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!49 = !DILocation(line: 29, column: 5, scope: !32)
