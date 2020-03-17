
%token ABSTRACT
%token AS
%token ASSERT
%token ASYNC
%token ASYNC_STAR
%token AWAIT
%token BREAK
%token CASE
%token CATCH
%token CLASS
%token CONST
%token CONTINUE
%token DEFAULT
%token DEFERRED
%token DO
//%token DYNAMIC
%token ELSE
%token ENUM
%token EXPORT
%token EXTENDS
%token EXTERNAL
%token FACTORY
%token FALSE
%token FINAL
%token FINALLY
%token FOR
%token GET
%token HIDE
%token IF
%token IMPLEMENTS
%token IMPORT
%token IN
%token LIBRARY
%token NEW
%token NULL
%token OF
%token ON
%token OPERATOR
%token PART
%token RETHROW
%token RETURN
%token SET
%token SHOW
%token STATIC
%token SUPER
%token SWITCH
%token SYNC_STAR
%token THIS
%token THROW
%token TRUE
%token TRY
%token TYPEDEF
%token VAR
%token VOID
%token WHILE
%token WITH
%token YIELD
%token YIELD_STAR

%token AMP_AMP
%token AMPERSAND              // ‘&’
%token AMPERSAND_EQUAL        // ‘&=’
%token ARROW
%token AT
%token CARET                  // ‘ˆ’
%token CARET_EQUAL            // ‘ˆ=’
%token COLON
%token COMMA
%token DOT
%token DOT_DOT
%token EOF                    // ===============
%token EQUAL
%token EQUAL_EQUAL
%token EXCLAMATION            // ‘!’
%token EXCLAMATION_EQUAL
%token GREATER                // ‘>’ 
%token GREATER_EQUAL          // ‘>=’
%token GREATER_GREATER        // ‘>>’
%token GREATER_GREATER_EQUAL  // ‘>>=’
%token IS
%token LBRACE
%token LBRACKET
%token LESS                   // ‘<’
%token LESS_EQUAL             // ‘<=’
%token LESS_LESS              // ‘<<’
%token LESS_LESS_EQUAL        // ‘<<=’ 
%token LPAREN
%token MINUS                  // ‘-’
%token MINUS_EQUAL            // ‘-=’ 
%token MINUS_MINUS
%token PERCENT                // ‘%’
%token PERCENT_EQUAL          // ‘%=’
%token PLUS                   // ‘+’
%token PLUS_EQUAL             // ‘+=’
%token PLUS_PLUS
%token QUESTION
%token QUESTION_DOT
%token QUEST_QUEST
%token QUEST_QUES_EQUAL       // ‘??=’ 
%token RBRACE
%token RBRACKET
%token RPAREN
%token SCRIPT_TAG
%token SHARP
%token SEMICOLON
%token SLASH                  // ‘/’
%token SLASH_EQUAL            // ‘/=’
%token STAR                   // ‘*’
%token STAR_EQUAL             // ‘*=’
%token TILDE                  // ‘˜’
%token TILDE_PERCENT          // ‘˜/’
%token TILDE_SLASH_EQUAL      // ‘˜/=’
%token VERT_EQUAL             // ‘|=’ 
%token VERT_VERT
%token VERTICAL               // ‘|’

%token IDENTIFIER
%token NUMBER
%token HEX_NUMBER
%token MULTILINE_STRING
%token SINGLELINE_STRING

%start libraryDefinition // partDeclaration
//%define lr.type ielr

%%



// variableDeclaration
//  : declaredIdentifier (‘, ’ identifier)*
// ;

variableDeclaration
    : metadata x_specifier x_identifier_list
    ;
	
x_specifier
    : FINAL
    | FINAL type
    | CONST
    | CONST type
    | VAR
    |       type
    ;

x_identifier_list
    :                         IDENTIFIER
    | x_identifier_list COMMA IDENTIFIER
    ;

// declaredIdentifier
//    : metadata finalConstVarOrType identifier
//    ;
//	
// finalConstVarOrType
//    : final type?
//    | const type?
//    | varOrType
//    ;
//
//varOrType
//    : var
//    | type
//    ;
	
// initializedVariableDeclaration:
// declaredIdentifier (‘=’ expression)? (‘, ’ initializedIdentifier)*
// ;
// initializedIdentifier:
// identifier (‘=’ expression)?
// ;
// initializedIdentifierList:
// initializedIdentifier (‘, ’ initializedIdentifier)*
// ;

initializedVariableDeclaration
    : metadata x_specifier x_id_expr_list
    ;
	
x_id_expr_list
    :                      IDENTIFIER x_equal_expr_tail_opt
	| x_id_expr_list COMMA IDENTIFIER x_equal_expr_tail_opt
    ;
	
// functionSignature:
// metadata returnType? identifier formalParameterList
// ;
//
// functionSignature
//    : metadata x_returnType_opt IDENTIFIER formalParameterList
//    ;

// returnType:
// void |
// type
// ;

x_returnType_opt
    :  // empty
    | VOID
    | type
    ;

// functionBody:
// async? ‘=>’ expression ‘;’ |
// (async | async* | sync*)? block
// ;

functionBody
    :       ARROW expression SEMICOLON
    | ASYNC	ARROW expression SEMICOLON
	|            block
    | ASYNC      block
    | ASYNC_STAR block
    | SYNC_STAR  block
    ;

// block:
// ‘{’ statements ‘}’
// ;

block
    : LBRACE statements RBRACE
    ;

// formalParameterList:
// ‘(’ ‘)’ |
// ‘(’ normalFormalParameters ( ‘, ’ optionalFormalParameters)? ‘)’ |
// ‘(’ optionalFormalParameters ‘)’
// ;

formalParameterList
    : LPAREN                                                       RPAREN
    | LPAREN normalFormalParameters                                RPAREN
    | LPAREN normalFormalParameters COMMA optionalFormalParameters RPAREN
    | LPAREN                              optionalFormalParameters RPAREN
    ;

// normalFormalParameters:
// normalFormalParameter (‘, ’ normalFormalParameter)*
// ;

normalFormalParameters
    :                              normalFormalParameter
    | normalFormalParameters COMMA normalFormalParameter
    ;

// optionalFormalParameters:
// optionalPositionalFormalParameters |
// namedFormalParameters
// ;

optionalFormalParameters
    : LBRACKET x_defaultFormalParameter_list RBRACKET // optionalPositionalFormalParameters
    | LBRACE   x_defaultNamedParameter_list  RBRACE   // namedFormalParameters
    ;

// optionalPositionalFormalParameters:
// ‘[’ defaultFormalParameter (‘, ’ defaultFormalParameter)* ‘]’
// ;

x_defaultFormalParameter_list
    :                                     defaultFormalParameter
	| x_defaultFormalParameter_list COMMA defaultFormalParameter
    ;

// namedFormalParameters:
// ‘{’ defaultNamedParameter (‘, ’ defaultNamedParameter)* ‘}’
// ;

