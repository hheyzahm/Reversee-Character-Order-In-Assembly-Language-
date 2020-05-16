data segment
  msg db 60 dup(?)
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:

    mov ax,@data
    mov ds,ax
    mov si,offset msg

input: 
    mov ah,1
    int 21h
    cmp al,13
    je display
    mov [si],al
    inc si
    jmp input

display:
    mov [si],'$'
    mov di,offset msg
    mov dl,13
    mov ah,02h
    int 21h
    mov dl,10
    mov ah,02h
    int 21h
    mov cx,0

again:
    cmp [di],'$'
    je LAST
    cmp [di],32
    je FOR
    mov dl,[di]
    push dx
    inc di
    inc cx
    jmp again

for:
    mov ax,00
    pop ax
    mov dx,ax
    mov ah,02h
    int 21h
   
   loop for
next:   
        mov cx,0
        mov dl,32
        mov ah,2
        int 21h
        inc di
        jmp again

last:
mov ax,00
    pop ax
    mov dx,ax
    mov ah,02h
    int 21h
   
   loop last
END:    
    mov ax, 4c00h
    int 21h  

ends

end start
