#ifndef CAL_H
#define CAL_H

#include "stack.h"

/** Les unites leicales */

#define DOT 1   // . fin de la ligne de commande
#define QMARK 2 //  ? debut d'une evaluation
#define EXMARK 3 // ! debut d'une sauvegarde

#define DOLLAR 4 // $ debut d'un affichage
#define OP 5 // operateur +-*/ 
#define NUM 6 // Constante entiere

#define VAR 7 // nom de la variable : m1, m2 ,..

#define ERR 8 // On a ajouté cet unite lexicale si tout autre caractere (erreur)

/* Valeur associee aux unites lexicales OP, NUM ou VAR*/

typedef union {
    char op;
    int num;
    int var;
} lexical_values; // je dois changer lexical_values par values 


/**Les 5 etats de la calculette */

typedef enum {
    WAIT, DISCMD, STOCMD,
    EVALCMD, SKIP
}states; //  states par etas


#define MEM_SIZE 10 // mem[0] = tampon, mem[1..9] = m1..m9

/**Variables globales (on va le definir dans cal.l) */

extern int mem[MEM_SIZE]; // La memoire

extern stack pile; // La pile d'evaluation

extern states state ; // l'etat courant

extern lexical_values lexval ; // valeur du dernier lexeme


#endif