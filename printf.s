section .data

template_str: 		db "Hello there %d", 0	; template string

buffer: times 64 	db 12					; buffer

hex_letters: 		db "ABCDEF"				; for printing hex numbers

string_buffer: times 16 db 0			; for translator to store the number to print

string_help_buffer: times 16 db 0		; for reversing number string

;------------------------------------------------

section .text

global _start

_start:

	mov eax, 165d		; translating digit to base_2
	xor ecx, ecx
	mov cl, 4d
	call Base2ToCmd

	

    mov eax,0x1          ; exiting the application like cool progers
	mov ebx,0            ; err code = 0
	int 80h              ; calling interrupt


;------------------------------------------------
; Prints arguments in the cmd according to 
; template string
;------------------------------------------------
;  Entry: rsi - pointer to template string
;  		  r8  - first arg
;		  r9  - second arg
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


;------------------------------------------------
; Translates value in eax into bin, oct or hex 
; template string
;------------------------------------------------
;  Entry: eax - value to translate
;  		  rcx - base 2^(1, 3, 4) = 2, 8, 16 = bin, oct, hex
;
;  Destroys: eax, ebx, edx
;
;  Expects: template strings ends on \0
;------------------------------------------------

Base2ToCmd:
	push rsi
	push rdi

	mov rsi, string_buffer

.loop:
	
	mov ebx, eax

	shr ebx, cl
	shl ebx, cl
	mov edx, eax
	sub edx, ebx	; now in edx - surplus
	
	shr eax, cl		; no in eax - res of division
	
	cmp edx, 10d	; checking if there are need to print letters like A,B,C,D,E,F
	jl .not_hex

	add edx, 55d	; to ASCII letter

	jmp .is_hex
.not_hex:	
	add edx, 48d	; to ASCII digit
.is_hex:

	mov [rsi], edx	; string_buffer = on of the digits in the number
	inc rsi			; ptr++

	cmp eax, 0
	jne .loop

	call ReverseAndPrint
	

	pop rdi
	pop rsi
	ret



;------------------------------------------------
;  Copies reverted string to another buffer and prints it 
;------------------------------------------------
;  Entry: rsi - pointer to end of the string to revert
;
;  Destroys: 
;
;  Expects: 
;------------------------------------------------
ReverseAndPrint: 

	;-------Now reversing the string upside-down-----

	mov rdi, string_help_buffer
	dec rsi	; setting ptr to end of string buffer
.reverse:

	mov ah, byte [rsi]		; string_buffer[n-i] = string_help_buffer[i]
	mov byte [rdi], ah

	inc rdi
	dec rsi

	cmp rsi, string_buffer - 1 
	jne .reverse

	;-------Printing the string we got--------------

	mov byte [rdi], 5
	mov rsi, string_help_buffer
	call Puts

	ret



;------------------------------------------------
; Prints symbol in console 
;------------------------------------------------
;  Entry: rsi - pointer to symbol to print
;
;  Destroys: rdx, rdi, rax
;
;  Expects: 
;------------------------------------------------

Putch:

	push rcx     ; i still havent figure out, but syscall destroys rcx and r11, so restore them
	push r11

	mov rdx, 1   ; msg len
	mov rdi, 1	 ; file descriptor
	mov rax, 1   ; syscall for write()
;   mov rsi, rsi ; no need cuz in prev func it is already set

	syscall

	pop r11
	pop rcx

	ret


;------------------------------------------------
; Prints string in console until \0
;------------------------------------------------
;  Entry: rsi - pointer to string
;
;  Destroys: 
;
;  Expects: template strings ends on \0
;------------------------------------------------

Puts:

.loop:
	
	cmp byte [rsi], 0
	je .end_loop

	call Putch
	inc rsi

	jmp .loop
.end_loop:

	mov byte [rsi], 10d	; new line symb
	call Putch

	ret


