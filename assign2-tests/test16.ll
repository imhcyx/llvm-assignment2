; ModuleID = '../assign2-tests/test16.bc'
source_filename = "../assign2-tests/test16.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @clever() #0 !dbg !7 {
  call void @llvm.dbg.value(metadata i32 0, metadata !11, metadata !DIExpression()), !dbg !12
  %name0 = call i32 @plus(i32 0, i32 10), !dbg !13
  %name1 = call i32 @minus(i32 %name0, i32 2), !dbg !14
  call void @llvm.dbg.value(metadata i32 %name1, metadata !11, metadata !DIExpression()), !dbg !12
  %name2 = call i32 @plus(i32 %name1, i32 2), !dbg !15
  %name3 = icmp ne i32 %name2, 0, !dbg !15
  br i1 %name3, label %1, label %2, !dbg !15

1:                                                ; preds = %0
  %name4 = call i32 @minus(i32 6, i32 %name1), !dbg !16
  br label %3, !dbg !15

2:                                                ; preds = %0
  br label %3, !dbg !15

3:                                                ; preds = %2, %1
  %name5 = phi i32 [ %name4, %1 ], [ 0, %2 ], !dbg !15
  call void @llvm.dbg.value(metadata i32 %name5, metadata !11, metadata !DIExpression()), !dbg !12
  ret i32 %name5, !dbg !17
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata %name6, metadata %name7, metadata %name8) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @minus(i32 %name9, i32 %name10) #0 !dbg !18 {
  call void @llvm.dbg.value(metadata i32 %name9, metadata !21, metadata !DIExpression()), !dbg !22
  call void @llvm.dbg.value(metadata i32 %name10, metadata !23, metadata !DIExpression()), !dbg !22
  %name11 = sub nsw i32 %name9, %name10, !dbg !24
  ret i32 %name11, !dbg !25
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @plus(i32 %name12, i32 %name13) #0 !dbg !26 {
  call void @llvm.dbg.value(metadata i32 %name12, metadata !27, metadata !DIExpression()), !dbg !28
  call void @llvm.dbg.value(metadata i32 %name13, metadata !29, metadata !DIExpression()), !dbg !28
  %name14 = add nsw i32 %name12, %name13, !dbg !30
  ret i32 %name14, !dbg !31
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata %name15, metadata %name16, metadata %name17) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../assign2-tests/test16.c", directory: "/home/free/workspace/compiler/assign2/build")
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
!13 = !DILocation(line: 9, column: 13, scope: !7)
!14 = !DILocation(line: 9, column: 7, scope: !7)
!15 = !DILocation(line: 10, column: 7, scope: !7)
!16 = !DILocation(line: 10, column: 17, scope: !7)
!17 = !DILocation(line: 11, column: 5, scope: !7)
!18 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 14, type: !19, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!19 = !DISubroutineType(types: !20)
!20 = !{!10, !10, !10}
!21 = !DILocalVariable(name: "a", arg: 1, scope: !18, file: !1, line: 14, type: !10)
!22 = !DILocation(line: 0, scope: !18)
!23 = !DILocalVariable(name: "b", arg: 2, scope: !18, file: !1, line: 14, type: !10)
!24 = !DILocation(line: 16, column: 13, scope: !18)
!25 = !DILocation(line: 16, column: 5, scope: !18)
!26 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 18, type: !19, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!27 = !DILocalVariable(name: "a", arg: 1, scope: !26, file: !1, line: 18, type: !10)
!28 = !DILocation(line: 0, scope: !26)
!29 = !DILocalVariable(name: "b", arg: 2, scope: !26, file: !1, line: 18, type: !10)
!30 = !DILocation(line: 20, column: 13, scope: !26)
!31 = !DILocation(line: 20, column: 5, scope: !26)
