; Check for an unexpected BRK, often signs of a rogue app
    pla  ; Retrieve P
    pha  ; but don't trash it
    and #$10  ; Check BRK flag
    beq ++
    lda systemflags
    and break_ok_flag  ; BRK expected?
    bne +
    jsr kill_current_pid  ; If BRK was unexpected, kill the process
+   lda systemflags
    and #255-break_ok_flag  ; Reset flag
    sta systemflags
++  