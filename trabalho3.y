%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "variaveis.h"
    #define YYDEBUG 1
    

    int yyerror(const char* s);
    extern int yylex(void);

   
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
     | INICIO '{' comandos '}' FIM {printf("entrou aqui");}
     ;




comandos: comandos ';' comando
        |comando
        ;

comando: _INIT_ESTADO{
   
            if(strcmp(posicao, "manutencao")){
                posicao="Posto de Manutencao";
            }
            else if(strcmp(posicao,"carregamento")){
                posicao="Posto de Carregamento";
            }
            else if(strcmp(posicao,"armazem")){
                posicao="Armazem";
            }
            else if(strcmp(posicao,"fabrica")){
                posicao="Linhas de Montagem";
            }
            else{
                printf("Posicao inválida!");
                return 0;
            }

            printf("---- NOVO ESTADO INICIAL ----");
            printf("\n----------------------------------");
                    printf("\nEstado da Bateria: %.2f ", perc_bateria);
                    printf("\nLocalização: %s", posicao);
                    printf("\nMateriais: %s", material_carro);
                    printf("\nQuantidade: %d", total_quantidade);
                    printf("\nVezes que foi a manutencao: %d", num_manutencao);
                    printf("\n----------------------------------\n\n");
        };

        |_MANUTENCAO {
            printf("---- REALIZAR MANUTENCAO ----");
            if (strcmp(posicao, "Posto de Manutencao") != 0){
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
                            printf("\nEstado da Bateria: %.2f ", perc_bateria);
                            printf("\nLocalização: %s", posicao);
                            printf("\nMateriais: %s", material_carro);
                            printf("\nQuantidade: %d", total_quantidade);
                            printf("\nVezes que foi a manutencao: %d", num_manutencao);
                            printf("\n----------------------------------\n\n");

        };
        
        |_BATERIA {
            printf("---- CARREGAMENTO DE BATERIA ----");
            if (perc_bateria == 100) {
                                printf("\nA bateria está completamente carregada, não é necessário um novo carregamento");
                            }

                            if (strcmp(posicao, "Posto de Carregamento") != 0){
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
                            printf("\nEstado da Bateria: %.2f ", perc_bateria);
                            printf("\nLocalização: %s", posicao);
                            printf("\nMateriais: %s", material_carro);
                            printf("\nQuantidade: %d", total_quantidade);
                            printf("\nVezes que foi a manutencao: %d", num_manutencao);
                            printf("\n----------------------------------\n\n");

        };

        |_RECOLHE{
            printf("---- RECOLHA ----");
            if (total_quantidade + quantidade > 80) {
                printf("\nAtencao! Excedeu a capacidade do veiculo, impossivel realizar o transporte");
            } 
            else{
                if (posicao != "Armazem"){
                bateria_necessaria= (100*0.1) + (aux_quant*0.01);
                }
                else{
                    bateria_necessaria=0;
                }

                if(manutencao==0){
                    printf("\nManutencao muito baixa! Por favor, realizar manutencao antes de avancar!\n");
                }
                if(perc_bateria!=0 && manutencao!=0){
                    if (perc_bateria >= 10.8 && perc_bateria <= 21.6){
                        estado_bateria=0;
                    }
                    else if(perc_bateria > 21.6 && perc_bateria <= 32.4){
                        estado_bateria=1;
                    }
                    else if(perc_bateria > 32.4){
                        estado_bateria=2;
                    }

                }

                if (estado_bateria==0){
                    printf("\nAtencao! Bateria insuficiente, por favor enviar para o posto de carregamento!");
                }
                else if(estado_bateria>0 && manutencao>0){
                    if (estado_bateria==1){
                        printf("\nNo final desta acao, a bateria sera insuficiente. Por favor, enviar para o posto de carregamento");
                    }
                    if(manutencao==1){
                        printf("\nNo final desta acao, a manutencao sera muito baixa. Por favor, enviar para o posto de manutencao\n");
                        manutencao=0;
                    }

                    material_recolha = aux_material;
                    material_recolha++;
                    material_recolha++;

                    printf("\nMaterial: %s",material_recolha);
                    printf("\nQuantidade: %d", quantidade);

                    if (posicao != "Armazem"){
                        perc_bateria= perc_bateria - (100*0.1) - (total_quantidade*0,01);
                    }
                    
                    posicao = "Armazem";

                    if(tarefas>0){
                        total_quantidade = total_quantidade + quantidade;
                        material_carro = strdup(material_recolha);

                    }
                    else if (tarefas == 0) {
                        total_quantidade = quantidade;
                        tarefas = tarefas + 1;
                        material_carro = strdup(material_recolha);

                    }
                    
        

                }

            }

            printf("\n----------------------------------");
            printf("\nEstado da Bateria: %.2f ", perc_bateria);
            printf("\nLocalização: %s", posicao);
            printf("\nMateriais: %s", material_carro);
            printf("\nQuantidade: %d", total_quantidade);
            printf("\nVezes que foi a manutencao: %d", num_manutencao);
            printf("\n----------------------------------\n\n");

        };


        |_ENTREGA{
            printf("---- ENTREGA ----");
            if (total_quantidade < quantidade) {
                printf("\nAtencao! Esta quantidade de material nao esta a ser transportada, impossivel realizar a entrega!");
                }
                else if (strcmp(material_carro, material_entrega) != 0) {
                    printf("\nAtencao! Este tipo de material nao esta a ser transportado, impossivel realizar a entrega!");
                }
                else{
                    if(manutencao==0){
                        printf("\nManutencao muito baixa! Por favor, realizar manutencao antes de avancar!\n");
                    }

                    if(perc_bateria!=0 && manutencao!=0){
                        if (posicao != "Linhas de Montagem"){
                        bateria_necessaria= (100*0.1) + (aux_quant*0.01);


                            if (perc_bateria >= 10.8 && perc_bateria <= 21.6){
                                estado_bateria=0;
                            }
                            else if(perc_bateria > 21.6 && perc_bateria <= 32.4){
                                estado_bateria=1;
                            }
                            else if(perc_bateria > 32.4){
                                estado_bateria=2;
                            }
                        }

                        else{
                            bateria_necessaria=(100*0.05)+(total_quantidade*0.01);

                            if (perc_bateria >= 10.8 && perc_bateria <= 16.6){
                                estado_bateria=0;
                            }
                            else if(perc_bateria > 16.6 && perc_bateria <= 22.4){
                                estado_bateria=1;
                            }
                            else if(perc_bateria > 22.4){
                                estado_bateria=2;
                            }

                        }
                }

                if (estado_bateria==0){
                    printf("\nAtencao! Bateria insuficiente, por favor enviar para o posto de carregamento!");
                }
                else if(estado_bateria==1 || estado_bateria==2){

                    if (estado_bateria==1){
                        printf("\nNo final desta acao, a bateria será insuficiente. Por favor, enviar para o posto de carregamento");
                    }
                    if(manutencao==1){
                        printf("\nNo final desta acao, a manutencao sera muito baixa. Por favor, enviar para o posto de manutencao\n");
                        manutencao=0;
                    }

                    total_quantidade = total_quantidade - quantidade;

                    if (posicao != "Linhas de Montagem"){
                        perc_bateria= perc_bateria - (100*0.1) - (total_quantidade*0.01);
                    }
                    else{
                        perc_bateria= perc_bateria - (100*0.05)-(total_quantidade*0.01);
                    }


                    printf("\nLinha de montagem: %s",linha);
                    printf("\nMaterial: %s",material_entrega);
                    printf("\nQuantidade: %d", quantidade);

                    posicao = "Linhas de Montagem";

                    if (total_quantidade == 0){
                        material_carro = "";
                        tarefas = tarefas - 1;
                    }
                    else {
                        material_carro = "";
                        material_carro = material_entrega;
                        }

                    
                }
                                                                                        
                printf("\n----------------------------------");
                printf("\nEstado da Bateria: %.2f ", perc_bateria);
                printf("\nLocalização: %s", posicao);
                printf("\nMateriais: %s", material_carro);
                printf("\nQuantidade: %d", total_quantidade);
                printf("\nVezes que foi a manutencao: %d", num_manutencao);
                printf("\n----------------------------------\n\n");


                }
        };

        |_ESTADO{
            printf("---- ESTADO ----");
            if (strcmp(aux_estado, "B") == 0){
                printf("\nBateria: %.2f", perc_bateria);
            }
            else if (strcmp(aux_estado, "T") == 0){
                printf("\nTarefas pendentes: %d", tarefas);
            }
            else if (strcmp(aux_estado, "M") == 0){
                printf("\nMateriais: %s",material_carro);
                printf("\nQuantidade: %d", total_quantidade);

            }
        };


%%

int yyerror(const char* s) {
    fprintf(stderr, "Parser error: %s\n", s);
    return 0;  
}

int yylex(void);

int main(void) {
    yydebug=1;
    yyparse();

    printf("\n----------------------------------\n");
     printf("ESTADO FINAL DO VEICULO\n");
     printf("Estado da Bateria: %.2f \n", perc_bateria);
     printf("Localização: %s \n", posicao);
     printf("Materiais: %s \n", material_carro);
     printf("Quantidade: %d \n", total_quantidade);
     printf("Vezes que foi a manutencao: %d \n", num_manutencao);
     printf("----------------------------------\n\n");

    return 0;
}