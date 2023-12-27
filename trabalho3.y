%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "trabalho3.tab.h"
    #include "trabalho3.lex.h"
   
    int manutencao=2, estado_bateria=2, quantidade=0, num_manutencao=0, tarefas=0, total_quantidade=0;
    char *instrucao="", *posicao="Posto de Carregamento", *linha="", *quant_str="", *material_entrega="", *material_carro="",*material_recolha="",*aux_material="", *aux_estado="", *total_materiais="";
    float perc_bateria=100.0,aux_quant=0.0,bateria_necessaria=0.0;

    int yyerror(const char* s);
%}

%union {
    int inteiro;
    char* string;
}

%token INICIO_DAS_INSTRUCOES FINAL_DAS_INSTRUCOES PONTO_VIRGULA
%token INICIO_FIM_INSTRUCOES INICIO_INSTRUCOES OPCIONAL

%token MANUTENCAO CARREGA_BATERIA ENTREGA RECOLHE ESTADO INIT_ESTADO

%token INICIO_MANUTENCAO FIM_MANUTENCAO _MANUTENCAO
%token INICIO_BATERIA FIM_BATERIA _BATERIA
%token INICIO_RECOLHE FIM_RECOLHE _RECOLHE
%token INICIO_ENTREGA FIM_ENTREGA _ENTREGA
%token INICIO_ESTADO FIM_ESTADO _ESTADO
%token INICIO_INIT_ESTADO FIM_INIT_ESTADO _INIT_ESTADO

%token <inteiro> NUMERO
%token <string> STRING

%start principal

%%
principal:
    INICIO_DAS_INSTRUCOES INICIO_FIM_INSTRUCOES instrucoes FINAL_DAS_INSTRUCOES  { printf("Análise concluída com sucesso.\n"); }
    | INICIO_DAS_INSTRUCOES INICIO_INSTRUCOES INICIO_FIM_INSTRUCOES instrucoes FINAL_DAS_INSTRUCOES { printf("Análise concluída com sucesso.\n"); }
    ;

instrucoes:
    MANUTENCAO '(' NUMERO ')' PONTO_VIRGULA { 

                            if (posicao != "Posto de Manutencao"){
                                perc_bateria= perc_bateria - (100*0.1) - (total_quantidade*0.01);
                            }
                            

                            if (manutencao==0){
                                posicao="Posto de Manutencao";
                                num_manutencao = num_manutencao + 1;
                                manutencao=2;
                            }
                            else if (manutencao==1){
                                if (tarefas==0){
                                    posicao="Posto de Manutencao";
                                    num_manutencao = num_manutencao + 1;
                                    manutencao=2;
                                }
                                else{
                                    printf("\nPor favor termine a tarefa pendente antes de realizar manutencao!");
                                }

                            }

                            if (num_manutencao >= 3) {
                                if (num_manutencao==3){
                                    printf("\nAtencao! O veículo foi chamado a manutencao 3 vezes");
                                }
                                
                                else if ((num_manutencao % 3) == 0) {
                                    printf("\nAtencao! O veiculo foi chamado a manutencao %d vezes", num_manutencao);
                                }
                            }

                            printf("\n----------------------------------");
                            printf("\nEstado da Bateria: %f ", perc_bateria);
                            printf("\nLocalização: %s", posicao);
                            printf("\nMateriais: %s", material_carro);
                            printf("\nQuantidade: %d", total_quantidade);
                            printf("\nVezes que foi a manutencao: %d", num_manutencao);
                            printf("\n----------------------------------\n\n");
                                            }

    | CARREGA_BATERIA '(' NUMERO ')' PONTO_VIRGULA {  

                            if (perc_bateria == 100) {
                                printf("\nA bateria está completamente carregada, não é necessário um novo carregamento");
                            }

                            if (posicao != "Posto de Carregamento"){
                                perc_bateria= perc_bateria - (100*0.1) - (total_quantidade*0.01);
                            }

                            if (estado_bateria==0){
                                posicao="Posto de Carregamento";
                                perc_bateria=100;
                                estado_bateria=2;
                                
                            }
                            else if (estado_bateria==1){
                                if (tarefas==0){
                                    posicao="Posto de Carregamento";
                                    perc_bateria=100;
                                    estado_bateria=2;
                                }

                            }
                            printf("\n----------------------------------");
                            printf("\nEstado da Bateria: %f ", perc_bateria);
                            printf("\nLocalização: %s", posicao);
                            printf("\nMateriais: %s", material_carro);
                            printf("\nQuantidade: %d", total_quantidade);
                            printf("\nVezes que foi a manutencao: %d", num_manutencao);
                            printf("\n----------------------------------\n\n");

                                                }
    | RECOLHE '(' STRING ')' PONTO_VIRGULA { printf("RECOLHE: %s\n", $3); }
    | ENTREGA '(' STRING ')' PONTO_VIRGULA { printf("ENTREGA: %s\n", $3); }
    | ESTADO '(' STRING ')' PONTO_VIRGULA { printf("ESTADO: %s\n", $3); }
    | INIT_ESTADO '(' STRING ',' NUMERO ',' STRING ',' NUMERO ')' PONTO_VIRGULA { printf("INIT-ESTADO: Localizacao=%s, Bateria=%d, Materiais=%s, NumManutencao=%d\n", $3, $5, $7, $9); }
    ;



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