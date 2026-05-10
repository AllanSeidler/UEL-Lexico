%option noyywrap
%{
#include <string.h>
#define MAX_ID_SIZE 255
char is_comment=0,scomment=0,mcomment=0;
int col=1, // coluna atual
    lin=1, // linha atual
    iComCol=1, // inicio comentario coluna
    iComLin=1; // inicio comentario linha

void print_new_line();
void void_print();

typedef void (*PRINT)();
PRINT println = void_print;
void print_new_line(){printf("\n");}
void void_print(){println=print_new_line;}

void error(const char* text,int l, int c){
    println();
    printf("error:lexical:%d:%d: %s",l,c,text);
}
void warning(const char* text){
    println();
    printf("warning:%d:%d: \'%s\' within block comment",lin,col,text);
}
void generic(const char* token,const char* text){
    col+=strlen(text);
    if(!is_comment){
        println();
        printf("%s",token);
    }
}
void start_comment(char type){ // 0:de linha, 1:de bloco
    if(!is_comment){
        iComCol=col;
        iComLin=lin;
        is_comment=1;
        if(type) mcomment=1; 
        else scomment=1;
    } else {
        if(type) warning("/*");
        // else warning("//");
    } col+=2;
}
void end_comment(){
    if(is_comment) {
        if(mcomment){
            is_comment=0;
            mcomment=0;
        } else {
            warning("*/");
        }
    } else error("*/",lin,col);
    col+=2;
}
void number(const char* token, const char* text){
    col+=strlen(text);
    if(!is_comment){
        println();
        printf("%s(%s)",token,text);
    }
}
void string_and_char(const char* token, const char* text){
    int s = strlen(text);
    col += s;
    if(!is_comment){
        println();
        printf("%s(",token);
        for(int i =1; i<s-1; i++){
            printf("%c",text[i]);
        }
        printf(")");
    }
}
void identifier(const char* text){
    int s = strlen(text);
    if(!is_comment){
        if(s>MAX_ID_SIZE) error("identifier too long",lin,col);
        else {
            println();
            printf("IDENTIFIER(%s)",text);
        }
    } col+=s;
}
void randon_char(const char* text){
    if(!is_comment){
        error(text,lin,col);
    }col++;
}
void bab(){ //barra asterisco barra
    if(is_comment){
        col++;
        end_comment();
    } else {
        start_comment(1);
        col++;
    }
}
%}

%%
void {generic("VOID",yytext);}
int {generic("INT",yytext);}
char {generic("CHAR",yytext);}
return {generic("RETURN",yytext);}
break {generic("BREAK",yytext);}
switch {generic("SWITCH",yytext);}
case {generic("CASE",yytext);}
default {generic("DEFAULT",yytext);}
do {generic("DO",yytext);}
while {generic("WHILE",yytext);}
for {generic("FOR",yytext);}
if {generic("IF",yytext);}
else {generic("ELSE",yytext);}
typedef {generic("TYPEDEF",yytext);}
struct {generic("STRUCT",yytext);}
printf {generic("PRINTF",yytext);}
scanf {generic("SCANF",yytext);}
define {generic("DEFINE",yytext);}
exit {generic("EXIT",yytext);}
"/*/" {bab();}
"//" {start_comment(0);}
"*/" {end_comment();}
"/*" {start_comment(1);}
"/" {generic("DIV",yytext);}
"*" {generic("MULTIPLY",yytext);}
% {generic("REMAINDER",yytext);}
-> {generic("POINTER",yytext);}
-- {generic("DEC",yytext);}
"+" {generic("PLUS",yytext);}
"++" {generic("INC",yytext);}
- {generic("MINUS",yytext);}
~ {generic("BITWISE_NOT",yytext);}
"^" {generic("BITWISE_XOR",yytext);}
! {generic("NOT",yytext);}
&& {generic("LOGICAL_AND",yytext);}
"||" {generic("LOGICAL_OR",yytext);}
& {generic("BITWISE_AND",yytext);}
"|" {generic("BITWISE_OR",yytext);}
"==" {generic("EQUAL",yytext);}
"!=" {generic("NOT_EQUAL",yytext);}
"<=" {generic("LESS_EQUAL",yytext);}
">=" {generic("GREATER_EQUAL",yytext);}
">>" {generic("R_SHIFT",yytext);}
"<<" {generic("L_SHIFT",yytext);}
"<" {generic("LESS_THAN",yytext);}
">" {generic("GREATER_THAN",yytext);}
"=" {generic("ASSIGN",yytext);}
["+"]= {generic("ADD_ASSIGN",yytext);}
-= {generic("MINUS_ASSIGN",yytext);}
";" {generic("SEMICOLON",yytext);}
"," {generic("COMMA",yytext);}
":" {generic("COLON",yytext);}
"(" {generic("L_PAREN",yytext);}
")" {generic("R_PAREN",yytext);}
"{" {generic("L_CURLY_BRACKET",yytext);}
"}" {generic("R_CURLY_BRACKET",yytext);}
"[" {generic("L_SQUARE_BRACKET",yytext);}
"]" {generic("R_SQUARE_BRACKET",yytext);}
\? {generic("TERNARY_CONDITIONAL",yytext);}
"#" {generic("NUMBER_SIGN",yytext);}
[_a-zA-Z][_a-zA-Z0-9]* {identifier(yytext);}
\'\\?.?\' {string_and_char("CHARACTER",yytext);}
\"[^\"\n]*\" {string_and_char("STRING",yytext);}
0[Xx][0-9a-fA-F]+ {number("NUM_HEXA",yytext);}
0[1-7][0-7]* {number("NUM_OCTAL",yytext);}
[0-9]+ {number("NUM_INTEGER",yytext);}
[ ] {col++;}
\n {col=1;lin++; if(scomment){is_comment=0;scomment=0;}}
. {randon_char(yytext);}
%%

int main(){
    yylex();
    if(is_comment) error("unterminated comment",iComLin,iComCol);
    return 0;
}