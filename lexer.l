%{
     
%}

letter [a-zA-Z]
digit [0-9]

%%
\n                                                  yylineno++;
#include<{letter}+(\.{letter}*)?>                   printf("%d\t%s\t\t\tPREPROCESSOR\n",yylineno,yytext);
return|main|for|while|case|switch|if|else           printf("%d\t%s\t\t\tKEYWORD\n",yylineno,yytext);
int|float|char|struct                               printf("%d\t%s\t\t\tDATATYPE\n",yylineno,yytext);
\(                                                  printf("%d\t%s\t\t\tBRACKETOPEN\n",yylineno,yytext);
\)                                                  printf("%d\t%s\t\t\tBRACKET CLOSE\n",yylineno,yytext);
{letter}({letter}|{digit})*                         printf("%d\t%s\t\t\tIDENTIFIER\n",yylineno,yytext);
{digit}+                                            printf("%d\t%s\t\t\tINTEGER\n",yylineno,yytext);
\"([^\\\n]|(\\.))*?\"                                            printf("%d\t%s\t\t\tSTRING LITERALS\n", yylineno,yytext);


\{                                                  printf("%d\t%s\t\t\tBRACE OPEN\n",yylineno,yytext);
\}                                                  printf("%d\t%s\t\t\tBRACE CLOSE\n",yylineno,yytext);
=                                                   printf("%d\t%s\t\t\tASSIGNMENY\n",yylineno,yytext);
;                                                   printf("%d\t%s\t\t\tTERMINATIOR\n",yylineno,yytext);
\t                                                  ;
" "                                                 ;

%%

int yywrap(){
    return 1;
}

int main(int argc,char * argv[]){
    yyin=fopen(argv[1],"r");
    printf("LINE\tLEXEME\t\t\t\tTOKEN\n");
    yylex();
    fclose(yyin);
    return 0;
}
