assume cs:code, ds:data, ss:stack

data segment
	
	db	'chou sha bi !!!!'
	db 	01000010B
	db	11000010B
	db	01001010B
	db	00000111B
	db	01110001B

data ends

stack segment stack
	db	128 dup (0)
stack ends



code segment

	start:  mov ax, stack
		mov ss, ax
		mov sp, 128
		
		mov bx, data
		mov ds, bx

		mov bx, 0B800H
		mov es, bx

		mov si, 0
		mov bx, 16
		mov di, 160*8 + 30*2
		call show_shabi

		mov ax, 4C00H
		int 21H

show_shabi:	push ax
		push bx
		push cx
		push ds
		push es
		push si
		push di

		mov cx, 3

show:		push si
		push di
		push cx
		mov cx, 16

showShabi:	mov al, ds:[si]
		mov ah, ds:[bx]
		mov es:[di], ax
		add di, 2
		inc si
		loop showShabi

		pop cx
		pop di
		pop si
		add di,160
		loop show

		pop di
		pop si
		pop es
		pop ds
		pop cx
		pop bx
		pop ax
		ret

code ends

end start
