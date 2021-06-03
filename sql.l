%{
#include <stdio.h>
#include "y.tab.h"
%}
alpha [A-Za-z]
digit[0-9]
%%
[ \t\n]			;	
"select"		return SELECT;
"from"			return FROM;
"where"			return WHERE;
"group by"		return GROUP;
"having"		return HAVING;
"order by"		return ORDER;
"create"		return CREATE;
"table"		return TABLE;
"drop"			return DROP;
"delete"		return DELETE;
"desc"			return DESC;
"asc"			return ASC;
"and"			return AND;
"or"			return OR;
"int"			return INT;
"varchar"		return VARCHAR;
"<="			return LE;
">="			return GE;
"=="			return EQ;
"!="			return DIF;	
"distinct"		return DISTINCT;
{digit}({digit})*	return NUM;
{alpha}({alpha}|{digit})*	return ID;
.				return yytext[0];

%%
int yywrap(){
return 0;
}
