; *SYSCALL*
blockmoveup
  ldy #$00      ; Initialize index (only want indirection)
blockuploop
  lda (zp2),y   ; Load data byte
  sta (zp0),y   ; Store data in destination
  lda zp2       ; Get data end low byte
  cmp zp4       ; Compare against data start low
  beq blockupchk          ; If equal, possibly done, so check
blockupok
  lda zp0       ; Get data dest. end low
  bne blockup1  ; if zp0 not 0, don't dec high byte
  dec zp1       ; Otherwise decrement high byte
blockup1
  dec zp0       ; Decrement data dest. end low byte
  lda zp2       ; Load data end low byte
  bne blockup2  ; If not 0, don't dec data end high
  dec zp3       ; Decrement data end high byte
blockup2
  dec zp2       ; Decrement data end low byte
  jmp blockuploop         ; Loop until zp2/3 = zp4/5
blockupchk
  lda zp3       ; Load data end high byte
  cmp zp5       ; Check against data start high
  bne blockupok           ; If not equal, return to loop
  rts
