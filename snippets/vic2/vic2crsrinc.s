vic2crsrinc
    lda vic2crsrX
    cmp #$27        ; X at end of line?
    bne +       ; No = just increment and exit
    lda #$00
    sta vic2crsrX
    lda vic2crsrY       ; Get Y
    cmp #$18        ; Y at end of screen?
    bne ++       ; No = just increment Y
    jsr vic2scroll      ; Scroll screen by one line
    rts
+   inc vic2crsrX       ; Increment X
    rts
++  inc vic2crsrY       ; Increment X
    rts