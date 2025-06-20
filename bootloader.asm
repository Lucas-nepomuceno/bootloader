org 0x0

_start:
    jmp short start
    nop

times 33 db 0

jmp main

main:
    cli
    mov ax, 0x7c0
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax
    mov sp, 0x7c00
    sti
    mov si, ola
    call puts 
                            
    mov si, nova_linha
    call puts

    xor si, si      ; reinicializa a contagem de caractere com 0 
    
.read_char:
    mov ah, 0x00             
    int 0x16                 ; lê a entrada do usuario e manda para al 
    
    cmp al, 0Dh                  ; compara al com enter
    je .done_input                      ;se for igual, termina o input 
    
    mov ah, 0Eh
    int 10h                ; expoe o que o usuario está digitando
    
    mov byte [buffer_space + si], al         ;senao, coloca no buffer o caractere
    inc si                              ;incrementa a contagem de caractere
    jmp .read_char                      ;reinicia

.done_input:                            
    mov cx, si
    mov byte [buffer + 1], cl
    mov byte [buffer_space + si], 0  ; termina a string com zero

    mov si, nova_linha
    call puts
    mov si, saudacao
    call puts

    mov si, buffer_space
    call puts 
      
    mov si, nova_linha
    call puts

start:
    jmp 0x7c0:main
    ret

; ---------- declara variaveis ----------
nova_linha: db 0Dh, 0Ah, 0    
saudacao:   db 'Ola, ', 0
ola:        db 'Qual seu nome?', 0  

buffer:
    db 255         ; comprimento máximo da entrada
    db 0           ; comprimento real digitado
    buffer_space db 255 dup (0) ; espaço para armazenar a string digitada


; ---------- funções de imprimir----------
putch:
    mov al, [si]
    mov ah, 0Eh
    int 10h
    ret
    
puts:
    call putch
    inc si
    cmp byte [si], 0
    jnz puts
    ret

times 510 - ($ - $$) db 0
dw 0xAA55