x_defaultNamedParameter_list
    :                                    defaultNamedParameter
    | x_defaultNamedParameter_list COMMA defaultNamedParameter
    ;

// normalFormalParameter:
// functionSignature |
// fieldFormalParameter |
// simpleFormalParameter
// ;

normalFormalParameter
      // functionSignature
    : metadata x_returnType_opt IDENTIFIER formalParameterList
	
      // fieldFormalParameter
    | metadata             THIS DOT IDENTIFIER x_formalParameterList_opt
    | metadata x_specifier THIS DOT IDENTIFIER x_formalParameterList_opt
	  
      // simpleFormalParameter
    | metadata x_specifier IDENTIFIER
	| metadata             IDENTIFIER
    ;

// simpleFormalParameter:
// declaredIdentifier |
// metadata identifier
// ;
//
// simpleFormalParameter
//    : metadata x_specifier IDENTIFIER
//    | metadata             IDENTIFIER
//    ;

// fieldFormalParameter:
// metadata finalConstVarOrType? this ‘.’ identifier formalParameterList?
// ;
//
// fieldFormalParameter
//    : metadata             THIS DOT IDENTIFIER x_formalParameterList_opt
//    | metadata x_specifier THIS DOT IDENTIFIER x_formalParameterList_opt
//    ;

x_formalParameterList_opt
    :  // empty
    | formalParameterList
    ;

// defaultFormalParameter:
// normalFormalParameter (’=’ expression)?
// ;

defaultFormalParameter
    : normalFormalParameter x_equal_expr_tail_opt
    ;

x_equal_expr_tail_opt
    :  // empty
    | EQUAL expression
    ;
	
// defaultNamedParameter:
// normalFormalParameter ( ‘:’ expression)?
// ;

defaultNamedParameter
    : normalFormalParameter x_colon_expr_tail_opt
    ;

x_colon_expr_tail_opt
    :  // empty
    | COLON expression
    ;

// classDefinition:
// metadata abstract? class identifier typeParameters? (superclass mixins?)? interfaces?
// ‘{’ (metadata classMemberDefinition)* ‘}’ |
// metadata abstract? class mixinApplicationClass
// ;

classDefinition
    : metadata          CLASS IDENTIFIER x_typeParameters_opt x_superclass_opt x_interfaces_opt x_class_body
    | metadata ABSTRACT CLASS IDENTIFIER x_typeParameters_opt x_superclass_opt x_interfaces_opt x_class_body
    | metadata          CLASS IDENTIFIER x_typeParameters_opt EQUAL type WITH typeList /*mixins*/ x_interfaces_opt SEMICOLON /*mixinApplicationClass*/
    | metadata ABSTRACT CLASS IDENTIFIER x_typeParameters_opt EQUAL type WITH typeList /*mixins*/ x_interfaces_opt SEMICOLON /*mixinApplicationClass*/
    ;

x_superclass_opt
    :  // empty
    | EXTENDS type /*superclass*/
    | EXTENDS type /*superclass*/ WITH typeList
    ;

x_class_body
    : LBRACE                             RBRACE
    | LBRACE x_classMemberDefinition_seq RBRACE
    ;

x_classMemberDefinition_seq
    :                             metadata classMemberDefinition
    | x_classMemberDefinition_seq metadata classMemberDefinition
    ;

// mixins:
// with typeList
// ;

// classMemberDefinition:
// declaration ‘;’ |
// methodSignature functionBody
// ;

classMemberDefinition
    : declaration SEMICOLON
    | methodSignature functionBody
    ;

// methodSignature:
// constructorSignature initializers? |
// factoryConstructorSignature |
// static? functionSignature |
// static? getterSignature |
// static? setterSignature |
// operatorSignature
// ;

methodSignature
    :               IDENTIFIER x_identifier_tail_opt     formalParameterList /*constructorSignature*/ x_initializers_opt
    |       FACTORY IDENTIFIER x_identifier_tail_opt     formalParameterList                                  // factoryConstructorSignature
    |       FACTORY IDENTIFIER x_identifier_tail_opt     formalParameterList EQUAL type x_identifier_tail_opt // redirectingFactoryConstructorSignature
    | CONST FACTORY IDENTIFIER x_identifier_tail_opt     formalParameterList EQUAL type x_identifier_tail_opt // redirectingFactoryConstructorSignature
    |        metadata x_returnType_opt     IDENTIFIER    formalParameterList /*functionSignature*/
    | STATIC metadata x_returnType_opt     IDENTIFIER    formalParameterList /*functionSignature*/
    |                 x_returnType_opt GET IDENTIFIER                        /*getterSignature*/
    | STATIC          x_returnType_opt GET IDENTIFIER                        /*getterSignature*/
    |                 x_returnType_opt SET IDENTIFIER    formalParameterList /*setterSignature*/
    | STATIC          x_returnType_opt SET IDENTIFIER    formalParameterList /*setterSignature*/
    |                 x_returnType_opt OPERATOR operator formalParameterList /*operatorSignature*/
    ;
 
x_initializers_opt
    :  // empty
    | COLON x_superCallOrFieldInitializer_list // initializers
    ;

// declaration:
// constantConstructorSignature (redirection | initializers)? |
// constructorSignature (redirection | initializers)? |
// external constantConstructorSignature |
// external constructorSignature |
// ((external static ?))? getterSignature |
// ((external static?))? setterSignature |
// external? operatorSignature |
// ((external static?))? functionSignature |
// static (final | const) type? staticFinalDeclarationList |
// final type? initializedIdentifierList |
// static? (var | type) initializedIdentifierList
// ;

declaration
    :          CONST qualified                  formalParameterList /*constantConstructorSignature*/ x_constructor_tail_opt
    | EXTERNAL CONST qualified                  formalParameterList /*constantConstructorSignature*/
    |          IDENTIFIER x_identifier_tail_opt formalParameterList /*constructorSignature*/         x_constructor_tail_opt
    | EXTERNAL IDENTIFIER x_identifier_tail_opt formalParameterList /*constructorSignature*/
	
    |                 x_returnType_opt GET IDENTIFIER                     /*getterSignature*/
    | EXTERNAL        x_returnType_opt GET IDENTIFIER                     /*getterSignature*/
    | EXTERNAL STATIC x_returnType_opt GET IDENTIFIER                     /*getterSignature*/	

    |                 x_returnType_opt SET IDENTIFIER formalParameterList /*setterSignature*/
    | EXTERNAL        x_returnType_opt SET IDENTIFIER formalParameterList /*setterSignature*/
    | EXTERNAL STATIC x_returnType_opt SET IDENTIFIER formalParameterList /*setterSignature*/
	
    |          x_returnType_opt OPERATOR operator formalParameterList /*operatorSignature*/
    | EXTERNAL x_returnType_opt OPERATOR operator formalParameterList /*operatorSignature*/
	
    |                 metadata x_returnType_opt IDENTIFIER formalParameterList /*functionSignature*/
    | EXTERNAL        metadata x_returnType_opt IDENTIFIER formalParameterList /*functionSignature*/
    | EXTERNAL STATIC metadata x_returnType_opt IDENTIFIER formalParameterList /*functionSignature*/
	
    | x_static_final_const      staticFinalDeclarationList
    | x_static_final_const type staticFinalDeclarationList
	
    | FINAL      x_id_expr_list /* initializedIdentifierList */
    | FINAL type x_id_expr_list /* initializedIdentifierList */	
	
    | x_static_var_type x_id_expr_list /* initializedIdentifierList */
    ;

