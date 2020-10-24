#include "stack.h"
#include <stdio.h>
#include <stdbool.h>

/* CREATE A STACK OF A GIVEN SIZE */
PikachuStack *createPikachuStack(){
    PikachuStack *pikachuStack = (PikachuStack*)malloc(sizeof(PikachuStack));
    pikachuStack->size = 0;
    pikachuStack->content = (char**)malloc(0 * sizeof(char*)); //null
    return pikachuStack;
}

/* GET THE SIZE OF A PIKACHU STACK */
int getSize(PikachuStack *pikachuStack){
    return pikachuStack->size;
}

/* CHECK IF A STACK IS EMPTY*/
bool isEmpty(PikachuStack *pikachuStack){
    if(pikachuStack->size == 0) return true;
    return false;
}

/* CHECK IF A STACK IS FULL */
bool isFull(PikachuStack *pikachuStack){
    if(pikachuStack->size == MAX_SIZE) return true;
    return false;
}

/* PRINT A STACK */
void printPikachuStack(PikachuStack *pikachuStack){
    for(int i = 0; i < pikachuStack->size; i++){
        printf("%s ", pikachuStack->content[i]);
    }
    printf("\n");
}

/* ADD AN ELEMENT --ITEM-- TO A STACK SPECIFIED AS THE FIRST PARAMETER */
void push(PikachuStack *pikachuStack, char *item){
    if(pikachuStack->size == MAX_SIZE){
        printf("FULLSTACK");
        return;
    }
    pikachuStack->content = (char**)realloc(pikachuStack->content, sizeof(char*)*(pikachuStack->size + 1));
    pikachuStack->content[pikachuStack->size++] = item;
}

/* GET THE FIRST ADDED ELEMENT FROM A STACK SPECIFIED AS PARAMETER */
char* pop(PikachuStack *pikachuStack){
    if(isEmpty(pikachuStack)) return NULL;
    char *poped = pikachuStack->content[0];
    int index = 0;
    while(index < pikachuStack->size - 1){
        pikachuStack->content[index] = pikachuStack->content[index + 1];
        ++index;
    }
    --pikachuStack->size;
    return poped;
}

/* GET THE LAST ADDED ELEMENT FROM A STACK SPECIFIED AS PARAMETER */
char* top(PikachuStack *pikachuStack){
    if(isEmpty(pikachuStack)) return NULL;
    return pikachuStack->content[--pikachuStack->size];
}

/* GET THE LAST ADDED ELEMENT FROM A STACK SPECIFIED AS PARAMETER WITHOUT DELETING IT */
char* peek(PikachuStack *pikachuStack){
    if(isEmpty(pikachuStack)) return NULL;
    return pikachuStack->content[pikachuStack->size - 1];
}
