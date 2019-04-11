mov ah, 0x0e ; tty mode
mov al, 'H'
int 0x10
mov al, 'E'
int 0x10
mov al, 'L'
int 0x10
int 0x10 ; 'L' is still on al, remember?
mov al, 'O'
int 0x10

jmp $ ; jump to current address = infinite loop

; padding and magic number
times 510 - ($-$$) db 0
dw 0xaa55 