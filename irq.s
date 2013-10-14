; IRQ handler

irq
; Immediately save the current context
    stx temp
    ldx ctxcache
    sta ctxarea,x ;A
    inx
    lda temp
    sta ctxarea,x ;X
    sty ctxarea,x ;Y

; !ifdef CONFIG_DONT_CHECK_BRK {} else {!src "brk.s"}

; By leaving P/PCL/PCH on the stack, we optimize context switches
    stx temp
    tsx
    txa
    ldx ctxcache
    sta ctxarea,x ;SP

!ifdef CONFIG_NO_CRITICAL {} else {
    lda systemflags
    and #criticalflag
    bne ++
}

; --- IRQ hook processing
; IRQ hooks are jumps; unregistered hooks use RTS instead of JMP
    jsr irq_vectors+0
    jsr irq_vectors+3
    jsr irq_vectors+6
    jsr irq_vectors+9
    jsr irq_vectors+12
    jsr irq_vectors+15
    jsr irq_vectors+18
    jsr irq_vectors+21

; --- Scheduler
!ifdef CONFIG_SCHED_PRIORITY !src "sched_pri.s" else !src "sched_rr.s"

; Restore context, X is set by the task scheduler.
; The calculated context location is cached to speed up subsequent switches.
start_current_task
++  stx ctxcache
    lda ctxarea,x ;SP
    tax
    txs
    dex
    ldy ctxarea,x ;Y
    dex
    lda ctxarea,x ;X
    sta temp
    dex
    lda ctxarea,x ;A
    ldx temp
    rti