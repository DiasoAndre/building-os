; boot.asm
org 7C00h                       ; set the offset

; stack initialization
mov     ax, 07C0h               
mov     ss, ax                  ; set SS to 07C0h
mov     sp, 03FEh               ; point to top of stack

; set data segment
xor     ax, ax                  ; zero AX
mov     ds, ax                  ; set data segment to 0000h

; change video mode
mov     ah, 00h                 ; subfunction to set video mode
mov     al, 03h                 ; 03h = 80x25, 16 colors
int     10h                     ; video interrupt

; read data from floppy disk
mov     ah, 02h                 ; read subfunction
mov     al, 1                   ; number of sectors to read
mov     ch, 0                   ; track (cylinder)
mov     cl, 2                   ; sector
mov     dh, 0                   ; head
mov     dl, 0                   ; drive (00h = A:)
mov     bx, 0800h               ; ES:BX points to memory location_
mov     es, bx                  ; where data will be written_
mov     bx, 0                   ; 0800:0000h (ES = 0800h, BX = 0000h)
int     13h                     ; disk interrupt

jmp     0800h:0000h             ; jump to the location where the kernel_
                                ; is loaded and pass execution to it

times 510-($-$$) db 0
dw 0xAA55
