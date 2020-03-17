// A.1 Keywords [gram.key]
// 1 New context_dependent keywords are introduced into a program by typedef (9.2.3), namespace (9.8.1),
// class (Clause 11), enumeration (9.7.1), and template (Clause 13) declarations.
//
// typedef_name:
//     identifier
//     simple_template_id
//
// namespace_name:
//     identifier
//     namespace_alias
//
// namespace_alias:
//     identifier
//
// class_name:
//     identifier
//     simple_template_id
//
// enum_name:
//     identifier
//
// template_name:
//     identifier
/*
literal
    : integer_literal
    | character_literal
    | floating_point_literal
    | string_literal
    | boolean_literal
    | pointer_literal
    | user_defined_literal
	;
boolean_literal:
false
true
pointer_literal:
nullptr

user_defined_literal
    : user_defined_integer_literal
    | user_defined_floating_point_literal
    | user_defined_string_literal
    | user_defined_character_literal
	;
	
user_defined_integer_literal
    : decimal_literal     ud_suffix
    | octal_literal       ud_suffix
    | hexadecimal_literal ud_suffix
    | binary_literal      ud_suffix
	
user_defined_floating_point_literal
    : fractional_constant exponent_partopt                                    ud_suffix
    | digit_sequence exponent_part                                            ud_suffix
    | hexadecimal_prefix hexadecimal_fractional_constant binary_exponent_part ud_suffix
    | hexadecimal_prefix hexadecimal_digit_sequence binary_exponent_part      ud_suffix
	
user_defined_string_literal
    : string_literal ud_suffix
    ;
	
user_defined_character_literal
    : character_literal ud_suffix
	
ud_suffix
    : IDENTIFIER
*/

	

%token ALIGNAS
%token ALIGNOF
%token ASM
%token AUTO
%token BOOL
%token BREAK
%token CASE
%token CATCH
%token CHAR
%token CHAR16_T
%token CHAR32_T
%token CHAR8_T
%token CLASS
%token CONCEPT
%token CONST
%token CONSTEVAL
%token CONSTEXPR
%token CONSTINIT
%token CONST_CAST
%token CONTINUE
%token CO_AWAIT
%token CO_RETURN
%token CO_YIELD
%token DECLTYPE
%token DEFAULT
%token DELETE	
%token DO
%token DOUBLE
%token DYNAMIC_CAST
%token ELSE
%token ENUM
%token EXPLICIT
%token EXPORT
%token EXTERN
%token FALSE
%token FINAL
%token FLOAT
%token FOR
%token FRIEND
%token GOTO
%token IF
%token IMPORT
%token INLINE
%token INT
%token LONG
%token MODULE
%token MUTABLE
%token NAMESPACE
%token NEW
%token NOEXCEPT
%token NULLPTR
%token OPERATOR
%token OVERRIDE
%token PRIVATE
%token PROTECTED
%token PUBLIC
%token REINTERPRET_CAST
%token REQUIRES
%token RETURN
%token SHORT
%token SIGNED
%token SIZEOF
%token STATIC
%token STATIC_ASSERT
%token STATIC_CAST
%token STRUCT
%token SWITCH
%token TEMPLATE
%token THIS
%token THREAD_LOCAL
%token THROW
%token TRUE
%token TRY
%token TYPEDEF
%token TYPEID
%token TYPENAME
%token UNION
%token UNSIGNED
%token USING
%token VIRTUAL
%token VOID
%token VOLATILE
%token WCHAR_T
%token WHILE

%token AMPERSAND              //  &
%token AMPERSAND_EQUAL        //  &=
%token AMP_AMP                //  &&
%token ARROW                  //  ->
%token ARROW_STAR             //  ->*
%token CARET                  //  ^
%token CARET_EQUAL            //  ^=
%token COLON                  //  :
%token COLON_COLON            //  ::
%token COMMA                  //  ,
%token DOT                    //  .
%token DOT_STAR               //  .*
%token ELLIPSIS               //  ...
%token EQUAL                  //  =
%token EQUAL_EQUAL            //  ==
%token EQUAL_ZERO             //  =0
%token EXCLAMATION            //  !
%token EXCL_EQUAL             //  !=
%token GREATER                //  >
%token GREATER_EQUAL          //  >= 
%token GREATER_GREATER        //  >>
%token GREATER_GREATER_EQUAL  //  >>=
%token LBRACE                 //  {
%token LBRACKET               //  [
%token LESS                   //  <
%token LESS_EQUAL             //  <=
%token LESS_LESS              //  <<
%token LESS_LESS_EQUAL        //  <<=
%token LPAREN                 //  (
%token MINUS                  //  -
%token MINUS_EQUAL            //  -=
%token MINUS_MINUS            //  --
%token PERCENT                //  %
%token PERCENT_EQUAL          //  %=
%token PLUS                   //  +
%token PLUS_EQUAL             //  +=
%token PLUS_PLUS              //  ++
%token QUESTION               //  ?
%token RBRACE                 //  }
%token RBRACKET               //  ]
%token RPAREN                 //  ) 
%token SEMICOLON              //  ;
%token SLASH                  //  /
%token SLASH_EQUAL            //  /=
%token SPACESHIP              //  <=>
%token STAR                   //  *
%token STAR_EQUAL             //  *=
%token TILDE                  //  ~
%token VERTICAL               //  |
%token VERT_EQUAL             //  |=
%token VERT_VERT              //  ||

%token IDENTIFIER
%token STRING_LITERAL
%token INTEGER_LITERAL
%token CHARACTER_LITERAL
%token FLOATING_POINT_LITERAL
%token USER_DEFINED_LITERAL

%define lr.type ielr

%start translation_unit

%%

// A.3 Basics [gram.basic]

translation_unit
    : top_level_declaration_seq_opt
    | global_module_fragment_opt module_declaration top_level_declaration_seq_opt private_module_fragment_opt
    ;
	
private_module_fragment_opt
    :  // empty
    | MODULE COLON PRIVATE SEMICOLON top_level_declaration_seq_opt
	;
	
top_level_declaration_seq
    :                           top_level_declaration
    | top_level_declaration_seq top_level_declaration
	;
	
top_level_declaration_seq_opt
    :  // empty
    | top_level_declaration_seq
    ;
	
top_level_declaration
    : module_import_declaration
    | declaration
	;
	
// A.4 Expressions [gram.expr]

primary_expression
    : literal
	| THIS
	| LPAREN expression RPAREN
	| id_expression
	| lambda_expression
	
       // fold_expression
    | LPAREN          cast_expression fold_operator ELLIPSIS                               RPAREN
	| LPAREN ELLIPSIS                 fold_operator                        cast_expression RPAREN
	| LPAREN          cast_expression fold_operator ELLIPSIS fold_operator cast_expression RPAREN
	
	   // requires_expression
    | REQUIRES                                            LBRACE requirement_seq RBRACE
	| REQUIRES LPAREN                              RPAREN LBRACE requirement_seq RBRACE
	| REQUIRES LPAREN parameter_declaration_clause RPAREN LBRACE requirement_seq RBRACE
	;

