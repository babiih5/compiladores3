%x ER_MANUTENCAO ER_BATERIA ER_ENTREGA ER_RECOLHE ER_ESTADO ER_INIT_ESTADO

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "trabalho3.tab.h"
    #include "variaveis.h"
    char *mat_aux, *quantidade_aux, *manutencao_aux, *entrada;
    int comp=0;
    

    /* Inicialização das variáveis */
    int manutencao=2, estado_bateria=2, quantidade=0, num_manutencao=0, tarefas=0, total_quantidade=0;
    char *instrucao="", *posicao="Posto de Carregamento", *linha="", *quant_str="", *material_entrega="", *material_carro="",*material_recolha="",*aux_material="", *aux_estado="", *total_materiais="";
    float perc_bateria=100.0,aux_quant=0.0,bateria_necessaria=0.0;


%}

INIT_ESTADO INIT_ESTADO

MANUTENCAO MANUTEN"Ç"AO
CARREGA-BATERIA CARREGA"-"BATERIA
ENTREGA ENTREGA 
RECOLHE RECOLHE 
ESTADO ESTADO

INICIO_DAS_INSTRUCOES INICIO
FINAL_DAS_INSTRUCOES FIM


%%

{INICIO_DAS_INSTRUCOES}       return INICIO;
{FINAL_DAS_INSTRUCOES}         return FIM;


{INIT_ESTADO}\( {BEGIN(ER_INIT_ESTADO);}
<ER_INIT_ESTADO>([A-Za-z]+,[0-9]+,\([A-Za-z0-9]{5},[0-9]+\),[0-9]+) {          entrada = yytext;
                                                                                    /* Guardar o valor das variáveis a usar no yacc*/
                                                                                    const int max_parts = 5;

                                                                                    char *parts[max_parts];

                                                                                    char *token = strtok(entrada, ",");

                                                                                    int i = 0;

                                                                                    while (token != NULL && i < max_parts) {
                                                                                        parts[i] = token;
                                                                                        i++;

                                                                                        token = strtok(NULL, ",");
                                                                                    }

                                                                                    posicao=parts[0];

                                                                                    perc_bateria=(float)atoi(parts[1]);

                                                                                    mat_aux=parts[2];
                                                                                    mat_aux++;
                                                                                    material_carro=mat_aux;

                                                                                    quantidade_aux=parts[3];
                                                                                    comp = strlen(quantidade_aux);
                                                                                    if (comp > 0) {
                                                                                        quantidade_aux[comp - 1] = '\0';  
                                                                                    }
                                                                                    total_quantidade=atoi(quantidade_aux);
                                                                                    
                                                                                    num_manutencao=atoi(parts[4]);

                                                                                    return _INIT_ESTADO;
                                                                                }
<ER_INIT_ESTADO>\) {BEGIN 0;}

{MANUTENCAO}\( {BEGIN(ER_MANUTENCAO);}
<ER_MANUTENCAO>([0-2]) {    manutencao=atoi(yytext); return _MANUTENCAO;
}
<ER_MANUTENCAO>\) {BEGIN 0;}


{CARREGA-BATERIA}\( {BEGIN(ER_BATERIA);}
<ER_BATERIA>([0-2]) {       estado_bateria=atoi(yytext); return _BATERIA;
}
<ER_BATERIA>\) {BEGIN 0;}


{RECOLHE}\( {BEGIN(ER_RECOLHE);}
<ER_RECOLHE>(\[\([A-Za-z0-9]{5},[1-9][0-9]*\)(,\([A-Za-z0-9]{5},[1-9][0-9]*\))*\]) {    
                                                                                    /* Guardar o valor das variáveis a usar no yacc*/
                                                                                    aux_material = strtok(yytext, ",");
                                                                                    quant_str = strtok(NULL, ")");
                                                                                    quantidade=atoi(quant_str);
                                                                                    aux_quant=total_quantidade;
                                                                                    return _RECOLHE;
}
<ER_RECOLHE>\) {BEGIN 0;}


{ENTREGA}\( {BEGIN(ER_ENTREGA);}
<ER_ENTREGA>([A-Z]{2}(([0-9]){3}|100),[A-Za-z0-9]{5},[1-9][0-9]*) {     /* Guardar o valor das variáveis a usar no yacc*/
                                                                        linha = strtok(yytext, ",");
                                                                        material_entrega = strtok(NULL, ",");
                                                                        quant_str = strtok(NULL, ")");
                                                                        quantidade=atoi(quant_str);
                                                                        aux_quant=total_quantidade; 
                                                                        return _ENTREGA;
}
<ER_ENTREGA>\) {BEGIN 0;}


{ESTADO}\( {BEGIN(ER_ESTADO);}
<ER_ESTADO>([BTM]|<ER_ESTADO>[BTM],[BTM],[BTM]|<ER_ESTADO>[BTM],[BTM]) { aux_estado = yytext; return _ESTADO;
}
<ER_ESTADO>\) {BEGIN 0;}


(";"|"{"|"}"|"(")    return yytext[0];
")"                  return ')';
[/t ]	;
.	;
%%

int yywrap(void) {
    return 1;
}