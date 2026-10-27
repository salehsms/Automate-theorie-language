%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "stack.h"
    #include "cal.h"

    // Definition des variables globales qui sont declaresees dans cal.h
    int mem[MEM_SIZE];
    stack pile;
    states state = WAIT ;
    lexical_values lexval;

%}


%%

"."    return DOT;

"?"    return QMARK;

"!"    return EXMARK;
"$"    return DOLLAR;

[-+*/]   {lexval.op = yytext[0]; return OP ;}

[0-9]+   {lexval.num = atoi(yytext); return NUM ;}

m[0-9]+   {lexval.var = atoi(yytext +1); return VAR ;}

[ \t\n]     ;
.        return ERR;

%%

int yywrap(void) {
    return 1;
}

/* Affiche un message d'erreur et passe a l'etat SKIP*/

void erreur(char *msg) {
    printf("Erreur : %s\n", msg);
    state = SKIP;
}

// Verifions que le numero de variable est valide( 1 .. MEM_SIZE -1)

int var_valide(int i) {
    if( i< 1 || i >= MEM_SIZE) {
        erreur("variable inexistante");
        return 0;
    }
    return 1;
}

int main(void ) {
    int tok , a,b,r;
    int fini = 0;

    pile = new_stack();
    mem[0] = 0;


    while(!fini && (tok = yylex()) != 0) {
        switch(tok) {
            case DOT:
                if(state == WAIT) {
                    fini = 1;
                }else if( state == EVALCMD) {
                    if(is_empty(pile)) {
                        printf("Erreur : expression vide\n");
                    }else {
                        r = top(pile);
                        pop(pile);
                        if(!is_empty(pile)) {
                            printf("Erreur : expression mal formee\n");

                        }else {
                            mem[0] = r;
                            printf("= %d\n", r);
                        }
                    }
                    state = WAIT ;

                }else {
                    state =  WAIT;
                }
                break;
            case QMARK:
                if(state == WAIT) {
                    while(!is_empty(pile))
                        pop(pile);
                    state = EVALCMD;
                }else if(state != SKIP) {
                    erreur("'?' inattendu");
                }
                break;
            case EXMARK:
                if(state == WAIT){
                    state = STOCMD;
                }else if( state != SKIP) {
                    erreur("'!' inattendu");
                }
                break;
            case DOLLAR:
                if(state == WAIT){
                    state = DISCMD;
                }else if( state != SKIP) {
                    erreur("'$' inattendu");
                }
                break;
            case OP:
                if(state == EVALCMD) {
                    if(is_empty(pile)) {
                        erreur("operande manquante");
                        break;
                    }
                    b = top(pile);
                    pop(pile);
                    if(is_empty(pile)) {
                        erreur("operande manquante");
                        break;
                    }
                    a = top(pile);
                    pop(pile);
                    switch(lexval.op) {
                        case '+' : r = a+b; break;
                        case '-' : r = a-b; break;
                        case '*' : r = a*b; break;
                        default:
                            if(b==0) {
                                erreur("division par zero");
                                r= 0;
                            }else {
                                r = a/b;
                            }

                    }
                    if(state == EVALCMD) {
                        push(r,pile);
                    }
                }else if( state != SKIP) {
                    erreur("operateur inattendu");
                }
                break;
            case NUM:
                if(state == EVALCMD) {
                    if(is_full(pile)) {
                        erreur("pile pleine");
                    }else {
                        push(lexval.num, pile);
                    }
                }else if( state != SKIP) {
                    erreur("nombre inattendu");
                }
                break;
            case VAR:
                if( state == SKIP) {
                    break ;
                }
                if( state == DISCMD) {
                    if(var_valide(lexval.var)) {
                        printf("m%d = %d\n", lexval.var , mem[lexval.var]);

                    }
                }else if( state == EVALCMD) {
                    if(var_valide(lexval.var)) {
                        if(is_full(pile)) {
                            erreur("pile pleine");
                        }else {
                            push(mem[lexval.var], pile);
                        }
                    }
                }else if ( state == STOCMD) {
                    if(var_valide(lexval.var)) {
                        mem[lexval.var] = mem[0];
                    }
                }else {
                    erreur("variable inattendue");
                }
                break;
            default : /* ERR : caractere errone*/
                if(state != SKIP) {
                    erreur("caractere errone");
                }
                break;
            

        }
    }
    return 0;
}