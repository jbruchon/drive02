; Kernel memory management initialization

; Clear mm_page
    ldx #$03  ; $0400 is the first RAM that isn't ALWAYS used by the kernel
!ifdef CONFIG_65C02 {
-   inx
    stz mm_page,x
    cpx #$ff
    bne -
} else {
-   inx
    lda #$00
    sta mm_page,x
    cpx #$fe
    bne -
}

; Always mark first four and absolute last pages as kernel reserved
    lda #$ff
    sta mm_page
    sta mm_page+$01
    sta mm_page+$02
    sta mm_page+$03
    sta mm_page+$ff