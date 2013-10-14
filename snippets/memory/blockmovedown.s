; *SYSCALL*
blockmovedown
  ldy #$00
blockdownloop
  lda (zp2),y   ; Load data byte
  sta (zp0),y   ; Store data in destination
  lda zp2       ; Load data start low
  cmp zp4       ; Compare to data start low
  beq blockdownchk        ; If equal, check high too
blockdownok
  inc zp0       ; Increment dest start low byte
  bne blockdown1          ; If dest start = 0 don't inc high
  inc zp1       ; Otherwise increment high
blockdown1
  inc zp2       ; Increment data start low byte
  bne blockdown2          ; If low byte non-zero, don't inc high
  inc zp3       ; Otherwise inc high
blockdown2
  jmp blockdownloop       ; Loop until done
blockdownchk
  lda zp3       ; Load data start high
  cmp zp5       ; Compare against data end high
  bne blockdownok         ; If not equal, return to loop
  rts