literal
    : INTEGER_LITERAL
    | CHARACTER_LITERAL
    | FLOATING_POINT_LITERAL
    | STRING_LITERAL
    | TRUE | FALSE   // boolean_literal
    | NULLPTR        // pointer_literal
    | USER_DEFINED_LITERAL
	;

// requires_expression
//    : REQUIRES                                            LBRACE requirement_seq RBRACE
//    | REQUIRES LPAREN                              RPAREN LBRACE requirement_seq RBRACE
//    | REQUIRES LPAREN parameter_declaration_clause RPAREN LBRACE requirement_seq RBRACE
//    ;

// fold_expression
//    : LPAREN          cast_expression fold_operator ELLIPSIS                               RPAREN
//    | LPAREN ELLIPSIS                 fold_operator                        cast_expression RPAREN
//    | LPAREN          cast_expression fold_operator ELLIPSIS fold_operator cast_expression RPAREN
//    ;

id_expression
    :                                unqualified_id
    | nested_name_specifier          unqualified_id   // qualified_id
	| nested_name_specifier TEMPLATE unqualified_id   // qualified_id
	;
	
unqualified_id
    : IDENTIFIER                                                                    x_template_argument_tail_opt // simple_template_id
	| OPERATOR operator                                  /* operator_function_id */ x_template_argument_tail_opt
	| OPERATOR type_specifier_seq                        /* conversion_function_id */ 
	| OPERATOR type_specifier_seq conversion_declarator  /* conversion_function_id */ 
	| OPERATOR STRING_LITERAL IDENTIFIER                 /* literal_operator_id */  x_template_argument_tail_opt
	
	| TILDE IDENTIFIER x_template_argument_tail_opt // type_name
	| TILDE DECLTYPE LPAREN expression RPAREN  // decltype_specifier

       // template_id
//  | IDENTIFIER /* template_name */                               x_template_argument_tail  // simple_template_id
//  | OPERATOR operator /* operator_function_id */                 x_template_argument_tail
//  | OPERATOR STRING_LITERAL IDENTIFIER /* literal_operator_id */ x_template_argument_tail
	;

// template_id
//    : IDENTIFIER /* template_name */                               x_template_argument_tail  // simple_template_id
//    | OPERATOR operator /* operator_function_id */                 x_template_argument_tail
//    | OPERATOR STRING_LITERAL IDENTIFIER /* literal_operator_id */ x_template_argument_tail
//    ;

// qualified_id
//    : nested_name_specifier          unqualified_id
//    | nested_name_specifier TEMPLATE unqualified_id
//    ;
	
// conversion_function_id
//    : OPERATOR conversion_type_id
//    ;

// conversion_type_id
//    : type_specifier_seq
//    | type_specifier_seq conversion_declarator
//    ;

conversion_declarator
    : ptr_operator
	| ptr_operator conversion_declarator
	;

nested_name_specifier
    :                                                                                          COLON_COLON
	|                                IDENTIFIER x_template_argument_tail_opt /* type_name */   COLON_COLON
//	|                                IDENTIFIER /* namespace_name */                           COLON_COLON -- covered by type_name

	| DECLTYPE LPAREN expression RPAREN /* decltype_specifier */                               COLON_COLON                                                                       COLON_COLON

//	| nested_name_specifier          IDENTIFIER                                                COLON_COLON
	| nested_name_specifier          IDENTIFIER x_template_argument_tail_opt /* simple_template_id */ COLON_COLON
	| nested_name_specifier TEMPLATE IDENTIFIER x_template_argument_tail /* simple_template_id */     COLON_COLON
	;
	
lambda_expression
    : lambda_introducer                                                        compound_statement
	| lambda_introducer                                      lambda_declarator compound_statement
    | lambda_introducer LESS template_parameter_list GREATER x_lambda_tail_opt compound_statement
	;

x_lambda_tail_opt  // can be empty because of lambda_declarator
	:  // empty
	|                 lambda_declarator
    | requires_clause
	| requires_clause lambda_declarator
    ;
	
lambda_introducer
    : LBRACKET                RBRACKET
	| LBRACKET lambda_capture RBRACKET
	;
	
lambda_declarator
    : LPAREN parameter_declaration_clause RPAREN decl_specifier_seq_opt
    | noexcept_specifier_opt attribute_specifier_seq_opt trailing_return_type_opt requires_clause_opt
	;
	
lambda_capture
    : capture_default
    |                       capture_list
    | capture_default COMMA capture_list
	;
	
capture_default
    : AMPERSAND
	| EQUAL
	;
	
capture_list
    :                    capture
    | capture_list COMMA capture
	;
	
capture
    : simple_capture
	| simple_capture ELLIPSIS
	|          init_capture
    | ELLIPSIS init_capture
	;
	
simple_capture
    :           IDENTIFIER
	| AMPERSAND IDENTIFIER
	|      THIS
	| STAR THIS
	;
	
init_capture
    :           IDENTIFIER initializer
	| AMPERSAND IDENTIFIER initializer
	;
	
fold_operator
    : PLUS | MINUS | STAR | SLASH | PERCENT | CARET | AMPERSAND | VERTICAL
	| LESS_LESS | GREATER_GREATER | PLUS_EQUAL | MINUS_EQUAL | STAR_EQUAL | SLASH_EQUAL
	| PERCENT_EQUAL | CARET_EQUAL | AMPERSAND_EQUAL | VERT_EQUAL | LESS_LESS_EQUAL
	| GREATER_GREATER_EQUAL | EQUAL | EQUAL_EQUAL | EXCL_EQUAL | LESS | GREATER
	| LESS_EQUAL | GREATER_EQUAL | AMP_AMP | VERT_VERT | COMMA | DOT_STAR | ARROW_STAR
	;
	
// + - * / % ^ & | << >>
// += -= *= /= %= ^= &= |= <<= >>= =
// == != < > <= >= && || , .* ->*

// requirement_parameter_list:
//   ( parameter_declaration_clauseopt )

// requirement_body:
//      { requirement_seq }

requirement_seq
    :                 requirement
    | requirement_seq requirement
	;
	
requirement
    : expression                                              SEMICOLON  // simple_requirement
	
    | TYPENAME                       IDENTIFIER x_template_argument_tail_opt /* type_name */ SEMICOLON  // type_requirement
    | TYPENAME nested_name_specifier IDENTIFIER x_template_argument_tail_opt /* type_name */ SEMICOLON  // type_requirement
    
	| LBRACE expression RBRACE                                SEMICOLON  // compound_requirement
	| LBRACE expression RBRACE          ARROW type_constraint SEMICOLON  // compound_requirement
	| LBRACE expression RBRACE NOEXCEPT                       SEMICOLON  // compound_requirement
	| LBRACE expression RBRACE NOEXCEPT ARROW type_constraint SEMICOLON  // compound_requirement
    
	| REQUIRES constraint_expression                          SEMICOLON  // nested_requirement
	;
	
