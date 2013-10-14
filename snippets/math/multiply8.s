; multiply8 provides an 8-bit multiply with 16-bit result.
; This should not produce results above $fe01 ($ff * $ff)

multiply8
!ifdef CONFIG_6502 {
    lda #$00
    sta kzp0
} else {
    stz kzp0
}
    ldy #$08  ; Init multiplier loop
    pla
    sta kzp1
    pla  ; Pull multiplier
-   asl kzp0  ; Shift low byte left
    rol kzp1  ; Shift high byte left
    bcc +     ; Skip add if there's no bit here
    clc
    adc kzp0  ; Add multiplier to result
    sta kzp0  ; Store new low byte
    lda kzp1  ; Load high byte
    adc #$00  ; Add carry (if any) to high byte
    sta kzp1  ; Store new high byte
+   dey
    bne -     ; If not zero, do again
    lda kzp1
    pha
    lda kzp0
    pha
    rts