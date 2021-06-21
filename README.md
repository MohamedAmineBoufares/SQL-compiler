# SQL_compiler


## Just copy past these lines into your terminal in order to run the " .l " and " .y " files :
* yacc -d --verbose sql.y
* lex sql.l
* gcc lex.yy.c y.tab.c -o sql -ll -w
* ./sql <test.txt


## Or you can just run the script by typing 🔥 : 
* ./run.sh
