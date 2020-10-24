#ifndef STACK_H
#define STACK_H
#define MAX_SIZE 10000
#include <stdbool.h>

typedef struct {
    int size;
    char **content;
}PikachuStack;

/* CREATE A STACK OF GIVEN SIZE */
PikachuStack *createPikachuStack();

/* GET THE SIZE OF A PIKACHU STACK */
int getSize(PikachuStack *pikachuStack);

/* CHECK IF A STACK IS EMPTY */
bool isEmpty(PikachuStack *pikachuStack);

/* CHECK IF A STACK IS FULL */
bool isFull(PikachuStack *pikachuStack);

/* PRINT A STACK */
void printPikachuStack(PikachuStack *pikachuStack);

/* ADD AN ELEMENT--ITEM-- TO A STACK SPECIFIED AS THE FIRST PARAMETER */
void push(PikachuStack *pikachuStack, char *item);

/* GET THE FIRST ADDED ELEMENT FROM A STACK SPECIFIED AS PARAMETER */
char* pop(PikachuStack *pikachuStack);

/* GET THE LAST ADDED ELEMENT FROM A STACK SPECIFIED AS PARAMETER */
char* top(PikachuStack *pikachuStack);

/* GET THE LAST ADDED ELEMENT FROM A STACK SPECIFIED AS PARAMETER WITHOUT DELETING IT */
char* peek(PikachuStack *pikachuStack);
#endif
