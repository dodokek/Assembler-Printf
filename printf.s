section .data

buffer: times 64 db 12

template_str: db "Ya pidoras", 0

;------------------------------------------------

section .text

global _start

_start:

	mov rsi, template_str
	call PrintfMain

    mov eax,0x1          ; exiting the application like cool progers
	mov ebx,0            ; err code = 0
	int 80h              ; calling interrupt


;------------------------------------------------
; Prints arguments in the cmd according to 
; template string
;------------------------------------------------
;  Entry: rsi - pointer to template string
;  		  r1  - first arg
;		  r2  - second arg
;
;  Destroys:
;
;  Expects: template strings ends on \0
;------------------------------------------------

PrintfMain:

.loop:
	mov al, [rsi]	; al = *tmpl_string

	cmp al, 0	; if al == \0 then return
	je .end

	cmp al, '%'		; if al == % then handle argument
	; je HandleArg

	call Putch		; print char


	inc rsi			; ptr++
	jmp .loop

.end:
	ret


Putch:

	push rcx 	; i still havent figure out, but syscall destroys rcx and r11, so restore them
	push r11

	mov rdx, 1   ; msg len
	mov rdi, 1	 ; file descriptor
	mov rax, 1   ; syscall for write()
;   mov rsi, rsi ; no need cuz in prev func it is already set

	syscall

	pop r11
	pop rcx

	ret
