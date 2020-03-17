// ==========================================================================
//  Source: ISO/IEC 9899:TC3 Committee Draft — Septermber 7, 2007 WG14/N1256
//  (c) Copyright Eugene Zouev, 2010 
// ==========================================================================

%token IDENTIFIER
%token INTEGER_CONSTANT
%token FLOATING_CONSTANT
%token CHARACTER_CONSTANT
%token STRING_LITERAL

%token LPAREN         // (
%token RPAREN         // )
%token LBRACKET       // [
%token RBRACKET       // ]
%token DOT            // .
%token ARROW          // ->
%token PLUSPLUS       // ++
%token MINUSMINUS     // --
%token LBRACE         // {
%token RBRACE         // }
%token COMMA          // ,
%token STAR           // *
%token PLUS           // +
%token MINUS          // -
%token TILDE          // ~
%token EXCLAMATION    // !
%token SLASH          // /
%token PERCENT        // %
%token LSHIFT         // <<
%token RSHIFT         // >>
%token LESS           // <
%token GREATER        // >
%token LESS_EQUAL     // <=
%token GREATER_EQUAL  // >=
%token EQUAL          // ==
%token NON_EQUAL      // !=
%token AMPERSAND      // &
%token CARET          // ^
%token VERTICAL       // |
%token DBLAMPERSAND   // &&
%token DBLVERTICAL    // ||
%token QUESTION       // ?
%token COLON          // :
%token ASSIGN         // =
%token STAR_ASSIGN    // *= 
%token SLASH_ASSIGN   // /= 
%token PERCENT_ASSIGN // %= 
%token PLUS_ASSIGN    // += 
%token MINUS_ASSIGN   // -= 
%token LSHIFT_ASSIGN  // <<= 
%token RSHIFT_ASSIGN  // >>= 
%token AMP_ASSIGN     // &= 
%token CARET_ASSIGN   // ^= 
%token VERT_ASSIGN    // |=
%token SEMICOLON      // ;
%token ELLIPSIS       // ...

%token TYPEDEF        // typedef
%token EXTERN         // extern
%token STATIC         // static
%token AUTO           // auto
%token REGISTER       // register
%token VOID           // void
%token CHAR           // char
%token SHORT          // short
%token INT            // int
%token LONG           // long
%token FLOAT          // float
%token DOUBLE         // double
%token SIGNED         // signed
%token UNSIGNED       // unsigned
%token _BOOL          // _Bool
%token _COMPLEX       // _Complex
%token STRUCT         // struct
%token UNION          // union
%token ENUM           // enum
%token CONST          // const
%token RESTRICT       // restrict
%token VOLATILE       // volatile
%token INLINE         // inline
%token CASE           // case
%token DEFAULT        // default
%token IF             // if
%token ELSE           // else
%token SWITCH         // switch
%token WHILE          // while
%token DO             // do
%token FOR            // for
%token GOTO           // goto
%token CONTINUE       // continue
%token BREAK          // break
%token RETURN         // return
%token SIZEOF         // sizeof

// Adding this terminal symbol is the only assumption
// made to make the grammar unambiguous.
// The original non-terminal symbol TypedefName (which was
// simply IDENTIFIER) caused reduce/reduce conflict
// in declaration-related productions.
//
// The meaning of this terminal symbol is that scanner
// should be able to distinguish typedef-names (i.e. identifiers
// declared in a declaration containing typedef keyword)
// from all other kinds of identifiers.
//
%token TYPEDEFNAME // Added as a replacement for TypedefName production

%start TranslationUnit

%%

// Expressions ///////////////////////////////////////////////////////////////////////

Constant         : INTEGER_CONSTANT
                 | FLOATING_CONSTANT
                 | CHARACTER_CONSTANT
              // | ENUMERATION_CONSTANT -- IDENTIFIER
                 ;
                       
PrimaryExpression
                 : IDENTIFIER
                 | Constant
                 | STRING_LITERAL
                 | ParenthExpression
                 ;
                  
PostfixExpression: PrimaryExpression
                 | PostfixExpression LBRACKET Expression RBRACKET
                 | PostfixExpression LPAREN                        RPAREN
                 | PostfixExpression LPAREN ArgumentExpressionList RPAREN
                 | PostfixExpression DOT IDENTIFIER
                 | PostfixExpression ARROW IDENTIFIER
                 | PostfixExpression PLUSPLUS
                 | PostfixExpression MINUSMINUS
                 | LPAREN TypeName RPAREN LBRACE InitializerList       RBRACE
                 | LPAREN TypeName RPAREN LBRACE InitializerList COMMA RBRACE
                 ;

