; --- Constant variables ---

; Code start point
!ifdef CORE_BASE {} else {CORE_BASE=$c000}

; Single-byte storage
; $00 and $01 reserved due to 6510-based systems
temp = $02
irq_temp = $03 ; Only used to preserve IRQ hook counters
nmi_temp = $04 ; NMI-only version of irq_temp
irq_vec_count = $05 ; Number of IRQ hooks
nmi_vec_count = $06 ; Number of NMI hooks
irq_vectors = $07 ; through $1e, 8 jumps
nmi_vectors = $1f ; through $2a, 4 jumps
big_kernel_lock = $2b  ; Self-explanatory mutex

; Kernel routine zero-page reserved locations
kzp0 = $78
kzp1 = $79
kzp2 = $7a
kzp3 = $7b
kzp4 = $7c
kzp5 = $7d
kzp6 = $7e
kzp7 = $7f

; Context storage and zero-page allocations
ctxarea = $80  ; through $bf, 8 bytes/process x 8 processes
task_zp_area = $c0  ; through $ff

task_state_table = $0200
task = $0208
num_tasks = $0209
ctxcache = $020a
systemflags = $020b
kb_queue_count = $020c
kb_queue = $020d  ; Through $021c, queue is 8 events (16b)

mm_page = $0300

; Flag masks
criticalflag = %00000001
break_ok_flag = %00000010

; Constants
maximum_tasks = 8
irqnmi_vector_byte_count = 36