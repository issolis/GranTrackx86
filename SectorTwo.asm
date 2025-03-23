org 0x7E00

;.....................main....................; 

main:
   mov al, 0x13
   int 0x10
   
   call SetupKeyboardInterupt

   call drawTrack
   call drawFinishLine

   mov eax, 95
   mov [carY], eax
   mov [pla1Y], eax

   mov eax, 45
   mov [carx], eax
   mov [pla1x], eax
   call drawPlayer
   
   jmp $

;.....................keyboard setup.................; 
SetupKeyboardInterupt:

   cli                    
   mov word [0x0024], keyboard_handler 
   mov [0x0026], cs                    
   sti                 
   ret

keyboard_handler:
   in al, 0x60 
   test al, 0x80
   jz .key_down

   ; key up 
   call Key_Up

   jmp .done


.key_down:
   and al, 0x7f
   xor bx, bx
   mov bl, al
   mov al, [scan_code_table + bx]
   mov [keyval], al
   call Key_Down

.done:
   mov al, 0x20
   out 0x20, al
   iret


Key_Up:
   ret


Key_Down:
   cmp byte [keyval], 'w'
   je .w
   cmp byte [keyval], 's'
   je .s
   cmp byte [keyval], 'a'
   je .a
   cmp byte [keyval], 'd'
   je .d

   jmp .done


.s:
   call write_char
   call validatePos
   jmp .done
.w:
   call write_char
   call validatePos
   jmp .done
.a:
   call write_char
   call validatePos
   jmp .done
.d: 
   call write_char
   call validatePos
   jmp .done

.done:
   ret
write_char:

   ;mov ah, 02h        ; Función: mover cursor
   ;mov bh, 0          ; Página de video
   ;mov dh, 0      ; Fila (0-based)
   ;mov dl, 0    ; Columna (0-based)
   ;int 10h    
   
   mov ah, 0x0E
   mov bl, 0x09
   int 0x10
   ret

;.....motion....;
validatePos: 
   mov eax, [carx]
   mov ebx, [carY]
;First Square verification
   cmp eax, 37
   jl .false

   cmp eax, 278
   jg .false

   cmp ebx, 25
   jl .false

   cmp ebx, 170
   jg .false


;.....second square
   cmp eax, 62
   jle .true

   cmp eax, 258
   jl .false

   cmp ebx, 50
   jge .true

   mov ebx, [carY]
   cmp ebx, 145
   jl .false 

   jmp .true

.false: 
   jmp .done
.true: 
   jmp .done

.done:
   ret
;.....................graphic setup..................; 
fillPixel: 
   push eax
   mov eax, [color]
   mov byte [edi], al
   pop eax
   ret


drawTrack: 
   mov word [cornerY], 20
   mov word [cornerX], 0x20

   mov word [height], 160
   mov word [width], 256

   mov eax, 0x8
   mov [color], eax
   call drawBox

   mov word [cornerY], 25
   mov word [cornerX], 0x25

   mov word [height], 150
   mov word [width], 246

   mov eax, 0x09
   mov [color], eax
   call drawBox

   mov word [cornerY], 55
   mov word [cornerX], 67

   mov word [height], 90
   mov word [width], 186

   mov eax, 0x08
   mov [color], eax
   call drawBox

   mov word [cornerY], 60
   mov word [cornerX], 72

   mov word [height], 80
   mov word [width], 176

   mov eax, 0x00
   mov [color], eax
   call drawBox
   ret

initialSetup: 
   mov edi, drawStart
   mov eax, [cornerY]
   mov ebx, 320
   mul ebx
   add eax, [cornerX]
   add edi, eax
   ret

drawFinishLine:
   mov eax, 100
   mov [cornerY], eax
   mov eax, 37
   mov [cornerX], eax
   call initialSetup
   mov eax, 0xF
   mov [color], eax
   xor ecx, ecx

.put_pixel:
   call fillPixel
   inc edi
   inc ecx
   cmp ecx, 0x1e
   jl .put_pixel

.done: 
   ret


drawBox:
   call initialSetup
   xor edx, edx
   xor ecx, ecx
   jmp .put_pixel

.nextRow:  
   mov eax, 320 
   mov ebx, [width]
   sub eax, ebx 
   add edi, eax
   xor ecx, ecx

.put_pixel: 
   call fillPixel
   inc ecx
   inc edi
   cmp ecx, [width]
   jl .put_pixel
   inc edx
   cmp edx, [height]
   jl .nextRow

.done: 
   ret 
   
drawPlayer: 
   mov eax, [carY]
   mov [cornerY], eax
   mov eax, [carx]
   mov [cornerX], eax

   mov word [height], 5
   mov word [width], 5

   mov eax, 0x1
   mov [color], eax

   call drawBox



   

;-------------------Variables and Constans------------------------; 
scan_code_table:
   db 0, 0, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', 0, 0
   db 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', 0, 0
   db 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', "'", '`', 0, '\\'
   db 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/', 0, '*', 0, ' '


drawStart equ 0xA0000
cornerY   dd 0x10
cornerX   dd 0x10
height    dd 0x40
width     dd 0x40
color     dd 0x05
keyval    db 0

pla1x     dd 0x0
pla1Y     dd 0x0

carx      dd 0x0
carY      dd 0x0

