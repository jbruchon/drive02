; breakexec will prematurely simulate an IRQ safely
; You must call this to return control to C02
; BRK without a BRK OK flag set will result in the
; process involved being killed immediately

; SYSCALL
breakexec
  pha
  lda systemflags         ; Load system flags
  ora breakokflag         ; Set break OK flag
  sta systemflags         ; Store new flags
  pla
  brk
  nop
  rts
