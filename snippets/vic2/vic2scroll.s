; vic2scroll will make a new line at the end of the screen and push all
; other lines up by one, destroying the last line.

vic2text=$0400
zp0=$30
zp1=$31
zp2=$32
zp3=$33
zp4=$34
pagemove
pagefill
vic2textll

vic2scroll
  lda #<vic2text+40       ; Prepare to push screen data up
  sta zp0
  lda #>vic2text+40
  sta zp1
  lda #<vic2text
  sta zp2
  lda #>vic2text
  sta zp3
  lda #$ff      ; 256 bytes at a time
  sta zp4
  jsr pagemove  ; Move first page

  inc zp1
  inc zp3
  jsr pagemove  ; Move second page

  inc zp1
  inc zp3
  jsr pagemove  ; Move third page

  inc zp1
  inc zp3
  lda #$bf      ; Don't go beyond the screen!
  sta zp4
  jsr pagemove  ; Move last page

  lda #<vic2textll        ; Last line on screen
  sta zp0
  lda #>vic2textll
  sta zp1
  lda #$27      ; $27 = chars 0-39 on the line
  sta zp2
  lda #$20      ; Blank space = 32 = $20
  jsr pagefill
  rts