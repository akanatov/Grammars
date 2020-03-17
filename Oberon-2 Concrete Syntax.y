// ==========================================================================
//  (c) Copyright Eugene Zouev, 2010 
// ==========================================================================

%token IDENTIFIER 
%token NUMBER
%token CHARACTER
%token STRING

%token SEMICOLON
%token DOT
%token ASSIGN
%token COMMA
%token EQUAL
%token COLON
%token MULT
%token PLUS
%token MINUS
%token LPAREN
%token RPAREN 
%token VERT
%token DOTDOT
%token TILDE
%token NON_EQUAL
%token LESS
%token LESS_EQUAL
%token GREATER
%token GREATER_EQUAL
%token DIVIDE
%token AMPERSAND
%token LBRACKET
%token RBRACKET
%token CARET
%token LBRACE
%token RBRACE

%token MODULE 
%token BEGIN
%token END
%token IMPORT
%token CONST
%token TYPE
%token VAR
%token PROCEDURE
%token ARRAY
%token OF
%token RECORD
%token POINTER
%token TO
%token IF
%token THEN
%token CASE
%token WHILE
%token DO
%token REPEAT
%token UNTIL
%token FOR
%token LOOP
%token WITH
%token EXIT
%token RETURN
%token ELSIF
%token ELSE
%token BY
%token NIL
%token IN
%token IS
%token OR
%token DIV
%token MOD

%start Module

%%

Module         : MODULE IDENTIFIER SEMICOLON        ModuleBody END IDENTIFIER DOT
               | MODULE IDENTIFIER SEMICOLON Import ModuleBody END IDENTIFIER DOT
               ;
               
ModuleBody     : // empty
               |                                              BEGIN StatementSeq
               |                      ProcedureDeclarationSeq
               |                      ProcedureDeclarationSeq BEGIN StatementSeq
               | SimpleDeclarationSeq
               | SimpleDeclarationSeq                         BEGIN StatementSeq
               | SimpleDeclarationSeq ProcedureDeclarationSeq
               | SimpleDeclarationSeq ProcedureDeclarationSeq BEGIN StatementSeq
               ;

Import         : IMPORT ImportedList SEMICOLON
               ;

ImportedList   :                    ImportedItem
               | ImportedList COMMA ImportedItem
               ;

ImportedItem   : IDENTIFIER
               | IDENTIFIER ASSIGN IDENTIFIER
               ;

SimpleDeclarationSeq 
               :                      SimpleDeclaration
               | SimpleDeclarationSeq SimpleDeclaration
               ;

SimpleDeclaration    
               : CONST
               | CONST ConstantDeclarationSeq
               | TYPE
               | TYPE  TypeDeclarationSeq
               | VAR   
               | VAR   VariableDeclarationSeq
               ;

ConstantDeclarationSeq
               :                        ConstantDeclaration
               | ConstantDeclarationSeq ConstantDeclaration
               ;

ConstantDeclaration
               : DefiningIdentifier EQUAL Expression SEMICOLON
               ;

TypeDeclarationSeq
               :                    TypeDeclaration
               | TypeDeclarationSeq TypeDeclaration
               ;

TypeDeclaration: DefiningIdentifier EQUAL Type SEMICOLON
               ;

VariableDeclarationSeq
               :                        VariableDeclaration
               | VariableDeclarationSeq VariableDeclaration
               ;

VariableDeclaration
               : DefiningIdentifierList COLON Type SEMICOLON
               ;

DefiningIdentifierList 
               :                              DefiningIdentifier
               | DefiningIdentifierList COMMA DefiningIdentifier
               ;

DefiningIdentifier
               : IDENTIFIER
               | IDENTIFIER MULT
               | IDENTIFIER MINUS
               ;

ProcedureDeclarationSeq
               :                         ProcedureDeclaration
               | ProcedureDeclarationSeq ProcedureDeclaration
               ;

ProcedureDeclaration
               : NormalProcedureDeclaration
               | ForwardDeclaration
               ;

ProcedureHead  :          DefiningIdentifier
               | Receiver DefiningIdentifier
               |          DefiningIdentifier FormalParameters
               | Receiver DefiningIdentifier FormalParameters
               ;
               
ProcedureBody  : // empty
               |                                              BEGIN StatementSeq
               |                      ProcedureDeclarationSeq                   
               |                      ProcedureDeclarationSeq BEGIN StatementSeq
               | SimpleDeclarationSeq
               | SimpleDeclarationSeq                         BEGIN StatementSeq
               | SimpleDeclarationSeq ProcedureDeclarationSeq
               | SimpleDeclarationSeq ProcedureDeclarationSeq BEGIN StatementSeq
               ;
               
NormalProcedureDeclaration
               : PROCEDURE ProcedureHead SEMICOLON ProcedureBody END IDENTIFIER
               ;

ForwardDeclaration
               : PROCEDURE CARET ProcedureHead SEMICOLON
               ;

FormalParameters
               : LPAREN              RPAREN 
               | LPAREN FPSectionSeq RPAREN 
               | LPAREN              RPAREN COLON QualifiedIdentifier
               | LPAREN FPSectionSeq RPAREN COLON QualifiedIdentifier
               ;

FPSectionSeq   :                        FPSection
               | FPSectionSeq SEMICOLON FPSection
               ;

