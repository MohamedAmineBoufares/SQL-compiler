#! /bin/sh
yacc -d --verbose sql.y
lex sql.l
gcc lex.yy.c y.tab.c -o sql -ll -w
./sql <test.txt