// simple_requirement:
//   expression ;
// type_requirement:
//   typename nested_name_specifieropt type_name ;
// compound_requirement:
//   { expression } noexceptopt return_type_requirementopt ;
// return_type_requirement:
//   -> type_constraint
// nested_requirement:
// requires constraint_expression ;

postfix_expression
    : primary_expression
	
	| postfix_expression LBRACKET expr_or_braced_init_list RBRACKET
    
	| postfix_expression x_argument_list
//	| simple_type_specifier x_argument_list  -- seems to be covered by prev. branch
	| typename_specifier x_argument_list
	
    | simple_type_specifier braced_init_list
    | typename_specifier braced_init_list
	
    | postfix_expression DOT          id_expression
	| postfix_expression DOT TEMPLATE id_expression
	
    | postfix_expression ARROW          id_expression
    | postfix_expression ARROW TEMPLATE id_expression
	
    | postfix_expression PLUS_PLUS
	| postfix_expression MINUS_MINUS
	
    | DYNAMIC_CAST     LESS type_id GREATER LPAREN expression RPAREN
    | STATIC_CAST      LESS type_id GREATER LPAREN expression RPAREN
    | REINTERPRET_CAST LESS type_id GREATER LPAREN expression RPAREN
    | CONST_CAST       LESS type_id GREATER LPAREN expression RPAREN
    
	| TYPEID LPAREN expression RPAREN
    | TYPEID LPAREN type_id    RPAREN
	;

x_argument_list
    : LPAREN                 RPAREN
	| LPAREN expression_list RPAREN
	;
	
expression_list
    : initializer_list
	;
	
unary_expression
    : postfix_expression
    | unary_operator cast_expression
    | PLUS_PLUS cast_expression
    | MINUS_MINUS cast_expression
    | CO_AWAIT cast_expression // await_expression
    | SIZEOF unary_expression
    | SIZEOF LPAREN type_id RPAREN
    | SIZEOF ELLIPSIS LPAREN IDENTIFIER RPAREN
    | ALIGNOF LPAREN type_id RPAREN
    | NOEXCEPT LPAREN expression RPAREN // noexcept_expression
    | new_expression
    | delete_expression
	;
	
unary_operator
    : STAR        // *
    | AMPERSAND   // &
    | PLUS        // +
    | MINUS       // -
    | EXCLAMATION // !
    | TILDE       // ~
	;
	
// await_expression
//    : CO_AWAIT cast_expression
//    ;
	
// noexcept_expression
//    : NOEXCEPT LPAREN expression RPAREN
//    ;

new_expression
    :             NEW new_placement_opt      new_type_id      new_initializer_opt
	| COLON_COLON NEW new_placement_opt      new_type_id      new_initializer_opt
	|             NEW new_placement_opt LPAREN type_id RPAREN new_initializer_opt
    | COLON_COLON NEW new_placement_opt LPAREN type_id RPAREN new_initializer_opt
	;
	
new_placement_opt
    :  // empty
    | LPAREN expression_list RPAREN
	;
	
new_type_id
    : type_specifier_seq
	| type_specifier_seq new_declarator
	;
	
new_declarator
    : ptr_operator
	| ptr_operator new_declarator
    | noptr_new_declarator
	;
	
noptr_new_declarator
    :                      LBRACKET                     RBRACKET attribute_specifier_seq_opt
    |                      LBRACKET expression          RBRACKET attribute_specifier_seq_opt
    | noptr_new_declarator LBRACKET constant_expression RBRACKET attribute_specifier_seq_opt
    ;

new_initializer_opt
    :  // empty
	| x_argument_list
    | braced_init_list
	;
	
delete_expression
    :             DELETE                   cast_expression
    | COLON_COLON DELETE                   cast_expression
	|             DELETE LBRACKET RBRACKET cast_expression
	| COLON_COLON DELETE LBRACKET RBRACKET cast_expression
	;
	
cast_expression
    : unary_expression
	| LPAREN type_id RPAREN cast_expression
	;
	
pm_expression
    :                          cast_expression
	| pm_expression DOT_STAR   cast_expression   // .*
	| pm_expression ARROW_STAR cast_expression   // ->*
	;
	
multiplicative_expression
    :                                   pm_expression
	| multiplicative_expression STAR    pm_expression
    | multiplicative_expression SLASH   pm_expression
    | multiplicative_expression PERCENT pm_expression
	;
	
additive_expression
    :                           multiplicative_expression  
    | additive_expression PLUS  multiplicative_expression
    | additive_expression MINUS multiplicative_expression
	;
	
shift_expression
    :                                  additive_expression
    | shift_expression LESS_LESS       additive_expression
    | shift_expression GREATER_GREATER additive_expression
	;
	
compare_expression
    :                              shift_expression
    | compare_expression SPACESHIP shift_expression  //  <=>
	;
	
relational_expression
    :                                     compare_expression
    | relational_expression LESS          compare_expression
    | relational_expression GREATER       compare_expression
    | relational_expression LESS_EQUAL    compare_expression
    | relational_expression GREATER_EQUAL compare_expression
	;
	
equality_expression
    :                                 relational_expression
    | equality_expression EQUAL_EQUAL relational_expression
    | equality_expression EXCL_EQUAL  relational_expression
	;
	
and_expression
    :                          equality_expression
    | and_expression AMPERSAND equality_expression
	;
	
exclusive_or_expression
    :                               and_expression
    | exclusive_or_expression CARET and_expression
	;

inclusive_or_expression
    :                                  exclusive_or_expression
    | inclusive_or_expression VERTICAL exclusive_or_expression
	;
	
logical_and_expression
    :                                inclusive_or_expression
    | logical_and_expression AMP_AMP inclusive_or_expression
	;
	
logical_or_expression
    :                                 logical_and_expression
    | logical_or_expression VERT_VERT logical_and_expression
	;
	
conditional_expression
    : logical_or_expression
    | logical_or_expression QUESTION expression COLON assignment_expression
	;
	
// yield_expression
//    : CO_YIELD assignment_expression
//    | CO_YIELD braced_init_list
//    ;
	
// throw_expression
//    : THROW
//    | THROW assignment_expression
//    ;
	
assignment_expression
    : conditional_expression
	
    | CO_YIELD assignment_expression  // yield_expression
    | CO_YIELD braced_init_list       // yield_expression
    
	| THROW                           // throw_expression
	| THROW assignment_expression     // throw_expression
    
	| logical_or_expression assignment_operator initializer_clause
	;
	
assignment_operator
    : EQUAL | STAR_EQUAL | SLASH_EQUAL | PERCENT_EQUAL | PLUS_EQUAL | MINUS_EQUAL
	| GREATER_GREATER_EQUAL | LESS_LESS_EQUAL | AMPERSAND_EQUAL | CARET_EQUAL | VERT_EQUAL
	;

expression
    :                  assignment_expression
    | expression COMMA assignment_expression
	;
	
constant_expression
    : conditional_expression
	;
	
// A.5 Statements [gram.stmt]

