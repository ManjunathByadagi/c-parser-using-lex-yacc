%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int line;
void yyerror(const char *s);
%}

%start program

/* Tokens */
%token INT FLOAT CHAR DOUBLE
%token IF ELSE DO WHILE
%token ID NUM
%token PLUS MINUS MUL DIV
%token LT GT LE GE EQ NE
%token ASSIGN
%token SEMI COMMA
%token LPAREN RPAREN
%token LBRACE RBRACE

/* Fix dangling else */
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%%

program:
        statement_list
        ;

statement_list:
        statement_list statement
        | statement
        ;

statement:
          declaration
        | if_stmt
        | do_while_stmt
        | block
        | assignment SEMI
        | expression SEMI
        ;

block:
        LBRACE statement_list RBRACE
        ;

declaration:
        type declarator_list SEMI
        ;

type:
          INT
        | FLOAT
        | CHAR
        | DOUBLE
        ;

declarator_list:
          ID
        | declarator_list COMMA ID
        ;

if_stmt:
          IF LPAREN condition RPAREN statement %prec LOWER_THAN_ELSE
        | IF LPAREN condition RPAREN statement ELSE statement
        ;

do_while_stmt:
        DO statement WHILE LPAREN condition RPAREN SEMI
        ;

assignment:
        ID ASSIGN expression
        ;

condition:
        expression relop expression
        ;

relop:
          LT | GT | LE | GE | EQ | NE
        ;

expression:
          expression PLUS term
        | expression MINUS term
        | term
        ;

term:
          term MUL factor
        | term DIV factor
        | factor
        ;

factor:
          ID
        | NUM
        | LPAREN expression RPAREN
        ;

%%

void yyerror(const char *s)
{
    printf("Syntax error at line %d\n", line);
    exit(1);
}

int main()
{
    if (yyparse() == 0)
        printf("Syntax valid.\n");

    return 0;
}