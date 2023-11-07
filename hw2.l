
%{
#include <kiraz/token.h>
using namespace kiraz::token;
using kiraz::Token;

int char_number = 0; 
%}

%option yylineno
%option noyywrap

OP_RETURNS ->
OP_EQUALS  ==
OP_ASSIGN  =
OP_GT      >
OP_LT      <
OP_GE      >=
OP_LE      <=
OP_LPAREN  \(
OP_RPAREN  \)
OP_LBRACE  \{
OP_RBRACE  \}
OP_PLUS    \+
OP_MINUS   \-
OP_MULT    \*
OP_DIVF    \/
OP_COMMA   ,
OP_NEWLINE \n
OP_COLON   :
OP_SCOLON  ;
OP_DOT     \.
OP_NOT     !

KW_IMPORT  import
KW_FUNC    func
KW_IF      if
KW_WHILE   while
KW_CLASS   class

LC_DEC     [0-9]
LC_HEX     [0-9A-Fa-f]
LC_TRUE    true
LC_FALSE   false

IDENTIFIER [a-zA-Z_][0-9a-zA-Z_]*
IGNORED    [ \t]

%%

{KW_IMPORT}     { char_number+=yyleng; return Token::feed(KeywordImport()); }
{KW_FUNC}       { char_number+=yyleng; return Token::feed(KeywordFunc()); }
{KW_IF}         { char_number+=yyleng; return Token::feed(KeywordIf()); }
{KW_WHILE}      { char_number+=yyleng; return Token::feed(KeywordWhile()); }
{KW_CLASS}      { char_number+=yyleng; return Token::feed(KeywordClass()); }
{LC_TRUE}       { char_number+=yyleng; return Token::feed(Boolean(true)); }
{LC_FALSE}      { char_number+=yyleng; return Token::feed(Boolean(false)); }

{LC_DEC}+       { char_number+=yyleng; return Token::feed(Integer::DecInteger(yytext)); }
0x{LC_HEX}+     { char_number+=yyleng; return Token::feed(Integer::HexInteger(yytext)); }
\"[^\"]+\"      { char_number+=yyleng; return Token::feed(String(yytext)); }

{OP_RETURNS}    { char_number+=yyleng; return Token::feed(OperatorReturns()); }
{OP_EQUALS}     { char_number+=yyleng; return Token::feed(OperatorEquals()); }
{OP_ASSIGN}     { char_number+=yyleng; return Token::feed(OperatorAssign()); }
{OP_GT}         { char_number+=yyleng; return Token::feed(OperatorGt()); }
{OP_LT}         { char_number+=yyleng; return Token::feed(OperatorLt()); }
{OP_GE}         { char_number+=yyleng; return Token::feed(OperatorGe()); }
{OP_LE}         { char_number+=yyleng; return Token::feed(OperatorLe()); }
{OP_LPAREN}     { char_number+=yyleng; return Token::feed(OperatorLParen()); }
{OP_RPAREN}     { char_number+=yyleng; return Token::feed(OperatorRParen()); }
{OP_LBRACE}     { char_number+=yyleng; return Token::feed(OperatorLBrace()); }
{OP_RBRACE}     { char_number+=yyleng; return Token::feed(OperatorRBrace()); }
{OP_PLUS}       { char_number+=yyleng; return Token::feed(OperatorPlus()); }
{OP_MINUS}      { char_number+=yyleng; return Token::feed(OperatorMinus()); }
{OP_MULT}       { char_number+=yyleng; return Token::feed(OperatorMult()); }
{OP_DIVF}       { char_number+=yyleng; return Token::feed(OperatorDivF()); }
{OP_COMMA}      { char_number+=yyleng; return Token::feed(OperatorComma()); }
{OP_NEWLINE}+   { char_number=0; return Token::feed(OperatorNewline()); }
{OP_COLON}      { char_number+=yyleng; return Token::feed(OperatorColon()); }
{OP_SCOLON}+    { char_number+=yyleng; return Token::feed(OperatorScolon()); }
{OP_DOT}        { char_number+=yyleng; return Token::feed(OperatorDot()); }
{OP_NOT}        { char_number+=yyleng; return Token::feed(OperatorNot()); }

{IDENTIFIER}    { char_number+=yyleng; return Token::feed(Identifier(yytext)); }

{IGNORED}+      { char_number+=yyleng; };
.               { char_number+=yyleng; return Token::feed(Rejected(yytext)); }
