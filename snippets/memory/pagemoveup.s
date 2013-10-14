; *SYSCALL*
pagemove
  lda zp3       ; Get dest. high byte
  cmp zp1       ; Check against start high
  bmi pagemovedown        ; If dest below start, move down
  beq pagemovelows        ; If equal, check low bytes to decide
  bne pagemoveup          ; If greater, move up
pagemovelows
  lda zp2       ; Get dest. low
  cmp zp0       ; Check against start low
  bmi pagemovedown        ; If less, move down
  bne pagemoveup          ; If not equal (greater), move up
  rts           ; Otherwise, start=dest so ignore call!

pagemovedown
  ldy #$00      ; Init index
  ldx zp4       ; Init counter
pagemovedownloop
  lda (zp0),y   ; Load data byte
  sta (zp2),y   ; Copy data byte
  cpx #$00      ; Is counter at zero?
  beq pagemovedown1       ; Yes = done
  iny           ; Increment index
  dex           ; Decrement counter
  jmp pagemovedownloop    ; Loop until done
pagemovedown1
  rts

pagemoveup
  ldy zp4       ; Init index/counter
pagemoveuploop
  lda (zp0),y   ; Load data byte
  sta (zp2),y   ; Save data byte
  cpy #$00      ; Is counter at zero?
  beq pagemoveup1         ; Yes = done
  dey           ; Decrement index/counter
  jmp pagemoveuploop      ; Loop until done
pagemoveup1
  rts
