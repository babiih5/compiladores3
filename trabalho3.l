%x ER_MANUTENCAO ER_BATERIA ER_ENTREGA ER_RECOLHE ER_ESTADO ER_INIT_ESTADO

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "trabalho3.tab.h"
    #include "variaveis.h"
    char *bateria_aux, *quantidade_aux, *manutencao_aux;
    int manutencao=2, estado_bateria=2, quantidade=0, num_manutencao=0, tarefas=0, total_quantidade=0;
    char *instrucao="", *posicao="Posto de Carregamento", *linha="", *quant_str="", *material_entrega="", *material_carro="",*material_recolha="",*aux_material="", *aux_estado="", *total_materiais="";
    float perc_bateria=100.0,aux_quant=0.0,bateria_necessaria=0.0;


%}
INIT_ESTADO _INIT_ESTADO

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



{MANUTENCAO}\( {BEGIN(ER_MANUTENCAO);}
<ER_MANUTENCAO>([0-2]) {    manutencao=atoi(yytext); return _MANUTENCAO;
}
<ER_MANUTENCAO>\) {BEGIN 0;}


{CARREGA-BATERIA}\( {BEGIN(ER_BATERIA);}
<ER_BATERIA>([0-2]) {       estado_bateria=atoi(yytext); return _BATERIA;
}
<ER_BATERIA>\) {BEGIN 0;}


{RECOLHE}\( {BEGIN(ER_RECOLHE);}
<ER_RECOLHE>(\([A-Za-z0-9]{5},[1-9][0-9]*\)(,\([A-Za-z0-9]{5},[1-9][0-9]*\))*) {    aux_material = strtok(yytext, ",");
                                                                                    quant_str = strtok(NULL, ")");
                                                                                    quantidade=atoi(quant_str);
                                                                                    aux_quant=total_quantidade; 
                                                                                    return _RECOLHE;
}
<ER_RECOLHE>\) {BEGIN 0;}


{ENTREGA}\( {BEGIN(ER_ENTREGA);}
<ER_ENTREGA>([A-Z]{2}(([0-9]){3}|100),[A-Za-z0-9]{5},[1-9][0-9]*) {     linha = strtok(yytext, ",");
                                                                        material_entrega = strtok(NULL, ",");
                                                                        quant_str = strtok(NULL, ")");
                                                                        quantidade=atoi(quant_str);
                                                                        aux_quant=total_quantidade; 
                                                                        return _ENTREGA;
}
<ER_ENTREGA>\) {BEGIN 0;}


{ESTADO}\( BEGIN(ER_ESTADO);
<ER_ESTADO>([BTM]|<ER_ESTADO>[BTM],[BTM],[BTM]|<ER_ESTADO>[BTM],[BTM]) { aux_estado = yytext; return _ESTADO;
}
<ER_ESTADO>\) {BEGIN 0;}


(";"|")"|"{"|"}"|"(")    return yytext[0];
[/t ]	;
.	;
%%

int yywrap(void) {
    return 1;
}