statement
    : labeled_statement
    | attribute_specifier_seq_opt expression_statement
    | attribute_specifier_seq_opt compound_statement
    | attribute_specifier_seq_opt selection_statement
    | attribute_specifier_seq_opt iteration_statement
    | attribute_specifier_seq_opt jump_statement
    | attribute_specifier_seq_opt try_block
    | block_declaration  // declaration_statement
	;

// declaration_statement
//    : block_declaration
//    ;

init_statement
    : expression_statement
    | simple_declaration
	;
	
init_statement_opt
    :  // empty
    | init_statement
    ;
	
condition
    : expression
    | attribute_specifier_seq_opt decl_specifier_seq declarator brace_or_equal_initializer
    ;
	
labeled_statement
    : attribute_specifier_seq_opt IDENTIFIER               COLON statement
    | attribute_specifier_seq_opt CASE constant_expression COLON statement
    | attribute_specifier_seq_opt DEFAULT                  COLON statement
    ;
	
expression_statement
    :            SEMICOLON
    | expression SEMICOLON
    ;
   
compound_statement
    : LBRACE               RBRACE
    | LBRACE statement_seq RBRACE
    ;	

statement_seq
    :               statement
    | statement_seq statement
	;

selection_statement
    : IF           LPAREN init_statement_opt condition RPAREN statement x_else_tail_opt
    | IF CONSTEXPR LPAREN init_statement_opt condition RPAREN statement x_else_tail_opt
    | SWITCH       LPAREN init_statement_opt condition RPAREN statement
	;
	
x_else_tail_opt
    :  // empty
	| ELSE statement
    ;
	
iteration_statement
    : WHILE LPAREN condition RPAREN statement
    | DO statement WHILE LPAREN expression RPAREN SEMICOLON
	
    | FOR LPAREN init_statement           SEMICOLON            RPAREN statement
    | FOR LPAREN init_statement           SEMICOLON expression RPAREN statement
    | FOR LPAREN init_statement condition SEMICOLON            RPAREN statement
    | FOR LPAREN init_statement condition SEMICOLON expression RPAREN statement

    | FOR LPAREN init_statement_opt for_range_declaration COLON expr_or_braced_init_list /* for_range_initializer */ RPAREN statement
    ;
	
for_range_declaration
    : attribute_specifier_seq_opt decl_specifier_seq declarator
    | attribute_specifier_seq_opt decl_specifier_seq ref_qualifier_opt LBRACKET identifier_list RBRACKET
    ;
	
// for_range_initializer
//    : expr_or_braced_init_list
//    ;
	
jump_statement
    : BREAK                              SEMICOLON
	| CONTINUE                           SEMICOLON
	| RETURN                             SEMICOLON
	| RETURN expr_or_braced_init_list    SEMICOLON
    | CO_RETURN                          SEMICOLON   // coroutine_return_statement
	| CO_RETURN expr_or_braced_init_list SEMICOLON   // coroutine_return_statement
    | GOTO IDENTIFIER                    SEMICOLON
	;
	
// coroutine_return_statement:
//    co_return expr_or_braced_init_listopt ;

// A.6 Declarations [gram.dcl]

declaration_seq
    :                 declaration
    | declaration_seq declaration
	;
	
declaration
    : block_declaration
    | nodeclspec_function_declaration
    | function_definition
    | template_declaration
    | deduction_guide
    | explicit_instantiation
    | explicit_specialization
    | export_declaration
    | linkage_specification
    | namespace_definition
    | SEMICOLON  // empty_declaration
    | attribute_specifier_seq SEMICOLON // attribute_declaration
	;
	
// attribute_declaration
//    : attribute_specifier_seq SEMICOLON
//    ;

block_declaration
    : simple_declaration
    | asm_declaration
    | namespace_alias_definition
    | using_declaration
    | using_enum_declaration
    | using_directive
    | static_assert_declaration
    | alias_declaration
    | opaque_enum_declaration
	;
	
nodeclspec_function_declaration
    : attribute_specifier_seq_opt declarator SEMICOLON
	;
	
alias_declaration
    : USING IDENTIFIER attribute_specifier_seq_opt EQUAL defining_type_id SEMICOLON
	;
	
simple_declaration
    :                             decl_specifier_seq                      SEMICOLON
    | attribute_specifier_seq_opt decl_specifier_seq init_declarator_list SEMICOLON
    | attribute_specifier_seq_opt decl_specifier_seq ref_qualifier_opt LBRACKET identifier_list RBRACKET
                                                                                                   initializer SEMICOLON
    ;

identifier_list
    :                       IDENTIFIER
	| identifier_list COMMA IDENTIFIER
	;

static_assert_declaration
    : STATIC_ASSERT LPAREN constant_expression                      RPAREN SEMICOLON
    | STATIC_ASSERT LPAREN constant_expression COMMA STRING_LITERAL RPAREN SEMICOLON
    ;

// empty_declaration
//    : SEMICOLON
//    ;
	
decl_specifier
    : STATIC       // storage_class_specifier
	| THREAD_LOCAL // storage_class_specifier
	| EXTERN       // storage_class_specifier
	| MUTABLE      // storage_class_specifier

    | defining_type_specifier
	
    | VIRTUAL                                                            // function_specifier
    | EXPLICIT                                    // explicit_specifier  // function_specifier
	| EXPLICIT LPAREN constant_expression RPAREN  // explicit_specifier  // function_specifier
	
    | FRIEND
	| TYPEDEF
	| CONSTEXPR
	| CONSTEVAL
	| CONSTINIT
	| INLINE
	;
	
decl_specifier_seq
    : decl_specifier attribute_specifier_seq_opt
    | decl_specifier decl_specifier_seq
	;
	
decl_specifier_seq_opt
    :  // empty
    | decl_specifier_seq
	;
	
// storage_class_specifier
//    : STATIC
//    | THREAD_LOCAL
//    | EXTERN
//    | MUTABLE
//    ;
	
// function_specifier
//    : VIRTUAL
//    | EXPLICIT                                    // explicit_specifier
//    | EXPLICIT LPAREN constant_expression RPAREN  // explicit_specifier
//    ;
	
// explicit_specifier
//    : EXPLICIT
//    | EXPLICIT LPAREN constant_expression RPAREN
//    ;

type_specifier
    : simple_type_specifier
	| elaborated_type_specifier
	| typename_specifier
	| CONST     // cv_qualifier
	| VOLATILE  // cv_qualifier
	;
	
type_specifier_seq
	: type_specifier attribute_specifier_seq_opt
    | type_specifier type_specifier_seq
	;
	
defining_type_specifier
    : type_specifier
    | class_specifier
    | enum_specifier
	;
	
defining_type_specifier_seq
    : defining_type_specifier attribute_specifier_seq_opt
    | defining_type_specifier defining_type_specifier_seq
	;

x_auto_tail
    : AUTO
	| DECLTYPE LPAREN AUTO RPAREN
	;
	
