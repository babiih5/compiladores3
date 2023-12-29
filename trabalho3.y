%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "trabalho3.tab.h"
    #include "trabalho3.lex.h"
   
    int manutencao=2, estado_bateria=2, quantidade=0, num_manutencao=0, tarefas=0, total_quantidade=0,num_aux=0;
    char *instrucao="", *posicao="Posto de Carregamento", *linha="", *quant_str="", *material_entrega="", *material_carro="",*material_recolha="",*aux_material="", *aux_estado="", *total_materiais="";
    float perc_bateria=100.0,aux_quant=0.0,bateria_necessaria=0.0;

    int yyerror(const char* s);

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


%token INICIO FIM _MANUTENCAO _BATERIA _RECOLHE _ENTREGA _ESTADO


%start begin

%%

begin: INICIO '{' '}' FIM
        | INICIO '{' opcional ';' comandos '}' FIM
        | INICIO '{' opcional ';' comando '}' FIM
        | INICIO '{' comandos '}' FIM
        | INICIO '{' comando '}' FIM
        ;

opcional: 
        _INIT_ESTADO {
            printf("\nEstado Inicial");
        };


comandos: comandos ';' comando
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