; -----------------------------------
; getchar will attempt to retrieve a character from the specified input.

getchar
; lock
  lda lock1     ; Load lock byte
  and #getcharL           ; Check getchar lock bit
  beq getcharLok          ; If zero, lock unset so continue
  jmp resourcelocked      ; Set lock = resource locked
getcharLok
  lda #getcharL
  ora lock1     ; Set getchar lock bit
  sta lock1
; endlock
  cpx #$00      ; $00 = console
  beq consoleinput
  jmp devnumfailure       ; Failed compares, put error

consoleinput
  jsr consoleget          ; Get char from console
getcharexit
  tax           ; Save A
; lock
  lda #255-getcharL       ; Load inverted lock bit mask
  and lock1     ; Clear lock bit
  sta lock1
; endlock
  txa           ; retrieve A
  clc
  rts
