; -----------------------------------
; queuekey adds a byte to the keyboard queue and updates queue pointers

queuekey
  tax           ; Save the key
; lock
  lda lock1     ; Load lock
  and #kbqueueL           ; Check lock
  beq kbqueueLok          ; If zero, continue
  jmp resourcelocked      ; Set lock = resource locked
kbqueueLok
  lda lock1     ; Load lock
  ora #kbqueueL           ; Set lock bit
  sta lock1     ; Store new lock byte
; endlock
  txa
  ldx kbqueue   ; Get current queue pointer
  inx
  cpx #kbqueuelen         ; Check against max length
  beq queuekeyfull        ; If full, drop key
  sta kbqueue,x           ; Store key
  stx kbqueue   ; Store pointer
; lock
  lda lock1     ; Get lock byte
  and #255-kbqueueL       ; Clear lock bit in lock byte
  sta lock1     ; Store lock byte
; endlock
  clc
  rts
queuekeyfull
  jmp bufferfull          ; Oops!
