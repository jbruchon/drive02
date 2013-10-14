; Round-robin process scheduler

; Gets current PID, finds next PID, recalculates and switches to that PID.
; Priority is ignored in this scheduler. All we do is continuously scan
; the running task table for a task in the "ready" state, starting with
; the next task after the one being switched from.

    ldx task
; Find next task in "ready" state and put its number in X
-   inx
    cpx #maximum_tasks
    bmi +
    ldx #$00  ; Cycle task 15 back to 0
+   lda task_state_table,x
    and #$c0
    eor #$c0  ; Check if process is in "ready" state
    bne -
++  txa  ; X = next task number to schedule
    stx task  ; "task" holds the current PID
    asl  ; Multiply by 4 (context size)
    asl
    ora #$40  ; Translate to context storage area at $40
    tax
; X contains the ZP pointer to the context for the next task.

; End of scheduler