org 0x7E00

pit_command equ 0x43
pit_channel_0 equ 0x40
divisor equ 19886
 

;.....................main....................; 

main:
   mov al, 0x13
   int 0x10
   
   call drawTrack
   

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

   mov eax, 55  ;45
   mov [carx], eax
   mov [pla2x], eax

   mov eax, 0x77
   mov [color], eax

   call drawPlayer

   mov eax, 0
   mov [timer], eax
   call boots
   call Timer_Setup
   call SetupKeyboardInterupt

   mov byte [column], 0
   lea si, [timerText]
   call print_string
   mov byte [column], 2

   mov byte [column], 0
   mov byte [row], 1
   lea si, [p1text]
   call print_string
   mov byte [column], 2

   mov byte [column], 0
   mov byte [row], 2
   lea si, [p2text]
   call print_string
   mov byte [column], 2

   mov byte [column], 0
   mov byte [row], 3
   lea si, [B1text]
   call print_string
   mov byte [column], 2

   mov byte [column], 0
   mov byte [row],4
   lea si, [B2text]
   call print_string
   mov byte [column], 2

   mov byte [column], 0
   mov byte [row],5
   lea si, [B3text]
   call print_string
   mov byte [column], 2
  
   
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

   mov eax, 0x01
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

   mov eax, 0x77
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

   mov eax, 0x77
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

   mov eax, 0x77
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

   mov eax, 0x77
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
   ;---Timer---;
   cli
   mov eax, [timer]
   inc eax
   mov [timer], eax
   xor edx, edx 
   mov ebx, 60 
   div ebx 
   mov [number], eax
   mov byte [row], 0x0
   call print_timer_value
   ;----Finish Line----;
   call drawFinishLine

 
   ;----Boots motion----; 
   ; first boot
   mov eax, [boot1x]
   mov [bootX], eax
   mov eax, [boot1y]
   mov [bootY], eax
   mov eax, 0x55
   mov [color], eax



   call moveBoot

   mov [boot1x], eax
   mov [boot1y], ebx

   ; second boot

   mov eax, [boot2x]
   mov [bootX], eax
   mov eax, [boot2y]
   mov [bootY], eax
   mov eax, 0x3
   mov [color], eax


   call moveBoot

   mov [boot2x], eax
   mov [boot2y], ebx

   ;third boot

   mov eax, [boot3x]
   mov [bootX], eax
   mov eax, [boot3y]
   mov [bootY], eax
   mov eax, 0x2
   mov [color], eax


   call moveBoot

   mov [boot3x], eax
   mov [boot3y], ebx

   ;....Counting playes points....; 
   mov eax, [followTrackP1]
   mov [followTrackP], eax
   mov eax, [pla1Y]
   mov [plaYT], eax
   mov eax, [pointsP1]
   mov [points], eax
   call countingPoints
   mov eax, [followTrackP]
   mov [followTrackP1], eax
   mov eax, [points]
   mov [pointsP1], eax
   mov [number], eax

   mov byte [row], 0x1
   call print_timer_value

   mov eax, [followTrackP2]
   mov [followTrackP], eax
   mov eax, [pla2Y]
   mov [plaYT], eax
   mov eax, [pointsP2]
   mov [points], eax
   call countingPoints
   mov eax, [followTrackP]
   mov [followTrackP2], eax
   mov eax, [points]
   mov [pointsP2], eax
   mov [number], eax

   mov byte [row], 0x2
   call print_timer_value

   mov eax, [followTrackB1]
   mov [followTrackP], eax
   mov eax, [boot1y]
   mov [plaYT], eax
   mov eax, [pointsB1]
   mov [points], eax
   call countingPoints
   mov eax, [followTrackP]
   mov [followTrackB1], eax
   mov eax, [points]
   mov [pointsB1], eax
   mov [number], eax

   mov byte [row], 0x3
   call print_timer_value

   mov eax, [followTrackB2]
   mov [followTrackP], eax
   mov eax, [boot2y]
   mov [plaYT], eax
   mov eax, [pointsB2]
   mov [points], eax
   call countingPoints
   mov eax, [followTrackP]
   mov [followTrackB2], eax
   mov eax, [points]
   mov [pointsB2], eax
   mov [number], eax

   mov byte [row], 0x4
   call print_timer_value

   mov eax, [followTrackB3]
   mov [followTrackP], eax
   mov eax, [boot3y]
   mov [plaYT], eax
   mov eax, [pointsB3]
   mov [points], eax
   call countingPoints
   mov eax, [followTrackP]
   mov [followTrackB3], eax
   mov eax, [points]
   mov [pointsB3], eax
   mov [number], eax

   mov byte [row], 0x5
   call print_timer_value

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
    mov eax, [number]           

    lea di, [string + 2] 
    mov cx, 2                  
