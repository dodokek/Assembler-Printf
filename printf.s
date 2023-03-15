section .text

global _start


;--------------------------------

_start:

    mov eax,0x1          ; exiting the application like cool progers
	mov ebx,0            ; err code = 0
	int 80h              ; calling interrupt


section .data

db	