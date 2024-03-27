%{
#include <stdio.h>
#include <stdlib.h>
%}

%token NUM
%left '+' '-'
%left '*' '/'

%%

calc:   /* empty */
    | calc expr '\n' { printf("= %d\n", $2); }
    ;

expr:   NUM             { $$ = $1; }
    | expr '+' expr    { $$ = $1 + $3; }
    | expr '-' expr    { $$ = $1 - $3; }
    | expr '*' expr    { $$ = $1 * $3; }
    | expr '/' expr    { $$ = $1 / $3; }
    | '(' expr ')'     { $$ = $2; }
    ;

%%

int main() {
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("error: %s\n", s);
    return 0;
}

