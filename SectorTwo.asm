org 0x7E00

pit_command equ 0x43
pit_channel_0 equ 0x40
divisor equ 19886
 

;.....................main....................; 

main:
   mov al, 0x13
   int 0x10
   
   call SetupKeyboardInterupt

   call drawTrack
   call drawFinishLine

   mov eax, 95   ;95
   mov [carY], eax
   mov [pla1Y], eax

   mov eax, 45  ;45
   mov [carx], eax
   mov [pla1x], eax

   mov eax, 0x1
   mov [color], eax

   call drawPlayer

   mov eax, 95   ;95
   mov [carY], eax
   mov [pla2Y], eax

   mov eax, 50  ;45
   mov [carx], eax
   mov [pla2x], eax

   mov eax, 0x3
   mov [color], eax

   call drawPlayer

   mov eax, 0
   mov [timer], eax
   call boots
   call Timer_Setup

   
   
   
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
   cmp byte [keyval], 'i'
   je .i
   cmp byte [keyval], 'j'
   je .j
   cmp byte [keyval], 'k'
   je .k
   cmp byte [keyval], 'l'
   je .l

   jmp .done


.w:
   mov eax, [pla1Y]
   sub eax, 3
   mov [carY], eax
   mov ecx, eax

   mov eax, [pla1x]
   mov [carx], eax

   call validatePos
   cmp byte al, 0
   je .done

   
   mov [pla1Y], ecx

   mov eax, 0x1
   mov [color], eax

   call drawPlayer

   mov eax, [pla1Y]
   add eax, 5 
   mov [cornerY], eax 
   mov eax, [pla1x]
   mov [cornerX], eax

   mov word [width], 5
   mov word [height],3

   mov eax, 0x09
   mov [color], eax


   call drawBox
   jmp .done
.s:

   mov eax, [pla1Y]
   add eax, 3
   mov [carY], eax
   mov ecx, eax

   mov eax, [pla1x]
   mov [carx], eax

   call validatePos
   cmp byte al, 0
   je .done

   mov [pla1Y], ecx

   mov eax, 0x1
   mov [color], eax

   call drawPlayer

   mov eax, [pla1Y]
   sub eax, 3 
   mov [cornerY], eax 
   mov eax, [pla1x]
   mov [cornerX], eax

   mov word [width], 5
   mov word [height],3

   mov eax, 0x09
   mov [color], eax


   call drawBox
   jmp .done
.d:
   mov eax, [pla1x]
   add eax, 3
   mov [carx], eax
   mov ecx, eax

   mov eax, [pla1Y]
   mov [carY], eax

   call validatePos
   cmp byte al, 0
   je .done

   mov [pla1x], ecx

   mov eax, 0x1
   mov [color], eax

   call drawPlayer

   mov eax, [pla1x]
   sub eax, 3
   mov [cornerX], eax
   mov eax, [pla1Y]
   mov [cornerY], eax

   mov word [height], 5 
   mov word [width],  3

   mov eax, 0x09
   mov [color], eax

   call drawBox
   jmp .done
.a: 
   mov eax, [pla1x]
   sub eax, 3
   mov [carx], eax
   mov ecx, eax

   mov eax, [pla1Y]
   mov [carY], eax

   call validatePos
   cmp byte al, 0
   je .done

   mov [pla1x], ecx

   mov eax, 0x1
   mov [color], eax

   call drawPlayer

   mov eax, [pla1x]
   add eax, 5
   mov [cornerX], eax
   mov eax, [pla1Y]
   mov [cornerY], eax

   mov word [height], 5 
   mov word [width],  3

   mov eax, 0x09
   mov [color], eax

   call drawBox

   jmp .done
.i:
   mov eax, [pla2Y]
   sub eax, 3
   mov [carY], eax
   mov ecx, eax

   mov eax, [pla2x]
   mov [carx], eax

   call validatePos
   cmp byte al, 0
   je .done

   
   mov [pla2Y], ecx

   mov eax, 0x3
   mov [color], eax

   call drawPlayer

   mov eax, [pla2Y]
   add eax, 5 
   mov [cornerY], eax 
   mov eax, [pla2x]
   mov [cornerX], eax

   mov word [width], 5
   mov word [height],3

   mov eax, 0x09
   mov [color], eax


   call drawBox
   jmp .done
.k:

   mov eax, [pla2Y]
   add eax, 3
   mov [carY], eax
   mov ecx, eax

   mov eax, [pla2x]
   mov [carx], eax

   call validatePos
   cmp byte al, 0
   je .done

   mov [pla2Y], ecx

   mov eax, 0x3
   mov [color], eax

   call drawPlayer

   mov eax, [pla2Y]
   sub eax, 3 
   mov [cornerY], eax 
   mov eax, [pla2x]
   mov [cornerX], eax

   mov word [width], 5
   mov word [height],3

   mov eax, 0x09
   mov [color], eax


   call drawBox
   jmp .done
