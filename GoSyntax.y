// |   alternation
// ()  grouping
// []  option (0 or 1 times)
// {}  repetition (0 to n times)

%token IDENTIFIER

%token FLOAT_LITERAL
%token IMAGINARY_LITERAL
%token INTEGER_LITERAL
%token RUNE_LITERAL
%token STRING_LITERAL

%token AMPERSAND
%token AMPERSAND_CARAT
%token AND
%token ARROW
%token CARET
%token COLON
%token COLON_EQUAL
%token COMMA
%token DOT
%token DOT_DOT_DOT
%token EQUAL
%token EQUAL_EQUAL
%token EXCLAMATION
%token EXCLAMATION_EQUAL
%token GREATER
%token GREATER_EQUAL
%token GREATER_GREATER
%token LBRACE // {
%token LBRACKET // [
%token LESS
%token LESS_EQUAL
%token LESS_LESS
%token LPAREN // (
%token MINUS
%token MINUS_MINUS
%token OR
%token PERCENT
%token PLUS
%token PLUS_PLUS
%token RBRACE // }
%token RBRACKET // ]
%token RPAREN // )
%token SEMICOLON
%token SLASH
%token STAR
%token VERTICAL

%token BREAK
%token CASE
%token CHANNEL
%token CONST
%token CONTINUE
%token DEFAULT
%token DEFER
%token ELSE
%token FALLTHROUGH
%token FOR
%token FUNCTION
%token GO
%token GOTO
%token IF
%token IMPORT
%token INTERFACE
%token MAP
%token PACKAGE
%token RANGE
%token RETURN
%token SELECT
%token STRUCT
%token SWITCH
%token TYPE
%token VAR

%start source_file

%%

//  SourceFile       = PackageClause ";" { ImportDecl ";" } { TopLevelDecl ";" } .

source_file
    : PACKAGE IDENTIFIER SEMICOLON x_import_decl_semicolon_seq_opt x_top_level_decl_semicolon_seq_opt
    ;

x_import_decl_semicolon_seq_opt
    :
    | x_import_decl_semicolon_seq
    ;

x_import_decl_semicolon_seq
    :                             import_decl SEMICOLON
    | x_import_decl_semicolon_seq import_decl SEMICOLON
    ;

x_top_level_decl_semicolon_seq_opt
    :
    | x_top_level_decl_semicolon_seq
    ;

x_top_level_decl_semicolon_seq
    :                                top_level_decl SEMICOLON
    | x_top_level_decl_semicolon_seq top_level_decl SEMICOLON
    ;

//  ImportDecl       = "import" ( ImportSpec | "(" { ImportSpec ";" } ")" ) .

import_decl
    : IMPORT        import_spec
    | IMPORT LPAREN                             RPAREN
    | IMPORT LPAREN x_import_spec_semicolon_seq RPAREN
    ;

x_import_spec_semicolon_seq
    :                             import_spec SEMICOLON
    | x_import_spec_semicolon_seq import_spec SEMICOLON
    ;

//  ImportSpec       = [ "." | PackageName ] ImportPath .

import_spec
    :            STRING_LITERAL
    | DOT        STRING_LITERAL
    | IDENTIFIER STRING_LITERAL
    ;

//  ImportPath       = string_lit .
//
//import_path
//    : STRING_LITERAL
//    ;

//  TopLevelDecl  = Declaration | FunctionDecl | MethodDecl .
top_level_decl
    : declaration
    | FUNCTION            IDENTIFIER signature x_function_body_opt  // function_decl
    | FUNCTION parameters IDENTIFIER signature x_function_body_opt  // method_decl
    ;

//  Declaration   = ConstDecl | TypeDecl | VarDecl .
declaration
      // const_decl
    : CONST        cons_spec
    | CONST LPAREN                 RPAREN
    | CONST LPAREN x_cons_spec_seq RPAREN

      // type_decl
    | TYPE        type_spec
    | TYPE LPAREN x_type_spec_semicolon_seq RPAREN
    | TYPE LPAREN                           RPAREN
	  
      // var_decl
    | VAR        var_spec
    | VAR LPAREN x_var_spec_semicolon_seq RPAREN
    | VAR LPAREN                          RPAREN
	  
    ;

