%{
#include <stdio.h>
#include <stdlib.h>
#include "stack.c"
PikachuStack *piStack;
PikachuStack *pikaStack;
void operateOnStack(PikachuStack *pikachuStack);
char* ADD(char *topElement, char *nextTopElement);
char* SUBTRACT(char *topElement, char *nextTopElement);
char* MULTIPLY(char *topElement, char *nextTopElement);
char* DIVIDE(char *topElement, char *nextTopElement);
char* ASCII(char *topElement);
int *numberOfWords;
int lineNumber;
int number;
bool moveToLine;
%}

%union { char *pikachuSound; }
%token <pikachuSound> PI 
%token <pikachuSound> PIKA
%token <pikachuSound> PIKACHU 
%token SPACE NEW_LINE


%%
program : program line NEW_LINE {
	
	lineNumber++;
	printf("\n");

	if(number > 0) {
		--number;
		printf("I AM AT LINE %d, MOVING OVER %d LINES\n", lineNumber, number);
	}

	if(moveToLine == true){
		moveToLine = false;
		number = numberOfWords[lineNumber - 1];
		printf("I AM AT LINE %d, MOVING OVER %d LINES\n", lineNumber, number);
	}

	printf("WORKING WITH ***PI PIKACHU***\n");
	printPikachuStack(piStack);

	const char *s1 = pop(piStack);
	const char *s2 = pop(piStack);
		
	char *result = (char*)malloc(strlen(s1) + strlen(s2) + 2);
	strcpy(result, s2);
	strcat(result, " ");
	strcat(result, s1);

	printf("result = %s\n", result);
	
	if(strcmp(result, "pi pikachu") == 0){
		
		/* RULE *blank* pop the value on top of the pikachu */

		char *topElement = peek(piStack);
		if(topElement == NULL){

			printf("RULE *blank* pop the value on top of ***PI PIKACHU***\n");

			char *item = pop(piStack);
			if(item != NULL){
				printf("poped %s\n", item);
			}
			else{
				printf("ERROR ***STACK IS EMPTY*** (10000)");
			}
		}else{
			/* RULE inputs are initially added to ***PI PIKACHU*** stack */

			printf("WORKING WITH ***PI PIKACHU***\n");
			printPikachuStack(piStack);

			operateOnStack(piStack);
		}
	}else if(strcmp(result, "pika pikachu") == 0){

		/* RULE *blank* pop the value on top of the pikachu */

		char *topElement = peek(piStack);
		if(topElement == NULL){

			printf("RULE *blank* pop the value on top of ***PIKA PIKACHU***\n");

			char *item = pop(pikaStack);
			if(item != NULL){
				printf("poped %s\n", item);
			}
			else{
				printf("ERROR ***STACK IS EMPTY***(10001)");
			}
		}else{
			/* RULE *n number of terms* push all of them to the STACK */

			printf("WORKING WITH ***PIKA PIKACHU***\n");
		
			while(getSize(piStack) > 0){
			
				char *item = pop(piStack);
				push(pikaStack, item);
			}
			printPikachuStack(pikaStack);
		
			operateOnStack(pikaStack);
		}
	}else{
		/* the line is not ending with a pikachu stack, so operate on both of them */
		if(s1 != NULL && s2 != NULL){
			
			char *result = (char*)malloc(strlen(s1) + strlen(s2) + 2);

			strcpy(result, s2);
			strcat(result, " ");
			strcat(result, s1);

			printf("result *NONE OF STACKS MENTIONED* = %s\n", result);
			
			/* RULE pi pika copy the top of Pi Pikachu to Pika Pikachu */
			if(strcmp(result, "pi pika") == 0){
				char *topElement = top(piStack);
				if(top == NULL){
					printf("ERROR ***STACK IS EMPTY***(11008)\n");
				}else{
					printf("RULE *pi pika* copy the top of Pi Pikachu to Pika Pikachu\n");
					push(pikaStack, top);
				}
			}else if(strcmp(result, "pi pika") == 0){
				char *topElement = top(pikaStack);
				if(top == NULL){
					printf("ERROR ***STACK IS EMPTY***(11009)\n");
				}else{
					printf("RULE *pika pi* copy the top of Pika Pikachu to Pi Pikachu\n");
					push(piStack, top);
				}
			}else if(strcmp(result, "pikachu pikachu") == 0){
				/* RULE pikachu pikachu if top are equal go to line n where n is number of terms in the next line */
				char *topOfPika = top(pikaStack);
				char *topOfPi = top(piStack);
				if(topOfPika == NULL || topOfPi == NULL){
					printf("ERROR ***STACK IS EMPTY***(11010)\n");
				}else{
					printf("TOP OF PIKA = %s, TOP OF PI = %s\n", topOfPika, topOfPi);
					if(strcmp(topOfPika, topOfPi) == 0){
						printf("RULE *top of stacks equal* go to line n \n");
						moveToLine = true;
					}
				}
			}else if(strcmp(result, "pika pika") == 0){
				/* RULE pika pika if top are !equal go to line n where n is number of terms in the next line */
				char *topOfPika = top(pikaStack);
				char *topOfPi = top(piStack);
				if(topOfPika == NULL || topOfPi == NULL){
					printf("ERROR ***STACK IS EMPTY***(11011)\n");
				}else{
					printf("TOP OF PIKA = %s, TOP OF PI = %s\n", topOfPika, topOfPi);
					if(strcmp(topOfPika, topOfPi) != 0){
						printf("RULE *top of stacks !equal* go to line n \n");
						moveToLine = true;
					}
				}
			}

		}
	}

	}
	|
	;