FPSection      :     IdentifierList COLON Type
               | VAR IdentifierList COLON Type
               ;

IdentifierList :                      IDENTIFIER
               | IdentifierList COMMA IDENTIFIER
               ;

Receiver       : LPAREN     IDENTIFIER COLON IDENTIFIER RPAREN
               | LPAREN VAR IDENTIFIER COLON IDENTIFIER RPAREN
               ;

Type           : QualifiedIdentifier

               | ARRAY                OF Type
               | ARRAY ExpressionList OF Type
               
               | RECORD                                   FieldListSeq END
               | RECORD LPAREN QualifiedIdentifier RPAREN FieldListSeq END
               
               | POINTER TO Type
               
               | PROCEDURE
               | PROCEDURE FormalParameters
               ;

ExpressionList :                      Expression
               | ExpressionList COMMA Expression
               ;

FieldListSeq   :                        FieldListOpt
               | FieldListSeq SEMICOLON FieldListOpt
               ;

FieldListOpt   :
               | FieldList
               ;

FieldList      : DefiningIdentifierList COLON Type
               ;

StatementSeq   :                        StatementOpt
               | StatementSeq SEMICOLON StatementOpt
               ;

StatementOpt   :
               | Statement
               ;

Statement      : Designator ASSIGN Expression
               | Designator
               
               | Designator LPAREN                RPAREN
               | Designator LPAREN ExpressionList RPAREN
               
               | IF Expression THEN StatementSeq                                  END
               | IF Expression THEN StatementSeq                ELSE StatementSeq END
               | IF Expression THEN StatementSeq ElsifClauseSeq                   END
               | IF Expression THEN StatementSeq ElsifClauseSeq ELSE StatementSeq END
               
               | CASE Expression OF CaseClauseList                   END
               | CASE Expression OF CaseClauseList ELSE StatementSeq END
               
               | WHILE Expression DO StatementSeq END
               | REPEAT StatementSeq UNTIL Expression
               
               | FOR IDENTIFIER ASSIGN Expression TO Expression               DO StatementSeq END
               | FOR IDENTIFIER ASSIGN Expression TO Expression BY Expression DO StatementSeq END
               
               | LOOP StatementSeq END
               | WITH GuardClauseSeq                   END
               | WITH GuardClauseSeq ELSE StatementSeq END
               
               | EXIT
               | RETURN
               | RETURN Expression
               ;

ElsifClauseSeq :                ElsifClause
               | ElsifClauseSeq ElsifClause
               ;

ElsifClause    : ELSIF Expression THEN StatementSeq 
               ;

CaseClauseList :                     CaseClauseOpt
               | CaseClauseList VERT CaseClauseOpt
               ;

CaseClauseOpt  :
               | CaseLabelList COLON StatementSeq
               ;

CaseLabelList  :                     CaseLabel
               | CaseLabelList COMMA CaseLabel
               ;

CaseLabel      : Expression
               | Expression DOTDOT Expression
               ;

GuardClauseSeq :                     GuardClause
               | GuardClauseSeq VERT GuardClause
               ;

GuardClause    : QualifiedIdentifier COLON QualifiedIdentifier
               ;

Expression     : SimpleExpression
               | SimpleExpression RelationalOperator SimpleExpression
               ;

SimpleExpression
               : SignOpt Term
               | SignOpt Term AdditiveTermSeq
               ;

SignOpt        : // empty
               | PLUS
               | MINUS
               ;

AdditiveTermSeq:                 AdditiveOperator Term
               | AdditiveTermSeq AdditiveOperator Term
               ;

Term           : Factor
               | Factor MultiplicativeFactorSeq
               ;

MultiplicativeFactorSeq
               :                         MultiplicativeOperator Factor
               | MultiplicativeFactorSeq MultiplicativeOperator Factor
               ;

Factor         : Designator
               | Designator LPAREN                RPAREN
               | Designator LPAREN ExpressionList RPAREN
               
               | NUMBER
               | CHARACTER
               | STRING
               | NIL
               
                 // Set
               | LBRACE             RBRACE
               | LBRACE ElementList RBRACE
               
               | LPAREN Expression RPAREN
               | TILDE Factor
               ;

ElementList    :                   Element
               | ElementList COMMA Element
               ;

Element        : Expression
               | Expression DOTDOT Expression
               ;

RelationalOperator
               : EQUAL
               | NON_EQUAL
               | LESS
               | LESS_EQUAL
               | GREATER
               | GREATER_EQUAL
               | IN
               | IS
               ;

AdditiveOperator
               : PLUS
               | MINUS
               | OR
               ;

MultiplicativeOperator
               : MULT
               | DIVIDE
               | DIV
               | MOD
               | AMPERSAND
               ;

Designator     : IDENTIFIER                    // QualifiedIdentifier
               | IDENTIFIER DesignatorTailSeq  // QualifiedIdentifier DesignatorTailSeq
               ;

DesignatorTailSeq
               :                   DesignatorTail
               | DesignatorTailSeq DesignatorTail
               ;

DesignatorTail : DOT IDENTIFIER
               | LBRACKET ExpressionList RBRACKET
               | CARET
            // | LPAREN QualifiedIdentifier RPAREN  -- Factor rule covers this case
               ;

QualifiedIdentifier
               :                IDENTIFIER
               | IDENTIFIER DOT IDENTIFIER
               ;

%%