//Expression = UnaryExpr | Expression binary_op Expression .
expression
    : unary_expression
    | expression binary_op expression
    ;

//UnaryExpr  = PrimaryExpr | unary_op UnaryExpr .
unary_expression
    : primary_expression
    | unary_op unary_expression
    ;

//binary_op  = "||" | "&&" | rel_op | add_op | mul_op .
binary_op
    : OR
    | AND
    | rel_op
    | add_op
    | mul_op
    ;

//rel_op     = "==" | "!=" | "<" | "<=" | ">" | ">=" .
rel_op
    : EQUAL_EQUAL
    | EXCLAMATION_EQUAL
    | LESS
    | LESS_EQUAL
    | GREATER
    | GREATER_EQUAL
    ;

//add_op     = "+" | "-" | "|" | "^" .
add_op
    : PLUS
    | MINUS
    | VERTICAL
    | CARET
    ;

//mul_op     = "*" | "/" | "%" | "<<" | ">>" | "&" | "&^" .
mul_op
    : STAR
    | SLASH
    | PERCENT
    | LESS_LESS
    | GREATER_GREATER
    | AMPERSAND
    | AMPERSAND_CARAT
    ;

//unary_op   = "+" | "-" | "!" | "^" | "*" | "&" | "<-" .
unary_op
    : PLUS
    | MINUS
    | EXCLAMATION
    | CARET
    | STAR
    | AMPERSAND
    | ARROW
    ;

//PrimaryExpr =
//	Operand |
//	Conversion |
//	MethodExpr |
//	PrimaryExpr Selector |
//	PrimaryExpr Index |
//	PrimaryExpr Slice |
//	PrimaryExpr TypeAssertion |
//	PrimaryExpr Arguments .
primary_expression
    : operand
    | type_or_operand_name x_literal_value_opt
    | type_or_operand_name LPAREN expression x_comma_opt RPAREN // additional for conversion
    | conversion
    | type_or_operand_name DOT IDENTIFIER // additional for method_expression
    | x_type_without_type_name DOT IDENTIFIER  // method_expression
    | primary_expression DOT IDENTIFIER                 /*selector*/
    | primary_expression LBRACKET expression RBRACKET   /*index*/
    | primary_expression slice
    | primary_expression DOT LPAREN type RPAREN         /*type_assertion*/
    | primary_expression LPAREN x_arguments_opt RPAREN  /*arguments*/
    ;

x_type_without_type_name
    : type_lit
    | LPAREN type RPAREN
    ;

// Selector       = "." identifier .
//
// selector
//    : DOT IDENTIFIER
//    ;

//Index          = "[" Expression "]" .
//
// index
//    : LBRACKET expression RBRACKET
//    ;

//Slice          = "[" [ Expression ] ":" [ Expression ] "]" |
//                 "[" [ Expression ] ":" Expression ":" Expression "]" .
slice
    : LBRACKET x_expression_opt COLON x_expression_opt            RBRACKET
    | LBRACKET x_expression_opt COLON expression COLON expression RBRACKET
    ;

x_expression_opt
    :
    | expression
    ;

//TypeAssertion  = "." "(" Type ")" .
//
// type_assertion
//    : DOT LPAREN type RPAREN
//    ;

//Arguments      = "(" [ ( ExpressionList | Type [ "," ExpressionList ] ) [ "..." ] [ "," ] ] ")" .
//
// arguments
//    : LPAREN x_arguments_opt RPAREN
//    ;

x_arguments_opt
    :
    |            expression_list x_dot_dot_dot_opt x_comma_opt
    | type                       x_dot_dot_dot_opt x_comma_opt
	| type COMMA expression_list x_dot_dot_dot_opt x_comma_opt
    ;

x_dot_dot_dot_opt
    :
    | DOT_DOT_DOT
    ;

x_comma_opt
    :
    | COMMA
    ;

