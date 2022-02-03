%{
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <string.h>
%}

/*Seccion de opciones*/
%option noyywrap
/* Nombre de salida del archivo */
%option outfile = "scanner.c"


/* SECCION DE TOKENS */

/*TOKENS BASICOS*/
DIGITO            [0-9]
LETRA             [a-zA-ZñÑ]
GUIONBAJO         [_]
COMA              ","
PUNTO             "."
COMENTARIO        "//"
PUNTOYCOMA        ";"
ESPACIOS          [" "\n\t]
CADENA            \"[^\n"]*\"
ENTERO            (-?[1-9][0-9]{0,4})|0
REAL              {DIGITO}{0,8}"."{DIGITO}{1,8}
ID                {LETRA}({LETRA}|{DIGITO}|{GUIONBAJO})*

/*PALABRAS RESERVADAS*/
IF                "if"
ELSE              "else"
WHILE             "while"
FOR               "for"
INT               "int"
FLOAT             "float"
STRING            "string"
CHAR              "char"
PRINT             "print"
INPUT             "input"
AND               "and"
OR                "or"

/*DELIMITADORES*/
LLAVE_A           "{"
LLAVE_C           "}"
PARENTESIS_A      "("
PARENTESIS_C      ")"
CORCHETE_A        "["
CORCHETE_C        "]" 

/*OPERADORES*/
OP_SUMA           "+"
OP_RESTA          "-"
OP_MULT           "*"
OP_DIV            "/"
OP_IGUAL          "="
OP_MENOR          "<"
OP_MENORIGUAL     "<="
OP_MAYOR          ">"
OP_MAYORIGUAL     ">="
OP_COMP_IGUAL     "=="
OP_NEGACION       "!"
OP_DISTINTO       "!="

/*Seccion de reglas, es importante el orden debido a que se buscara el patron y se ejecutara el patron en orden secuencial*/
%%

{COMA}            {printf("COMA: %s\n", yytext);}
{PUNTOYCOMA}      {printf("PUNTO Y COMA: %s\n", yytext);}
{ENTERO}          {printf("ENTERO: %s\n", yytext);}
{REAL}            {printf("REAL: %s\n", yytext);}
{CADENA}          {printf("CADENA: %s\n", yytext);}
{GUIONBAJO}       {printf("GUION BAJO: %s\n", yytext);}
{PUNTO}           {printf("PUNTO: %s\n", yytext);}
{COMENTARIO}      {printf("COMENTARIO: %s\n", yytext);}

 
{OP_SUMA}         {printf("OPERADOR SUMA: %s\n", yytext);}
{OP_RESTA}        {printf("OPERADOR RESTA: %s\n", yytext);}
{OP_MULT}         {printf("OPERADOR MULT: %s\n", yytext);}
{OP_DIV}          {printf("OPERADOR DIV: %s\n", yytext);}
{OP_IGUAL}        {printf("OPERADOR IGUAL: %s\n", yytext);}
{OP_MENOR}        {printf("OPERADOR MENOR: %s\n", yytext);}
{OP_MENORIGUAL}   {printf("OPERADOR MENORIGUAL: %s\n", yytext);}
{OP_MAYOR}        {printf("OPERADOR MAYOR: %s\n", yytext);}
{OP_MAYORIGUAL}   {printf("OPERADOR MAYORIGUAL: %s\n", yytext);}
{OP_COMP_IGUAL}   {printf("OPERADOR COMPARADOR IGUAL: %s\n", yytext);}
{OP_NEGACION}     {printf("OPERADOR NEGACION: %s\n", yytext);}
{OP_DISTINTO}     {printf("OPERADOR DISTINTO: %s\n", yytext);}

{LLAVE_A}         {printf("LLAVE APERTURA: %s\n", yytext);}
{LLAVE_C}         {printf("LLAVE CIERRE: %s\n", yytext);}
{PARENTESIS_A}    {printf("PARENTESIS APERTURA: %s\n", yytext);}
{PARENTESIS_C}    {printf("PARENTESIS CIERRE: %s\n", yytext);}
{CORCHETE_A}      {printf("CORCHETE APERTURA: %s\n", yytext);}
{CORCHETE_C}      {printf("CORCHETE CIERRE: %s\n", yytext);}  

{IF}              {printf("PALABRA RESERVADA IF\n");}
{ELSE}            {printf("PALABRA RESERVADA ELSE\n");}
{WHILE}           {printf("PALABRA RESERVADA WHILE\n");}
{FOR}             {printf("PALABRA RESERVADA FOR\n");}
{INT}             {printf("PALABRA RESERVADA INT\n");}
{FLOAT}           {printf("PALABRA RESERVADA FLOAT\n");}
{STRING}          {printf("PALABRA RESERVADA STRING\n");}
{CHAR}            {printf("PALABRA RESERVADA CHAR\n");}
{PRINT}           {printf("PALABRA RESERVADA PRINT\n");}
{INPUT}           {printf("PALABRA RESERVADA INPUT\n");}
{AND}             {printf("PALABRA RESERVADA AND\n");}
{OR}              {printf("PALABRA RESERVADA OR\n");}       

{ID}              {printf("ID: %s\n", yytext);}

{ESPACIOS}      

.               {printf("Error, caracter invalido: %s\n", yytext);}

%%

int main(){
    
    char linea[255];
    FILE *archivo = fopen("codigo.txt","r");
    FILE *aux = fopen("tem.txt", "w");

    while(fgets(linea, sizeof(linea), archivo)){
        aux = freopen("tem.txt", "w", aux);
        
        if(linea[strlen(linea)-1] == '\n')
            linea[strlen(linea)-1] = ' ';
        
        printf("\n%s\n\n", linea);
        fprintf(aux, "%s", linea);
        aux = freopen("tem.txt", "r", aux);
        yyin = aux;
        yylex();  
    }
    
    fclose(archivo);
    fclose(aux);
    remove("tem.txt");
    return 0;
}