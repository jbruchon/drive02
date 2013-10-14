; activatepid will start a task

; *SYSCALL*
activatepid
  sei
  jsr criticalsection     ; No interruptions!
  lda systemflags
  and #createpidflag      ; Check if a PID is waiting for activation
  bne activatepid1
  jsr uncriticalsection
  cli
  jmp activatepiderror    ; If no PID has been initialized, error
activatepid1
  ldx #$00      ; Init PID search index
activatepid2
  ldy pidpage+pitpid,x    ; Get PID at index
  cpy pidtemp   ; Check against index
  beq activatepid3        ; If found, activate it!
  tya           ; Not found? Increment and try again.
  clc
  adc #pitentrysize       ; Jump by the PIT entry size
  bcc activatepidcc1      ; Error (this should never happen)
  sec
  rts
activatepidcc1
  tay           ; Restore index
  jmp activatepid2        ; Restart PID search
activatepid3
  lda #$01      ; Process state = running
  inc tasks     ; Schedule task for execution
  jsr uncriticalsection
  cli
  clc
  rts
