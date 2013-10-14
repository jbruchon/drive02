; *SYSCALL*
pagefill
  ldy #$00      ; Init counter to zero
pagefillloop
  sta (zp0),y   ; Store fill byte
  cpy zp2       ; Last byte reached?
  beq pagefilldone        ; If so, end fill
  iny           ; If not, move to next byte
  bne pagefillloop        ; and loop until done
pagefilldone
  rts
