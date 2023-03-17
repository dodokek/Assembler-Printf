all: main

main : printf.o run_print.o
	gcc -no-pie run_print.o printf.o -o main

printf.o : printf.s 
	nasm -f elf64 -g printf.s -o printf.o

run_print.o : run_print.cpp
	gcc	-c run_print.cpp -o run_print.o

clear:
	rm *.o