.l:
   mov eax, [pla2x]
   add eax, 3
   mov [carx], eax
   mov ecx, eax

   mov eax, [pla2Y]
   mov [carY], eax

   call validatePos
   cmp byte al, 0
   je .done

   mov [pla2x], ecx

   mov eax, 0x3
   mov [color], eax

   call drawPlayer

   mov eax, [pla2x]
   sub eax, 3
   mov [cornerX], eax
   mov eax, [pla2Y]
   mov [cornerY], eax

   mov word [height], 5 
   mov word [width],  3

   mov eax, 0x09
   mov [color], eax

   call drawBox
   jmp .done
.j: 
   mov eax, [pla2x]
   sub eax, 3
   mov [carx], eax
   mov ecx, eax

   mov eax, [pla2Y]
   mov [carY], eax

   call validatePos
   cmp byte al, 0
   je .done

   mov [pla2x], ecx

   mov eax, 0x3
   mov [color], eax

   call drawPlayer

   mov eax, [pla2x]
   add eax, 5
   mov [cornerX], eax
   mov eax, [pla2Y]
   mov [cornerY], eax

   mov word [height], 5 
   mov word [width],  3

   mov eax, 0x09
   mov [color], eax

   call drawBox

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

   cmp ebx, 24
   jle .false

   cmp ebx, 170
   jg .false


;.....second square
   cmp eax, 63
   jl .true

   cmp eax, 252
   jg .true

   cmp ebx, 51
   jl .true

   cmp ebx, 144
   jg .true

   jmp .false

.false: 
   mov al, 0
   jmp .done
.true: 
   mov al, 1
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

   call drawBox

   ret


;.....................timer.........................;
Timer_Event:
   cli
   mov eax, [timer]
   inc eax
   mov [timer], eax
   xor edx, edx 
   mov ebx, 60 
   div ebx 
   mov [number], eax

   call print_timer_value
   call drawFinishLine


   ; first boot
   mov eax, [boot1x]
   mov [bootX], eax
   mov eax, [boot1y]
   mov [bootY], eax

   call moveBoot

   mov [boot1x], eax
   mov [boot1y], ebx

   ; second boot

   mov eax, [boot2x]
   mov [bootX], eax
   mov eax, [boot2y]
   mov [bootY], eax

   call moveBoot

   mov [boot2x], eax
   mov [boot2y], ebx

   ;third boot

   mov eax, [boot3x]
   mov [bootX], eax
   mov eax, [boot3y]
   mov [bootY], eax

   call moveBoot

   mov [boot3x], eax
   mov [boot3y], ebx
   sti
   ret

timer_interrupt:
   call Timer_Event
   mov al, 0x20
   out 0x20, al
   iret

Timer_Setup:
   cli 
   mov al, 00110100b                      ; Channel 0, lobyte/hibyte, rate generator
   out pit_command, al
   ; Set the divisor
   mov ax, divisor
   out pit_channel_0, al                  ; Low byte
   mov al, ah
   out pit_channel_0, al                  ; High byte
   ; Set up the timer ISR
   mov word [0x0020], timer_interrupt
   mov word [0x0022], 0x0000              ; Enable interrupts

   sti 
   ret

;.......................print..........................;
print_timer_value:
    ; Convertir valor numérico de 'timer' a cadena decimal
    mov eax, [number]           ; Cargar el valor de 'timer' en EAX

    lea di, [string + 5] ; DI ← dirección del último carácter (al final de la cadena de 5 dígitos)

    ; Vamos a convertir EAX a decimal y ponerlo en los 5 dígitos de timer_string
    mov cx, 5                  ; Necesitamos 5 dígitos
.convert_loop:
    xor edx, edx               ; Limpiar EDX (división de 32 bits requiere EDX:EAX)
    mov ebx, 10                ; Divisor = 10 para extraer dígitos decimales
    div ebx                    ; EAX / 10 → cociente en EAX, residuo (dígito) en EDX
    add dl, '0'                ; Convertimos el dígito a ASCII ('0'..'9')
    
    mov [di-1], dl             ; Escribimos el dígito al revés (de derecha a izquierda)
    dec di                     ; Mover DI hacia atrás para el siguiente dígito

    loop .convert_loop         ; Repetimos para los siguientes dígitos

    ; Mostrar la cadena actualizada (timer_string)
    lea si, [string]     ; Cargar la dirección de 'timer_string'
    call print_string          ; Mostrar la cadena con el número actualizado

    ret                        ; Fin de print_timer_value


print_string:
    ; Mover el cursor a la posición (0, 0)
    mov ah, 0x02              ; Función para mover el cursor
    mov bh, 0x00              ; Página de video (0 para la pantalla principal)
    mov dh, 0x00              ; Fila (0 para la primera fila)
    mov dl, 0x00              ; Columna (0 para la primera columna)
    int 0x10                  ; Llamar a la interrupción para mover el cursor

    ; Imprimir la cadena
