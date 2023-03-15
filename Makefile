all: main

main : printf.o
	ld printf.o -o main

printf.o : printf.s 
	nasm -f elf64 -g printf.s -o printf.o