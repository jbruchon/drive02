; vic2xyput puts the screen code specified into the specified X and Y
; locations (starting at 0,0) on the text console.  Load A with the value
; to place, X and Y with the screen location to put the character in.

vic2xyput
  pha           ; Save value
  sty zp1       ; Pass multiplier to multiply8
  txa
  pha           ; Save offset from multiplier
  ldx #$28      ; 40 characters per line
  jsr multiply8           ; Do the multiply
  lda zp1       ; Load high byte
  adc #>vic2text          ; Add in VIC-II text base high byte
  sta zp1       ; Save changes to vector
  pla           ; Pull offset
  tay           ; Use offset as index
  pla           ; Get code to put on screen
  sta (zp0),y   ; Store code on screen
  rts