// STATIC (FINAL | CONST)

x_static_final_const
    : STATIC FINAL
    | STATIC CONST
    ;

// STATIC? (VAR | type)

x_static_var_type
    : STATIC VAR
    | STATIC type
    |        VAR
    |        type
    ;

x_constructor_tail_opt
    :  // empty
    | COLON THIS x_identifier_tail_opt arguments // redirection
    | COLON x_superCallOrFieldInitializer_list   // initializers
    ;

// staticFinalDeclarationList:
// staticFinalDeclaration (‘, ’ staticFinalDeclaration)*
// ;

staticFinalDeclarationList
    :                                  IDENTIFIER EQUAL expression /*staticFinalDeclaration*/
    | staticFinalDeclarationList COMMA IDENTIFIER EQUAL expression /*staticFinalDeclaration*/
    ;

// staticFinalDeclaration:
// identifier ‘=’ expression
// ;
//
// staticFinalDeclaration
//    : IDENTIFIER EQUAL expression
//    ;

// operatorSignature:
// returnType? operator operator formalParameterList
// ;
//
// operatorSignature
//    : x_returnType_opt OPERATOR operator formalParameterList
//    ;

// operator:
// ‘˜’ |
// binaryOperator |
// ‘[’ ‘]’ |
// ‘[’ ‘]’ ‘=’
// ;

operator
    : TILDE
	
      // binaryOperator
    | multiplicativeOperator
    | additiveOperator
    | shiftOperator
    | relationalOperator
    | EQUAL_EQUAL
    | bitwiseOperator
	  
    | LBRACKET RBRACKET
    | LBRACKET RBRACKET EQUAL
    ;

// binaryOperator:
// multiplicativeOperator |
// additiveOperator |
// shiftOperator |
// relationalOperator |
// ‘==’ |
// bitwiseOperator
// ;
//
// binaryOperator
//    : multiplicativeOperator
//    | additiveOperator
//    | shiftOperator
//    | relationalOperator
//    | EQUAL_EQUAL
//    | bitwiseOperator
//    ;

// An operator declaration is identified using the built-in identifier (16.33) operator.
// The following names are allowed for user-defined operators:
// <, >, <=, >=, ==, -, +, /, ˜/, *, %, |, ˆ, &, <<, >>, []=, [], ˜.

// getterSignature:
// returnType? get identifier
// ;
//
// getterSignature
//    : x_returnType_opt GET IDENTIFIER
//    ;

// setterSignature:
// returnType? set identifier formalParameterList
// ;
//
// setterSignature
//    : x_returnType_opt SET IDENTIFIER formalParameterList
//    ;

// constructorSignature:
// identifier (‘.’ identifier)? formalParameterList
// ;
//
// constructorSignature
//    : IDENTIFIER x_identifier_tail_opt formalParameterList
//    ;

// redirection:
// ‘:’ this (‘.’ identifier)? arguments
// ;
//
// redirection
//    : COLON THIS x_identifier_tail_opt arguments
//    ;

// initializers:
// ‘:’ superCallOrFieldInitializer (‘, ’ superCallOrFieldInitializer)*
// ;
//
// initializers
//    : COLON x_superCallOrFieldInitializer_list
//    ;

x_superCallOrFieldInitializer_list
    :                                          superCallOrFieldInitializer
    | x_superCallOrFieldInitializer_list COMMA superCallOrFieldInitializer
    ;

// superCallOrFieldInitializer:
// super arguments |
// super ‘.’ identifier arguments |
// fieldInitializer
// ;

superCallOrFieldInitializer
    : SUPER x_identifier_tail_opt arguments
	
      // fieldInitializer
    |          IDENTIFIER EQUAL conditionalExpression x_cascadeSection_seq_opt
    | THIS DOT IDENTIFIER EQUAL conditionalExpression x_cascadeSection_seq_opt
    ;

// fieldInitializer:
// (this ‘.’)? identifier ‘=’ conditionalExpression cascadeSection*
// ;
//
// fieldInitializer
//    :          IDENTIFIER EQUAL conditionalExpression x_cascadeSection_seq_opt
//    | THIS DOT IDENTIFIER EQUAL conditionalExpression x_cascadeSection_seq_opt
//    ;

// factoryConstructorSignature:
// factory identifier (‘.’ identifier)? formalParameterList
// ;
//
// factoryConstructorSignature
//    : FACTORY IDENTIFIER x_identifier_tail_opt formalParameterList
//    ;

// Seems to be not used!
//
// redirectingFactoryConstructorSignature:
// const? factory identifier (‘.’ identifier)? formalParameterList
// ‘=’ type (‘.’ identifier)?
// ;
//
// redirectingFactoryConstructorSignature
//    : x_const_opt FACTORY IDENTIFIER x_identifier_tail_opt formalParameterList EQUAL type x_identifier_tail_opt
//    ;

// x_identifier_tail
//    : DOT IDENTIFIER
//    ;

x_identifier_tail_opt
    :  // empty
    | DOT IDENTIFIER // x_identifier_tail
    ;

x_identifier_tail_seq_opt
    :  // empty
    | x_identifier_tail_seq
    ;

x_identifier_tail_seq
    :                       DOT IDENTIFIER /*x_identifier_tail*/
    | x_identifier_tail_seq DOT IDENTIFIER /*x_identifier_tail*/
    ;

// constantConstructorSignature:
// const qualified formalParameterList
// ;
//
// constantConstructorSignature
//    : CONST qualified formalParameterList
//    ;

// superclass:
// extends type
// ;
//
// superclass
//    : EXTENDS type
//    ;
	
x_extends_opt
    :  // empty
    | EXTENDS type // superclass
    ;

// interfaces:
// implements typeList
// ;

x_interfaces_opt
    :  // empty
    | IMPLEMENTS typeList
    ;

// mixinApplicationClass:
// identifier typeParameters? ‘=’ mixinApplication ‘;’
// ;
//
// mixinApplication:
// type mixins interfaces?
// ;
//
// mixinApplicationClass
//    : IDENTIFIER x_typeParameters_opt EQUAL type mixins x_interfaces_opt SEMICOLON
//    ;

