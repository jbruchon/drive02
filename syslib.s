; Library of system functions

; 8-bit multiply, returning 16-bit result
; Push multiplier, then multiplicand.
; Pull low byte, then high byte
multiply8
    jsr lock_kernel
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
    jsr unlock_kernel
    pha
    rts

; Routines for managing the "big kernel lock"
lock_kernel
    sei
    lda big_kernel_lock
    beq +
; FIXME: put code to wait on BKL here!
+   lda task
    cli
    rts

unlock_kernel
    sei
    lda task  ; Do not unlock unless the locking task requests it!
    cmp big_kernel_lock
    beq +
; FIXME: Need to abort with error, for now just return.
    rts
+   lda #$00
    sta big_kernel_lock
    rts