simple_type_specifier
    :                                IDENTIFIER x_template_argument_tail_opt /* type_name */             /* type_constraint */
	|                                IDENTIFIER x_template_argument_tail_opt /* type_name */ x_auto_tail /* type_constraint */
    | nested_name_specifier          IDENTIFIER x_template_argument_tail_opt /* type_name */             /* type_constraint */
    | nested_name_specifier          IDENTIFIER x_template_argument_tail_opt /* type_name */ x_auto_tail /* type_constraint */
//	|                                IDENTIFIER /* template_name */  -- covered by type_name
//	| nested_name_specifier          IDENTIFIER /* template_name */  -- covered by type_name
    | nested_name_specifier TEMPLATE IDENTIFIER x_template_argument_tail /* simple_template_id */
	
    | DECLTYPE LPAREN expression RPAREN // decltype_specifier
	
	| x_auto_tail
	
//  |                 AUTO                         // placeholder_type_specifier
//  | type_constraint AUTO                         // placeholder_type_specifier
//  |                 DECLTYPE LPAREN AUTO RPAREN  // placeholder_type_specifier
//  | type_constraint DECLTYPE LPAREN AUTO RPAREN  // placeholder_type_specifier
	
    | CHAR
    | CHAR8_T
    | CHAR16_T
    | CHAR32_T
    | WCHAR_T
    | BOOL
    | SHORT
    | INT
    | LONG
    | SIGNED
    | UNSIGNED
    | FLOAT
    | DOUBLE
    | VOID
	;
	
// placeholder_type_specifier
//    :                 AUTO
//    | type_constraint AUTO
//    |                 DECLTYPE LPAREN AUTO RPAREN
//    | type_constraint DECLTYPE LPAREN AUTO RPAREN
//    ;

// type_name
//       // enum_name, class_name, typedef_name
//    | IDENTIFIER
//       // class_name, typedef_name
//    | IDENTIFIER x_template_argument_tail /* simple_template_id */
//    ;
	
// Simplified type_name
// type_name
//    : IDENTIFIER x_template_argument_tail_opt
//    ;
	
// class_name
//    : IDENTIFIER
//    | IDENTIFIER x_template_argument_tail // simple_template_id
//    ;

// enum_name
//    : IDENTIFIER
//    ;

// typedef_name
//    : IDENTIFIER
//    | IDENTIFIER x_template_argument_tail /* simple_template_id */
//    ;
	
elaborated_type_specifier
    : class_key attribute_specifier_seq_opt                       IDENTIFIER
	| class_key attribute_specifier_seq_opt nested_name_specifier IDENTIFIER
	| class_key                                IDENTIFIER x_template_argument_tail /* simple_template_id */
    | class_key nested_name_specifier          IDENTIFIER x_template_argument_tail /* simple_template_id */
    | class_key nested_name_specifier TEMPLATE IDENTIFIER x_template_argument_tail /* simple_template_id */
    | elaborated_enum_specifier
	;
	
elaborated_enum_specifier
    : ENUM                       IDENTIFIER
	| ENUM nested_name_specifier IDENTIFIER
	;
	
// decltype_specifier
//    : DECLTYPE LPAREN expression RPAREN
//    ;
	
init_declarator_list
    :                            init_declarator
	| init_declarator_list COMMA init_declarator
	;
	
init_declarator
 // : declarator
	: declarator initializer
    | declarator requires_clause_opt
	;
	
declarator
    : ptr_declarator
    | noptr_declarator parameters_and_qualifiers ARROW type_id // trailing_return_type
    ;
	
ptr_declarator
    : noptr_declarator
    | ptr_operator ptr_declarator
	;
	
noptr_declarator
    :                  declarator_id attribute_specifier_seq_opt

    | noptr_declarator parameters_and_qualifiers

    | noptr_declarator LBRACKET                     RBRACKET attribute_specifier_seq_opt
    | noptr_declarator LBRACKET constant_expression RBRACKET attribute_specifier_seq_opt

    | LPAREN ptr_declarator RPAREN
	;
	
parameters_and_qualifiers
    : LPAREN parameter_declaration_clause RPAREN cv_qualifier_seq_opt
                        	ref_qualifier_opt noexcept_specifier_opt attribute_specifier_seq_opt
    ;
	
// trailing_return_type
//    : ARROW type_id
//    ;

trailing_return_type_opt
    :  // empty
	| ARROW type_id
	;
	
ptr_operator
	: AMPERSAND attribute_specifier_seq_opt
	| AMP_AMP   attribute_specifier_seq_opt

	|                       STAR attribute_specifier_seq_opt cv_qualifier_seq_opt
    | nested_name_specifier STAR attribute_specifier_seq_opt cv_qualifier_seq_opt
	;
	
cv_qualifier_seq_opt
    :  // empty
	| CONST
	| CONST VOLATILE
	| VOLATILE CONST
	| VOLATILE
	;
	
// cv_qualifier_seq
//    : cv_qualifier
//    | cv_qualifier cv_qualifier_seq
//    ;
	
// cv_qualifier
//    : CONST
//    | VOLATILE
//    ;

ref_qualifier_opt
    :  // empty
    | AMPERSAND
	| AMP_AMP
	;

declarator_id
    :          id_expression
	| ELLIPSIS id_expression
	;

type_id
    : type_specifier_seq
	| type_specifier_seq abstract_declarator
	;
	
defining_type_id
    : defining_type_specifier_seq
	| defining_type_specifier_seq abstract_declarator
	;
	
abstract_declarator
    : ptr_abstract_declarator
    |                           parameters_and_qualifiers ARROW type_id // trailing_return_type
	| noptr_abstract_declarator parameters_and_qualifiers ARROW type_id // trailing_return_type
    | abstract_pack_declarator
	;
	
ptr_abstract_declarator
    : noptr_abstract_declarator
	| ptr_operator
    | ptr_operator ptr_abstract_declarator
	;
	
noptr_abstract_declarator
    :                           parameters_and_qualifiers
	| noptr_abstract_declarator parameters_and_qualifiers
	
	|                           LBRACKET                     RBRACKET attribute_specifier_seq_opt
	|                           LBRACKET constant_expression RBRACKET attribute_specifier_seq_opt
	| noptr_abstract_declarator LBRACKET                     RBRACKET attribute_specifier_seq_opt
	| noptr_abstract_declarator LBRACKET constant_expression RBRACKET attribute_specifier_seq_opt
	
    | LPAREN ptr_abstract_declarator RPAREN
	;
	
abstract_pack_declarator
    : noptr_abstract_pack_declarator
    | ptr_operator abstract_pack_declarator
	;
	
noptr_abstract_pack_declarator
    : noptr_abstract_pack_declarator parameters_and_qualifiers
    
    | noptr_abstract_pack_declarator LBRACKET                     RBRACKET attribute_specifier_seq_opt
    | noptr_abstract_pack_declarator LBRACKET constant_expression RBRACKET attribute_specifier_seq_opt
	
    | ELLIPSIS
	;
	
