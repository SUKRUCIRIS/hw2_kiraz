%{
#include <kiraz/stmt.h>
#include <kiraz/hw2-lexer.hpp>

int yyerror(const char *s);

#define YYSTYPE std::shared_ptr<kiraz::Stmt>
#define YYDEBUG 1

extern int char_number;
%}

%locations

%token    IDENTIFIER

// Operators
%token    OP_RETURNS
%token    OP_EQUALS
%token    OP_ASSIGN
%token    OP_GT
%token    OP_LT
%token    OP_GE
%token    OP_LE
%token    OP_LPAREN
%token    OP_RPAREN
%token    OP_LBRACE
%token    OP_RBRACE
%token    OP_COLON
%token    OP_PLUS
%token    OP_MINUS
%token    OP_MULT
%token    OP_DIVF
%token    OP_COMMA
%token    OP_NEWLINE
%token    OP_SCOLON
%token    OP_DOT
%token    OP_NOT

// Literals
%token    L_INTEGER
%token    L_STRING
%token    L_BOOLEAN

// Keywords
%token    KW_IF
%token    KW_FUNC
%token    KW_WHILE
%token    KW_CLASS
%token    KW_IMPORT

%%

input: 	%empty
		| second
		| input OP_NEWLINE
		| input OP_SCOLON
		;

second: second OP_PLUS first { $$=kiraz::Stmt::add<kiraz::stmt::Operator>(0,$1,$3); }
		| second OP_MINUS first { $$=kiraz::Stmt::add<kiraz::stmt::Operator>(1,$1,$3); }
		| first {$$=$1;}
		;

first: 	first OP_MULT paran { $$=kiraz::Stmt::add<kiraz::stmt::Operator>(2,$1,$3); }
		| first OP_DIVF paran { $$=kiraz::Stmt::add<kiraz::stmt::Operator>(3,$1,$3); }
		| paran {$$=$1;}
		;

paran: 	OP_LPAREN second OP_RPAREN {$$=$2;}
		| int {$$=$1;}
		;

int: 	posi_int {$$=kiraz::Stmt::add<kiraz::stmt::Integer>(true, kiraz::Token::last());}
		| nega_int {$$=kiraz::Stmt::add<kiraz::stmt::Integer>(false, kiraz::Token::last());}
		;

posi_int: 	L_INTEGER
			| OP_PLUS L_INTEGER
			; 

nega_int: 	OP_MINUS L_INTEGER;

%%

int yyerror(const char *s) {
    fmt::print("** Parser Error at line# {} char# {}. Current token: {}\n", yylineno, char_number, kiraz::Token::last().get_repr());
    kiraz::Stmt::reset_root();
    return 1;
}