// enumType:
// metadata enum id ‘{’ id [‘, ’ id]* [‘, ’] ‘}’
// ;
//
// enumType
//    : metadata ENUM IDENTIFIER LBRACE x_identifier_list x_comma_opt RBRACE
//    ;

// typeParameter:
// metadata identifier (extends type)?
// ;
//
// typeParameter
//    : metadata IDENTIFIER x_extends_opt
//    ;

// typeParameters:
// ‘<’ typeParameter (‘,’ typeParameter)* ‘>’
// ;

x_typeParameters_opt
    :  // empty
    | LESS x_typeParameter_list GREATER // typeParameters
    ;

// typeParameters
//    : LESS x_typeParameter_list GREATER
//    ;

x_typeParameter_list
    :                            metadata IDENTIFIER x_extends_opt /*typeParameter*/
    | x_typeParameter_list COMMA metadata IDENTIFIER x_extends_opt /*typeParameter*/
    ;

// metadata:
// (‘@’ qualified (‘.’ identifier)? (arguments)?)*
// ;

metadata
    :  // empty
    | x_metadata_seq
    ;

x_metadata_seq
    :                x_metadata
    | x_metadata_seq x_metadata
    ;

x_metadata
    : AT qualified x_identifier_tail_opt x_arguments_opt
    ;

// expression:
// assignableExpression assignmentOperator expression |
// conditionalExpression cascadeSection* |
// throwExpression
// ;

expression
    : assignableExpression assignmentOperator expression
    | conditionalExpression x_cascadeSection_seq_opt
    | THROW expression  // throwExpression
    ;

// expressionWithoutCascade:
// assignableExpression assignmentOperator expressionWithoutCascade |
// conditionalExpression |
// throwExpressionWithoutCascade
// ;

expressionWithoutCascade
    : assignableExpression assignmentOperator expressionWithoutCascade
    | conditionalExpression
    | THROW expressionWithoutCascade // throwExpressionWithoutCascade
    ;

// expressionList:
// expression (‘, ’ expression)*
// ;

expressionList
    :                      expression
    | expressionList COMMA expression
    ;

x_expressionList_opt
    :  // empty
    | expressionList
    ;

// primary:
// thisExpression |
// super unconditionalAssignableSelector |
// functionExpression |
// literal |
// identifier |
// newExpression |
// new type ‘#’ (‘.’ identifier)? |
// constObjectExpression |
// ‘(’ expression ‘)’
// ;

primary
    : THIS // thisExpression
    | SUPER unconditionalAssignableSelector
    | formalParameterList functionBody // functionExpression
    | literal
    | IDENTIFIER
    | NEW type x_identifier_tail_opt arguments // newExpression
    | NEW type SHARP x_identifier_tail_opt
    | CONST type x_identifier_tail_opt arguments // constObjectExpression
    | LPAREN expression RPAREN
    ;

// literal:
// nullLiteral |
// booleanLiteral |
// numericLiteral |
// stringLiteral |
// symbolLiteral |nullLiteral:
// null
// ;

literal
    : NULL               // nullLiteral 
    | TRUE               // booleanLiteral
    | FALSE              // booleanLiteral
    | NUMBER             // numericLiteral
    | HEX_NUMBER         // numericLiteral
    | stringLiteral
    | SHARP operator                              // symbolLiteral
    | SHARP IDENTIFIER x_identifier_tail_seq_opt  // symbolLiteral
    | mapLiteral
    | listLiteral
    ;

// nullLiteral:
// null
// ;
//
// nullLiteral
//    : NULL
//    ;

// numericLiteral:
// NUMBER |
// HEX_NUMBER
// ;
//
// numericLiteral
//    : NUMBER
//    | HEX_NUMBER
//    ;

// booleanLiteral:
// true |
// false
// ;
//
// booleanLiteral
//    : TRUE
//    | FALSE
//    ;

// stringLiteral:
// (multilineString | singleLineString)+
// ;

stringLiteral
    : MULTILINE_STRING
    | SINGLELINE_STRING
    ;

// symbolLiteral:
// ‘#’ (operator | (identifier (‘.’ identifier)*))
// ;
//
// symbolLiteral
//    : SHARP operator
//    | SHARP identifier x_identifier_tail_seq_opt
//    ;

// listLiteral:
// const? typeArguments? ‘[’ (expressionList ‘, ’?)? ‘]’
// ;

listLiteral
    :       x_typeArguments_opt LBRACKET x_expressionList_opt x_comma_opt RBRACKET
    | CONST x_typeArguments_opt LBRACKET x_expressionList_opt x_comma_opt RBRACKET
    ;

// mapLiteral:
// const? typeArguments? ‘{’ (mapLiteralEntry (‘, ’ mapLiteralEntry)* ‘, ’?)? ‘}’
// ;

mapLiteral
    :       x_typeArguments_opt LBRACE                        x_comma_opt RBRACE
    | CONST x_typeArguments_opt LBRACE                        x_comma_opt RBRACE
    |       x_typeArguments_opt LBRACE x_mapLiteralEntry_list x_comma_opt RBRACE
    | CONST x_typeArguments_opt LBRACE x_mapLiteralEntry_list x_comma_opt RBRACE
    ;

x_mapLiteralEntry_list
    :                              mapLiteralEntry
    | x_mapLiteralEntry_list COMMA mapLiteralEntry
    ;

x_comma_opt
    :  // empty
    | COMMA
    ;

// mapLiteralEntry:
// expression ‘:’ expression
// ;

mapLiteralEntry
    : expression COLON expression
    ;

// throwExpression:
// throw expression
// ;
//
// throwExpression
//    : THROW expression
//    ;

// throwExpressionWithoutCascade:
// throw expressionWithoutCascade
// ;
//
// throwExpressionWithoutCascade
//    : THROW expressionWithoutCascade
//    ;

// functionExpression:
// formalParameterList functionBody
// ;
//
// functionExpression
//    : formalParameterList functionBody
//    ;

// thisExpression:
// this
// ;
//
// thisExpression
//    : THIS
//    ;

// newExpression:
// new type (‘.’ identifier)? arguments
// ;
//
// newExpression
//    : NEW type x_identifier_tail_opt arguments
//    ;

// constObjectExpression:
// const type (’.’ identifier)? arguments
// ;
//
// constObjectExpression
//    : CONST type x_identifier_tail_opt arguments
//    ;

// arguments:
// ‘(’ argumentList? ‘)’
// ;

arguments
    : LPAREN              RPAREN
    | LPAREN argumentList RPAREN
    ;
	
x_arguments_opt
    :  // empty
    | arguments
    ;

x_arguments_seq_opt
    :  // empty
    | x_arguments_seq
    ;
	
x_arguments_seq
    :                 arguments
    | x_arguments_seq arguments
    ;

// argumentList:
// namedArgument (‘, ’ namedArgument)* |
// expressionList (‘, ’ namedArgument)*
// ;

