%{
#include <stdio.h>
int num_lines = 0, num_chars = 0;
%}
%token ID NUM SELECT FROM DISTINCT WHERE 
%token GROUP HAVING ORDER DESC ASC
%token CREATE TABLE DROP DELETE
%token AND OR LE GE EQ DIF INT VARCHAR
%start Input
%%
Input:
|Input S;
S	: ST1 ';'
	| ST7 ';'
	| ST8 ';'
	| ST9 ';'
 
ST1 	: SELECT attributList FROM tableList {printf("REQUETE ACCEPTEE... \n\t");}
	| SELECT error {printf("REQUETE Manque un attribut... \n\t");}
     	| SELECT DISTINCT attributList FROM tableList {printf("REQUETE ACCEPTEE... \n\t");}
     	| SELECT DISTINCT attributList FROM error {printf("REQUETE MANQUE un tablelsit... 			\n\t");}
	| SELECT attributList FROM tableList ST2 
	| SELECT attributList FROM tableList ST3 
	;
	
ST9:	DELETE FROM ID {printf("DATA de la TABLE supprimé \n\t");}
	| DELETE error {printf("Il manque le mot clé 'from' \n\t");}
	| DELETE FROM ID ST2 {printf("un sous-ensemble de lignes dans la table a été supprimé 			\n\t");}
	;
	
ST2:	WHERE error {printf("Condition manquante !! \n");}
	| WHERE COND ST3
	|
	| WHERE COND {printf("Requette avec Condition accepté !!\n");}
	;

ST3:	GROUP attributList {printf("REQUETE avec Group by ACCEPTEE...\n\t");}
	| GROUP attributList ST4
	| GROUP error {printf("REQUETE avec Group by Manquante... \n\t");}
	| ST4
	;
	
ST4:	HAVING COND ST5 
	| HAVING COND {printf("REQUETE avec HAVING ACCEPTE... \n\t");}
	| HAVING error {printf("REQUETE avec HAVING Manqaunte... \n\t");}
	| ST5
	;
	
ST5:	ORDER attributList ST6
	|ORDER error {printf("REQUETE avec ORDER by Manquante... \n\t");}
	|
	;

ST6:	DESC {printf("REQUETE avec ORDER by descendant accepté... \n\t");}
	| ASC {printf("REQUETE avec ORDER by ascendant accepté... \n\t");}
	;

ST7:	CREATE TABLE ID {printf("TABLE crée \n\t");}
	| CREATE {printf("manque le mot clé \'table\' \n\t");}
	| CREATE TABLE error {printf("manque un nom de TABLE \n\t");}
	| CREATE TABLE ID '(' column ')' {printf("TABLE avec attribut(s) crée \n\t");}
	;

ST8:	DROP TABLE ID {printf("TABLE supprimé \n\t");}
	| DROP error {printf("manque le mot clé \'table\' \n\t");}
	| DROP TABLE error {printf("manque le nom de la table \n\t");}
	;
	
types:	INT
	| VARCHAR
	;

column: ID types','column
	| ID types
	; 

attributList :		ID','attributList
	     	| '*'
		| ID
		;

tableList	: ID',' tableList
	  	  | ID
		  ;
		  
COND:	COND OR COND
	| COND AND COND
	| E
	;

E:	F '=' F
	| F '<' F
	| F '>' F
	| F OPP F
	| F AND F
	| F OR F
	;

OPP:	EQ
	| LE
	| GE
	| DIF
	;

F: 	ID
	| NUM
	;
%%
extern FILE * yyin;

void yyerror(char *s) {
    fprintf(stderr,"%s: ", s);
    return 1;
}
int main(void)
 {

printf("Compilateur SQL:\n");
yyin=fopen("./test.txt","r");
if (yyin==NULL) return -1;
yyparse();
}
