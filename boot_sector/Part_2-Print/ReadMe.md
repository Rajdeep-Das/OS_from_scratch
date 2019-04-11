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

# CPU Registers
Just as we use variables in a higher level languages, it is useful if we can store data tem-
porarily during a particular routine. All x86 CPUs have four general purpose registers,
ax, bx, cx, and dx, for exactly that purpose. Also, these registers, which can each hold
a word (two bytes, 16 bits) of data, can be read and written by the CPU with negligible
delay as compared with accessing main memory. In assembly programs, one of the most
common operations is moving (or more accurately, copying) data between these registers:
``` mov ax , 1234 ; store the decimal number 1234 in ax
mov cx , 0 x234 ; store the hex number 0 x234 in cx
mov dx , 't' ; store the ASCII code for letter 't' in dx
mov bx , ax ; copy the value of ax into bx , so now bx == 1234 
```
Notice that the destination is the first and not second argument of the mov operation,
but this convention varies with different assemblers.
Sometimes it is more convenient to work with single bytes, so these registers let us
set their high and low bytes independently:
```mov ax , 0 ; ax -> 0x0000 , or in binary 0000000000000000
mov ah , 0 x56 ; ax -> 0 x5600
mov al , 0 x23 ; ax -> 0 x5623
mov ah , 0 x16 ; ax -> 0 x1623
```

# Putting it all Together
So, recall that we'd like BIOS to print a character on the screen for us, and that we
can invoke a specic BIOS routine by setting ax to some BIOS-dened value and then triggering a specic interrupt. The specic routine we want is the BIOS scrolling tele-
type routine, which will print a single character on the screen and advance the cursor,
ready for the next character. There is a whole list of BIOS routines published that show
you which interrupt to use and how to set the registers prior to the interrupt. Here, we
need interrupt 0x10 and to set ah to 0x0e (to indicate tele-type mode) and al to the
ASCII code of the character we wish to print.

` nasm boot_print.asm -o boot_print.bin `
