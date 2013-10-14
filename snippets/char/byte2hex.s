; -----------------------------------
; Convert a byte to two ASCII hexadecimal digits

byte2hex
  lda zp0
byte2hexhigh
  lsr         ; Translate high down to low
  lsr
  lsr
  lsr
  clc
  adc #$30    ; ASCII 0 = $30
  cmp #$3a    ; Is it going to be a-f?
  bmi byte2hexhigh1     ; No = go ahead and send
  clc
  adc #$07    ; Translate up to alphabet for hex
byte2hexhigh1
  sta zp1
  lda zp0
  and #$0f    ; Cut high nybble out
  clc
  adc #$30    ; ASCII 0 = $30
  cmp #$3a    ; Is it going to be a-f?
  bmi byte2hexlow1      ; No = go ahead and send
  clc
  adc #$07    ; Translate up to alphabet for hex
byte2hexlow1
  sta zp2
  clc
  rts
