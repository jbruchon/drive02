; consoleget does queue retrieval and pointer update

consoleget
  clc
  ldx kbqueue   ; Load keyboard queue pointer
  bne kbqnotnull          ; Non-zero = get char
  lda #$00      ; Zero = send a null char back
  clc
  rts
kbqnotnull
  lda kbqueue+1           ; Load character from queue
  pha
  cpx #$01
  beq kbqnocycle          ; <2 = no cycling
  ldx #$01      ; Prepare to move buffer backwards
  ldy #$00
kbqcycle
  inx
  iny
  lda kbqueue,x           ; Load char
  sta kbqueue,y           ; Move back 1 space
  cpx kbqueue   ; Check Y against current queue end
  bne kbqcycle
kbqnocycle
  dec kbqueue   ; Decrement pointer
  pla           ; Restore value
  rts