ArgumentExpressionList
                 :                              AssignmentExpression
                 | ArgumentExpressionList COMMA AssignmentExpression
                 ;
                  
UnaryExpression  : PostfixExpression
                 | PLUSPLUS UnaryExpression
                 | MINUSMINUS UnaryExpression
                 | UnaryOperator CastExpression
                 | SIZEOF UnaryExpression
                 | SIZEOF LPAREN TypeName RPAREN
                 ;
                  
UnaryOperator    : AMPERSAND
                 | STAR
                 | PLUS
                 | MINUS
                 | TILDE
                 | EXCLAMATION
                 ;

CastExpression   : UnaryExpression
                 | LPAREN TypeName RPAREN CastExpression
                 ;
                  
MultiplicativeExpression
                 :                                  CastExpression
                 | MultiplicativeExpression STAR    CastExpression
                 | MultiplicativeExpression SLASH   CastExpression
                 | MultiplicativeExpression PERCENT CastExpression
                 ;

AdditiveExpression
                 :                          MultiplicativeExpression
                 | AdditiveExpression PLUS  MultiplicativeExpression
                 | AdditiveExpression MINUS MultiplicativeExpression
                 ;
                  
ShiftExpression  :                        AdditiveExpression
                 | ShiftExpression LSHIFT AdditiveExpression
                 | ShiftExpression RSHIFT AdditiveExpression
                 ;
                  
RelationalExpression
                 :                                    ShiftExpression
                 | RelationalExpression LESS          ShiftExpression
                 | RelationalExpression GREATER       ShiftExpression
                 | RelationalExpression LESS_EQUAL    ShiftExpression
                 | RelationalExpression GREATER_EQUAL ShiftExpression
                 ;
                  
EqualityExpression
                 :                              RelationalExpression
                 | EqualityExpression EQUAL     RelationalExpression
                 | EqualityExpression NON_EQUAL RelationalExpression
                 ;
                       
ANDExpression    :                         EqualityExpression
                 | ANDExpression AMPERSAND EqualityExpression
                 ;
                       
ExclusiveORExpression  
                 :                             ANDExpression
                 | ExclusiveORExpression CARET ANDExpression
                 ;
                       
InclusiveORExpression  
                 :                                ExclusiveORExpression
                 | InclusiveORExpression VERTICAL ExclusiveORExpression
                 ;
                       
LogicalANDExpression   
                 :                                   InclusiveORExpression
                 | LogicalANDExpression DBLAMPERSAND InclusiveORExpression
                 ;
                       
LogicalORExpression
                 :                                 LogicalANDExpression
                 | LogicalORExpression DBLVERTICAL LogicalANDExpression
                 ;
                       
ConditionalExpression  
                 : LogicalORExpression
                 | LogicalORExpression QUESTION Expression COLON ConditionalExpression
                 ;
                       
AssignmentExpression   
                 : ConditionalExpression
                 | UnaryExpression AssignmentOperator AssignmentExpression
                 ;
                       
AssignmentOperator
                 : ASSIGN         // =
                 | STAR_ASSIGN    // *= 
                 | SLASH_ASSIGN   // /= 
                 | PERCENT_ASSIGN // %= 
                 | PLUS_ASSIGN    // += 
                 | MINUS_ASSIGN   // -= 
                 | LSHIFT_ASSIGN  // <<= 
                 | RSHIFT_ASSIGN  // >>= 
                 | AMP_ASSIGN     // &= 
                 | CARET_ASSIGN   // ^= 
                 | VERT_ASSIGN    // |=
                 ;
                       
Expression       :                  AssignmentExpression
                 | Expression COMMA AssignmentExpression
                 ;

ConstantExpression
                 : ConditionalExpression
                 ;

ExpressionOpt    : // empty
                 | Expression
                 ;

ParenthExpression: LPAREN Expression RPAREN
                 ;
                       
// Declarations /////////////////////////////////////////////////////////////////

Declaration      : DeclarationSpecifierSeq                    SEMICOLON
                 | DeclarationSpecifierSeq InitDeclaratorList SEMICOLON
                 ;

DeclarationSpecifierSeq
                 :                         DeclarationSpecifier
                 | DeclarationSpecifierSeq DeclarationSpecifier
                 ;
                       
