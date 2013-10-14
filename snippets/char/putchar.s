; -----------------------------------
; putchar attempts to send a character to the specified output device.
; Currently only handles console

putchar
  cpx #$00      ; $00 = console
  beq putchardev0
  jmp devnumfailure       ; Failed compares, put error

putchardev0
  jsr consoleput
  jmp putcharworked
putcharworked
  clc
  rts
