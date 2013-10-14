; getcpid will return the currently executing process's ID

; *SYSCALL*
getcpid
  ldx task      ; Load current task number
  lda #$00      ; Clear offset count
getcpid1
  dex
  beq getcpid2  ; If X=0, finish up
  clc
  adc #pitentrysize
  bcc getcpid1
!ifdef CONFIG_DEBUG {
  sei
  jsr kernelpanic         ; This should never happen.
}

getcpid2
  tax           ; Prepare calculated offset for use
  lda pidpage+pitpid,x    ; Get current PID
  rts