// ConstDecl      = "const" ( ConstSpec | "(" { ConstSpec ";" } ")" ) .
//
///const_decl
//    : CONST        cons_spec
//    | CONST LPAREN                 RPAREN
//    | CONST LPAREN x_cons_spec_seq RPAREN
//    ;

x_cons_spec_seq
    :                 cons_spec SEMICOLON
    | x_cons_spec_seq cons_spec SEMICOLON
    ;

// ConstSpec      = IdentifierList [ [ Type ] "=" ExpressionList ] .

cons_spec
    : identifier_list x_assignment_expression_list_opt
    ;

x_assignment_expression_list_opt
    :
    |      EQUAL expression_list
    | type EQUAL expression_list
    ;

// IdentifierList = identifier { "," identifier } .

identifier_list
    :                       IDENTIFIER
    | identifier_list COMMA IDENTIFIER
    ;

// ExpressionList = Expression { "," Expression } .
expression_list
    :                       expression
    | expression_list COMMA expression
    ;

// Type      = TypeName | TypeLit | "(" Type ")" .
type
    : type_or_operand_name
    | type_lit
    | LPAREN type RPAREN
    ;

// TypeLit   = ArrayType | StructType | PointerType | FunctionType | InterfaceType |
//  	    SliceType | MapType | ChannelType .
type_lit
    : LBRACKET expression RBRACKET type // array_type
    | STRUCT LBRACE x_field_decl_semicolon_seq_opt RBRACE // struct_type
    | STAR type                       // pointer_type
    | FUNCTION signature              // function_type
    | INTERFACE LBRACE x_method_spec_semicolon_seq RBRACE  // interface_type
    | LBRACKET RBRACKET type          // slice_type
    | MAP LBRACKET type RBRACKET type // map_type
    | x_channel_tag type              // channel_type
    ;

//  PackageClause  = "package" PackageName .
//
// package_clause
//    : PACKAGE IDENTIFIER
//    ;

//  PackageName    = identifier .

// package_name
//    : IDENTIFIER
//    ;

//  ArrayType   = "[" ArrayLength "]" ElementType .
//
// array_type
//    : LBRACKET expression RBRACKET type
//    ;

//  ArrayLength = Expression .
//
//array_length
//    : expression
//    ;

//  ElementType = Type .
//
// element_type
//    : type
//    ;

//  ChannelType = ( "chan" | "chan" "<-" | "<-" "chan" ) ElementType .
//
// channel_type
//    : x_channel_tag type
//    ;

x_channel_tag
    :       CHANNEL
    | ARROW CHANNEL
	|       CHANNEL ARROW
    ;

// Conversion = Type "(" Expression [ "," ] ")" .
conversion
    : x_type_without_type_name LPAREN expression x_comma_opt RPAREN
    ;

//  FunctionDecl = "func" FunctionName Signature [ FunctionBody ] .
//
// function_decl
//    : FUNCTION IDENTIFIER signature x_function_body_opt
//    ;

x_function_body_opt
    :
    | block
    ;

//  FunctionName = identifier .
//function_name
//    : IDENTIFIER
//    ;

//  FunctionBody = Block .
//function_body
//    : block
//    ;

//  FunctionType   = "func" Signature .
//
// function_type
//    : FUNCTION signature
//    ;

//  Signature      = Parameters [ Result ] .
signature
    : parameters x_result_opt
    ;

//  Result         = Parameters | Type .
result
    : parameters
    | type
    ;

x_result_opt
    :
    | result
    ;

//  Parameters     = "(" [ ParameterList [ "," ] ] ")" .

parameters
    : LPAREN                            RPAREN
    | LPAREN parameter_list x_comma_opt RPAREN
    ;

//  ParameterList  = ParameterDecl { "," ParameterDecl } .

parameter_list
    :                      parameter_decl
    | parameter_list COMMA parameter_decl
    ;

//  ParameterDecl  = [ IdentifierList ] [ "..." ] Type .

parameter_decl
    :                 x_dot_dot_dot_opt type
    | identifier_list x_dot_dot_dot_opt type
    ;

