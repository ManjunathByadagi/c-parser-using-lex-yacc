%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>

int line = 1;
%}

%%

"int"       { return INT; }
"float"     { return FLOAT; }
"char"      { return CHAR; }
"double"    { return DOUBLE; }

"if"        { return IF; }
"else"      { return ELSE; }
"do"        { return DO; }
"while"     { return WHILE; }

"=="        { return EQ; }
"!="        { return NE; }
"<="        { return LE; }
">="        { return GE; }
"<"         { return LT; }
">"         { return GT; }

"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MUL; }
"/"         { return DIV; }

"="         { return ASSIGN; }
";"         { return SEMI; }
","         { return COMMA; }

"("         { return LPAREN; }
")"         { return RPAREN; }
"{"         { return LBRACE; }
"}"         { return RBRACE; }

[0-9]+                      { return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*      { return ID; }

[ \t\r]+    ;
\n          { line++; }

.           {
                printf("Syntax error at line %d, token: %s\n", line, yytext);
                exit(1);
            }

%%

int yywrap() { return 1; }