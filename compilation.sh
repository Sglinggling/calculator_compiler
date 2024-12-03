bison -d calculatrice.y
flex calculatrice.l
gcc -o calculatrice calculatrice.tab.h calculatrice.tab.c lex.yy.c -lfl