//  InterfaceType      = "interface" "{" { MethodSpec ";" } "}" .
//
// interface_type
//    : INTERFACE LBRACE x_method_spec_semicolon_seq RBRACE
//    ;

x_method_spec_semicolon_seq
    :                             method_spec SEMICOLON
    | x_method_spec_semicolon_seq method_spec SEMICOLON
    ;

//  MethodSpec         = MethodName Signature | InterfaceTypeName .

method_spec
    : IDENTIFIER signature
    | type_or_operand_name
    ;

//  MethodName         = identifier .
//
// method_name
//    : IDENTIFIER
//    ;

//  InterfaceTypeName  = TypeName .
//
// interface_type_name
//    : type_name
//    ;

//  MapType     = "map" "[" KeyType "]" ElementType .
//
// map_type
//    : MAP LBRACKET type RBRACKET type
//    ;

//  KeyType     = Type .
//
// key_type
//    : type
//    ;

//  MethodDecl = "func" Receiver MethodName Signature [ FunctionBody ] .
//
// method_decl
//    : FUNCTION parameters IDENTIFIER signature x_function_body_opt
//    ;

//  Receiver   = Parameters .
//
// receiver
//    : parameters
//    ;

//  MethodExpr    = ReceiverType "." MethodName .
//
// method_expression
//    : x_type_without_type_name DOT IDENTIFIER
//    ;

//  ReceiverType  = Type .
//
// receiver_type
//    : type
//    ;

//  Operand     = Literal | OperandName | "(" Expression ")" .
operand
    : literal
    | LPAREN expression RPAREN
    ;

x_literal_value_opt
    :
    | literal_value
    ;

//  Literal     = BasicLit | CompositeLit | FunctionLit .
literal
      // basic_lit
    : INTEGER_LITERAL
    | FLOAT_LITERAL
    | IMAGINARY_LITERAL
    | RUNE_LITERAL
    | STRING_LITERAL
	  
      // composite_lit
	| literal_type literal_value 
	
      // function_lit
	| FUNCTION signature block
    ;

//  BasicLit    = int_lit | float_lit | imaginary_lit | rune_lit | string_lit .
//
// basic_lit
//    : INTEGER_LITERAL
//    | FLOAT_LITERAL
//    | IMAGINARY_LITERAL
//    | RUNE_LITERAL
//    | STRING_LITERAL
//    ;

//  OperandName = identifier | QualifiedIdent.
//  TypeName  = identifier | QualifiedIdent .
//  QualifiedIdent = PackageName "." identifier .
type_or_operand_name
    : IDENTIFIER x_dot_identifier_opt
    ;

x_dot_identifier_opt
    : DOT IDENTIFIER
    ;

//  CompositeLit  = LiteralType LiteralValue .
//
// composite_lit
//    : literal_type literal_value
//    ;

//  LiteralType   = StructType | ArrayType | "[" "..." "]" ElementType |
//                SliceType | MapType | TypeName .
literal_type
    : STRUCT LBRACE x_field_decl_semicolon_seq_opt RBRACE // struct_type
    | LBRACKET expression RBRACKET type  // array_type
    | LBRACKET DOT_DOT_DOT RBRACKET type
    | LBRACKET RBRACKET type             // slice_type
    | MAP LBRACKET type RBRACKET type    // map_type
    ;

//  LiteralValue  = "{" [ ElementList [ "," ] ] "}" .
literal_value
    : LBRACE x_element_list_with_comma_opt RBRACE
    ;

x_element_list_with_comma_opt
    :
    | element_list x_comma_opt
    ;

//  ElementList   = KeyedElement { "," KeyedElement } .
element_list
    :                    keyed_element
    | element_list COMMA keyed_element
    ;

//  KeyedElement  = [ Key ":" ] Element .
keyed_element
    : key COLON element
    |           element
    ;

//  Key           = FieldName | Expression | LiteralValue .
key
    : expression
    | literal_value
    ;

//  FieldName     = identifier .
//
// field_name
//    : IDENTIFIER
//    ;

//  Element       = Expression | LiteralValue .
element
    : expression
    | literal_value
    ;

