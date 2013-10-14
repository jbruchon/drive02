; Main build source file

!to "main.o",plain
!sl "ksyms.txt"

; Load build configuration variables
!src "vars.s"
!src "build.cfg"

!ifdef CONFIG_NES_HEADER !src "ineshead.s"

!ifdef CONFIG_PREPEND {
  *=CORE_BASE-CONFIG_PREPEND
  !fill CONFIG_PREPEND
}

*=CORE_BASE

!src "init.s"

!src "init_task.s"

!src "irq.s"
!src "nmi.s"

!src "syslib.s"

; Device drivers
!ifdef CONFIG_INPUT_C64_KEY !src "c64key.s"
!ifdef CONFIG_INPUT_NES_PAD !src "nespad.s"
!ifdef CONFIG_NES_PPU !src "nesppu.s"
!ifdef CONFIG_INPUT_SIMTERM !src "simterm.s"
!ifdef CONFIG_CIA_C64 !src "c64cia.s"
!ifdef CONFIG_SERIAL_6551 !src "6551.s"
!ifdef CONFIG_VIC_I !src "vic1.s"
!ifdef CONFIG_VIC_II !src "vic2.s"

!ifdef CONFIG_ROM {

  *=$fffa
  !08 <nmi, >nmi, <init, >init, <irq, >irq
}