argumentList
    :                x_namedArgument_list
    | expressionList x_namedArgument_tail_opt
    ;

x_namedArgument_tail_opt
    :  // empty
    | COMMA x_namedArgument_list
    ;

x_namedArgument_list
    :                            namedArgument
    | x_namedArgument_list COMMA namedArgument
    ;

// namedArgument:
// label expression
// ;

namedArgument
    : label expression
    ;

x_cascadeSection_seq_opt
    :  // empty
    | x_cascadeSection_seq
    ;

x_cascadeSection_seq
    :                      cascadeSection
    | x_cascadeSection_seq cascadeSection
    ;

// cascadeSection:
// ‘..’ (cascadeSelector arguments*) (assignableSelector arguments*)*
// (assignmentOperator expressionWithoutCascade)?
// ;

cascadeSection
    : DOT_DOT cascadeSelector x_arguments_seq_opt x_cascade_part_seq_opt x_cascade_part_2_opt
    ;

// cascadeSelector:
// ‘[’ expression ‘]’ |
// identifier
// ;

cascadeSelector
    : LBRACKET expression RBRACKET
    | IDENTIFIER
    ;

x_cascade_part_seq_opt
    :  // empty
    | x_cascade_part_seq
    ;

x_cascade_part_seq
    :                    assignableSelector x_arguments_seq_opt
    | x_cascade_part_seq assignableSelector x_arguments_seq_opt
    ;

x_cascade_part_2_opt
    : // empty
    | assignmentOperator expressionWithoutCascade
    ;

// assignmentOperator:
// ‘=’ |
// compoundAssignmentOperator
// ;

assignmentOperator
    : EQUAL         // ‘=’
    | compoundAssignmentOperator
    ;

// compoundAssignmentOperator:
// ‘*=’ |
// ‘/=’ |
// ‘˜/=’ |
// ‘%=’ |
// ‘+=’ |
// ‘-=’ |
// ‘<<=’ |
// ‘>>=’ |
// ‘&=’ |
// ‘ˆ=’ |
// ‘|=’ |
// ‘??=’ |
// ;

compoundAssignmentOperator
    : STAR_EQUAL             // ‘*=’
    | SLASH_EQUAL            // ‘/=’
    | TILDE_SLASH_EQUAL      // ‘˜/=’
    | PERCENT_EQUAL          // ‘%=’
    | PLUS_EQUAL             // ‘+=’ 
    | MINUS_EQUAL            // ‘-=’ 
    | LESS_LESS_EQUAL        // ‘<<=’ 
    | GREATER_GREATER_EQUAL  // ‘>>=’ 
    | AMPERSAND_EQUAL        // ‘&=’
    | CARET_EQUAL            // ‘ˆ=’
    | VERT_EQUAL             // ‘|=’ 
    | QUEST_QUES_EQUAL       // ‘??=’ 
    ;

// conditionalExpression:
// ifNullExpression (‘?’ expressionWithoutCascade ‘:’ expression-
// WithoutCascade)?
// ;

conditionalExpression
    : ifNullExpression x_ConditionalTail_opt
    ;

x_ConditionalTail_opt
    :  // empty
    | QUESTION expressionWithoutCascade COLON expressionWithoutCascade
    ;

// ifNullExpression:
// logicalOrExpression (‘??’ logicalOrExpression)*

ifNullExpression
    :                              logicalOrExpression
    | ifNullExpression QUEST_QUEST logicalOrExpression
    ;

// logicalOrExpression:
// logicalAndExpression (‘||’ logicalAndExpression)*
// ;

logicalOrExpression
    :                               logicalAndExpression
    | logicalOrExpression VERT_VERT logicalAndExpression
    ;

// logicalAndExpression:
// equalityExpression (‘&&’ equalityExpression)*
// ;

logicalAndExpression
    :                              equalityExpression 
    | logicalAndExpression AMP_AMP equalityExpression
    ;

// equalityExpression:
// relationalExpression (equalityOperator relationalExpression)? |
// super equalityOperator relationalExpression
// ;

equalityExpression
    : relationalExpression x_equalityExpression_opt
    | SUPER equalityOperator relationalExpression
    ;

x_equalityExpression_opt
    :  // empty
    | equalityOperator relationalExpression
    ;

// equalityOperator:
// ‘==’ |
// ‘!=’
// ;

equalityOperator
    : EQUAL_EQUAL        // ‘==’
    | EXCLAMATION_EQUAL  // ‘!=’
    ;

// relationalExpression:
// bitwiseOrExpression (typeTest | typeCast | relationalOperator bitwiseOrExpression)? |
// super relationalOperator bitwiseOrExpression
// ;

relationalExpression
    : bitwiseOrExpression x_relationalExpression_opt
    | SUPER relationalOperator bitwiseOrExpression
    ;

x_relationalExpression_opt
    :  // empty
	
    | IS             type  // typeTest
    | IS EXCLAMATION type  // typeTest
	
    | AS type              // typeCast
	
    | relationalOperator bitwiseOrExpression
    ;

// relationalOperator:
// ‘>=’ |
// ‘>’ |
// ‘<=’ |
// ‘<’
// ;

relationalOperator
    : GREATER_EQUAL  // ‘>=’
    | GREATER        // ‘>’ 
    | LESS_EQUAL     // ‘<=’
    | LESS           // ‘<’
    ;

// bitwiseOrExpression:
// bitwiseXorExpression (‘|’ bitwiseXorExpression)* |
// super (‘|’ bitwiseXorExpression)+
// ;

bitwiseOrExpression
    :                x_bitwiseOrExpression_list
    | SUPER VERTICAL x_bitwiseOrExpression_list
    ;

x_bitwiseOrExpression_list
    :                                     bitwiseXorExpression
    | x_bitwiseOrExpression_list VERTICAL bitwiseXorExpression
    ;

// bitwiseXorExpression:
// bitwiseAndExpression (‘ˆ’ bitwiseAndExpression)* |
// super (‘ˆ’ bitwiseAndExpression)+
// ;

bitwiseXorExpression
    :             x_bitwiseXorExpression_list
    | SUPER CARET x_bitwiseXorExpression_list
    ;

x_bitwiseXorExpression_list
    :                                   bitwiseAndExpression
    | x_bitwiseXorExpression_list CARET bitwiseAndExpression
    ;

// bitwiseAndExpression:
// shiftExpression (‘&’ shiftExpression)* |
// super (‘&’ shiftExpression)+
// ;

bitwiseAndExpression
    :                 x_bitwiseAndExpression_list
    | SUPER AMPERSAND x_bitwiseAndExpression_list
    ;

x_bitwiseAndExpression_list
    :                                       shiftExpression
    | x_bitwiseAndExpression_list AMPERSAND shiftExpression
    ;

// bitwiseOperator:
// ‘&’ |
// ‘ˆ’ |
// ‘|’
// ;

