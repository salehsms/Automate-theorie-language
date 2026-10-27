#include <stdio.h>
#include <stdlib.h>

#include "stack.h"


stack new_stack(void) {
    stack s = malloc(sizeof(struct stack_s));
    if(s == NULL) {
        printf("Erreur : plus de memoire\n");
        exit(1);
    }
    s->nb = 0;
    return s ;
}

// fonction empiler
void push(int x, stack s) {
    if(is_full(s)) {
        printf("Erreur : pile pleine\n");
        exit(1);
    }
    s->tab[s->nb] = x;
    s->nb++;
}


// Valeur du somment  de pile
int top(stack s) {
    if(is_empty(s)) {
        printf("Erreur : pile vide\n");
        exit(1);
    }
    return s->tab[s->nb -1];

}

// Depiler
void pop(stack s) {
    if(is_empty(s)) {
        printf("Erreur : pile vide\n");
        exit(1);
    }
    s->nb--;

}


// 1 si la pile est vide , 0 sinon 
int is_empty(stack s) {
    return s->nb == 0 ;
}

// 1 si la pile est pleine, 0 sinon
int is_full(stack s) {
    return s->nb == STACK_SIZE ;
}