%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "variaveis.h"

    

    int yyerror(const char* s);
    extern int yylex(void);

    void mostrar_estado() {
    printf("\n----------------------------------");
    printf("\nEstado da Bateria: %f ", perc_bateria);
    printf("\nLocalização: %s", posicao);
    printf("\nMateriais: %s", material_carro);
    printf("\nQuantidade: %d", total_quantidade);
    printf("\nVezes que foi a manutenção: %d", num_manutencao);
    printf("\n----------------------------------\n\n");
}
%}

%union {
    int inteiro;
    char *str;
    float real;
}


%token INICIO FIM _MANUTENCAO _BATERIA _RECOLHE _ENTREGA _ESTADO _INIT_ESTADO


%start begin

%%

begin: INICIO '{' '}' FIM
     /*| INICIO '{' opcional ';' comandos '}' FIM*/
     | INICIO '{' comandos '}' FIM {printf("entrou aqui");}
     ;

/*opcional: 
        _INIT_ESTADO {
            printf("\nEstado Inicial");
        };*/


comandos: comandos ';' comando
        |comando
        ;

comando: _MANUTENCAO {
            printf("\nFoi à manutencao");
        };
        




%%

int yyerror(const char* s) {
    fprintf(stderr, "Parser error: %s\n", s);
    return 0;  
}

int yylex(void);

int main(void) {
    yyparse();
    return 0;
}