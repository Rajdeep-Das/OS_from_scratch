# Interrupts

Interrupts are a mechanism that allow the CPU temporarily to halt what it is doing and
run some other, higher-priority instructions before returning to the original task. An
interrupt could be raised either by a software instruction (e.g. int 0x10) or by some
hardware device that requires high-priority action (e.g. to read some incoming data from
a network device).
Each interrupt is represented by a unique number that is an index to the interrupt
vector, a table initially set up by BIOS at the start of memory (i.e. at physical address
0x0) that contains address pointers to interrupt service routines (ISRs). An ISR is simply
a sequence of machine instructions, much like our boot sector code, that deals with a
specic interrupt (e.g. perhaps to read new data from a disk drive or from a network
card).
So, in a nutshell, BIOS adds some of its own ISRs to the interrupt vector that
specialise in certain aspects of the computer, for example: interrupt 0x10 causes the
screen-related ISR to be invoked; and interrupt 0x13, the disk-related I/O ISR.
However, it would be wasteful to allocate an interrupt per BIOS routine, so BIOS
multiplexes the ISRs by what we could imagine as a big switch statement, based usually
on the value set in one of the CPUs general purpose registers, ax, prior to raising the
interrupt.