!ifdef CONFIG_BUILD_ROM {

  *=$fffa
  !08 <nmivec, >nmivec, <RESVEC, >RESVEC, <irq, >irq
}
