org 0x7c00

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00



    ; functions
    
    mov si, message
    call print_string
    call wait_enter
    call JumpToSectorTwo
    ; 

    jmp $

PrepSectorTwo:
   mov ah, 0x02    ; BIOS read sector
   mov al, 6       ; Number of sectors
   mov ch, 0       ; Cylinder number
   mov dh, 0       ; Head number
   mov cl, 2       ; Sector number
   mov bx, 0x7E00  ; Load address
   int 0x13
   ret
JumpToSectorTwo:
   call PrepSectorTwo
   jmp 0x7E00 ; jump to sector two
   ret

wait_enter:
    mov ah, 0x00
    int 0x16       ; wait -> AL
    cmp al, 0x0D   ; ¿ENTER?
    jne wait_enter ; if not wait enter
    ret

print_string:
    mov ah, 0x0E           
.next_char:
    lodsb                  
    cmp al, 0
    je .done               
    int 0x10               
    jmp .next_char
.done:
    ret

message db "Press Enter to play!!!!", 0

times 510-($-$$) db 0
dw 0xAA55
