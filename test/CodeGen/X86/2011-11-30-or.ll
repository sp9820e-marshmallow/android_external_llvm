; RUN: llc < %s -march=x86-64 -mcpu=corei7 | FileCheck %s

target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:128:128-n8:16:32"
target triple = "x86_64-apple-macosx10.6.6"

; Test that the order of operands is correct
; CHECK: select_func
; CHECK: pblendvb        %xmm1, %xmm2
; CHECK: ret

define void @select_func() {
entry:
  %c.lobit.i.i.i = ashr <8 x i16> <i16 17, i16 5, i16 1, i16 15, i16 19, i16 15, i16 4, i16 1> , <i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15>
  %a35 = bitcast <8 x i16> %c.lobit.i.i.i to <2 x i64>
  %and.i56.i.i.i = and <8 x i16> %c.lobit.i.i.i, <i16 25, i16 8, i16 65, i16 25, i16 8, i16 95, i16 15, i16 45>
  %and.i5.i.i.i = bitcast <8 x i16> %and.i56.i.i.i to <2 x i64>
  %neg.i.i.i.i = xor <2 x i64> %a35, <i64 -1, i64 -1>
  %and.i.i.i.i = and <2 x i64> zeroinitializer, %neg.i.i.i.i
  %or.i.i.i.i = or <2 x i64> %and.i.i.i.i, %and.i5.i.i.i
  %a37 = bitcast <2 x i64> %or.i.i.i.i to <8 x i16>
  store <8 x i16> %a37, <8 x i16> addrspace(1)* undef, align 4
  ret void
}

