; Kernel initialization

init
  sei           ; Mask off IRQs so we aren't interrupted
  cld           ; Just in case, clear decimal mode.

!ifdef CONFIG_6502 {
  lda #$00
  sta systemflags
  sta kb_queue_count
}
!ifdef CONFIG_65C02 {
  stz systemflags
  stz kb_queue_count
}

; Fill IRQ/NMI hooks with RTS instructions
    ldx #irqnmi_vector_byte_count
    lda #$60  ; $60 = RTS
-   dex
    sta irq_vectors,x
    bne -

!src "drvinit.s"     ; Per-driver initialization code

!ifdef RAM_AT_FF_PAGE {
    lda #<nmi           ; Set NMI vector to irq
    sta $fffa           ; nmivec = $fffa-b
    lda #>nmi
    sta $fffb
    lda #<init          ; Set RESET vector to init
    sta $fffc           ; resvec = $fffc-d
    lda #>init
    sta $fffd
    lda #<irq           ; Set IRQ vector to irq (surprise...)
    sta $fffe           ; irqvec = $fffe-f
    lda #>irq
    sta $ffff
}
!ifdef CONFIG_65C02 {
    stz task
    stz num_tasks
    stz systemflags
} else {
    lda #$00
    sta task
    sta num_tasks
    sta systemflags
}

!src "mm_init.s"

    lda #>init_task
    pha
    lda #<init_task
    pha
    lda #$20        ; Clear P, except for E bit
    pha
    rti
