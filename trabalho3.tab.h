/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_TRABALHO3_TAB_H_INCLUDED
# define YY_YY_TRABALHO3_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    INICIO_DAS_INSTRUCOES = 258,   /* INICIO_DAS_INSTRUCOES  */
    FINAL_DAS_INSTRUCOES = 259,    /* FINAL_DAS_INSTRUCOES  */
    PONTO_VIRGULA = 260,           /* PONTO_VIRGULA  */
    INICIO_FIM_INSTRUCOES = 261,   /* INICIO_FIM_INSTRUCOES  */
    INICIO_INSTRUCOES = 262,       /* INICIO_INSTRUCOES  */
    OPCIONAL = 263,                /* OPCIONAL  */
    MANUTENCAO = 264,              /* MANUTENCAO  */
    CARREGA_BATERIA = 265,         /* CARREGA_BATERIA  */
    ENTREGA = 266,                 /* ENTREGA  */
    RECOLHE = 267,                 /* RECOLHE  */
    ESTADO = 268,                  /* ESTADO  */
    INIT_ESTADO = 269,             /* INIT_ESTADO  */
    INICIO_MANUTENCAO = 270,       /* INICIO_MANUTENCAO  */
    FIM_MANUTENCAO = 271,          /* FIM_MANUTENCAO  */
    _MANUTENCAO = 272,             /* _MANUTENCAO  */
    INICIO_BATERIA = 273,          /* INICIO_BATERIA  */
    FIM_BATERIA = 274,             /* FIM_BATERIA  */
    _BATERIA = 275,                /* _BATERIA  */
    INICIO_RECOLHE = 276,          /* INICIO_RECOLHE  */
    FIM_RECOLHE = 277,             /* FIM_RECOLHE  */
    _RECOLHE = 278,                /* _RECOLHE  */
    INICIO_ENTREGA = 279,          /* INICIO_ENTREGA  */
    FIM_ENTREGA = 280,             /* FIM_ENTREGA  */
    _ENTREGA = 281,                /* _ENTREGA  */
    INICIO_ESTADO = 282,           /* INICIO_ESTADO  */
    FIM_ESTADO = 283,              /* FIM_ESTADO  */
    _ESTADO = 284,                 /* _ESTADO  */
    INICIO_INIT_ESTADO = 285,      /* INICIO_INIT_ESTADO  */
    FIM_INIT_ESTADO = 286,         /* FIM_INIT_ESTADO  */
    _INIT_ESTADO = 287,            /* _INIT_ESTADO  */
    NUMERO = 288,                  /* NUMERO  */
    STRING = 289                   /* STRING  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 15 "trabalho3.y"

    int inteiro;
    char* string;

#line 103 "trabalho3.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_TRABALHO3_TAB_H_INCLUDED  */
