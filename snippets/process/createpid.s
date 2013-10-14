; createpid will create a new empty process entry

; *SYSCALL*
createpid
  sei
  jsr criticalsection     ; No interruptions!
  lda systemflags
  and #createpidflag
  beq createpidfok
  jsr uncriticalsection
  cli
  jmp createpidused       ; If flag set, an unused PID exists.
createpidfok
  ldx #$00
  ldy tasks
  lda #$01      ; Default first PID entry
  sta pidtemp   ; Store as potential PID
createpid1
  lda pidpage+pitpid,x    ; Get PID from table
  cmp pidtemp   ; Compare against possible PID
  bne createpid2          ; Don't change PID if not the same
  inc pidtemp   ; Increment PID
  ldx #$00      ; Restart PID search
  ldy tasks
  beq createpid1
createpid2
  dey           ; Decrement task counter
  beq createpid4          ; If task counter is zero, PID found!
  txa
  clc
  adc #pitentrysize       ; Increase index for next check
  bcc createpid3
!ifdef CONFIG_DEBUG {
  jsr kernelpanic         ; If add produces carry, too many processes
}
  sec
  rts
createpid3
  tax
  inc pidtemp   ; Increment PID to try
  jmp createpid1          ; Return to try next PID number
createpid4
  ldy #$ff
  cpy pidtemp
  bne createpid5
!ifdef CONFIG_DEBUG {
  jsr kernelpanic         ; If add produces carry, too many processes
}
  sec
  rts
createpid5
  txa
  clc
  adc #pitentrysize       ; Increase offset for new PID
  bcc createpid6
  jsr uncriticalsection
  cli
  jmp createpidfail       ; Error if add produces carry
createpid6
  tax
  lda #$00
  sta pidpage+pitstate    ; Clear out process state
  lda pidtemp
  sta pidpage+pitpid,x    ; Store new PID in PIT
  jsr uncriticalsection
  cli
  clc
  rts           ; Return PID in A
