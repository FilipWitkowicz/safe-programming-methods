	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 26, 0	sdk_version 26, 2
	.globl	_foo                            ; -- Begin function foo
	.p2align	2
_foo:                                   ; @foo
	.cfi_startproc
; %bb.0:
	mov	w0, #42                         ; =0x2a
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_thread1                        ; -- Begin function thread1
	.p2align	2
_thread1:                               ; @thread1
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	b	LBB1_1
LBB1_1:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_2 Depth 2
                                        ;     Child Loop BB1_7 Depth 2
	stur	wzr, [x29, #-12]
	b	LBB1_2
LBB1_2:                                 ;   Parent Loop BB1_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	adrp	x8, _run_state@PAGE
	add	x8, x8, _run_state@PAGEOFF
	ldapr	w8, [x8]
	stur	w8, [x29, #-16]
	ldur	w8, [x29, #-16]
	stur	w8, [x29, #-12]
	cbnz	w8, LBB1_4
	b	LBB1_3
LBB1_3:                                 ;   in Loop: Header=BB1_2 Depth=2
	b	LBB1_2
LBB1_4:                                 ;   in Loop: Header=BB1_1 Depth=1
	ldur	w8, [x29, #-12]
	subs	w8, w8, #2
	b.ne	LBB1_6
	b	LBB1_5
LBB1_5:
	b	LBB1_12
LBB1_6:                                 ;   in Loop: Header=BB1_1 Depth=1
	bl	_foo
	stur	w0, [x29, #-20]
	ldur	w8, [x29, #-20]
	adrp	x9, _x@PAGE
	str	w8, [x9, _x@PAGEOFF]
	;MEMBARRIER
	mov	w8, #1                          ; =0x1
	str	w8, [sp, #24]
	ldr	w9, [sp, #24]
	adrp	x10, _f@PAGE
	str	w9, [x10, _f@PAGEOFF]
	str	w8, [sp, #20]
	ldr	w8, [sp, #20]
	adrp	x9, _done_count@PAGE
	add	x9, x9, _done_count@PAGEOFF
	ldaddl	w8, w8, [x9]
	str	w8, [sp, #16]
	b	LBB1_7
LBB1_7:                                 ;   Parent Loop BB1_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	adrp	x8, _run_state@PAGE
	add	x8, x8, _run_state@PAGEOFF
	ldapr	w8, [x8]
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	stur	w8, [x29, #-12]
	subs	w8, w8, #1
	b.ne	LBB1_9
	b	LBB1_8
LBB1_8:                                 ;   in Loop: Header=BB1_7 Depth=2
	b	LBB1_7
LBB1_9:                                 ;   in Loop: Header=BB1_1 Depth=1
	ldur	w8, [x29, #-12]
	subs	w8, w8, #2
	b.ne	LBB1_11
	b	LBB1_10
LBB1_10:
	b	LBB1_12
LBB1_11:                                ;   in Loop: Header=BB1_1 Depth=1
	mov	w8, #1                          ; =0x1
	str	w8, [sp, #8]
	ldr	w8, [sp, #8]
	adrp	x9, _done_count@PAGE
	add	x9, x9, _done_count@PAGEOFF
	ldaddl	w8, w8, [x9]
	str	w8, [sp, #4]
	b	LBB1_1
LBB1_12:
	mov	x0, #0                          ; =0x0
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_thread2                        ; -- Begin function thread2
	.p2align	2
_thread2:                               ; @thread2
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	str	x0, [sp, #56]
	b	LBB2_1
LBB2_1:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_2 Depth 2
                                        ;     Child Loop BB2_7 Depth 2
                                        ;     Child Loop BB2_12 Depth 2
	str	wzr, [sp, #52]
	b	LBB2_2
LBB2_2:                                 ;   Parent Loop BB2_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	adrp	x8, _run_state@PAGE
	add	x8, x8, _run_state@PAGEOFF
	ldapr	w8, [x8]
	str	w8, [sp, #48]
	ldr	w8, [sp, #48]
	str	w8, [sp, #52]
	cbnz	w8, LBB2_4
	b	LBB2_3
LBB2_3:                                 ;   in Loop: Header=BB2_2 Depth=2
	b	LBB2_2
LBB2_4:                                 ;   in Loop: Header=BB2_1 Depth=1
	ldr	w8, [sp, #52]
	subs	w8, w8, #2
	b.ne	LBB2_6
	b	LBB2_5
LBB2_5:
	b	LBB2_17
LBB2_6:                                 ;   in Loop: Header=BB2_1 Depth=1
	b	LBB2_7
LBB2_7:                                 ;   Parent Loop BB2_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	adrp	x8, _f@PAGE
	ldr	w8, [x8, _f@PAGEOFF]
	str	w8, [sp, #44]
	ldr	w8, [sp, #44]
	cbnz	w8, LBB2_9
	b	LBB2_8
LBB2_8:                                 ;   in Loop: Header=BB2_7 Depth=2
	b	LBB2_7
LBB2_9:                                 ;   in Loop: Header=BB2_1 Depth=1
	;MEMBARRIER
	adrp	x8, _x@PAGE
	ldr	w8, [x8, _x@PAGEOFF]
	str	w8, [sp, #40]
	ldr	w8, [sp, #40]
	cbnz	w8, LBB2_11
	b	LBB2_10
LBB2_10:                                ;   in Loop: Header=BB2_1 Depth=1
	mov	x8, #1                          ; =0x1
	str	x8, [sp, #32]
	ldr	x8, [sp, #32]
	adrp	x9, _x_was_zero@PAGE
	add	x9, x9, _x_was_zero@PAGEOFF
	ldadd	x8, x8, [x9]
	str	x8, [sp, #24]
	b	LBB2_11
LBB2_11:                                ;   in Loop: Header=BB2_1 Depth=1
	mov	w8, #1                          ; =0x1
	str	w8, [sp, #20]
	ldr	w8, [sp, #20]
	adrp	x9, _done_count@PAGE
	add	x9, x9, _done_count@PAGEOFF
	ldaddl	w8, w8, [x9]
	str	w8, [sp, #16]
	b	LBB2_12
LBB2_12:                                ;   Parent Loop BB2_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	adrp	x8, _run_state@PAGE
	add	x8, x8, _run_state@PAGEOFF
	ldapr	w8, [x8]
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	str	w8, [sp, #52]
	subs	w8, w8, #1
	b.ne	LBB2_14
	b	LBB2_13
LBB2_13:                                ;   in Loop: Header=BB2_12 Depth=2
	b	LBB2_12
LBB2_14:                                ;   in Loop: Header=BB2_1 Depth=1
	ldr	w8, [sp, #52]
	subs	w8, w8, #2
	b.ne	LBB2_16
	b	LBB2_15
LBB2_15:
	b	LBB2_17
LBB2_16:                                ;   in Loop: Header=BB2_1 Depth=1
	mov	w8, #1                          ; =0x1
	str	w8, [sp, #8]
	ldr	w8, [sp, #8]
	adrp	x9, _done_count@PAGE
	add	x9, x9, _done_count@PAGEOFF
	ldaddl	w8, w8, [x9]
	str	w8, [sp, #4]
	b	LBB2_1
LBB2_17:
	mov	x0, #0                          ; =0x0
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #192
	stp	x29, x30, [sp, #176]            ; 16-byte Folded Spill
	add	x29, sp, #176
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x8, _f@PAGE
	add	x8, x8, _f@PAGEOFF
	adrp	x9, _x@PAGE
	add	x9, x9, _x@PAGEOFF
	subs	x8, x8, x9
	str	x8, [sp, #24]                   ; 8-byte Folded Spill
	stur	wzr, [x29, #-4]
	stur	w0, [x29, #-8]
	stur	x1, [x29, #-16]
	mov	w8, #16960                      ; =0x4240
	movk	w8, #15, lsl #16
	stur	w8, [x29, #-20]
	ldur	w8, [x29, #-8]
	subs	w8, w8, #1
	b.le	LBB3_2
	b	LBB3_1
LBB3_1:
	ldur	x8, [x29, #-16]
	ldr	x0, [x8, #8]
	bl	_atoi
	stur	w0, [x29, #-20]
	b	LBB3_2
LBB3_2:
	adrp	x0, l_.str@PAGE
	add	x0, x0, l_.str@PAGEOFF
	bl	_printf
	ldr	x8, [sp, #24]                   ; 8-byte Folded Reload
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str.1@PAGE
	add	x0, x0, l_.str.1@PAGEOFF
	bl	_printf
	ldur	w8, [x29, #-20]
                                        ; kill: def $x8 killed $w8
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str.2@PAGE
	add	x0, x0, l_.str.2@PAGEOFF
	bl	_printf
	sub	x0, x29, #32
	mov	x3, #0                          ; =0x0
	str	x3, [sp, #16]                   ; 8-byte Folded Spill
	mov	x1, x3
	adrp	x2, _thread1@PAGE
	add	x2, x2, _thread1@PAGEOFF
	bl	_pthread_create
	ldr	x3, [sp, #16]                   ; 8-byte Folded Reload
	sub	x0, x29, #40
	mov	x1, x3
	adrp	x2, _thread2@PAGE
	add	x2, x2, _thread2@PAGEOFF
	bl	_pthread_create
	mov	w0, #6                          ; =0x6
	sub	x1, x29, #56
	bl	_clock_gettime
	stur	wzr, [x29, #-76]
	b	LBB3_3
LBB3_3:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_5 Depth 2
                                        ;     Child Loop BB3_8 Depth 2
	ldur	w8, [x29, #-76]
	ldur	w9, [x29, #-20]
	subs	w8, w8, w9
	b.ge	LBB3_12
	b	LBB3_4
LBB3_4:                                 ;   in Loop: Header=BB3_3 Depth=1
	stur	wzr, [x29, #-80]
	ldur	w8, [x29, #-80]
	adrp	x9, _x@PAGE
	str	w8, [x9, _x@PAGEOFF]
	stur	wzr, [x29, #-84]
	ldur	w8, [x29, #-84]
	adrp	x9, _f@PAGE
	str	w8, [x9, _f@PAGEOFF]
	str	wzr, [sp, #88]
	ldr	w8, [sp, #88]
	adrp	x9, _done_count@PAGE
	str	w8, [x9, _done_count@PAGEOFF]
	mov	w8, #1                          ; =0x1
	str	w8, [sp, #84]
	ldr	w8, [sp, #84]
	adrp	x9, _run_state@PAGE
	add	x9, x9, _run_state@PAGEOFF
	stlr	w8, [x9]
	b	LBB3_5
LBB3_5:                                 ;   Parent Loop BB3_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	adrp	x8, _done_count@PAGE
	add	x8, x8, _done_count@PAGEOFF
	ldapr	w8, [x8]
	str	w8, [sp, #80]
	ldr	w8, [sp, #80]
	subs	w8, w8, #2
	b.eq	LBB3_7
	b	LBB3_6
LBB3_6:                                 ;   in Loop: Header=BB3_5 Depth=2
	b	LBB3_5
LBB3_7:                                 ;   in Loop: Header=BB3_3 Depth=1
	str	wzr, [sp, #76]
	ldr	w8, [sp, #76]
	adrp	x9, _run_state@PAGE
	add	x9, x9, _run_state@PAGEOFF
	stlr	w8, [x9]
	b	LBB3_8
LBB3_8:                                 ;   Parent Loop BB3_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	adrp	x8, _done_count@PAGE
	add	x8, x8, _done_count@PAGEOFF
	ldapr	w8, [x8]
	str	w8, [sp, #72]
	ldr	w8, [sp, #72]
	subs	w8, w8, #4
	b.eq	LBB3_10
	b	LBB3_9
LBB3_9:                                 ;   in Loop: Header=BB3_8 Depth=2
	b	LBB3_8
LBB3_10:                                ;   in Loop: Header=BB3_3 Depth=1
	b	LBB3_11
LBB3_11:                                ;   in Loop: Header=BB3_3 Depth=1
	ldur	w8, [x29, #-76]
	add	w8, w8, #1
	stur	w8, [x29, #-76]
	b	LBB3_3
LBB3_12:
	mov	w0, #6                          ; =0x6
	sub	x1, x29, #72
	bl	_clock_gettime
	mov	w8, #2                          ; =0x2
	str	w8, [sp, #68]
	ldr	w8, [sp, #68]
	adrp	x9, _run_state@PAGE
	add	x9, x9, _run_state@PAGEOFF
	stlr	w8, [x9]
	ldur	x0, [x29, #-32]
	mov	x1, #0                          ; =0x0
	str	x1, [sp, #8]                    ; 8-byte Folded Spill
	bl	_pthread_join
	ldr	x1, [sp, #8]                    ; 8-byte Folded Reload
	ldur	x0, [x29, #-40]
	bl	_pthread_join
	ldur	x8, [x29, #-72]
	ldur	x9, [x29, #-56]
	subs	x8, x8, x9
	scvtf	d0, x8
	ldur	x8, [x29, #-64]
	ldur	x9, [x29, #-48]
	subs	x8, x8, x9
	scvtf	d1, x8
	mov	x8, #225833675390976            ; =0xcd6500000000
	movk	x8, #16845, lsl #48
	fmov	d2, x8
	fdiv	d1, d1, d2
	fadd	d0, d0, d1
	str	d0, [sp, #56]
	ldur	s1, [x29, #-20]
                                        ; implicit-def: $d0
	fmov	s0, s1
	sshll.2d	v0, v0, #0
                                        ; kill: def $d0 killed $d0 killed $q0
	scvtf	d0, d0
	ldr	d1, [sp, #56]
	fdiv	d0, d0, d1
	str	d0, [sp, #48]
	adrp	x8, _x_was_zero@PAGE
	add	x8, x8, _x_was_zero@PAGEOFF
	ldar	x8, [x8]
	str	x8, [sp, #32]
	ldr	x8, [sp, #32]
	str	x8, [sp, #40]
	ldur	w8, [x29, #-20]
                                        ; kill: def $x8 killed $w8
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str.3@PAGE
	add	x0, x0, l_.str.3@PAGEOFF
	bl	_printf
	ldr	d0, [sp, #56]
	mov	x8, sp
	str	d0, [x8]
	adrp	x0, l_.str.4@PAGE
	add	x0, x0, l_.str.4@PAGEOFF
	bl	_printf
	ldr	d0, [sp, #48]
	mov	x8, sp
	str	d0, [x8]
	adrp	x0, l_.str.5@PAGE
	add	x0, x0, l_.str.5@PAGEOFF
	bl	_printf
	ldr	x8, [sp, #40]
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str.6@PAGE
	add	x0, x0, l_.str.6@PAGEOFF
	bl	_printf
	ldr	x8, [sp, #40]
	subs	x8, x8, #0
	b.ls	LBB3_14
	b	LBB3_13
LBB3_13:
	adrp	x0, l_.str.7@PAGE
	add	x0, x0, l_.str.7@PAGEOFF
	bl	_printf
	b	LBB3_15
LBB3_14:
	adrp	x0, l_.str.8@PAGE
	add	x0, x0, l_.str.8@PAGEOFF
	bl	_printf
	b	LBB3_15
LBB3_15:
	mov	w0, #0                          ; =0x0
	ldp	x29, x30, [sp, #176]            ; 16-byte Folded Reload
	add	sp, sp, #192
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_x                              ; @x
.zerofill __DATA,__common,_x,4,6
	.globl	_f                              ; @f
.zerofill __DATA,__common,_f,4,6
	.globl	_x_was_zero                     ; @x_was_zero
.zerofill __DATA,__common,_x_was_zero,8,3
	.globl	_run_state                      ; @run_state
.zerofill __DATA,__common,_run_state,4,2
	.globl	_done_count                     ; @done_count
.zerofill __DATA,__common,_done_count,4,2
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"=== Test hardware reorderingu (persistent threads, relaxed) ===\n"

l_.str.1:                               ; @.str.1
	.asciz	"x i f na roznych liniach cache (odleglosc: %lu bajtow)\n"

l_.str.2:                               ; @.str.2
	.asciz	"Uruchamianie %d iteracji...\n\n"

l_.str.3:                               ; @.str.3
	.asciz	"\nIteracje:   %d\n"

l_.str.4:                               ; @.str.4
	.asciz	"Czas:       %.3f s\n"

l_.str.5:                               ; @.str.5
	.asciz	"Throughput: %.0f iter/s\n"

l_.str.6:                               ; @.str.6
	.asciz	"BUG (x==0 gdy f==1): %llu\n"

l_.str.7:                               ; @.str.7
	.asciz	">>> HARDWARE REORDERING ZAOBSERWOWANY! <<<\n"

l_.str.8:                               ; @.str.8
	.asciz	"Brak anomalii.\n"

.subsections_via_symbols