bitwiseOperator
    : AMPERSAND  // ‘&’
    | CARET      // ‘ˆ’
    | VERTICAL   // ‘|’
    ;

// shiftExpression:
// additiveExpression (shiftOperator additiveExpression)* |
// super (shiftOperator additiveExpression)+
// ;

shiftExpression
    :                     x_shiftExpression_list
    | SUPER shiftOperator x_shiftExpression_list
    ;

x_shiftExpression_list
    :                                      additiveExpression
    | x_shiftExpression_list shiftOperator additiveExpression
    ;

// shiftOperator:
// ‘<<’ |
// ‘>>’
// ;

shiftOperator
    : LESS_LESS         // ‘<<’
    | GREATER_GREATER   // ‘>>’
    ;

// additiveExpression:
// multiplicativeExpression (additiveOperator multiplicativeExpression)* |
// super (additiveOperator multiplicativeExpression)+
// ;

additiveExpression
    :                        x_additiveExpression_list
    | SUPER additiveOperator x_additiveExpression_list
    ;

x_additiveExpression_list
    :                                            multiplicativeExpression
    | x_additiveExpression_list additiveOperator multiplicativeExpression
    ;

// additiveOperator:
// ‘+’ |
// ‘-’
// ;

additiveOperator
    : PLUS   // ‘+’
    | MINUS  // ‘-’
    ;

// multiplicativeExpression:
// unaryExpression (multiplicativeOperator unaryExpression)* |
// super (multiplicativeOperator unaryExpression)+
// ;

multiplicativeExpression
    : x_multiplicativeExpression_list
    | SUPER multiplicativeOperator unaryExpression
    ;

x_multiplicativeExpression_list
    :                                                        unaryExpression
    | x_multiplicativeExpression_list multiplicativeOperator unaryExpression
	
// multiplicativeOperator:
// ‘*’ |
// ‘/’ |
// ‘%’ |
// ‘˜/’
// ;

multiplicativeOperator
    : STAR          // ‘*’
    | SLASH         // ‘/’
    | PERCENT       // ‘%’
    | TILDE_PERCENT // ‘˜/’
    ;

// unaryExpression:
// prefixOperator unaryExpression |
// awaitExpression |
// postfixExpression |
// (minusOperator | tildeOperator) super |
// incrementOperator assignableExpression
// ;

unaryExpression
    : prefixOperator unaryExpression
    | awaitExpression
    | postfixExpression
    | minusOperator SUPER
    | tildeOperator SUPER
    | incrementOperator assignableExpression
    ;

// prefixOperator:
// minusOperator |
// negationOperator |
// tildeOperator
// ;

prefixOperator
    : minusOperator
    | negationOperator
    | tildeOperator
    ;

// minusOperator:
// ‘-’ |
// ;
// negationOperator:
// ‘!’ |
// ;
// tildeOperator:
// ‘˜’
// ;

minusOperator
    : MINUS // ‘-’
    ;

negationOperator
    : EXCLAMATION  // ‘!’
    ;

tildeOperator
    : TILDE  // ‘˜’
    ;

// awaitExpression:
// await unaryExpression

awaitExpression
    : AWAIT unaryExpression
    ;

// postfixExpression:
// assignableExpression postfixOperator |
// primary (selector* | ( ‘#’ ( (identifier ‘=’?) | operator)))
// ;

postfixExpression
    : assignableExpression postfixOperator
    | primary x_selector_seq_opt
    | primary SHARP IDENTIFIER
    | primary SHARP IDENTIFIER EQUAL
    | primary SHARP operator
    ;

// postfixOperator:
// incrementOperator
// ;

postfixOperator
    : incrementOperator
    ;

x_selector_seq_opt
    :  // empty
    | x_selector_seq
    ;

x_selector_seq
    :                selector
    | x_selector_seq selector
    ;

// selector:
// assignableSelector |
// arguments
// ;

selector
    : assignableSelector
    | arguments
    ;

// incrementOperator:
// ‘++’ |
// ‘--’
// ;

incrementOperator
    : PLUS_PLUS
    | MINUS_MINUS
    ;

// assignableExpression:
// primary (arguments* assignableSelector)+ |
// super unconditionalAssignableSelector |
// identifier
// ;

assignableExpression
    : primary x_assignableExpression_tail_opt
//  | SUPER unconditionalAssignableSelector   -- now covered by primary
//  | IDENTIFIER                              -- now covered by primary
    ;

x_assignableExpression_tail_opt
    :  // empty
    | x_assignableExpression_tail
    ;
	
x_assignableExpression_tail
    :                             x_arguments_seq_opt assignableSelector
    | x_assignableExpression_tail x_arguments_seq_opt assignableSelector
    ;

// unconditionalAssignableSelector:
// ‘[’ expression ‘]’ |
// ‘.’ identifier
// ;

unconditionalAssignableSelector
    : LBRACKET expression RBRACKET
    | DOT IDENTIFIER
    ;

// assignableSelector:
// unconditionalAssignableSelector |
// ‘?.’ identifier
// ;

assignableSelector
    : unconditionalAssignableSelector
    | QUESTION_DOT IDENTIFIER
    ;

// qualified:
// identifier (‘.’ identifier)?
// ;

qualified
    : IDENTIFIER x_identifier_tail_opt
    ;

// typeTest:
// isOperator type
// ;
//
// typeTest
//    : isOperator type
//    ;

// isOperator:
// is ‘!’?
// ;
//
// isOperator
//    : IS
//    | IS EXCLAMATION
//    ;

// typeCast:
// asOperator type
// ;
//
// typeCast
//    : asOperator type
//    ;
//
// asOperator:
// as
// ;
//
// asOperator
//    : AS
//    ;

// statements:
// statement*
// ;

statements
    :  // empty
    | x_statement_seq
    ;

x_statement_seq
    :            statement
    | statements statement
    ;

// statement:
// label* nonLabelledStatement
// ;

// statement
//    : x_label_seq_opt nonLabelledStatement
//    ;

statement
    : nonLabelledStatement
    | label statement
    ;

// nonLabelledStatement:
// block |
// localVariableDeclaration |
// forStatement |
// whileStatement |
// doStatement |
// switchStatement |
// ifStatement |
// rethrowStatement |
// tryStatement |
// breakStatement |
// continueStatement |
// returnStatement |
// yieldStatement |
// yieldEachStatement |
// expressionStatement |
// assertStatement |
// localFunctionDeclaration
// ;