.print_char:
    mov al, [si]              ; Cargar el siguiente carácter de la cadena
    inc si                    ; Avanzar al siguiente carácter de la cadena
    cmp al, 0                 ; Comprobar si es el fin de la cadena (carácter nulo)
    je .done                  ; Si es nulo, terminamos
    mov ah, 0x0E              ; Función para imprimir un carácter en pantalla (modo texto)
    int 0x10                  ; Llamar a la interrupción de video para imprimir
    jmp .print_char           ; Volver al siguiente carácter
.done:
    ret                       ; Fin de la rutina
;..........................boots......................;

boots: 
   mov eax, 95   ;95
   mov [carY], eax

   mov eax, 45  ;45
   mov [carx], eax

   mov eax, 0x4
   mov [color], eax

   call drawPlayer
   mov eax, 95   ;95
   mov [carY], eax

   mov eax, 55  ;45
   mov [carx], eax

   mov eax, 0x5
   mov [color], eax

   call drawPlayer

   mov eax, 95   ;95
   mov [carY], eax

   mov eax, 50  ;45
   mov [carx], eax

   mov eax, 0x6
   mov [color], eax

   call drawPlayer

   ret




moveBoot: 

   mov ecx, [bootY]
   mov eax, 155
   cmp ecx, eax
   jge .fourthLine

   mov ecx, [bootX]
   mov eax, 270
   cmp ecx, eax
   jge .thirdLine

   mov ecx, [bootY]
   mov eax, 45
   cmp ecx, eax
   jle .secondLine



   jmp .firstLine
   
.firstLine: 
   

   mov eax, [bootY]
   dec eax
   mov [carY], eax
   mov ecx, eax

   mov eax, [bootX]
   mov [carx], eax

   call validatePos
   cmp byte al, 0
   je .done

   
   mov [bootY], ecx

   mov eax, 0x1
   mov [color], eax

   call drawPlayer

   mov eax, [bootY]
   add eax, 5 
   mov [cornerY], eax 
   mov eax, [bootX]
   mov [cornerX], eax

   mov word [width], 5
   mov word [height],1

   mov eax, 0x09
   mov [color], eax


   call drawBox
   jmp .done

.secondLine: 

   mov ecx, [bootX]
   mov eax, 270
   cmp ecx, eax
   jge .done

   mov eax, [bootX]
   inc eax
   mov [carx], eax
   mov ecx, eax

   mov eax, [bootY]
   mov [carY], eax

   call validatePos
   cmp byte al, 0
   je .done

   mov [bootX], ecx

   mov eax, 0x1
   mov [color], eax

   call drawPlayer

   mov eax, [bootX]
   dec eax
   mov [cornerX], eax
   mov eax, [bootY]
   mov [cornerY], eax

   mov word [height], 5 
   mov word [width],  1

   mov eax, 0x09
   mov [color], eax

   call drawBox

   jmp .done

.thirdLine: 
   mov ecx, [bootY]
   mov eax, 155
   cmp ecx, eax
   jge .done

   mov eax, [bootY]
   inc eax
   mov [carY], eax
   mov ecx, eax

   mov eax, [bootX]
   mov [carx], eax

   call validatePos
   cmp byte al, 0
   je .done

   
   mov [bootY], ecx

   mov eax, 0x1
   mov [color], eax

   call drawPlayer

   mov eax, [bootY]
   dec eax
   mov [cornerY], eax 
   mov eax, [bootX]
   mov [cornerX], eax

   mov word [width], 5
   mov word [height],1

   mov eax, 0x09
   mov [color], eax


   call drawBox
   jmp .done

.fourthLine: 
   mov ecx, [bootX]
   mov eax, 45
   cmp ecx, eax
   jle .firstLine

   mov eax, [bootX]
   dec eax
   mov [carx], eax
   mov ecx, eax

   mov eax, [bootY]
   mov [carY], eax

   call validatePos
   cmp byte al, 0
   je .done

   mov [bootX], ecx

   mov eax, 0x1
   mov [color], eax

   call drawPlayer

   mov eax, [bootX]
   add eax, 5
   mov [cornerX], eax
   mov eax, [bootY]
   mov [cornerY], eax

   mov word [height], 5 
   mov word [width],  1

   mov eax, 0x09
   mov [color], eax

   call drawBox

   jmp .done

   


.done: 
   mov eax, [bootX]
   mov ebx, [bootY]

   ret 


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
keyval    db 0x0

pla1x     dd 0x0
pla1Y     dd 0x0
pla2x     dd 0x0
pla2Y     dd 0x0

boot1y    dd 95
boot1x    dd 40
boot2y    dd 95
boot2x    dd 50
boot3y    dd 95
boot3x    dd 60
bootY    dd 0x0
bootX    dd 0x0

number dd 0x0    
timer dd 0x0                   ; Temporizador en valor numérico
string db '00000', 0

carx      dd 0x0
carY      dd 0x0
