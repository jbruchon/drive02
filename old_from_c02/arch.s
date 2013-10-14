; C02 Operating System
; arch.s: Architecture-specific initialization inclusion
; Copyright (C) 2004-2008 by Jody Bruchon

!ifdef CONFIG_ARCH_C64 !src "i-c64.s"
!ifdef CONFIG_ARCH_NES !src "i-nes.s"