//  FunctionLit = "func" Signature FunctionBody
//
// function_lit
//    : FUNCTION signature block
//    ;

// PointerType = "*" BaseType .
//
// pointer_type
//    : STAR type
//    ;

//  BaseType    = Type .
// base_type
//    : type
//    ;

// SliceType = "[" "]" ElementType .
//
// slice_type
//    : LBRACKET RBRACKET type
//    ;

//  StructType    = "struct" "{" { FieldDecl ";" } "}" .
//
// struct_type
//    : STRUCT LBRACE x_field_decl_semicolon_seq_opt RBRACE
//    ;

x_field_decl_semicolon_seq_opt
    : // empty
    | x_field_decl_semicolon_seq
    ;
	
x_field_decl_semicolon_seq
    :                            field_decl SEMICOLON
    | x_field_decl_semicolon_seq field_decl SEMICOLON
    ;

//  FieldDecl     = (IdentifierList Type | EmbeddedField) [ Tag ] .

field_decl
    : identifier_list type x_tag_opt
    | embedded_field       x_tag_opt
    ;

x_tag_opt
    :
    | STRING_LITERAL
    ;

//  EmbeddedField = [ "*" ] TypeName .

embedded_field
    :      type_or_operand_name
    | STAR type_or_operand_name
    ;

//  Tag           = string_lit .
//
// tag
//    : STRING_LITERAL
//    ;

//  TypeDecl = "type" ( TypeSpec | "(" { TypeSpec ";" } ")" ) .
//
// type_decl
//    : TYPE        type_spec
//    | TYPE LPAREN x_type_spec_semicolon_seq RPAREN
//    | TYPE LPAREN                           RPAREN
//    ;

x_type_spec_semicolon_seq
    :                           type_spec SEMICOLON
    | x_type_spec_semicolon_seq type_spec SEMICOLON
    ;

//  TypeSpec = AliasDecl | TypeDef .
type_spec
    : IDENTIFIER EQUAL type  // alias_decl
    | IDENTIFIER       type  // type_def
    ;

// AliasDecl = identifier "=" Type .
//
// alias_decl
//    : IDENTIFIER EQUAL type
//    ;

// TypeDef = identifier Type .
//
// type_def
//    : IDENTIFIER type
//    ;

//  VarDecl     = "var" ( VarSpec | "(" { VarSpec ";" } ")" ) .
//
// var_decl
//    : VAR        var_spec
//    | VAR LPAREN x_var_spec_semicolon_seq RPAREN
//    | VAR LPAREN                          RPAREN
//    ;

x_var_spec_semicolon_seq
    :                          var_spec SEMICOLON
    | x_var_spec_semicolon_seq var_spec SEMICOLON
    ;

//  VarSpec     = IdentifierList ( Type [ "=" ExpressionList ] | "=" ExpressionList ) .

var_spec
    : identifier_list type x_assignment_expression_list_opt
    | identifier_list      EQUAL expression_list
    ;

// Block = "{" StatementList "}" .

block
    : LBRACE statement_seq RBRACE
    ;

// StatementList = { Statement ";" } .

statement_seq
    :
    | x_statement_semicolon_seq
    ;

x_statement_semicolon_seq
    :               statement SEMICOLON
    | statement_seq statement SEMICOLON
    ;

//  Statement =
//  	Declaration | LabeledStmt | SimpleStmt |
//  	GoStmt | ReturnStmt | BreakStmt | ContinueStmt | GotoStmt |
//  	FallthroughStmt | Block | IfStmt | SwitchStmt | SelectStmt | ForStmt |
//  	DeferStmt .

statement
    : declaration
    | IDENTIFIER COLON statement  // labeled_stmt
    | simple_stmt
    | GO expression         // go_stmt
    | RETURN x_expression_list_opt  // return_stmt
    | BREAK x_label_opt     // break_stmt
    | CONTINUE x_label_opt  // continue_stmt