DeclarationSpecifier   
                 : StorageClassSpecifier
                 | TypeSpecifier
                 | TypeQualifier
                 | INLINE  // function-specifier
                 ;
                       
InitDeclaratorList
                 :                          InitDeclarator
                 | InitDeclaratorList COMMA InitDeclarator
                 ;
                       
InitDeclarator   : Declarator
                 | Declarator ASSIGN Initializer
                 ;
                       
StorageClassSpecifier
                 : TYPEDEF
                 | EXTERN
                 | STATIC
                 | AUTO
                 | REGISTER
                 ;
                       
TypeSpecifier    : VOID
                 | CHAR
                 | SHORT
                 | INT
                 | LONG
                 | FLOAT
                 | DOUBLE
                 | SIGNED
                 | UNSIGNED 
                 | _BOOL
                 | _COMPLEX
                 | StructOrUnionSpecifier STAR
                 | EnumSpecifier
                 | TYPEDEFNAME  // instead of TypedefName
                 ;
                       
StructOrUnionSpecifier
                 : StructOrUnion            LBRACE StructDeclarationSeq RBRACE
                 | StructOrUnion IDENTIFIER LBRACE StructDeclarationSeq RBRACE
                 | StructOrUnion IDENTIFIER
                 ;
                       
StructOrUnion    : STRUCT
                 | UNION
                 ;
                       
StructDeclarationSeq
                 :                      StructDeclaration
                 | StructDeclarationSeq StructDeclaration
                 ;
                       
StructDeclaration: SpecifierQualifierSeq StructDeclaratorList SEMICOLON
                 ;

SpecifierQualifierSeq  
                 :                       SpecifierQualifier
                 | SpecifierQualifierSeq SpecifierQualifier
                 ;
                       
SpecifierQualifier
                 : TypeSpecifier
                 | TypeQualifier
                 ;
                       
StructDeclaratorList
                 :                            StructDeclarator
                 | StructDeclaratorList COMMA StructDeclarator
                 ;
                       
StructDeclarator : Declarator
                 |            COLON ConstantExpression
                 | Declarator COLON ConstantExpression
                 ;
                       
EnumSpecifier    : ENUM            LBRACE EnumeratorList       RBRACE
                 | ENUM IDENTIFIER LBRACE EnumeratorList       RBRACE
                 | ENUM            LBRACE EnumeratorList COMMA RBRACE
                 | ENUM IDENTIFIER LBRACE EnumeratorList COMMA RBRACE
                 | ENUM IDENTIFIER
                 ;
                       
EnumeratorList   :                      Enumerator
                 | EnumeratorList COMMA Enumerator
                 ;
                       
Enumerator       : IDENTIFIER
                 | IDENTIFIER ASSIGN ConstantExpression
                 ;
                       
TypeQualifier    : CONST
                 | RESTRICT
                 | VOLATILE
                 ;
                       
Declarator       :         DirectDeclarator
                 | Pointer DirectDeclarator
                 ;
                       
DirectDeclarator : IDENTIFIER
                 | LPAREN Declarator RPAREN
                       
                 | DirectDeclarator LBRACKET        TypeQualifierSeqOpt                             RBRACKET
                 | DirectDeclarator LBRACKET        TypeQualifierSeqOpt        AssignmentExpression RBRACKET
                 | DirectDeclarator LBRACKET STATIC TypeQualifierSeqOpt        AssignmentExpression RBRACKET
                 | DirectDeclarator LBRACKET        TypeQualifierSeq    STATIC AssignmentExpression RBRACKET
                 | DirectDeclarator LBRACKET        TypeQualifierSeqOpt                        STAR RBRACKET
                       
                 | DirectDeclarator LPAREN ParameterTypeList RPAREN
                 | DirectDeclarator LPAREN IdentifierList    RPAREN
                 | DirectDeclarator LPAREN                   RPAREN
                 ;
                       
Pointer          :         STAR TypeQualifierSeqOpt
                 | Pointer STAR TypeQualifierSeqOpt
                 ;

TypeQualifierSeqOpt
                 : // empty
                 | TypeQualifierSeq
                 ;

TypeQualifierSeq :                  TypeQualifier
                 | TypeQualifierSeq TypeQualifier
                 ;
                       
ParameterTypeList: ParameterList
                 | ParameterList COMMA ELLIPSIS
                 ;
                       
ParameterList    :                     ParameterDeclaration
                 | ParameterList COMMA ParameterDeclaration
                 ;
                       