parameter_declaration_clause
    :  // empty
	|                            ELLIPSIS
	| parameter_declaration_list
	| parameter_declaration_list ELLIPSIS
	
    | parameter_declaration_list COMMA ELLIPSIS
	;
	
parameter_declaration_list
    :                                  parameter_declaration
    | parameter_declaration_list COMMA parameter_declaration
	;
	
parameter_declaration
    : attribute_specifier_seq_opt decl_specifier_seq declarator
    | attribute_specifier_seq_opt decl_specifier_seq declarator EQUAL initializer_clause
	
    | attribute_specifier_seq_opt decl_specifier_seq
	| attribute_specifier_seq_opt decl_specifier_seq abstract_declarator
    
	| attribute_specifier_seq_opt decl_specifier_seq                     EQUAL initializer_clause
	| attribute_specifier_seq_opt decl_specifier_seq abstract_declarator EQUAL initializer_clause
	;
	
initializer
    : brace_or_equal_initializer
    | LPAREN expression_list RPAREN
	;
	
brace_or_equal_initializer
    : EQUAL initializer_clause
	| braced_init_list
	;
	
initializer_clause
    : assignment_expression
    | braced_init_list
	;
	
braced_init_list
    : LBRACE initializer_list                  RBRACE
	| LBRACE initializer_list ELLIPSIS         RBRACE
    | LBRACE designated_initializer_list       RBRACE
	| LBRACE designated_initializer_list COMMA RBRACE
	| LBRACE                                   RBRACE
	;
	
initializer_list
    :                        initializer_clause
	|                        initializer_clause ELLIPSIS
    | initializer_list COMMA initializer_clause
	| initializer_list COMMA initializer_clause ELLIPSIS
	;
	
designated_initializer_list
    :                                   designated_initializer_clause
    | designated_initializer_list COMMA designated_initializer_clause
	;
	
designated_initializer_clause
    : DOT IDENTIFIER /*designator*/ brace_or_equal_initializer
	;
	
// designator
//    : DOT IDENTIFIER
//    ;

expr_or_braced_init_list
    : expression
    | braced_init_list
	;
	
function_definition
    : attribute_specifier_seq_opt decl_specifier_seq_opt declarator virt_specifier_seq_opt function_body
    | attribute_specifier_seq_opt decl_specifier_seq_opt declarator requires_clause function_body
	;
	
function_body
    :                            compound_statement
	| COLON mem_initializer_list compound_statement  // ctor_initializer

    | TRY                            compound_statement handler_seq  // function_try_block
	| TRY COLON mem_initializer_list compound_statement handler_seq  // function_try_block

    | EQUAL DEFAULT SEMICOLON
    | EQUAL DELETE  SEMICOLON
	;

// function_try_block
//    : TRY                  compound_statement handler_seq
//    | TRY ctor_initializer compound_statement handler_seq
//    ;

// ctor_initializer
//    : COLON mem_initializer_list
//    ;

enum_specifier
    : enum_head LBRACE                       RBRACE
	| enum_head LBRACE enumerator_list       RBRACE
    | enum_head LBRACE enumerator_list COMMA RBRACE
	;
	
enum_head
    : enum_key attribute_specifier_seq_opt                enum_base_opt
	| enum_key attribute_specifier_seq_opt enum_head_name enum_base_opt
	;
	
enum_head_name
    :                       IDENTIFIER
	| nested_name_specifier IDENTIFIER
	;
	
opaque_enum_declaration
    : enum_key attribute_specifier_seq_opt enum_head_name enum_base_opt SEMICOLON
	;
	
enum_key
    : ENUM
    | ENUM CLASS
    | ENUM STRUCT
	;
	
enum_base_opt
    :  // empty
    | COLON type_specifier_seq
	;
	
enumerator_list
    :                       enumerator_definition
    | enumerator_list COMMA enumerator_definition
	;
	
enumerator_definition
    : enumerator
    | enumerator EQUAL constant_expression
	;
	
enumerator
    : IDENTIFIER attribute_specifier_seq_opt
	;
	
using_enum_declaration
    : USING elaborated_enum_specifier SEMICOLON
	;
	
// namespace_name
//    : IDENTIFIER
//    | namespace_alias
//    ;

namespace_definition
    :        NAMESPACE attribute_specifier_seq_opt enclosing_namespace_specifier_opt namespace_body
	| INLINE NAMESPACE attribute_specifier_seq_opt enclosing_namespace_specifier_opt namespace_body
	;
//    : named_namespace_definition
//    | unnamed_namespace_definition
//    | nested_namespace_definition
//    ;
	
// named_namespace_definition
//    : inlineopt NAMESPACE attribute_specifier_seq_opt IDENTIFIER LBRACE namespace_body RBRACE
//    ;
//	
// unnamed_namespace_definition
//    : inlineopt NAMESPACE attribute_specifier_seq_opt LBRACE namespace_body RBRACE
//    ;
//	
// nested_namespace_definition
//    : NAMESPACE enclosing_namespace_specifier /* COLON_COLON inlineopt IDENTIFIER */ LBRACE namespace_body RBRACE
//    ;
	
enclosing_namespace_specifier
    :                                                  IDENTIFIER
    | enclosing_namespace_specifier COLON_COLON        IDENTIFIER
    | enclosing_namespace_specifier COLON_COLON INLINE IDENTIFIER
    ;
	
enclosing_namespace_specifier_opt
    :  // empty 
	| enclosing_namespace_specifier
    ;
	
namespace_body
    : LBRACE                 RBRACE
	| LBRACE declaration_seq RBRACE
	;
	
//namespace_alias
//    : IDENTIFIER
//    ;
	
namespace_alias_definition
    : NAMESPACE IDENTIFIER EQUAL                       IDENTIFIER /* namespace_name */ SEMICOLON
	| NAMESPACE IDENTIFIER EQUAL nested_name_specifier IDENTIFIER /* namespace_name */ SEMICOLON
	;
	
// qualified_namespace_specifier
//    :                       namespace_name
//    | nested_name_specifier namespace_name
//    ;
	
using_directive
    : attribute_specifier_seq_opt USING NAMESPACE                       IDENTIFIER /* namespace_name */ SEMICOLON
	| attribute_specifier_seq_opt USING NAMESPACE nested_name_specifier IDENTIFIER /* namespace_name */ SEMICOLON
	;
	
using_declaration
    : USING using_declarator_list SEMICOLON
	;
	
using_declarator_list
    :                             using_declarator
	|                             using_declarator ELLIPSIS
    | using_declarator_list COMMA using_declarator
	| using_declarator_list COMMA using_declarator ELLIPSIS
	;
	
using_declarator
    :          nested_name_specifier unqualified_id
	| TYPENAME nested_name_specifier unqualified_id
	;
	
asm_declaration
    : attribute_specifier_seq_opt ASM LPAREN STRING_LITERAL RPAREN SEMICOLON
	;
	
linkage_specification
    : EXTERN STRING_LITERAL LBRACE                 RBRACE
	| EXTERN STRING_LITERAL LBRACE declaration_seq RBRACE
    | EXTERN STRING_LITERAL        declaration
	;