//  | GOTO IDENTIFIER       // goto_stmt -- is covered by GO expression
    | FALLTHROUGH           // fallthrough_stmt
    | block
    | if_stmt
	
      // switch_stmt
    | expr_switch_stmt
    | type_switch_stmt
	
      // select_stmt
    | SELECT LBRACE x_comm_clause_seq RBRACE
    | SELECT LBRACE                   RBRACE
	  
    | FOR x_for_condition_opt block // for_stmt
    | DEFER expression              // defer_stmt
    ;

//  SimpleStmt = EmptyStmt | ExpressionStmt | SendStmt | IncDecStmt | Assignment | ShortVarDecl .
simple_stmt
    :
    | expression
    | send_stmt
	
      // inc_dec_stmt
    | expression PLUS_PLUS
    | expression MINUS_MINUS
	  
    | expression_list assign_op   expression_list    // assignment
    | identifier_list COLON_EQUAL expression_list    // short_var_decl
    ;

//  Assignment = ExpressionList assign_op ExpressionList .
//
// assignment
//    : expression_list assign_op expression_list
//    ;

//  assign_op = [ add_op | mul_op ] "=" .

assign_op
    : x_assign_ops_opt EQUAL
    ;

x_assign_ops_opt
    :
    | mul_op
    | add_op
    ;

//  BreakStmt = "break" [ Label ] .
//
// break_stmt
//    : BREAK x_label_opt
//    ;

x_label_opt
    :
    | IDENTIFIER
    ;

//  LabeledStmt = Label ":" Statement .
//
// labeled_stmt
//    : IDENTIFIER COLON statement
//    ;

//  Label       = identifier .
//
// label
//    : IDENTIFIER
//    ;

//  ContinueStmt = "continue" [ Label ] .
//
// continue_stmt
//    : CONTINUE x_label_opt
//    ;

//  DeferStmt = "defer" Expression .
//
// defer_stmt
//    : DEFER expression
//    ;

//  EmptyStmt = .
//
// empty_stmt
//    :
//    ;

//  ExpressionStmt = Expression .
//
// expression_stmt
//    : expression
//    ;

//  FallthroughStmt = "fallthrough" .
//
// fallthrough_stmt
//    : FALLTHROUGH
//    ;

// ForStmt = "for" [ Condition | ForClause | RangeClause ] Block .
//
// for_stmt
//    : FOR x_for_condition_opt block
//    ;

x_for_condition_opt
    :
    | expression
    | simple_stmt SEMICOLON x_expression_opt SEMICOLON simple_stmt  // for_clause
    | x_expression_list_equal_or_identifier_list_colon_equal_opt RANGE expression  //range_clause
    ;

// Condition = Expression .
//
//condition
//    : expression
//    ;

//  GoStmt = "go" Expression .
//
// go_stmt
//    : GO expression
//    ;

//  GotoStmt = "goto" Label .
//
// goto_stmt
//    : GOTO IDENTIFIER
//    ;

//  IfStmt = "if" [ SimpleStmt ";" ] Expression Block [ "else" ( IfStmt | Block ) ] .

if_stmt
    : IF x_simple_stmt_semicolon_opt expression block x_else_opt
    ;

x_simple_stmt_semicolon_opt
    :
    | simple_stmt SEMICOLON
    ;

x_else_opt
    :
    | ELSE if_stmt
    | ELSE block
    ;

//  ReturnStmt = "return" [ ExpressionList ] .
//
// return_stmt
//    : RETURN x_expression_list_opt
//    ;

x_expression_list_opt
    :
    | expression_list
    ;

//  SelectStmt = "select" "{" { CommClause } "}" .
//
// select_stmt
//    : SELECT LBRACE x_comm_clause_seq RBRACE
//    | SELECT LBRACE                   RBRACE
//    ;

x_comm_clause_seq
    :                   comm_clause
    | x_comm_clause_seq comm_clause
    ;

//  CommClause = CommCase ":" StatementList .

comm_clause
    : CASE send_stmt COLON statement_seq
    | CASE recv_stmt COLON statement_seq
    | DEFAULT        COLON statement_seq
    ;

//  CommCase   = "case" ( SendStmt | RecvStmt ) | "default" .
//
// comm_case
//    : CASE send_stmt
//    | CASE recv_stmt
//    | DEFAULT
//    ;

