mfree
  jsr criticalsection     ; Don't task-switch during mfree
  sta mmtemp0   ; Save start of pages to free
  stx mmtemp1   ; Save number of pages
  jsr getcpid   ; Get CPID of caller
  ldx mmtemp0   ; Restore start page
  ldy mmtemp1   ; Restore page count
mfree1
  cmp memorymap,x         ; Check CPID against PID in memory map
  beq mfree2    ; If equal, proceed
  jmp mfreepid  ; If not equal, abort and return error
mfree2
  inx           ; Increment page number to check
  dey           ; Decrement page counter
  beq mfree3    ; If zero, actually de-allocate it
  bne mfree1    ; If non-zero, keep checking
mfree3
  ldx mmtemp0   ; Restore start page
  ldy mmtemp1   ; Restore page count
  lda #$00      ; Initialize A for deallocation
mfree4
  sta memorymap,x         ; Deallocate memory
  inx           ; Increment page number
  inc mmfreepagecnt       ; Increment free page count
  dey           ; Decrement page counter
  bne mfree4    ; If non-zero, keep going
  jsr uncriticalsection   ; Unlock task switching
  clc           ; If zero, return OK
  rts