nonLabelledStatement
    : block
    | initializedVariableDeclaration SEMICOLON              // localVariableDeclaration
	
      // forStatement
    |       FOR LPAREN forLoopParts RPAREN statement
    | AWAIT FOR LPAREN forLoopParts RPAREN statement
	
    | WHILE LPAREN expression RPAREN statement              // whileStatement
    | DO statement WHILE LPAREN expression RPAREN SEMICOLON // doStatement
	
      // switchStatement
    | SWITCH LPAREN expression RPAREN LBRACE x_switchCase_seq_opt x_defaultCase_opt RBRACE	  
	
    | IF LPAREN expression RPAREN statement x_else_tail_opt // ifStatement
	
    | RETHROW SEMICOLON                                     // rethrowStatement
	
      // tryStatement
    | TRY block x_onPart_seq x_finallyPart_opt
    | TRY block              finallyPart
	
      // breakStatement
    | BREAK            SEMICOLON
    | BREAK IDENTIFIER SEMICOLON
	
      // continueStatement
    | CONTINUE            SEMICOLON
    | CONTINUE IDENTIFIER SEMICOLON
	  
     // returnStatement
    | RETURN            SEMICOLON
    | RETURN expression SEMICOLON
	 
    | YIELD expression SEMICOLON         // yieldStatement
    | YIELD_STAR expression SEMICOLON    // yieldEachStatement
	
      // expressionStatement
    |            SEMICOLON
    | expression SEMICOLON
	  
    | ASSERT LPAREN conditionalExpression RPAREN SEMICOLON  // assertStatement
	
      // localFunctionDeclaration
    | metadata x_returnType_opt IDENTIFIER formalParameterList /*functionSignature*/ functionBody	  
    ;

// expressionStatement:
// expression? ‘;’
// ;
//
// expressionStatement
//    :            SEMICOLON
//    | expression SEMICOLON
//    ;

// localVariableDeclaration:
// initializedVariableDeclaration ’;’
// ;
//
// localVariableDeclaration
//    : initializedVariableDeclaration SEMICOLON
//    ;

// localFunctionDeclaration:
// functionSignature functionBody
// ;
//
// localFunctionDeclaration
//    : metadata x_returnType_opt IDENTIFIER formalParameterList /*functionSignature*/ functionBody
//    ;

// ifStatement:
// if ‘(’ expression ‘)’ statement ( else statement)?
// ;
//
// ifStatement
//    : IF LPAREN expression RPAREN statement x_else_tail_opt
//    ;
	
x_else_tail_opt
    :  // empty
    | ELSE statement
    ;

// forStatement:
// await? for ‘(’ forLoopParts ‘)’ statement
// ;
//
// forStatement
//    :       FOR LPAREN forLoopParts RPAREN statement
//    | AWAIT FOR LPAREN forLoopParts RPAREN statement
//    ;

// forLoopParts:
// forInitializerStatement expression? ‘;’ expressionList? |
// declaredIdentifier in expression |
// identifier in expression
// ;

forLoopParts
    : forInitializerStatement x_forInitializer_tail
    | metadata x_specifier IDENTIFIER /*declaredIdentifier*/ IN expression
    |                      IDENTIFIER                        IN expression
    ;

x_forInitializer_tail
    :            SEMICOLON x_expressionList_opt
    | expression SEMICOLON x_expressionList_opt
    ;

// forInitializerStatement:
// localVariableDeclaration |
// expression? ‘;’
// ;

forInitializerStatement
    : initializedVariableDeclaration SEMICOLON // localVariableDeclaration
    |                                SEMICOLON
    | expression                     SEMICOLON
    ;

// whileStatement:
// while ‘(’ expression ‘)’ statement
// ;
//
// whileStatement
//    : WHILE LPAREN expression RPAREN statement
//    ;

// doStatement:
// do statement while ‘(’ expression ‘)’ ‘;’
// ;
//
// doStatement
//    : DO statement WHILE LPAREN expression RPAREN SEMICOLON
//    ;

// switchStatement:
// switch ‘(’ expression ‘)’ ‘{’ switchCase* defaultCase? ‘}’
// ;
//
// switchStatement
//    : SWITCH LPAREN expression RPAREN LBRACE x_witchCase_seq_opt x_defaultCase_opt RBRACE
//    ;

x_switchCase_seq_opt
    :  // empty
    | x_switchCase_seq
    ;

x_switchCase_seq
    :                  switchCase
    | x_switchCase_seq switchCase
    ;

// switchCase:
// label* case expression ‘:’ statements
// ;

// switchCase
//    : x_label_seq_opt CASE expression COLON statements
//    ;

switchCase
    : CASE expression COLON statements
    | label switchCase
    ;

///////////// L: case x: f(); L1: case/statement!!!! 

x_defaultCase_opt
    :  // empty
    | defaultCase
    ;

// defaultCase:
// label* default ‘:’ statements
// ;

// defaultCase
//    : x_label_seq_opt DEFAULT COLON statements
//    ;

defaultCase
    : DEFAULT COLON statements
    | label defaultCase
    ;
	
// rethrowStatement:
// rethrow ‘;’
// ;
//
// rethrowStatement
//    : RETHROW SEMICOLON
//    ;

// tryStatement:
// try block (onPart+ finallyPart? | finallyPart)
// ;
//
// tryStatement
//    : TRY block x_onPart_seq x_finallyPart_opt
//    | TRY block              finallyPart
//    ;

x_onPart_seq
    :              onPart
    | x_onPart_seq onPart
    ;

// onPart:
// catchPart block |
// on type catchPart? block
// ;

onPart
    :         catchPart block
    | ON type           block
    | ON type catchPart block
    ;

// catchPart:
// catch ‘(’ identifier (‘, ’ identifier)? ‘)’
// ;

catchPart
    : CATCH LPAREN IDENTIFIER                  RPAREN
    | CATCH LPAREN IDENTIFIER COMMA IDENTIFIER RPAREN
    ;

// finallyPart:
// finally block
// ;

finallyPart
    : FINALLY block
    ;
	
x_finallyPart_opt
    :  // empty
    | finallyPart
    ;

// returnStatement:
// return expression? ‘;’
// ;
//
// returnStatement
//    : RETURN            SEMICOLON
//    | RETURN expression SEMICOLON
//    ;

// label:
// identifier ‘:’
// ;

label
    : IDENTIFIER COLON
    ;
	
// breakStatement:
// break identifier? ‘;’
// ;
//
// breakStatement
//    : BREAK            SEMICOLON
//    | BREAK IDENTIFIER SEMICOLON
//    ;

// continueStatement:
// continue identifier? ‘;’
// ;
//
// continueStatement
//    : CONTINUE            SEMICOLON
//    | CONTINUE IDENTIFIER SEMICOLON
//    ;

// yieldStatement:
// yield expression ‘;’
// ;
//
// yieldStatement
//    : YIELD expression SEMICOLON
//    ;

// yieldEachStatement:
// yield* expression ‘;’
// ;
//
// yieldEachStatement
//    : YIELD_STAR expression SEMICOLON
//    ;

// assertStatement:
// assert ‘(’ conditionalExpression ‘)’ ‘;’
// ;
//
// assertStatement
//    : ASSERT LPAREN conditionalExpression RPAREN SEMICOLON
//    ;

