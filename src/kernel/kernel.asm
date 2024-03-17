; kernel.asm
org 0000h                       ; set the offset

push cs                         ; CS = current program address
pop ds                          ; DS = CS

call clearscreen               ; call procedure to clear the screen

lea si, Mensagem                ; SI = address of the message
mov ah, 0Eh                     ; subfunction to print character

loop:

    mov al, [si]                ; move the character at SI to AL
    cmp al, 0h                  ; compare with 0 (end of string)
    jz finish                 ; if ended, jump to 'finish'
    int 10h                     ; video interrupt
    inc si                      ; next character
    jmp loop               ; repeat the process until finding 0

finish:

mov ah, 0h                      ; subfunction to wait for key
int 16h                         ; keyboard interrupt

mov ax, 0040h                   ; reboot method consists in setting_
mov ds, ax                      ; the value of address 0040:0072h_
mov word [0072h], 1234h            ; to 1234h and jump to the address_
jmp 0FFFFh:0000h                ; FFFF:0000h

clearscreen:                ; procedure to clear the screen
    pusha                       ; push all registers onto the stack

    mov     ah, 06h             ; subfunction to scroll the screen up
    mov     al, 0               ; clear the screen
    mov     bh, 0000_1111b      ; set colors (background_text)
    mov     ch, 0               ; top left corner line
    mov     cl, 0               ; top left corner column
    mov     dh, 19h             ; bottom right corner line (25)
    mov     dl, 50h             ; bottom right corner column (80)
    int     10h                 ; video interrupt

    popa                        ; restore the values of the registers
    ret                         ; return to the code

Mensagem db "root:/$",0 ; our string to be displayed