//  RecvStmt   = [ ExpressionList "=" | IdentifierList ":=" ] RecvExpr .
recv_stmt
    : x_expression_list_equal_or_identifier_list_colon_equal_opt expression
    ;

x_expression_list_equal_or_identifier_list_colon_equal_opt
    :
    | expression_list EQUAL
    | identifier_list COLON_EQUAL
    ;

//  RecvExpr   = Expression .
//
// recv_expr
//    : expression
//    ;

//  SendStmt = Channel "<-" Expression .
send_stmt
    : expression ARROW expression
    ;

//  Channel  = Expression .
//
// channel
//    : expression
//    ;

//  IncDecStmt = Expression ( "++" | "--" ) .
//
// inc_dec_stmt
//    : expression PLUS_PLUS
//    | expression MINUS_MINUS
//    ;

//  ShortVarDecl = IdentifierList ":=" ExpressionList .
//
// short_var_decl
//    : identifier_list COLON_EQUAL expression_list
//    ;

//  SwitchStmt = ExprSwitchStmt | TypeSwitchStmt .
//
// switch_stmt
//    : expr_switch_stmt
//    | type_switch_stmt
//    ;

//  ExprSwitchStmt = "switch" [ SimpleStmt ";" ] [ Expression ] "{" { ExprCaseClause } "}" .

expr_switch_stmt
    : SWITCH x_simple_stmt_semicolon_opt x_expression_opt LBRACE x_expr_case_clause_list RBRACE
    | SWITCH x_simple_stmt_semicolon_opt x_expression_opt LBRACE RBRACE
    ;

x_expr_case_clause_list
    : expr_case_clause
    | x_expr_case_clause_list expr_case_clause
    ;

//  ExprCaseClause = ExprSwitchCase ":" StatementList .

expr_case_clause
    : CASE expression_list COLON statement_seq
	| DEFAULT              COLON statement_seq
    ;

//  ExprSwitchCase = "case" ExpressionList | "default" .
//
// expr_switch_case
//    : CASE expression_list
//    | DEFAULT
//    ;

//  ForClause = [ InitStmt ] ";" [ Condition ] ";" [ PostStmt ] .
//
// for_clause
//    : simple_stmt SEMICOLON x_expression_opt SEMICOLON simple_stmt
//    ;

//  InitStmt = SimpleStmt .
//
// init_stmt
//    : simple_stmt
//    ;

//  PostStmt = SimpleStmt .
//
// post_stmt
//    : simple_stmt
//    ;

//  RangeClause = [ ExpressionList "=" | IdentifierList ":=" ] "range" Expression .
//
// range_clause
//    : x_expression_list_equal_or_identifier_list_colon_equal_opt RANGE expression
//    ;

//  TypeSwitchStmt  = "switch" [ SimpleStmt ";" ] TypeSwitchGuard "{" { TypeCaseClause } "}" .
type_switch_stmt
    : SWITCH x_simple_stmt_semicolon_opt type_switch_guard LBRACE x_type_case_clause_seq RBRACE
    | SWITCH x_simple_stmt_semicolon_opt type_switch_guard LBRACE                        RBRACE
    ;

x_type_case_clause_seq
    :                        type_case_clause
    | x_type_case_clause_seq type_case_clause
    ;

//  TypeSwitchGuard = [ identifier ":=" ] PrimaryExpr "." "(" "type" ")" .
type_switch_guard
    : IDENTIFIER COLON_EQUAL primary_expression DOT LPAREN TYPE RPAREN
    |                        primary_expression DOT LPAREN TYPE RPAREN
    ;

//  TypeCaseClause  = TypeSwitchCase ":" StatementList .
type_case_clause
    : CASE type_list COLON statement_seq
	| DEFAULT        COLON statement_seq
    ;

//  TypeSwitchCase  = "case" TypeList | "default" .
//
// type_switch_case
//    : CASE type_list
//    | DEFAULT
//    ;

//  TypeList        = Type { "," Type } .

type_list
    :                 type
    | type_list COMMA type
    ;

%%
