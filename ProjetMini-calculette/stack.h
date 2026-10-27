#ifndef STACK_H
#define STACK_H


#define STACK_SIZE 100 // La taille maximale de la pile

// Notre structure pile

typedef struct stack_s {
    int tab[STACK_SIZE];
    int nb ;

} *stack;

// Creation d'une nouvelle pile
stack new_stack(void);

// fonction empiler
void push(int , stack);

// Valeur du somment  de pile
int top(stack);

// Depiler
void pop(stack);


// 1 si la pile est vide , 0 sinon 
int is_empty(stack);

// 1 si la pile est pleine, 0 sinon
int is_full(stack);

#endif


