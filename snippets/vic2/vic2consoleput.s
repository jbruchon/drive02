consoleput
  cmp #$0d      ; Carriage return?
  bne vic2noydown         ; No = no new line, yes= new line
vic2ydown
  ldy vic2crsrY           ; Get cursor location
  cpy #24       ; At line 24 already?
  bne vic2not24           ; No = don't scroll
  jmp vic2scroll
vic2noydown
; This translates ASCII codes to screen codes
  cmp #$20      ; Is code $20 or higher?
  bpl vic2is32  ; Yes = OK
  rts           ; No = ignore
vic2is32
  cmp #$80      ; Is code $80 or higher?
  bmi vic2is127           ; No = OK
  rts           ; Yes = ignore
vic2is127
  sec
  sbc #$20      ; Lower A by 32 for lookup
  tax           ; Use A as lookup index
  lda vic2transtbl,x      ; Load A with new value
  ldx vic2crsrX           ; Get cursor X
  ldy vic2crsrY           ; Get cursor Y
  jsr vic2xyput           ; Put screen code
  jmp vic2crsrinc         ; Increment cursor location

vic2not24
  iny           ; Increment Y
  sty vic2crsrY
  ldx #$00
  stx vic2crsrX           ; Zero X
  rts
