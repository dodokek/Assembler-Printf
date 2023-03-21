section .data

test_string:		db "У меня %d хромосом", 10, 0

section .text
global main

extern printf

main:
    mov rax, -1

    push rbp

    mov rdi, test_string
    mov rsi, 10d

    mov  eax, 0     ; no f.p. args
    call printf
    
    
    pop rbp

ret
