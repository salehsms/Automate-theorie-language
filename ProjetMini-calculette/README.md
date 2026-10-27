#### LE PROJET ALGO5 MINI-CACULETTE

**SALEH MAMAHAMT Saleh ***

`Principe`
Calculette en notation postfixée. Lex découpe la ligne en lexèmes; le main dans cal.l réagit selon l'état courant. En plus on avait utilisé une pile et aussi parcourt infixe qu'on avais vu ça dans le cours d'algo les `arbres`.

# Compilation  et exécution
```bash 
    make 
    ./cal < test.in # ou ./cal pour taper les cmd au clavier comme je l'ai effectué au dessous.
    make clean
```
Commandes , chaque ligne se termine par un point.

|Commande |	Effet

|? expr . |	Évalue expr, affiche =résultat, le range dans mem[0]

|! mi .	  | Copie le dernier résultat (mem[0]) dans la variable mi
|$ mi .	  | Affiche la valeur de mi
|.	      | Quitte

Variables : m1 à m9 (mem[0]) est le tampon interne .

`Lexèmes`{DOT . · QMARK ? · EXMARK ! · DOLLAR $ · OP + - * / · NUM [0-9]+ · VAR m[0-9]+ · ERR tout autre caractère}

`Etas`{WAIT (attente) · EVALCMD (évaluation) · STOCMD (sauvegarde) · DISCMD (affichage) · SKIP (ignore jusqu'au prochain point)}

Pour chaque lexéme : action prévue dans l'état attendu ; rien en SKIP ; sinon message d'erreur puis SKIP.

# Évaluation postfixée

Nombre ou variable : on empile. Opérateur : on dépile 2 valeurs, on calcule, on empile le résultat. 2 m1 + 4 + avec m1 = 3 : [2] → [2,3] → [5] → [5,4] → [9]

### Erreurs gérées

Caractère erroné · lexème inattendu pour l'état · opérande manquante · division par zéro · expression vide ou mal formée (valeurs en trop) · variable inexistante · pile pleine.  


# Les testes qui peuvent justifier la fonctionnalité du mini-calculette.

```bash 
saleh@saleh-HP-EliteBook-840-G3:~/Documents/Artois/ALGO5/TP5mini-calculette$ ls
cal  cal.c  cal.h  cal.l  cal.o  Makefile  stack.c  stack.h  stack.o
saleh@saleh-HP-EliteBook-840-G3:~/Documents/Artois/ALGO5/TP5mini-calculette$ ./cal
? 2 3 + .
= 5
! m1 .
$ m1 .
m1 = 5
? 2 m1 + 4 + .
= 11
! m2 .
? m2 m1 * 10 - .
= 45
? 8 0 / .
Erreur : division par zero
? 1 + .
Erreur : operande manquante
? 1 2 .
Erreur : expression mal formee
? 5 @ 3 + .
Erreur : caractere errone
$ m1 m2 .
m1 = 5
m2 = 11
? 7 ? .
Erreur : '?' inattendu
2 .
Erreur : nombre inattendu
? 20 4 / 3 - .
= 2
.


```