%{
#include <kiraz/stmt.h>
#include <kiraz/hw2-lexer.hpp>

using namespace kiraz;
using kiraz::Stmt;
using kiraz::Token;
int yyerror(const char *s);

#define YYSTYPE std::shared_ptr<Stmt>
#define YYDEBUG 1
%}

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
input:	%empty 
		| input line;

line: 	expression OP_NEWLINE
    	;

expression: int
			| plus
			| minus
			| mult
			| div
			| paren
			| neg
			;

int: L_INTEGER { $$ = $1; };
plus: L_INTEGER OP_PLUS L_INTEGER { $$ = $1 + $3; };
minus: L_INTEGER OP_MINUS L_INTEGER { $$ = $1 - $3; };
mult: L_INTEGER OP_MULT L_INTEGER { $$ = $1 * $3; };
div: L_INTEGER OP_DIVF L_INTEGER { $$ = $1 / $3; };
paren: OP_LPAREN L_INTEGER OP_RPAREN { $$ = $2; };
neg: OP_MINUS L_INTEGER { $$ = -$2; };
%%

int yyerror(const char *s) {
    fmt::print("** Parser error. text: '{}'\n", s);
    Stmt::reset_root();
    return 1;
}
