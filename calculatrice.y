%{
#include <stdio.h>
#include <stdlib.h>

//fonctions pour gerer les erreurs 
void yyerror(const char *s);

//fonction pour renvoyer les tokens a yacc
int yylex();
%}

%token NUMBER
%type Expr Term Factor 

//definition des priorites des operateurs
%left '+' '-'
%left '*' '/'
%right UMINUS //declare la negation "-3" par exemple

%%

calculation: 
	Expr '\n' {printf("Resultat = %d\n", $1);}
      | Expr 	  {printf("Resultat = %d\n", $1);}
      | /* vide */ {} //Si vide, ne rien faire 
      ;	


//les regles de grammaire 

Expr:
	Expr '+' Term { $$ = $1 + $3; }
      | Expr '-' Term { $$ = $1 - $3; }
      | Term
      ;	

Term:
        Term '*' Factor { $$ = $1 * $3; }
      | Term '/' Factor { 
      	    if($3 == 0){
      	    	yyerror("Erreur : Division par zero !");
      	    	$$ = 0; // Par defaut, retourner 0
      	    }else{
      	    	$$ = $1 / $3;
      	    }
      	}
      | Factor
      ;	
      
Factor:  
        '(' Expr ')' { $$ = $2; }
      | '-' Factor   %prec UMINUS { $$ = -$2; } //force la priorite pour la negation
      | NUMBER	     { $$ = $1;}
      ;	

%%

//fonction pour la gestion d'erreur
void yyerror(const char *s){
	fprintf(stderr, "Erreur de syntaxe: %s\n", s);
}

int main(){
	printf("Entrez une expression : ");
	if(yyparse() == 0){
		printf("Expression valide.\n");
	}
	return 0;
}
