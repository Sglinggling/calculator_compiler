%{
#include "calculatrice.tab.h"
#include <stdlib.h>

int yywrap(void) {  //permet a Flex de savoir quoi faire lorsqu'il atteint la fin de l'entree 
	return -1;
}
%}

%%

[0-9]+	{
	yylval = atoi(yytext); //variable global utilisee par flex pour communiquer les valeurs des tokens a bison
	return NUMBER;
}

[+\-\*\/] {
	return *yytext;
}

"("	{	
	return '(';
}

")"	{
	return ')';
}

[ \t]	{}

\n	{
	return 0;
}

.	{	
	printf("Erreur de syntaxe : %s\n", yytext);
}

%%
