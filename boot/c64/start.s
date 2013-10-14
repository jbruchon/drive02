; Kernel start routine for C64
; This is an example that will start
; a program loaded under the KERNAL ROM
; from BASIC.


* = $0801
!to "boot.o"

main

; SYS 2061
!byte $0b,$08,$01,$00,$9e,$32,$30,$36,$31,$00,$00,$00

sei
lda #$05
sta $01
jmp $f000
