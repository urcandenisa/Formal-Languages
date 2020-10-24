%{
#include "y.tab.h"
%}

%%
"pi" { yylval.pikachuSound = strdup(yytext); return PI; }
"pika" { yylval.pikachuSound = strdup(yytext); return PIKA; }
"pikachu" { yylval.pikachuSound = strdup(yytext); return PIKACHU; }
" " { return SPACE; }
"<<EOF>>" { yyterminate(); }
\n { return NEW_LINE; }
. { return *yytext; }
%%

int yywrap(void){
return 1;
}