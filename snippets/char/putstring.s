; -----------------------------------
; Prints pointed-to string to the console
putstring
  ldy #$00    ; Counter for message printing
putstring1
  lda (zp0),y           ; Grab next char from message
  sty zp2     ; Save counter
  sta zp3     ; Save character for compare
  jsr putchar           ; Send to the console
  bcc putstring2        ; If carry clear, all is well
  rts         ; If carry set, pass error on
putstring2
  lda #$00    ; Load a null into A for compare
  cmp zp3     ; Check against character
  beq putstring3        ; If equal, finish up
  ldy zp2     ; Restore counter value
  iny         ; Increment counter
  jmp putstring1        ; Do it again until done
putstring3
  rts