.convert_loop:
    xor edx, edx               
    mov ebx, 10                
    div ebx                    
    add dl, '0'                
    
    mov [di-1], dl             
    dec di                     

    loop .convert_loop         
    lea si, [string]     
    call print_string          
    ret                        ; Fin de print_timer_value


print_string:
    ; Mover el cursor a la posición (0, 0)
    mov ah, 0x02              
    mov bh, 0x00                
    mov dh, [row]            
    mov dl, [column]            
    int 0x10                
.print_char:
    mov al, [si]              
    inc si                    
    cmp al, 0                
    je .done                  
    mov ah, 0x0E              
    int 0x10                  
    jmp .print_char           
.done:
    ret                       ; Fin de la rutina

;....................counting points..................; 

countingPoints: 
   mov eax, [followTrackP]
   mov ebx, 1
   cmp eax, ebx
   jne .firstTrack 

   mov eax, [plaYT]
   mov ebx, 100
   cmp eax, ebx
   jge .done

   mov eax, [points]
   inc eax
   mov [points], eax 
   mov eax, 0
   mov [followTrackP], eax

   jmp .done

   
.firstTrack: 

   mov eax, [plaYT]
   mov ebx, 145
   cmp eax, ebx
   jl .done

   mov eax, 1
   mov [followTrackP], eax


.done: 
   ret
;...................choose winer......................; 

chooseWiner: 
   mov eax, [pointsP1]
   mov [pointsBP], eax 
   mov eax, 1
   mov [indexBP], eax

.firstComp:
   mov eax, [pointsBP]
   mov ebx, [pointsP2]

   cmp ebx,eax 
   jle .secondComp

   mov [pointsBP], ebx
   mov eax, 2
   mov [indexBP], eax

.secondComp: 
   mov eax, [pointsBP]
   mov ebx, [pointsB1]

   cmp ebx,eax 
   jle .thirdComp

   mov [pointsBP], ebx
   mov eax, 3
   mov [indexBP], eax

.thirdComp: 
   mov eax, [pointsBP]
   mov ebx, [pointsB2]

   cmp ebx,eax 
   jle .fourthComp

   mov [pointsBP], ebx
   mov eax, 4
   mov [indexBP], eax

.fourthComp:
   mov eax, [pointsBP]
   mov ebx, [pointsB3]

   cmp ebx,eax 
   jle .fourthComp

   mov [pointsBP], ebx
   mov eax, 5
   mov [indexBP], eax

   jmp .done

.done: 
   ret
   



;..........................boots......................;

boots: 
   mov eax, [boot1y]   ;95
   mov [carY], eax

   mov eax, [boot1x]  ;45
   mov [carx], eax

   mov eax, 0x4
   mov [color], eax

   call drawPlayer
   mov eax, [boot2y]   ;95
   mov [carY], eax

   mov eax, [boot2x]  ;45
   mov [carx], eax

   mov eax, 0x5
   mov [color], eax

   call drawPlayer

   mov eax, [boot3y]   ;95
   mov [carY], eax

   mov eax, [boot3x] ;45
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
   mov [bootY], eax

   mov eax, [bootX]
   mov [carx], eax

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
   mov eax, [bootX]
   inc eax

   mov [bootX], eax
   mov [carx], eax

   mov eax, [bootY]
   mov [carY], eax

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
   mov [bootY], eax

   mov eax, [bootX]
   mov [carx], eax

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
   mov [bootX], eax

   mov eax, [bootY]
   mov [carY], eax

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
bootY     dd 0x0
bootX     dd 0x0

pointsP1 dd 0x0
pointsP2 dd 0x0 
pointsB1 dd 0x0
pointsB2 dd 0x0
pointsB3 dd 0x0
points   dd 0x0

followTrackP1 dd 0x0
followTrackP2 dd 0x0
followTrackB1 dd 0x0
followTrackB2 dd 0x0
followTrackB3 dd 0x0

followTrackP dd 0x0
plaYT        dd 0x0

row db 0x0
column db 0x2

pointsBP dd 0x0
indexBP  dd 0x0


number dd 0x0    
timer dd 0x0                   ; Temporizador en valor numérico
string db '00', 0
timerText db 'Ti', 0
p1text db 'P1', 0
p2text db 'P2', 0
B1text db 'B1', 0
B2text db 'B2', 0
B3text db 'B3', 0
carx      dd 0x0
carY      dd 0x0
