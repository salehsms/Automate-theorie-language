# Variables

# But principal

cal : cal.o stack.o
	gcc cal.o stack.o -o cal

stack.o : stack.c stack.h
	gcc -c stack.c 

# De .lex a .c
cal.c : cal.l cal.h stack.h
	lex -t cal.l > cal.c 

cal.o : cal.c cal.h stack.h
	gcc -c cal.c 

# Le menage
clean :
	rm -f *.o *~ cal.c cal 