// topLevelDefinition:
// classDefinition |
// enumType |
// typeAlias |
// external? functionSignature ‘;’ |
// external? getterSignature ‘;’ |
// external? setterSignature ‘;’ |
// functionSignature functionBody |
// returnType? get identifier functionBody |
// returnType? set identifier formalParameterList functionBody |
// (final | const) type? staticFinalDeclarationList ‘;’ |
// variableDeclaration ‘;’
// ;

topLevelDefinition
    : classDefinition
    | metadata ENUM IDENTIFIER LBRACE x_identifier_list x_comma_opt RBRACE // enumType
	
    | metadata TYPEDEF functionTypeAlias /*typeAliasBody*/ // typeAlias
	
    |          metadata x_returnType_opt IDENTIFIER formalParameterList /*functionSignature*/ SEMICOLON
    | EXTERNAL metadata x_returnType_opt IDENTIFIER formalParameterList /*functionSignature*/ SEMICOLON
	
    |                   x_returnType_opt GET IDENTIFIER /*getterSignature*/                   SEMICOLON
    | EXTERNAL          x_returnType_opt GET IDENTIFIER /*getterSignature*/                   SEMICOLON
	
    |                   x_returnType_opt SET IDENTIFIER formalParameterList /*setterSignature*/ SEMICOLON
    | EXTERNAL          x_returnType_opt SET IDENTIFIER formalParameterList /*setterSignature*/ SEMICOLON
	
    | metadata x_returnType_opt IDENTIFIER formalParameterList /*functionSignature*/ functionBody
	
    | x_returnType_opt GET IDENTIFIER                     functionBody
    | x_returnType_opt SET IDENTIFIER formalParameterList functionBody
	
    | x_final_const      staticFinalDeclarationList SEMICOLON
    | x_final_const type staticFinalDeclarationList SEMICOLON
	
    | variableDeclaration SEMICOLON
    ;

x_final_const
    : FINAL
    | CONST
    ;

// getOrSet:
// get |
// set
// ;

// libraryDefinition:
// scriptTag? libraryName? importOrExport* partDirective* topLevelDefinition*
// ;

libraryDefinition
    : SCRIPT_TAG x_libraryName_opt x_importOrExport_seq_opt x_partDirective_seq_opt x_topLevelDefinition_seq_opt
    ;

x_libraryName_opt
    :  // empty
    | metadata LIBRARY IDENTIFIER x_identifier_tail_seq_opt SEMICOLON // libraryName
    ;

// scriptTag:
// ‘#!’ (˜NEWLINE)* NEWLINE
// ;

// libraryName:
// metadata library identifier (‘.’ identifier)* ‘;’
// ;
//
// libraryName
//    : metadata LIBRARY IDENTIFIER x_identifier_tail_seq_opt SEMICOLON
//    ;

x_importOrExport_seq_opt
    :  // empty
    | x_importOrExport_seq
    ;

x_importOrExport_seq
    :                      importOrExport
    | x_importOrExport_seq importOrExport
    ;

// importOrExport:
// libraryImport |
// libraryExport

importOrExport
    : metadata importSpecification                       // libraryImport
    | metadata EXPORT uri x_combinator_seq_opt SEMICOLON // libraryExport
    ;

// libraryImport:
// metadata importSpecification
// ;
//
// libraryImport
//    : metadata importSpecification
//    ;

// importSpecification:
// import uri (as identifier)? combinator* ‘;’ |
// import uri deferred as identifier combinator* ‘;’
// ;

importSpecification
    : IMPORT uri                        x_combinator_seq_opt SEMICOLON
    | IMPORT uri          AS IDENTIFIER x_combinator_seq_opt SEMICOLON
    | IMPORT uri DEFERRED AS IDENTIFIER x_combinator_seq_opt SEMICOLON
    ;

x_combinator_seq_opt
    :  // empty
    | x_combinator_seq
    ;

x_combinator_seq
    :                  combinator
    | x_combinator_seq combinator
    ;

// combinator:
// show identifierList |
// hide identifierList
// ;

combinator
    : SHOW identifierList
    | HIDE identifierList
    ;

// identifierList:
// identifier (, identifier)*

identifierList
    :                      IDENTIFIER
    | identifierList COMMA IDENTIFIER
    ;

// libraryExport:
// metadata export uri combinator* ‘;’
// ;
//
// libraryExport
//    : metadata EXPORT uri x_combinator_seq_opt SEMICOLON
//    ;

// partDirective:
// metadata part uri ‘;’
// ;

partDirective
    : metadata PART uri SEMICOLON
    ;

x_partDirective_seq_opt
    :  // empty
    | x_partDirective_seq
    ;
	
x_partDirective_seq
    :                     partDirective
    | x_partDirective_seq partDirective
    ;

// partHeader:
// metadata part of identifier (‘.’ identifier)* ‘;’
// ;
//
// partHeader
//    : metadata PART OF IDENTIFIER x_identifier_tail_seq_opt SEMICOLON
//    ;

// partDeclaration:
// partHeader topLevelDefinition* EOF
// ;


////////
////////  partDeclaration
////////     : metadata PART OF IDENTIFIER x_identifier_tail_seq_opt SEMICOLON /*partHeader*/ x_topLevelDefinition_seq_opt EOF
////////     ;


x_topLevelDefinition_seq_opt
    :  // empty
    | x_topLevelDefinition_seq
    ;

x_topLevelDefinition_seq
    :                          topLevelDefinition
    | x_topLevelDefinition_seq topLevelDefinition
    ;

// uri:
// stringLiteral
// ;

uri
    : stringLiteral
    ;

// type:
// typeName typeArguments?
// ;

type
    : qualified /*typeName*/ x_typeArguments_opt
    ;

// typeName:
// qualified
// ;
//
// typeName
//    : qualified
//    ;

x_typeArguments_opt
    :  // empty
    | typeArguments
    ;

// typeArguments:
// ’<’ typeList ’>’
// ;

typeArguments
    : LESS typeList GREATER
    ;

// typeList:
// type (’, ’ type)*
// ;

typeList
    :                type
    | typeList COMMA type
    ;

// typeAlias:
// metadata typedef typeAliasBody
// ;
//
// typeAlias
//    : metadata TYPEDEF functionTypeAlias /*typeAliasBody*/
//    ;

// typeAliasBody:
// functionTypeAlias
// ;
//
// typeAliasBody
//    : functionTypeAlias
//    ;

// functionTypeAlias:
// functionPrefix typeParameters? formalParameterList ’;’
// ;

functionTypeAlias
    : x_returnType_opt IDENTIFIER /*functionPrefix*/ x_typeParameters_opt formalParameterList SEMICOLON
    ;

// functionPrefix:
// returnType? identifier
// ;
//
// functionPrefix
//    : x_returnType_opt IDENTIFIER
//    ;