line: piWords
	| pikaWords
	| pikachuWords
	;
piWords: PI {
	numberOfWords[lineNumber]++;
	push(piStack, $1);
	}
	| PI SPACE PI { 
	numberOfWords[lineNumber]+=2;
	push(piStack, $1); 
	push(piStack, $3);
	}
	| PI SPACE pikaWords {
	numberOfWords[lineNumber]++;
	push(piStack, $1);
	}
	| PI SPACE PI SPACE pikaWords {
	numberOfWords[lineNumber]+=2;
	push(piStack, $1); 
	push(piStack, $3);
	}
	| PI SPACE pikachuWords {
	numberOfWords[lineNumber]++;
	push(piStack, $1); 
	}
	| PI SPACE PI SPACE pikachuWords {
	numberOfWords[lineNumber]+=2;
	push(piStack, $1); 
	push(piStack, $3);
	}
	;
pikaWords: PIKA {
	push(piStack, $1); 
	numberOfWords[lineNumber]++;
	}
	| PIKA SPACE PIKA  {
	numberOfWords[lineNumber]+=2;
	push(piStack, $1); 
	push(piStack, $3);
	}
	| PIKA SPACE piWords {
	numberOfWords[lineNumber]++;
	push(piStack, $1); 
	}
	| PIKA SPACE PIKA SPACE piWords {
	numberOfWords[lineNumber]+=2;
	push(piStack, $1); 
	push(piStack, $3);
	}
	| PIKA SPACE pikachuWords {
	numberOfWords[lineNumber]++;
	push(piStack, $1); 
	}
	| PIKA SPACE PIKA SPACE pikachuWords {
	numberOfWords[lineNumber]+=2;
	push(piStack, $1); 
	push(piStack, $3);
	}
	;
pikachuWords: PIKACHU {
	numberOfWords[lineNumber]++;
	push(piStack, $1); 
	}
	| PIKACHU SPACE PIKACHU {
	numberOfWords[lineNumber]+=2;
	push(piStack, $1); 
	push(piStack, $3);
	} 
	| PIKACHU SPACE piWords {
	numberOfWords[lineNumber]++;
	push(piStack, $1); 
	}
	| PIKACHU SPACE PIKACHU SPACE piWords {
	numberOfWords[lineNumber]+=2;
	push(piStack, $1); 
	push(piStack, $3);
	}
	| PIKACHU SPACE pikaWords {
	numberOfWords[lineNumber]++;
	push(piStack, $1); 
	}
	| PIKACHU SPACE PIKACHU SPACE pikaWords {
	numberOfWords[lineNumber]+=2;
	push(piStack, $1); 
	push(piStack, $3);
	}
	;
%%

