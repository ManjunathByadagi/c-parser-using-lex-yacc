\# Simplified C Parser using Lex \& Yacc



This project implements a syntax validator for a simplified subset of the C language using:



\- Flex (Lex)

\- Bison (Yacc)



\## Features Supported



\- Multiple variable declarations

\- Basic data types (int, float, char, double)

\- if and if-else statements

\- do-while loop

\- Nested blocks

\- Arithmetic expressions

\- Relational expressions

\- Assignment statements



\## How to Run



bison -d parser.y

flex lexer.l

gcc parser.tab.c lex.yy.c -o parser

parser < input.c



\## Output



\- On success: Syntax valid.

\- On failure: Syntax error at line X

