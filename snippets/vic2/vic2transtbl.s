vic2transtbl
; This table is missing 32 bytes for non-displayable
; ASCII characters; the table starts at $20 (32)
; $20 (32)
!08 $20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2a,$2b,$2c,$2d,$2e,$2f
!08 $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3a,$3b,$3c,$3d,$3e,$3f
; $40 (64)
!08 $00,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4a,$4b,$4c,$4d,$4e,$4f
!08 $50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5a,$1b,$1c,$1d,$1e,$1f
; $60 (96)
!08 $27,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e,$0f
!08 $10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1a,$1b,$5d,$1d,$7a,$60
; $80 (128) and above are not part of ASCII and will
; not be used in the console driver, though special access
; is planned in the future for raw screen codes.