ParameterDeclaration
                 : DeclarationSpecifierSeq Declarator
                 | DeclarationSpecifierSeq AbstractDeclarator
                 | DeclarationSpecifierSeq
                 ;
                       
IdentifierList   :                      IDENTIFIER
                 | IdentifierList COMMA IDENTIFIER
                 ;
                       
TypeName         : SpecifierQualifierSeq
                 | SpecifierQualifierSeq AbstractDeclarator
                 ;
                       
AbstractDeclarator
                 : Pointer
                 |         DirectAbstractDeclarator
                 | Pointer DirectAbstractDeclarator
                 ;
                       
DirectAbstractDeclarator
                 : LPAREN AbstractDeclarator RPAREN
                 | DirectAbstractDeclarator DirectAbstractDeclaratorTail
                 |                          DirectAbstractDeclaratorTail
                 ;

DirectAbstractDeclaratorTail
                 : LBRACKET                                                        RBRACKET
                 | LBRACKET        TypeQualifierSeq                                RBRACKET
                 | LBRACKET                                   AssignmentExpression RBRACKET
                 | LBRACKET        TypeQualifierSeq           AssignmentExpression RBRACKET
                 | LBRACKET STATIC                            AssignmentExpression RBRACKET
                 | LBRACKET STATIC TypeQualifierSeq           AssignmentExpression RBRACKET
                 | LBRACKET        TypeQualifierSeq    STATIC AssignmentExpression RBRACKET
                 | LBRACKET                                                   STAR RBRACKET
                 | LPAREN                   RPAREN
                 | LPAREN ParameterTypeList RPAREN
                 ;
/*                       
TypedefName      : IDENTIFIER
                 ;
*/
Initializer      : AssignmentExpression
                 | LBRACE InitializerList       RBRACE
                 | LBRACE InitializerList COMMA RBRACE
                 ;
                       
InitializerList  :                       DesignationOpt Initializer
                 | InitializerList COMMA DesignationOpt Initializer
                 ;
                       
DesignationOpt   : // empty
                 | DesignatorSeq ASSIGN
                 ;
                       
DesignatorSeq    :               Designator
                 | DesignatorSeq Designator
                 ;
                       
Designator       : LBRACKET ConstantExpression RBRACKET
                 | DOT IDENTIFIER
                 ;
                       
// Statements ////////////////////////////////////////////////////////////////

Statement        : LabeledStatement
                 | CompoundStatement
                 | ExpressionStatement
                 | SelectionStatement
                 | IterationStatement
                 | JumpStatement
                 ;
                       
LabeledStatement : IDENTIFIER              COLON Statement
                 | CASE ConstantExpression COLON Statement
                 | DEFAULT                 COLON Statement
                 ;
                       
CompoundStatement: LBRACE              RBRACE
                 | LBRACE BlockItemSeq RBRACE
                 ;
                       
BlockItemSeq     :              BlockItem
                 | BlockItemSeq BlockItem
                 ;
                       
BlockItem        : Declaration
                 | Statement
                 ;

ExpressionStatement
                 : ExpressionOpt SEMICOLON
                 ;
                       
SelectionStatement
                 : IF ParenthExpression Statement
                 | IF ParenthExpression Statement ELSE Statement
                 | SWITCH ParenthExpression Statement
                 ;
                       
IterationStatement
                 : WHILE ParenthExpression Statement
                 | DO Statement WHILE ParenthExpression SEMICOLON
                 | FOR LPAREN             ExpressionOpt SEMICOLON ExpressionOpt SEMICOLON ExpressionOpt
                                                                                         RPAREN Statement
                 | FOR LPAREN Declaration ExpressionOpt SEMICOLON ExpressionOpt          RPAREN Statement
                 ;
                       
JumpStatement    : GOTO IDENTIFIER SEMICOLON
                 | CONTINUE SEMICOLON
                 | BREAK SEMICOLON
                 | RETURN ExpressionOpt SEMICOLON
                 ;
                       
// External definitions ///////////////////////////////////////////////////////////

TranslationUnit  :                 ExternalDeclaration
                 | TranslationUnit ExternalDeclaration
                 ;
                       
ExternalDeclaration
                 : FunctionDefinition
                 | Declaration
                 ;
                       
FunctionDefinition
                 : DeclarationSpecifierSeq Declarator                CompoundStatement
                 | DeclarationSpecifierSeq Declarator DeclarationSeq CompoundStatement
                 ;
                       
DeclarationSeq   :                Declaration
                 | DeclarationSeq Declaration
                 ;
                       
%%