attribute_specifier_seq_opt
    :  // empty
    | attribute_specifier_seq
    ;
	
attribute_specifier_seq
    :                         attribute_specifier
	| attribute_specifier_seq attribute_specifier
	;
	
attribute_specifier
    : LBRACKET LBRACKET                        attribute_list RBRACKET RBRACKET
    | LBRACKET LBRACKET attribute_using_prefix attribute_list RBRACKET RBRACKET
    | alignment_specifier
	;

alignment_specifier
    : ALIGNAS LPAREN type_id                      RPAREN
	| ALIGNAS LPAREN type_id             ELLIPSIS RPAREN
	| ALIGNAS LPAREN constant_expression          RPAREN
	| ALIGNAS LPAREN constant_expression ELLIPSIS RPAREN
	;
	
attribute_using_prefix
    : USING IDENTIFIER /* attribute_namespace */ COLON
	;
	
attribute_list
    :  // empty
	|                      attribute
	|                      attribute ELLIPSIS
	| attribute_list COMMA
    | attribute_list COMMA attribute
	| attribute_list COMMA attribute ELLIPSIS
    ;
	
attribute
    : attribute_token
	| attribute_token attribute_argument_clause
	;
	
attribute_token
    : IDENTIFIER
	| attribute_scoped_token
	;
	
attribute_scoped_token
    : IDENTIFIER /* attribute_namespace */ COLON_COLON IDENTIFIER
	;
	
// attribute_namespace
//    : IDENTIFIER
//    ;
	
attribute_argument_clause
    : LPAREN balanced_token_seq_opt RPAREN
	;
	
balanced_token_seq_opt
    :  // empty
	| balanced_token_seq
	;
	
balanced_token_seq
    :                    balanced_token
    | balanced_token_seq balanced_token
	;
	
balanced_token
    : LPAREN   balanced_token_seq_opt RPAREN
    | LBRACKET balanced_token_seq_opt RBRACKET
    | LBRACE   balanced_token_seq_opt RBRACE
	| STRING_LITERAL  // any token other than a parenthesis, a bracket, or a brace
	;
	
// A.7 Modules [gram.module]

module_declaration
    :        MODULE                              attribute_specifier_seq_opt SEMICOLON
    |        MODULE module_name module_partition attribute_specifier_seq_opt SEMICOLON
    | EXPORT MODULE module_name                  attribute_specifier_seq_opt SEMICOLON
    | EXPORT MODULE module_name module_partition attribute_specifier_seq_opt SEMICOLON
	;
	
module_name
    :                       IDENTIFIER
    | module_name_qualifier IDENTIFIER
	;
	
module_partition
    : COLON                       IDENTIFIER
	| COLON module_name_qualifier IDENTIFIER
	;
	
module_name_qualifier
    :                       IDENTIFIER DOT
    | module_name_qualifier IDENTIFIER DOT
	;
	
export_declaration
    : EXPORT        declaration
    | EXPORT LBRACE                 RBRACE
	| EXPORT LBRACE declaration_seq RBRACE
	;
	
module_import_declaration
    : x_export_import module_name                      attribute_specifier_seq_opt SEMICOLON
    | x_export_import module_partition                 attribute_specifier_seq_opt SEMICOLON
    | x_export_import STRING_LITERAL /* header_name */ attribute_specifier_seq_opt SEMICOLON
	;
	
x_export_import
    :        IMPORT
	| EXPORT IMPORT
	;
	
global_module_fragment_opt
    :  // empty
    | MODULE SEMICOLON
	| MODULE SEMICOLON top_level_declaration_seq
	;
	
// A.8 Classes [gram.class]

class_specifier
    : class_head LBRACE                      RBRACE
	| class_head LBRACE member_specification RBRACE
	;
	
class_head
    : class_key attribute_specifier_seq_opt class_head_name class_virt_specifier_opt base_clause_opt
    | class_key attribute_specifier_seq_opt                                          base_clause_opt
	;
	
class_head_name
                             // class_name
    :                       IDENTIFIER x_template_argument_tail_opt // simple_template_id
    | nested_name_specifier IDENTIFIER x_template_argument_tail_opt // simple_template_id
	;

class_virt_specifier_opt
    :  // empty
	| FINAL
	;

class_key
    : CLASS
	| STRUCT
	| UNION
	;

member_specification
    : member_declaration
	| member_declaration member_specification
    | access_specifier COLON
	| access_specifier COLON member_specification
	;
	
member_declaration
    : attribute_specifier_seq_opt decl_specifier_seq_opt                        SEMICOLON
    | attribute_specifier_seq_opt decl_specifier_seq_opt member_declarator_list SEMICOLON
    | function_definition
    | using_declaration
    | using_enum_declaration
    | static_assert_declaration
    | template_declaration
    | deduction_guide
    | alias_declaration
    | opaque_enum_declaration
    | SEMICOLON  // empty_declaration
	;
	
member_declarator_list
    :                              member_declarator
    | member_declarator_list COMMA member_declarator
	;
	
member_declarator
    : declarator virt_specifier_seq_opt pure_specifier_opt
	
    | declarator requires_clause
	
    | declarator brace_or_equal_initializer
	
    |            attribute_specifier_seq_opt COLON constant_expression
    |            attribute_specifier_seq_opt COLON constant_expression brace_or_equal_initializer
    | IDENTIFIER attribute_specifier_seq_opt COLON constant_expression
    | IDENTIFIER attribute_specifier_seq_opt COLON constant_expression brace_or_equal_initializer
	;
	
// virt_specifier_seq
//    :                    virt_specifier
//    | virt_specifier_seq virt_specifier
//    ;
	
// virt_specifier
//    : OVERRIDE
//    | FINAL
//    ;
	
virt_specifier_seq_opt
    :  // empty
	| OVERRIDE
	| OVERRIDE FINAL
	| FINAL OVERRIDE
	| FINAL
	;
	
pure_specifier_opt
    :  // empty
    | EQUAL_ZERO
	;
	
base_clause_opt
    :  // empty
    | COLON base_specifier_list
	;
	
base_specifier_list
    :                           base_specifier
	|                           base_specifier ELLIPSIS
    | base_specifier_list COMMA base_specifier 
	| base_specifier_list COMMA base_specifier ELLIPSIS
	;
	
base_specifier
    : attribute_specifier_seq_opt                          class_or_decltype
    | attribute_specifier_seq_opt x_virtual_and_access_opt class_or_decltype
	;
	
class_or_decltype
    :                                IDENTIFIER x_template_argument_tail_opt // type_name
	| nested_name_specifier          IDENTIFIER x_template_argument_tail_opt // type_name
    | nested_name_specifier TEMPLATE IDENTIFIER x_template_argument_tail // simple_template_id
	
    | DECLTYPE LPAREN expression RPAREN // decltype_specifier
	;
	
access_specifier
    : PRIVATE
    | PROTECTED
    | PUBLIC
	;
	
