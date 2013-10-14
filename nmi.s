; NMI handler code

!ifdef CONFIG_NO_NMI {
nmi
    rti
} else {
nmi
    jsr nmi_vectors+0
    jsr nmi_vectors+3
    jsr nmi_vectors+6
    jsr nmi_vectors+9
    rti
}