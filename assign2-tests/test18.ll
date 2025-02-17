; ModuleID = '../assign2-tests/test18.bc'
source_filename = "../assign2-tests/test18.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @use() #0 !dbg !7 {
  %name0 = call i32 (...) @clever(), !dbg !11
  ret i32 %name0, !dbg !12
}

declare dso_local i32 @clever(...) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @minus(i32 %name1, i32 %name2) #0 !dbg !13 {
  call void @llvm.dbg.value(metadata i32 %name1, metadata !16, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.value(metadata i32 %name2, metadata !18, metadata !DIExpression()), !dbg !17
  %name3 = sub nsw i32 %name1, %name2, !dbg !19
  ret i32 %name3, !dbg !20
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata %name4, metadata %name5, metadata %name6) #2

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @plus(i32 %name7, i32 %name8) #0 !dbg !21 {
  call void @llvm.dbg.value(metadata i32 %name7, metadata !22, metadata !DIExpression()), !dbg !23
  call void @llvm.dbg.value(metadata i32 %name8, metadata !24, metadata !DIExpression()), !dbg !23
  %name9 = add nsw i32 %name7, %name8, !dbg !25
  ret i32 %name9, !dbg !26
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata %name10, metadata %name11, metadata %name12) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../assign2-tests/test18.c", directory: "/home/free/workspace/compiler/assign2/build")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 10.0.0-4ubuntu1 "}
!7 = distinct !DISubprogram(name: "use", scope: !1, file: !1, line: 6, type: !8, scopeLine: 7, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocation(line: 8, column: 12, scope: !7)
!12 = !DILocation(line: 8, column: 5, scope: !7)
!13 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 10, type: !14, scopeLine: 11, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!14 = !DISubroutineType(types: !15)
!15 = !{!10, !10, !10}
!16 = !DILocalVariable(name: "a", arg: 1, scope: !13, file: !1, line: 10, type: !10)
!17 = !DILocation(line: 0, scope: !13)
!18 = !DILocalVariable(name: "b", arg: 2, scope: !13, file: !1, line: 10, type: !10)
!19 = !DILocation(line: 12, column: 13, scope: !13)
!20 = !DILocation(line: 12, column: 5, scope: !13)
!21 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 14, type: !14, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!22 = !DILocalVariable(name: "a", arg: 1, scope: !21, file: !1, line: 14, type: !10)
!23 = !DILocation(line: 0, scope: !21)
!24 = !DILocalVariable(name: "b", arg: 2, scope: !21, file: !1, line: 14, type: !10)
!25 = !DILocation(line: 16, column: 13, scope: !21)
!26 = !DILocation(line: 16, column: 5, scope: !21)