x_virtual_and_access_opt
    :  // empty
	| access_specifier
	| access_specifier VIRTUAL
	| VIRTUAL
	| VIRTUAL access_specifier
	;
	
mem_initializer_list
    :                            mem_initializer
	|                            mem_initializer ELLIPSIS
    | mem_initializer_list COMMA mem_initializer
    | mem_initializer_list COMMA mem_initializer ELLIPSIS
	;

mem_initializer
	: mem_initializer_id x_argument_list
    | mem_initializer_id braced_init_list
	;
	
mem_initializer_id
    : class_or_decltype
//  | IDENTIFIER  -- covered by class_or_decltype
	;
	
// A.9 Overloading [gram.over]

// operator_function_id
//    : OPERATOR operator
//    ;
	
operator
    : NEW | DELETE | NEW LBRACKET RBRACKET | DELETE LBRACKET RBRACKET | CO_AWAIT
	| LPAREN RPAREN | LBRACKET RBRACKET | ARROW | ARROW_STAR | TILDE | EXCLAMATION
	| PLUS | MINUS | STAR | SLASH | PERCENT | CARET | AMPERSAND | VERTICAL
	| EQUAL | PLUS_EQUAL | MINUS_EQUAL | STAR_EQUAL | SLASH_EQUAL | PERCENT_EQUAL
	| CARET_EQUAL | AMPERSAND_EQUAL | VERT_EQUAL | EQUAL_EQUAL | EXCL_EQUAL
	| LESS | GREATER | LESS_EQUAL | GREATER_EQUAL | SPACESHIP | AMP_AMP | VERT_VERT
	| LESS_LESS | GREATER_GREATER | LESS_LESS_EQUAL | GREATER_GREATER_EQUAL
	| PLUS_PLUS | MINUS_MINUS | COMMA
	;
// new delete new[] delete[] co_await ( ) [ ] -> ->*
// ~ ! + _ * / % ^ &
// | = += -= *= /= %= ^= &=
// |= == != < > <= >= <=> &&
// || << >> <<= >>= ++ -- ,


// literal_operator_id
//    : OPERATOR STRING_LITERAL IDENTIFIER
//    | OPERATOR user_defined_string_literal
//    ;
	
// A.10 Templates [gram.temp]

template_declaration
    : template_head declaration
    | template_head CONCEPT IDENTIFIER EQUAL constraint_expression SEMICOLON // concept_definition
	;

// concept_definition
//    : CONCEPT concept_name EQUAL constraint_expression SEMICOLON
//    ;
	
template_head
    : TEMPLATE LESS template_parameter_list GREATER requires_clause_opt
	;
	
template_parameter_list
    :                               template_parameter
    | template_parameter_list COMMA template_parameter
	;
	
requires_clause
    : REQUIRES constraint_logical_or_expression
	;
	
requires_clause_opt
    :  // empty
	| requires_clause
	;
	
constraint_logical_or_expression
    :                                            constraint_logical_and_expression
    | constraint_logical_or_expression VERT_VERT constraint_logical_and_expression
	;
	
constraint_logical_and_expression
    :                                           primary_expression
    | constraint_logical_and_expression AMP_AMP primary_expression
	;
	
// concept_name
//    : IDENTIFIER
//    ;
	
type_constraint
    :                       IDENTIFIER x_template_argument_tail_opt
    | nested_name_specifier IDENTIFIER x_template_argument_tail_opt
    ;
	
template_parameter
    : type_parameter
    | parameter_declaration
	;
	
type_parameter
    : type_parameter_key
	| type_parameter_key          IDENTIFIER
	| type_parameter_key ELLIPSIS
	| type_parameter_key ELLIPSIS IDENTIFIER
	
    | type_parameter_key            EQUAL type_id
	| type_parameter_key IDENTIFIER EQUAL type_id
	
    | type_constraint
    | type_constraint          IDENTIFIER
    | type_constraint ELLIPSIS
    | type_constraint ELLIPSIS IDENTIFIER

    | type_constraint            EQUAL type_id
	| type_constraint IDENTIFIER EQUAL type_id
	
    | template_head type_parameter_key
    | template_head type_parameter_key          IDENTIFIER
    | template_head type_parameter_key ELLIPSIS
    | template_head type_parameter_key ELLIPSIS IDENTIFIER

    | template_head type_parameter_key            EQUAL id_expression
    | template_head type_parameter_key IDENTIFIER EQUAL id_expression
	;
	
type_parameter_key
    : CLASS
	| TYPENAME
	;

// simple_template_id
//  // : IDENTIFIER /* template_name */ LESS                        GREATER
//  // | IDENTIFIER /* template_name */ LESS template_argument_list GREATER
//     : IDENTIFIER x_template_argument_tail
//     ;
	
x_template_argument_tail
    : LESS                        GREATER
	| LESS template_argument_list GREATER
	;
	
x_template_argument_tail_opt
    :  // empty
	| x_template_argument_tail
	;
	
// template_name
//    : IDENTIFIER
//    ;
	
template_argument_list
    :                              template_argument
	|                              template_argument ELLIPSIS
    | template_argument_list COMMA template_argument
	| template_argument_list COMMA template_argument ELLIPSIS
	;
	
template_argument
    : constant_expression
    | type_id
//  | id_expression -- seems to be covered by constant_expression
	;
	
constraint_expression
    : logical_or_expression
	;
	
typename_specifier
//  : TYPENAME nested_name_specifier          IDENTIFIER
	                                          // simple_template_id
    : TYPENAME nested_name_specifier          IDENTIFIER /* template_name */ x_template_argument_tail_opt
	                                          // simple_template_id
    | TYPENAME nested_name_specifier TEMPLATE IDENTIFIER /* template_name */ x_template_argument_tail
    ;
	
explicit_instantiation
    :        TEMPLATE declaration
	| EXTERN TEMPLATE declaration
	;
	
explicit_specialization
    : TEMPLATE LESS GREATER declaration
	;
	
deduction_guide
    :          IDENTIFIER /* template_name */ LPAREN parameter_declaration_clause RPAREN
                                              	ARROW IDENTIFIER x_template_argument_tail /* simple_template_id */ SEMICOLON
	| EXPLICIT IDENTIFIER /* template_name */ LPAREN parameter_declaration_clause RPAREN
                                                ARROW IDENTIFIER x_template_argument_tail /* simple_template_id */ SEMICOLON
	;
	
// A.11 Exception handling [gram.except]

try_block
    : TRY compound_statement handler_seq
	;
	
handler_seq
    :             handler
    | handler_seq handler
	;
	
handler
    : CATCH LPAREN exception_declaration RPAREN compound_statement
	;
	
exception_declaration
	: attribute_specifier_seq_opt type_specifier_seq declarator
	
    | attribute_specifier_seq_opt type_specifier_seq
    | attribute_specifier_seq_opt type_specifier_seq abstract_declarator

    | ELLIPSIS
	;
	
noexcept_specifier_opt
    :  // empty
    | NOEXCEPT
	| NOEXCEPT LPAREN constant_expression RPAREN
	;

%%

