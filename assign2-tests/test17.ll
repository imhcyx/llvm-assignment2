; ModuleID = '../assign2-tests/test17.bc'
source_filename = "../assign2-tests/test17.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @clever() #0 !dbg !7 {
  call void @llvm.dbg.value(metadata i32 0, metadata !11, metadata !DIExpression()), !dbg !12
  call void @llvm.dbg.value(metadata i32 0, metadata !13, metadata !DIExpression()), !dbg !15
  br label %1, !dbg !16

1:                                                ; preds = %6, %0
  %.01 = phi i32 [ 0, %0 ], [ %name5, %6 ], !dbg !15
  %.0 = phi i32 [ 0, %0 ], [ %.1, %6 ], !dbg !12
  call void @llvm.dbg.value(metadata i32 %.0, metadata !11, metadata !DIExpression()), !dbg !12
  call void @llvm.dbg.value(metadata i32 %.01, metadata !13, metadata !DIExpression()), !dbg !15
  %name0 = icmp slt i32 %.01, 10, !dbg !17
  br i1 %name0, label %2, label %7, !dbg !19

2:                                                ; preds = %1
  %name1 = srem i32 %.01, 2, !dbg !20
  %name2 = icmp ne i32 %name1, 0, !dbg !20
  br i1 %name2, label %3, label %4, !dbg !23

3:                                                ; preds = %2
  %name3 = call i32 @plus(i32 %.0, i32 %.01), !dbg !24
  call void @llvm.dbg.value(metadata i32 %name3, metadata !11, metadata !DIExpression()), !dbg !12
  br label %5, !dbg !25

4:                                                ; preds = %2
  %name4 = call i32 @minus(i32 %.0, i32 %.01), !dbg !26
  call void @llvm.dbg.value(metadata i32 %name4, metadata !11, metadata !DIExpression()), !dbg !12
  br label %5

5:                                                ; preds = %4, %3
  %.1 = phi i32 [ %name3, %3 ], [ %name4, %4 ], !dbg !27
  call void @llvm.dbg.value(metadata i32 %.1, metadata !11, metadata !DIExpression()), !dbg !12
  br label %6, !dbg !28

6:                                                ; preds = %5
  %name5 = add nsw i32 %.01, 1, !dbg !29
  call void @llvm.dbg.value(metadata i32 %name5, metadata !13, metadata !DIExpression()), !dbg !15
  br label %1, !dbg !30, !llvm.loop !31

