malloc
  jsr criticalsection     ; Don't task-switch during malloc
  cmp mmfreepagecnt       ; Check against free pages available
  bcc +         ; If enough or more available, scan
  beq +
  jmp malloctoobig        ; If request too big, return an error
+       sta mmtemp0   ; Temporarily save requested page count
  lda #$00
  ldx #$00      ; Start page scan at zero-page
---     cmp memorymap,x         ; Compare memory map page with zero
  beq +         ; If equal, start page ranging scan
  inx           ; Increment page counter
  bne ---       ; Keep scanning until out of pages
--      jmp mallocnoblock       ; ERROR-No block large enough for request
+       stx mmtemp1   ; Temporarily store starting page
  ldy #$00      ; Initialize Y for page count
  cpx #$00      ; Check for page 0
; The following two lines are a workaround to cover the special case
; where the zero-page is actually marked "free"
  bne +         ; If not page 0, skip to scanner
  beq ++        ; If page 0, skip first zero check in scan
+
-       cpx #$00      ; Check X to be sure it's not zeroed
  beq --        ; If X has recycled to zero, error!
++      iny           ; Increment counter
  inx           ; Increment scan page
  cpy mmtemp0   ; Check against requested number of pages
  beq +         ; If done, complete malloc and return
  cmp memorymap,x         ; Check next page in block
  beq -         ; If free, return to counter checkpoint
  jmp ---       ; If not free, return to main scan
+       jsr getcpid   ; Get current process ID in A
  ldx mmtemp1   ; Get starting page of allocation
  ldy mmtemp0   ; Get number of pages allocated
-       sta memorymap,x         ; Set current memory map pointer to CPID
  inx           ; Increment to next page
  dec mmfreepagecnt       ; Decrement free page count
  dey           ; Decrement pages requested counter
  bne -         ; Keep going until all marked used
  lda mmtemp1   ; Return starting page of block in A
  ldx mmtemp0   ; Return original pages requested in X
  jsr uncriticalsection
  clc
  rts