void operateOnStack(PikachuStack *pikachuStack){
	
	/* SET OF RULES LINE ENDS WITH ***PI PIKACHU*** OR ***PIKA PIKACHU*** */
	char *s1 = pop(pikachuStack);
	char *s2 = pop(pikachuStack);

	if(s1 != NULL && s2 != NULL){

		char *result = (char*)malloc(strlen(s1) + strlen(s2) + 2);

		strcpy(result, s2);
		strcat(result, " ");
		strcat(result, s1);

		printf("result = %s\n", result);

		if(strcmp(result, "pi pika") == 0){
			
			/* RULE add the top element to the next top element and push result */
			char *topElement = top(pikachuStack);
			char *nextTopElement = top(pikachuStack);
			if(topElement == NULL || nextTopElement == NULL){
				
				printf("ERROR ***STACK IS EMPTY***(10002)\n");

			}else{
				char *newTop = ADD(topElement, nextTopElement);
				printf("RULE *pi pika* add the top element of the pikachu ***%s*** to the next top element ***%s*** and push the result into pikachu\n", topElement, nextTopElement);
				push(pikachuStack, newTop);
		}	
		}else if(strcmp(result, "pika pi") == 0){
			/* RULE subtract the top element from the next top element and push result */
			char *topElement = top(pikachuStack);
			char *nextTopElement = top(pikachuStack);
			if(topElement == NULL || nextTopElement == NULL){
				
				printf("ERROR ***STACK IS EMPTY***(10003)");

			}else{

				char *newTop = SUBTRACT(topElement, nextTopElement);
				printf("RULE *pika pi* subtract the top element of the pikachu ***%s*** from next top element ***%s*** and push the result into pikachu \n", topElement, nextTopElement);
				push(pikachuStack, newTop);
			
			}
			
		}else if(strcmp(result, "pi pikachu") == 0){
			/* RULE multiply the top element to the next top element and push result */

			char *topElement = top(pikachuStack);
			char *nextTopElement = top(pikachuStack);			
			if(top == NULL || nextTopElement == NULL){
				
				printf("ERROR ***STACK IS EMPTY***(10004)");

			}else{

				char *newTop = MULTIPLY(topElement, nextTopElement);
				printf("RULE *pi pikachu* multiply the top element of the pikachu ***%s*** to the next top element ***%s*** and push the result into pikachu \n", topElement, nextTopElement);
				push(pikachuStack, newTop);
			}
		}if(strcmp(result, "pikachu pikachu") == 0){
			/* RULE pop the value on top and print ASCII */
			char *topElement = top(pikachuStack);
			if(topElement == NULL){
				
				printf("ERROR ***STACK IS EMPTY***(10007)");

			}else{
				printf("RULE *pikachu pikachu* pop the value on top and print ASCII\n");					printf("TOP %s, ", topElement);
				char *asciiElement = ASCII(topElement);
				printf("ASCII %s\n", asciiElement);
			}
			}else if(strcmp(s1, "pikachu") == 0){
			/* RULE divide the top element from the next top element and push result */

			char *topElement = top(pikachuStack);
			char *nextTopElement = top(pikachuStack);
			if(topElement == NULL || nextTopElement == NULL){
				
				printf("ERROR ***STACK IS EMPTY***(10005)");

			}else{

				char *newTop = DIVIDE(topElement, nextTopElement);
				printf("RULE *pikachu* divide the top element of the pikachu ***%s*** from the next top element ***%s*** and push the result into pikachu \n", topElement, nextTopElement);
				push(pikachuStack, newTop);
			}
		}else if(strcmp(result, "pika pikachu") == 0){
			/* RULE pop the value on top and print */

			char *topElement = top(pikachuStack);
			if(topElement == NULL){
			
				printf("ERROR ***STACK IS EMPTY***(10006)");
	
			}else{
				printf("RULE *pika pikachu* pop the value on top and print\n");
				printf("TOP %s\n", topElement);
			}
		}
		else{
			/* none of the above commands */
			if(s1 != NULL)
				push(pikachuStack, s1);
			if(s2 != NULL)
				push(pikachuStack, s2);
		}
	}else{
		/* none of the above commands */
		if(s1 != NULL)
			push(pikachuStack, s1);
		if(s2 != NULL)
			push(pikachuStack, s2);
	}
}

char* ADD(char *topElement, char *nextTopElement){

	char *newTop = (char*)malloc(strlen(topElement)+ strlen(nextTopElement) + 2);
	strcpy(newTop, nextTopElement);
	strcat(newTop, " ");
	strcat(newTop, topElement);
	
	return newTop;
}

char* SUBTRACT(char *topElement, char *nextTopElement){ //nextTopElement - top (string difference)
	
	char *newTop = (char*)malloc(strlen(nextTopElement));
	return newTop;
}

char* MULTIPLY(char *topElement, char *nextTopElement){ //top*nextTopElement (string multiply)
	
	char *newTop = (char*)malloc(strlen(nextTopElement));
	return newTop;
}

char* DIVIDE(char *topElement, char *nextTopElement){ //nextTopElement / top (string divide)

	char *newTop = (char*)malloc(strlen(nextTopElement));
	return newTop;
}

char* ASCII(char *topElement){
	
	char *newTop = (char*)malloc(strlen(topElement)*sizeof(char));
	char aux[4];
	
	strcpy(newTop, "");
	for(int i = 0; i < strlen(topElement); i++){
		
		sprintf(aux, "%d", *(topElement+i));
		strcat(newTop, aux);
		strcat(newTop, " ");
	}
	
	return newTop;
}

int main(void){
	
	lineNumber = 0;
	number = 0;
	numberOfWords = (int*)malloc(50 * sizeof(int));

	moveToLine = false;
	
	piStack = createPikachuStack();
	pikaStack = createPikachuStack();
	
	yyparse();

	if(number != 0){
		printf("ERROR ***COULD NOT STEP OVER LINES ***(11111)\n");
	}
	return 0;

}