7:                                                ; preds = %1
  ret i32 %.0, !dbg !33
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata %name6, metadata %name7, metadata %name8) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @plus(i32 %name9, i32 %name10) #0 !dbg !34 {
  call void @llvm.dbg.value(metadata i32 %name9, metadata !37, metadata !DIExpression()), !dbg !38
  call void @llvm.dbg.value(metadata i32 %name10, metadata !39, metadata !DIExpression()), !dbg !38
  %name11 = add nsw i32 %name9, %name10, !dbg !40
  ret i32 %name11, !dbg !41
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @minus(i32 %name12, i32 %name13) #0 !dbg !42 {
  call void @llvm.dbg.value(metadata i32 %name12, metadata !43, metadata !DIExpression()), !dbg !44
  call void @llvm.dbg.value(metadata i32 %name13, metadata !45, metadata !DIExpression()), !dbg !44
  %name14 = sub nsw i32 %name12, %name13, !dbg !46
  ret i32 %name14, !dbg !47
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 ()* %name15) #0 !dbg !48 {
  call void @llvm.dbg.value(metadata i32 ()* %name15, metadata !52, metadata !DIExpression()), !dbg !53
  %name16 = call i32 %name15(), !dbg !54
  ret i32 %name16, !dbg !55
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @moo(i32 (i32 ()*)* %name17, i32 ()* %name18) #0 !dbg !56 {
  call void @llvm.dbg.value(metadata i32 (i32 ()*)* %name17, metadata !60, metadata !DIExpression()), !dbg !61
  call void @llvm.dbg.value(metadata i32 ()* %name18, metadata !62, metadata !DIExpression()), !dbg !61
  %name19 = call i32 %name17(i32 ()* %name18), !dbg !63
  ret i32 %name19, !dbg !64
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @use() #0 !dbg !65 {
  call void @llvm.dbg.value(metadata i32 (i32 (i32 ()*)*, i32 ()*)* @moo, metadata !66, metadata !DIExpression()), !dbg !68
  %name20 = call i32 @moo(i32 (i32 ()*)* @foo, i32 ()* @clever), !dbg !69
  ret i32 %name20, !dbg !70
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata %name21, metadata %name22, metadata %name23) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../assign2-tests/test17.c", directory: "/home/free/workspace/compiler/assign2/build")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 10.0.0-4ubuntu1 "}
!7 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 6, type: !8, scopeLine: 7, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 8, type: !10)
!12 = !DILocation(line: 0, scope: !7)
!13 = !DILocalVariable(name: "i", scope: !14, file: !1, line: 9, type: !10)
!14 = distinct !DILexicalBlock(scope: !7, file: !1, line: 9, column: 5)
!15 = !DILocation(line: 0, scope: !14)
!16 = !DILocation(line: 9, column: 9, scope: !14)
!17 = !DILocation(line: 9, column: 18, scope: !18)
!18 = distinct !DILexicalBlock(scope: !14, file: !1, line: 9, column: 5)
!19 = !DILocation(line: 9, column: 5, scope: !14)
!20 = !DILocation(line: 11, column: 13, scope: !21)
!21 = distinct !DILexicalBlock(scope: !22, file: !1, line: 11, column: 12)
!22 = distinct !DILexicalBlock(scope: !18, file: !1, line: 10, column: 5)
!23 = !DILocation(line: 11, column: 12, scope: !22)
!24 = !DILocation(line: 12, column: 15, scope: !21)
!25 = !DILocation(line: 12, column: 13, scope: !21)
!26 = !DILocation(line: 14, column: 15, scope: !21)
!27 = !DILocation(line: 0, scope: !21)
!28 = !DILocation(line: 15, column: 5, scope: !22)
!29 = !DILocation(line: 9, column: 23, scope: !18)
!30 = !DILocation(line: 9, column: 5, scope: !18)
!31 = distinct !{!31, !19, !32}
!32 = !DILocation(line: 15, column: 5, scope: !14)
!33 = !DILocation(line: 16, column: 5, scope: !7)
!34 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 37, type: !35, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!35 = !DISubroutineType(types: !36)
!36 = !{!10, !10, !10}
!37 = !DILocalVariable(name: "a", arg: 1, scope: !34, file: !1, line: 37, type: !10)
!38 = !DILocation(line: 0, scope: !34)
!39 = !DILocalVariable(name: "b", arg: 2, scope: !34, file: !1, line: 37, type: !10)
!40 = !DILocation(line: 39, column: 13, scope: !34)
!41 = !DILocation(line: 39, column: 5, scope: !34)
!42 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 33, type: !35, scopeLine: 34, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!43 = !DILocalVariable(name: "a", arg: 1, scope: !42, file: !1, line: 33, type: !10)
!44 = !DILocation(line: 0, scope: !42)
!45 = !DILocalVariable(name: "b", arg: 2, scope: !42, file: !1, line: 33, type: !10)
!46 = !DILocation(line: 35, column: 13, scope: !42)
!47 = !DILocation(line: 35, column: 5, scope: !42)
!48 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 18, type: !49, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!49 = !DISubroutineType(types: !50)
!50 = !{!10, !51}
!51 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!52 = !DILocalVariable(name: "pf_ptr", arg: 1, scope: !48, file: !1, line: 18, type: !51)
!53 = !DILocation(line: 0, scope: !48)
!54 = !DILocation(line: 20, column: 12, scope: !48)
!55 = !DILocation(line: 20, column: 5, scope: !48)
!56 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 23, type: !57, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!57 = !DISubroutineType(types: !58)
!58 = !{!10, !59, !51}
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !49, size: 64)
!60 = !DILocalVariable(name: "uf_ptr", arg: 1, scope: !56, file: !1, line: 23, type: !59)
!61 = !DILocation(line: 0, scope: !56)
!62 = !DILocalVariable(name: "pf_ptr", arg: 2, scope: !56, file: !1, line: 23, type: !51)
!63 = !DILocation(line: 25, column: 12, scope: !56)
!64 = !DILocation(line: 25, column: 5, scope: !56)
!65 = distinct !DISubprogram(name: "use", scope: !1, file: !1, line: 27, type: !8, scopeLine: 28, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!66 = !DILocalVariable(name: "uf_ptr", scope: !65, file: !1, line: 29, type: !67)
!67 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !57, size: 64)
!68 = !DILocation(line: 0, scope: !65)
!69 = !DILocation(line: 31, column: 12, scope: !65)
!70 = !DILocation(line: 31, column: 5, scope: !65)
