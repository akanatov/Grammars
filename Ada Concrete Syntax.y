// Ada Concrete syntax Stage 2
// ===========================
// Следующий этап разработки:
// Удаление избыточных правил и ликвидация наиболее очевидных неоднозначностей.

// ISO/IEC 8652:201z(E) — Ada Reference Manual
// Syntax Summary 18 May 2012 812
//
// Annex P (informative)
// Syntax Summary
//
// This Annex summarizes the complete syntax of the language.
// See 1.1.4 for a description of the notation used.

// 2.8:
// pragma ::=
//     pragma identifier [(pragma_argument_association {, pragma_argument_association})];
//
// 2.8:
// pragma_argument_association ::=
//     [pragma_argument_identifier =>] name
//   | [pragma_argument_identifier =>] expression
//   | pragma_argument_aspect_mark => name
//   | pragma_argument_aspect_mark => expression


%token IDENTIFIER

%token CHARACTER_LITERAL
%token NUMERIC_LITERAL
%token OPERATOR_SYMBOL
%token STRING_LITERAL

%token AMPERSAND
%token APOSTROPH
%token ARROW
%token ASSIGN
%token DOT
%token DOT_DOT
%token EQUAL
%token COLON
%token COMMA
%token GREATER
%token GREATER_EQUAL
%token GREATER_GREATER
%token LESS
%token LESS_EQUAL
%token LESS_GREATER
%token LESS_LESS
%token LPAREN
%token MINUS
%token PLUS
%token RPAREN
%token SEMICOLON
%token SLASH
%token SLASH_EQUAL
%token STAR
%token STAR_STAR
%token VERTICAL

%token ABORT
%token ABS
%token ABSTRACT
%token ACCEPT
%token ACCESS
%token ALIASED
%token ALL
%token AND
%token ARRAY
%token AT
%token BEGIN
%token BODY
%token CASE
%token CONSTANT
%token DECLARE
%token DELAY
%token DELTA
%token DIGITS
%token DO
%token ELSE
%token ELSIF
%token END
%token ENTRY
%token EXCEPTION
%token EXIT
%token FOR
%token FUNCTION
%token GENERIC
%token GOTO
%token IF
%token IN
%token INTERFACE
%token IS
%token LIMITED
%token LOOP
%token MOD
%token NEW
%token NOT
%token NULL
%token OF
%token OR
%token OTHERS
%token OUT
%token OVERRIDING
%token PACKAGE
%token PRIVATE
%token PROCEDURE
%token PROTECTED
%token RAISE
%token RANGE
%token RECORD
%token REM
%token RENAMES
%token REQUEUE
%token RETURN
%token REVERSE
%token SELECT
%token SEPARATE
%token SOME
%token SUBTYPE
%token SYNCHRONIZED
%token TAGGED
%token TASK
%token TERMINATE
%token THEN
%token TYPE
%token UNTIL
%token USE
%token WHEN
%token WHILE
%token WITH
%token XOR

%token Access 
%token Delta
%token Digits
%token Mod
%token Range
//%token By_Entry
//%token By_Protected_Procedure
//%token Optional
%token Class

%start compilation

%%

// 3.1:
// basic_declaration ::=
//     type_declaration | subtype_declaration
//   | object_declaration | number_declaration
//   | subprogram_declaration | abstract_subprogram_declaration
//   | null_procedure_declaration | expression_function_declaration
//   | package_declaration | renaming_declaration
//   | exception_declaration | generic_declaration
//   | generic_instantiation

basic_declaration

    : type_declaration
	
      // subtype_declaration
    | SUBTYPE IDENTIFIER IS subtype_indication x_aspect_specification_opt SEMICOLON
	
    | object_declaration
	
	  // number_declaration
    | defining_identifier_list COLON CONSTANT ASSIGN expression SEMICOLON
	
    | subprogram_declaration
	
    | x_overriding_indicator_opt subprogram_specification IS ABSTRACT                 x_aspect_specification_opt SEMICOLON  // abstract_subprogram_declaration
    | x_overriding_indicator_opt procedure_specification  IS NULL                     x_aspect_specification_opt SEMICOLON  // null_procedure_declaration
    | x_overriding_indicator_opt function_specification   IS LPAREN expression RPAREN x_aspect_specification_opt SEMICOLON  // expression_function_declaration
	
    | package_specification SEMICOLON  // package_declaration
    | renaming_declaration
	
      // exception_declaration
    | defining_identifier_list COLON EXCEPTION x_aspect_specification_opt SEMICOLON
	
    | generic_declaration
    | generic_instantiation	
    ;

// 3.1:
// defining_identifier ::= identifier
//
// 3.2.1:
// type_declaration ::= full_type_declaration
//   | incomplete_type_declaration
//   | private_type_declaration
//   | private_extension_declaration

type_declaration
      // full_type_declaration
    : TYPE IDENTIFIER x_known_discriminant_part_opt IS type_definition x_aspect_specification_opt SEMICOLON
      // task_type_declaration
    | TASK TYPE IDENTIFIER x_known_discriminant_part_opt x_aspect_specification_opt x_task_tail_opt SEMICOLON
      // protected_type_declaration
    | PROTECTED TYPE IDENTIFIER x_known_discriminant_part_opt x_aspect_specification_opt IS
          x_protected_new_tail_opt protected_definition SEMICOLON	  
      // incomplete_type_declaration
    | TYPE IDENTIFIER x_discriminant_part_opt x_is_tagged_opt SEMICOLON
      // private_type_declaration
    | TYPE IDENTIFIER x_discriminant_part_opt IS x_abstract_tagged_opt x_limited_opt PRIVATE x_aspect_specification_opt SEMICOLON
      // private_extension_declaration
    | TYPE IDENTIFIER x_discriminant_part_opt IS x_abstract_opt x_limited_sync_opt NEW subtype_indication
           x_and_interface_opt WITH PRIVATE x_aspect_specification_opt SEMICOLON	  
    ;

// 3.2.1:
// full_type_declaration ::=
//     type defining_identifier [known_discriminant_part] is type_definition [aspect_specification];
//   | task_type_declaration
//   | protected_type_declaration

// full_type_declaration
//    : TYPE IDENTIFIER x_known_discriminant_part_opt IS type_definition x_aspect_specification_opt SEMICOLON
//    | task_type_declaration
//    | protected_type_declaration
//    ;

// 3.2.1:
// type_definition ::=
//     enumeration_type_definition | integer_type_definition
//   | real_type_definition | array_type_definition
//   | record_type_definition | access_type_definition
//   | derived_type_definition | interface_type_definition

type_definition
      // enumeration_type_definition
    : LPAREN x_enumeration_literal_specification_list RPAREN	  
	
      // integer_type_definition
    | RANGE simple_expression DOT_DOT simple_expression // signed_integer_type_definition
    | MOD expression                                    // modular_type_definition
	  
      // real_type_definition
          // floating_point_definition
    | DIGITS expression x_real_range_specification_opt
          // fixed_point_definition
    | DELTA expression real_range_specification // ordinary_fixed_point_definition
    | DELTA expression DIGITS expression x_real_range_specification_opt // decimal_fixed_point_definition
	  
    | array_type_definition
    | record_type_definition
    | access_type_definition
    | derived_type_definition
    | interface_type_definition
    ;

// 3.2.2:
// subtype_declaration ::=
//     subtype defining_identifier is subtype_indication [aspect_specification];

// subtype_declaration
//    : SUBTYPE IDENTIFIER IS subtype_indication x_aspect_specification_opt SEMICOLON
//    ;

// 3.2.2:
// subtype_indication ::= [null_exclusion] subtype_mark [constraint]

subtype_indication
     : x_null_exclusion_opt name /*subtype_mark*/ constraint_opt
	 ;

// 3.2.2:
// subtype_mark ::= subtype_name

//subtype_mark
//    : name
//    ;

// 3.2.2:
// constraint ::= scalar_constraint | composite_constraint

constraint_opt
      // scalar_constraint
    : x_range_constraint_opt
    | DIGITS expression x_range_constraint_opt // digits_constraint
    | DELTA expression x_range_constraint_opt  // delta_constraint
		  
      // composite_constraint
    | index_constraint
    | discriminant_constraint
    ;

// 3.2.2:
// scalar_constraint ::=
//     range_constraint | digits_constraint | delta_constraint

//scalar_constraint
//    : range_constraint
//    | digits_constraint
//    | delta_constraint
//    ;

// 3.2.2:
// composite_constraint ::=
//     index_constraint | discriminant_constraint

//composite_constraint
//    : index_constraint
//    | discriminant_constraint
//    ;

// 3.3.1:
// object_declaration ::=
//     defining_identifier_list : [aliased] [constant] subtype_indication [:= expression] [aspect_specification];
//   | defining_identifier_list : [aliased] [constant] access_definition [:= expression] [aspect_specification];
//   | defining_identifier_list : [aliased] [constant] array_type_definition [:= expression] [aspect_specification];
//   | single_task_declaration
//   | single_protected_declaration

object_declaration
    : defining_identifier_list COLON x_aliased_opt x_constant_opt x_object_type x_initializer_opt x_aspect_specification_opt SEMICOLON
	   // single_task_declaration
    | TASK IDENTIFIER x_aspect_specification_opt x_task_tail_opt SEMICOLON 
	   // single_protected_declaration
    | PROTECTED IDENTIFIER x_aspect_specification_opt IS x_protected_new_tail_opt protected_definition SEMICOLON
    ;
	
x_object_type
    : subtype_indication
    | access_definition
    | array_type_definition
    ;
	
x_initializer_opt
    :  // empty
    | ASSIGN expression
    ;

x_aliased_opt
    :  // empty
    | ALIASED
    ;

x_constant_opt
    :  // empty
    | CONSTANT
    ;
	
// 3.3.1:
// defining_identifier_list ::=
//     defining_identifier {, defining_identifier}

defining_identifier_list
    :                                IDENTIFIER
    | defining_identifier_list COMMA IDENTIFIER
    ;
	
// 3.3.2:
// number_declaration ::=
//     defining_identifier_list : constant := static_expression;

// number_declaration
//    : defining_identifier_list COLON CONSTANT ASSIGN expression SEMICOLON
//    ;

// 3.4:
// derived_type_definition ::=
//     [abstract] [limited] new parent_subtype_indication [[and interface_list] record_extension_part]

derived_type_definition
    : x_abstract_opt x_limited_opt NEW subtype_indication x_derived_type_tail_opt
    ;
	
x_abstract_opt
    :  // empty
    | ABSTRACT
    ;
	
x_limited_opt
    :  // empty
    | LIMITED
    ;
	
x_derived_type_tail_opt
    :  // empty
    |                    WITH record_definition /*record_extension_part*/
    | AND interface_list WITH record_definition /*record_extension_part*/
    ;

// 3.5:
// range_constraint ::= range range

x_range_constraint_opt
    :  // empty
    | RANGE range   // range_constraint
    ;

// range_constraint
//    : RANGE range
//    ;
	
// 3.5:
// range ::= range_attribute_reference
//    | simple_expression .. simple_expression

range
    : name APOSTROPH Range x_attribute_designator_tail_opt // range_attribute_designator // range_attribute_reference
    | simple_expression DOT_DOT simple_expression
    ;

// 3.5.1:
// enumeration_type_definition ::=
//     (enumeration_literal_specification {, enumeration_literal_specification})

// enumeration_type_definition
//    : LPAREN x_enumeration_literal_specification_list RPAREN
//    ;
	
x_enumeration_literal_specification_list
    :                                                enumeration_literal_specification
    | x_enumeration_literal_specification_list COMMA enumeration_literal_specification
    ;

// 3.5.1:
// enumeration_literal_specification ::= defining_identifier | defining_character_literal

enumeration_literal_specification
    : IDENTIFIER
    | CHARACTER_LITERAL
    ;

// 3.5.1:
// defining_character_literal ::= character_literal

//defining_character_literal
//    : character_literal
//    ;

// 3.5.4:
// integer_type_definition ::= signed_integer_type_definition | modular_type_definition

//integer_type_definition
//    : RANGE simple_expression DOT_DOT simple_expression // signed_integer_type_definition
//    | MOD expression // modular_type_definition
//    ;

// 3.5.4:
// signed_integer_type_definition ::= range static_simple_expression .. static_simple_expression

//signed_integer_type_definition
//    : RANGE simple_expression DOT_DOT simple_expression
//    ;

// 3.5.4:
// modular_type_definition ::= mod static_expression

//modular_type_definition
//    : MOD expression
//    ;

// 3.5.6:
// real_type_definition ::=
//     floating_point_definition | fixed_point_definition

// real_type_definition
//      // floating_point_definition
//    : DIGITS expression x_real_range_specification_opt
//      // fixed_point_definition
//    | DELTA expression real_range_specification // ordinary_fixed_point_definition
//    | DELTA expression DIGITS expression x_real_range_specification_opt // decimal_fixed_point_definition
//    ;

// 3.5.7:
// floating_point_definition ::=
//     digits static_expression [real_range_specification]

//floating_point_definition
//    : DIGITS expression x_real_range_specification_opt
//    ;

// 3.5.7:
// real_range_specification ::=
//    range static_simple_expression .. static_simple_expression

x_real_range_specification_opt
    :  // empty
	| RANGE simple_expression DOT_DOT simple_expression  // real_range_specification
    ;

real_range_specification
    : RANGE simple_expression DOT_DOT simple_expression
    ;

// 3.5.9:
// fixed_point_definition ::= ordinary_fixed_point_definition | decimal_fixed_point_definition

//fixed_point_definition
//    : DELTA expression real_range_specification // ordinary_fixed_point_definition
//    | DELTA expression DIGITS expression x_real_range_specification_opt // decimal_fixed_point_definition
//    ;

// 3.5.9:
// ordinary_fixed_point_definition ::=
//     delta static_expression real_range_specification

//ordinary_fixed_point_definition
//    : DELTA expression real_range_specification
//    ;

// 3.5.9:
// decimal_fixed_point_definition ::=
//     delta static_expression digits static_expression [real_range_specification]

//decimal_fixed_point_definition
//    : DELTA expression DIGITS expression x_real_range_specification_opt
//    ;

// 3.5.9:
// digits_constraint ::=
//     digits static_expression [range_constraint]

//digits_constraint
//    : DIGITS expression x_range_constraint_opt
//    ;

// 3.6:
// array_type_definition ::=
//     unconstrained_array_definition | constrained_array_definition

array_type_definition
    : ARRAY LPAREN x_index_subtype_definition_list    RPAREN OF component_definition // unconstrained_array_definition
    | ARRAY LPAREN x_discrete_subtype_definition_list RPAREN OF component_definition // constrained_array_definition
    ;

// 3.6:
// unconstrained_array_definition ::=
//     array(index_subtype_definition {, index_subtype_definition}) of component_definition

// unconstrained_array_definition
//    : ARRAY LPAREN x_index_subtype_definition_list RPAREN OF component_definition
//    ;

// 3.6:
// index_subtype_definition ::= subtype_mark range <>

// index_subtype_definition
//    : name /*subtype_mark*/ RANGE LESS_GREATER
//    ;

x_index_subtype_definition_list
    :                                       name RANGE LESS_GREATER /*index_subtype_definition*/
    | x_index_subtype_definition_list COMMA name RANGE LESS_GREATER /*index_subtype_definition*/
    ;

// 3.6:
// constrained_array_definition ::=
//     array (discrete_subtype_definition {, discrete_subtype_definition}) of component_definition

// constrained_array_definition
//    : ARRAY LPAREN x_discrete_subtype_definition_list RPAREN OF component_definition
//    ;

x_discrete_subtype_definition_list
    :                                          discrete_subtype_definition
    | x_discrete_subtype_definition_list COMMA discrete_subtype_definition
    ;

// 3.6:
// discrete_subtype_definition ::= discrete_subtype_indication | range

discrete_subtype_definition
    : subtype_indication
    | range
    ;

// 3.6:
// component_definition ::=
//     [aliased] subtype_indication
//   | [aliased] access_definition

component_definition
    : x_aliased_opt subtype_indication
    | x_aliased_opt access_definition
    ;
	
// 3.6.1:
// index_constraint ::= (discrete_range {, discrete_range})

index_constraint
    : LPAREN x_discrete_range_list RPAREN
    ;

x_discrete_range_list
    :                             discrete_range
    | x_discrete_range_list COMMA discrete_range
    ;

// 3.6.1:
// discrete_range ::= discrete_subtype_indication | range

discrete_range
    : subtype_indication
    | range
    ;

// 3.7:
// discriminant_part ::= unknown_discriminant_part | known_discriminant_part

x_discriminant_part_opt
    :  // empty
    | LPAREN LESS_GREATER RPAREN // unknown_discriminant_part
    | known_discriminant_part
    ;

// 3.7:
// unknown_discriminant_part ::= (<>)

//unknown_discriminant_part
//    : LPAREN LESS_GREATER RPAREN
//    ;

// 3.7:
// known_discriminant_part ::=
//    (discriminant_specification {; discriminant_specification})

x_known_discriminant_part_opt
    :  // empty
    | known_discriminant_part
    ;

known_discriminant_part
    : LPAREN discriminant_specification_seq RPAREN
    ;

discriminant_specification_seq
    :                                          discriminant_specification
    | discriminant_specification_seq SEMICOLON discriminant_specification
    ;

// 3.7:
// discriminant_specification ::=
//     defining_identifier_list : [null_exclusion] subtype_mark [:= default_expression]
//   | defining_identifier_list : access_definition [:= default_expression]

discriminant_specification
    : defining_identifier_list COLON x_null_exclusion_opt name /*subtype_mark*/ x_initializer_opt
    | defining_identifier_list COLON                      access_definition     x_initializer_opt
    ;

// 3.7:
// default_expression ::= expression

// 3.7.1:
// discriminant_constraint ::=
//     (discriminant_association {, discriminant_association})

discriminant_constraint
    : LPAREN x_discriminant_association_list RPAREN
    ;

x_discriminant_association_list
    :                                       discriminant_association
    | x_discriminant_association_list COMMA discriminant_association
    ;

// 3.7.1:
// discriminant_association ::=
//     [discriminant_selector_name {| discriminant_selector_name} =>] expression

discriminant_association
    :                            expression
    | x_selector_name_list ARROW expression
    ;
	
x_selector_name_list
    :                               selector_name
    | x_selector_name_list VERTICAL selector_name
    ;

// 3.8:
// record_type_definition ::= [[abstract] tagged] [limited] record_definition

record_type_definition
    : x_abstract_opt TAGGED x_limited_opt record_definition
    |                       x_limited_opt record_definition
    ;

// 3.8:
// record_definition ::=
//     record
//     component_list
//     end record
//   | null record

record_definition
    : RECORD component_list END RECORD
    | NULL RECORD
    ;

// 3.8:
// component_list ::=
//     component_item {component_item}
//   | {component_item} variant_part
//   | null;

component_list
    : x_component_item_seq
    | x_component_item_seq variant_part
	|                      variant_part
    | NULL SEMICOLON
    ;

x_component_item_seq
    :                      component_item
    | x_component_item_seq component_item
    ;

// 3.8:
// component_item ::= component_declaration | aspect_clause

component_item
    : component_declaration
    | aspect_clause
    ;

// 3.8:
// component_declaration ::=
//     defining_identifier_list : component_definition [:= default_expression] [aspect_specification];

component_declaration
    : defining_identifier_list COLON component_definition x_initializer_opt x_aspect_specification_opt SEMICOLON
    ;

// 3.8.1:
// variant_part ::=
//     case discriminant_direct_name is
//        variant {variant}
//     end case;

variant_part
    : CASE direct_name IS x_variant_seq END CASE SEMICOLON
    ;
	
x_variant_seq
    :               variant
    | x_variant_seq variant
    ;

// 3.8.1:
// variant ::=
//     when discrete_choice_list => component_list

variant
    : WHEN discrete_choice_list ARROW component_list
    ;

// 3.8.1:
// discrete_choice_list ::= discrete_choice {| discrete_choice}

discrete_choice_list
    :                               discrete_choice
    | discrete_choice_list VERTICAL discrete_choice
    ;

// 3.8.1:
// discrete_choice ::= choice_expression | discrete_subtype_indication | range | others

discrete_choice
    : choice_expression
    | subtype_indication
    | range
    | OTHERS
    ;

// 3.9.1:
// record_extension_part ::= with record_definition

// record_extension_part
//    : WITH record_definition
//    ;

// 3.9.3:
// abstract_subprogram_declaration ::=
//     [overriding_indicator] subprogram_specification is abstract [aspect_specification];

// abstract_subprogram_declaration
//    : x_overriding_indicator_opt subprogram_specification IS ABSTRACT x_aspect_specification_opt SEMICOLON
//    ;

// 3.9.4:
// interface_type_definition ::=
//     [limited | task | protected | synchronized] interface [and interface_list]

interface_type_definition
    : x_interface_specifier_opt INTERFACE x_interface_tail_opt
    ;
	
x_interface_specifier_opt
    :  // empty
    | LIMITED
    | TASK
    | PROTECTED
    | SYNCHRONIZED
    ;

x_interface_tail_opt
    :  // empty
    | AND interface_list
    ;

// 3.9.4:
// interface_list ::= interface_subtype_mark {and interface_subtype_mark}

interface_list
    :                    name /*subtype_mark*/
    | interface_list AND name /*subtype_mark*/
    ;

// 3.10:
// access_type_definition ::=
//     [null_exclusion] access_to_object_definition
//   | [null_exclusion] access_to_subprogram_definition

access_type_definition
                           //  access_to_object_definition
    : x_null_exclusion_opt ACCESS x_general_access_modifier_opt subtype_indication
	                       // access_to_subprogram_definition
    | x_null_exclusion_opt ACCESS x_protected_opt PROCEDURE parameter_profile
    | x_null_exclusion_opt ACCESS x_protected_opt FUNCTION  parameter_and_result_profile
    ;

// 3.10:
// access_to_object_definition ::=
//     access [general_access_modifier] subtype_indication

//access_to_object_definition
//    : ACCESS x_general_access_modifier_opt subtype_indication
//    ;

// 3.10:
// general_access_modifier ::= all | constant

x_general_access_modifier_opt
    :  // empty
    | ALL
    | CONSTANT
    ;

// 3.10:
// access_to_subprogram_definition ::=
//     access [protected] procedure parameter_profile
//   | access [protected] function parameter_and_result_profile

//access_to_subprogram_definition
//    : ACCESS x_protected_opt PROCEDURE parameter_profile
//    | ACCESS x_protected_opt FUNCTION  parameter_and_result_profile
//    ;

x_protected_opt
    :  // empty
    | PROTECTED
    ;
	
// 3.10:
// null_exclusion ::= not null

x_null_exclusion_opt
    :  // empty
    | NOT NULL
    ;
	
// 3.10:
// access_definition ::=
//     [null_exclusion] access [constant] subtype_mark
//   | [null_exclusion] access [protected] procedure parameter_profile
//   | [null_exclusion] access [protected] function parameter_and_result_profile

access_definition
    : x_null_exclusion_opt ACCESS x_constant_opt  name /*subtype_mark*/
    | x_null_exclusion_opt ACCESS x_protected_opt PROCEDURE parameter_profile
    | x_null_exclusion_opt ACCESS x_protected_opt FUNCTION  parameter_and_result_profile
    ;

// 3.10.1:
// incomplete_type_declaration ::= type defining_identifier [discriminant_part] [is tagged];

// incomplete_type_declaration
//    : TYPE IDENTIFIER x_discriminant_part_opt x_is_tagged_opt SEMICOLON
//    ;
	
x_is_tagged_opt
    :  // empty
    | IS TAGGED
    ;

// 3.11:
// declarative_part ::= {declarative_item}

declarative_part
    :  // empty
    |  x_declarative_item_seq
    ;
	
x_declarative_item_seq
    :                        declarative_item
    | x_declarative_item_seq declarative_item
    ;

// 3.11:
// declarative_item ::=
//     basic_declarative_item | body

declarative_item
    : basic_declarative_item
    | body
    ;

// 3.11:
// basic_declarative_item ::=
//     basic_declaration | aspect_clause | use_clause

basic_declarative_item
    : basic_declaration
    | aspect_clause
    | use_clause
    ;

// 3.11:
// body ::= proper_body | body_stub

body
    : proper_body
    | body_stub
    ;

// 3.11:
// proper_body ::=
//     subprogram_body | package_body | task_body | protected_body

proper_body
    : subprogram_body
    | package_body
    | task_body
    | protected_body
    ;

// 4.1:
// name ::=
//     direct_name | explicit_dereference
//   | indexed_component | slice
//   | selected_component | attribute_reference
//   | type_conversion | function_call
//   | character_literal | qualified_expression
//   | generalized_reference | generalized_indexing

name
    : direct_name
    | name DOT ALL                         // explicit_dereference
//  | name LPAREN x_expression_list RPAREN // indexed_component   -- the branch is covered by 'function_call' branch
    | name LPAREN discrete_range RPAREN    // slice
    | name DOT selector_name               // selected_component
    | name APOSTROPH attribute_designator  // attribute_reference
//  | name /*subtype_mark*/ LPAREN expression RPAREN // type_conversion  -- the branch is covered by 'function_call'
    | name actual_parameter_part           // function_call
    | CHARACTER_LITERAL
    | qualified_expression
//  | generalized_reference
//  | name actual_parameter_part // generalized_indexing  -- the branch is covered by 'function_call'
    ;

// 4.1:
// direct_name ::= identifier | operator_symbol

direct_name
    : IDENTIFIER
    | OPERATOR_SYMBOL
    ;

// 4.1:
// prefix ::= name | implicit_dereference

// prefix
//    : name
//    | implicit_dereference
//    ;

// 4.1:
// explicit_dereference ::= name.all

// explicit_dereference
//     : name DOT ALL
//     ;
	
// 4.1:
// implicit_dereference ::= name

// implicit_dereference
//     : name
//     ;

// 4.1.1:
// indexed_component ::= prefix(expression {, expression})

// indexed_component
//     : prefix LPAREN x_expression_list RPAREN
//     ;

// 4.1.2:
// slice ::= prefix(discrete_range)

// slice
//     : prefix LPAREN discrete_range RPAREN
//     ;

// 4.1.3:
// selected_component ::= prefix . selector_name

// selected_component
//     : prefix DOT selector_name
//     ;

// 4.1.3:
// selector_name ::= identifier | character_literal | operator_symbol

selector_name
    : IDENTIFIER
    | CHARACTER_LITERAL
    | OPERATOR_SYMBOL
    ;

// 4.1.4:
// attribute_reference ::= prefix'attribute_designator

// attribute_reference
//    : prefix APOSTROPH attribute_designator
//    ;

// 4.1.4:
// attribute_designator ::=
//     identifier[(static_expression)]
//   | Access | Delta | Digits | Mod

attribute_designator
    : IDENTIFIER x_attribute_designator_tail_opt
    | Access 
    | Delta
    | Digits
    | Mod
    ;

x_attribute_designator_tail_opt
    :  // empty
    | LPAREN expression RPAREN
    ;

// 4.1.4:
// range_attribute_reference ::= prefix'range_attribute_designator/

// range_attribute_reference
//    : prefix APOSTROPH Range x_attribute_designator_tail_opt // range_attribute_designator
//    ;

// 4.1.4:
// range_attribute_designator ::= Range[(static_expression)]

// range_attribute_designator
//     : Range x_attribute_designator_tail_opt
//     ;

// 4.1.5:
// generalized_reference ::= reference_object_name

// generalized_reference
//     : name
//     ;

// 4.1.6:
// generalized_indexing ::= indexable_container_object_prefix actual_parameter_part

//generalized_indexing
//    : prefix actual_parameter_part
//    ;

// 4.3:
// aggregate ::= record_aggregate | extension_aggregate | array_aggregate

aggregate
    : record_aggregate
    | extension_aggregate
    | array_aggregate
    ;

// 4.3.1:
// record_aggregate ::= (record_component_association_list)

record_aggregate
    : LPAREN record_component_association_list RPAREN
    ;

// 4.3.1:
// record_component_association_list ::=
//     record_component_association {, record_component_association}
//   | null record

record_component_association_list
    : x_record_component_association_list
    | NULL RECORD
    ;
	
x_record_component_association_list
    :                                           record_component_association
    | x_record_component_association_list COMMA record_component_association
    ;

// 4.3.1:
// record_component_association ::=
//     [component_choice_list =>] expression
//   | component_choice_list => <>

record_component_association
    :                             expression
    | component_choice_list ARROW expression
    | component_choice_list ARROW LESS_GREATER
    ;

// 4.3.1:
// component_choice_list ::=
//     component_selector_name {| component_selector_name}
//   | others

component_choice_list
    : x_component_choice_list
    | OTHERS
    ;
	
x_component_choice_list	
    :                                  selector_name
    | x_component_choice_list VERTICAL selector_name
    ;

// 4.3.2:
// extension_aggregate ::=
//     (ancestor_part with record_component_association_list)

extension_aggregate
    : LPAREN ancestor_part WITH record_component_association_list RPAREN
    ;

// 4.3.2:
// ancestor_part ::= expression | subtype_mark

ancestor_part
    : expression
//  | name /*subtype_mark*/
    ;
	
// 4.3.3:
// array_aggregate ::=
//     positional_array_aggregate | named_array_aggregate

array_aggregate
    : positional_array_aggregate
    | named_array_aggregate
    ;

// 4.3.3:
// positional_array_aggregate ::=
//     (expression, expression {, expression})
//   | (expression {, expression}, others => expression)
//   | (expression {, expression}, others => <>)

// Simplified
positional_array_aggregate
    : LPAREN x_expression_list x_others_tail_opt RPAREN
    ;

x_expression_list
    :                         expression
    | x_expression_list COMMA expression
    ;

x_others_tail_opt
    :  // empty
    | COMMA OTHERS ARROW expression
    | COMMA OTHERS ARROW LESS_GREATER
    ;

// 4.3.3:
// named_array_aggregate ::=
//     (array_component_association {, array_component_association})

named_array_aggregate
    : LPAREN x_array_component_association_list RPAREN
    ;

x_array_component_association_list
    :                                          array_component_association
    | x_array_component_association_list COMMA array_component_association
    ;

// 4.3.3:
// array_component_association ::=
//     discrete_choice_list => expression
//   | discrete_choice_list => <>

array_component_association
    : discrete_choice_list ARROW expression
    | discrete_choice_list ARROW LESS_GREATER
    ;

// 4.4:
// expression ::=
//     relation {and relation} | relation {and then relation}
//   | relation {or relation} | relation {or else relation}
//   | relation {xor relation}

expression
    :                            relation
    | expression x_bool_operator relation
    ;
	
x_bool_operator
    : AND
    | AND THEN
    | OR
    | OR ELSE
    | XOR
    ;

// 4.4:
// choice_expression ::=
//     choice_relation {and choice_relation}
//   | choice_relation {or choice_relation}
//   | choice_relation {xor choice_relation}
//   | choice_relation {and then choice_relation}
//   | choice_relation {or else choice_relation}

choice_expression
    :                                   choice_relation
    | choice_expression x_bool_operator choice_relation
    ;

// 4.4:
// choice_relation ::=
// simple_expression [relational_operator simple_expression]

choice_relation
    : simple_expression x_relational_tail_opt
    ;

x_relational_tail_opt
    :  // empty
    | relational_operator simple_expression
    ;

// 4.4:
// relation ::=
//     simple_expression [relational_operator simple_expression]
//   | simple_expression [not] in membership_choice_list

relation
    : simple_expression x_relational_tail_opt
    | simple_expression     IN membership_choice_list
    | simple_expression NOT IN membership_choice_list
    ;

// 4.4:
// membership_choice_list ::= membership_choice {| membership_choice}

membership_choice_list
    :                                 membership_choice
    | membership_choice_list VERTICAL membership_choice
    ;

// 4.4:
// membership_choice ::= choice_expression | range | subtype_mark

membership_choice
    : choice_expression
    | range
    | name /*subtype_mark*/
    ;

// 4.4:
// simple_expression ::= [unary_adding_operator] term {binary_adding_operator term}

simple_expression
    :                       x_binary_adding_list
    | unary_adding_operator x_binary_adding_list
    ;
	
x_binary_adding_list
    :                                             term
    | x_binary_adding_list binary_adding_operator term
    ;

// 4.4:
// term ::= factor {multiplying_operator factor}

term
    :                           factor
    | term multiplying_operator factor
    ;

// 4.4:
// factor ::= primary [** primary] | abs primary | not primary

factor
    :     primary x_power_tail_opt
    | ABS primary
    | NOT primary
    ;

x_power_tail_opt
    :  // empty
    | STAR_STAR primary
    ;

// 4.4:
// primary ::=
//     numeric_literal | null | string_literal | aggregate
//   | name | allocator | (expression)
//   | (conditional_expression) | (quantified_expression)

primary
    : NUMERIC_LITERAL
    | NULL
    | STRING_LITERAL
    | aggregate
    | name
    | allocator
    | LPAREN expression             RPAREN
    | LPAREN conditional_expression RPAREN
    | LPAREN quantified_expression  RPAREN
    ;

// 4.5:
// logical_operator ::= and | or | xor

// NOT NEEDED

// 4.5:
// relational_operator ::= = | /= | < | <= | > | >=

relational_operator
    : EQUAL
    | SLASH_EQUAL
    | LESS
    | LESS_EQUAL
    | GREATER
    | GREATER_EQUAL
    ;

// 4.5:
// binary_adding_operator ::= + | – | &

binary_adding_operator
    : PLUS
    | MINUS
    | AMPERSAND
    ;

// 4.5:
// unary_adding_operator ::= + | –

unary_adding_operator
    : PLUS
    | MINUS
    ;

// 4.5:
// multiplying_operator ::= * | / | mod | rem

multiplying_operator
    : STAR
    | SLASH
    | MOD
    | REM
    ;

// 4.5:
// highest_precedence_operator ::= ** | abs | not

// NOT NEEDED

// 4.5.7:
// conditional_expression ::= if_expression | case_expression

conditional_expression
    : if_expression
    | case_expression
    ;

// 4.5.7:
// if_expression ::=
//     if condition then dependent_expression
//     {elsif condition then dependent_expression}
//     [else dependent_expression]

if_expression
    : IF expression THEN expression              x_else_tail_opt
    | IF expression THEN expression x_elsif_list x_else_tail_opt
    ;

x_elsif_list
    :              x_elsif
    | x_elsif_list x_elsif
    ;

x_elsif
    : ELSIF expression THEN expression
    ;

x_else_tail_opt
    :  // empty
    | ELSE expression
    ;

// 4.5.7:
// condition ::= boolean_expression

// condition
//    : expression
//    ;

// 4.5.7:
// case_expression ::=
//     case selecting_expression is case_expression_alternative {, case_expression_alternative}

case_expression
    : CASE expression IS x_case_expression_alternative_list
    ;

x_case_expression_alternative_list
    :                                          case_expression_alternative
    | x_case_expression_alternative_list COMMA case_expression_alternative
    ;

// 4.5.7:
// case_expression_alternative ::=
//     when discrete_choice_list => dependent_expression

case_expression_alternative
    : WHEN discrete_choice_list ARROW expression
    ;

// 4.5.8:
// quantified_expression ::= for quantifier loop_parameter_specification => predicate
//     | for quantifier iterator_specification => predicate

quantified_expression
    : FOR quantifier loop_parameter_specification ARROW predicate
    | FOR quantifier iterator_specification       ARROW predicate

// 4.5.8:
// quantifier ::= all | some

quantifier
    : ALL
    | SOME
    ;

// 4.5.8:
// predicate ::= boolean_expression

predicate
    : expression
    ;

// 4.6:
// type_conversion ::=
//     subtype_mark(expression)
//   | subtype_mark(name)

// type_conversion
//    : name /*subtype_mark*/ LPAREN expression RPAREN
//    | name /*subtype_mark*/ LPAREN name       RPAREN
//    ;

// 4.7:
// qualified_expression ::=
//     subtype_mark'(expression) | subtype_mark'aggregate

qualified_expression
    : name /*subtype_mark*/ APOSTROPH LPAREN expression RPAREN
    | name /*subtype_mark*/ APOSTROPH aggregate
    ;

// 4.8:
// allocator ::=
//     new [subpool_specification] subtype_indication
//   | new [subpool_specification] qualified_expression

allocator
    : NEW x_subpool_specification_opt subtype_indication
    | NEW x_subpool_specification_opt qualified_expression

// 4.8:
// subpool_specification ::= (subpool_handle_name)

x_subpool_specification_opt
    :  // empty
    | LPAREN name RPAREN
    ;

// 5.1:
// sequence_of_statements ::= statement {statement} {label}

//sequence_of_statements
//    : x_statement_seq x_label_seq_opt
//    ;

sequence_of_statements
    :                        statement
    | sequence_of_statements statement
    ;

//x_statement_seq
//    :                 statement
//    | x_statement_seq statement
//    ;

x_label_seq_opt
    :  // empty
    | x_label_seq
    ;

x_label_seq
    :             label
    | x_label_seq label
    ;

// 5.1:
// statement ::=
//     {label} simple_statement | {label} compound_statement

statement
    : x_label_seq_opt x_statement
    ;

x_statement
    : simple_statement
    | compound_statement
    ;

// 5.1:
// simple_statement ::= null_statement
//   | assignment_statement | exit_statement
//   | goto_statement | procedure_call_statement
//   | simple_return_statement | entry_call_statement
//   | requeue_statement | delay_statement
//   | abort_statement | raise_statement
//   | code_statement

simple_statement
    : NULL SEMICOLON                      // null_statement
    | name ASSIGN expression SEMICOLON    // assignment_statement
	
       // exit_statement
	| EXIT                      SEMICOLON
	| EXIT      WHEN expression SEMICOLON
	| EXIT name                 SEMICOLON
	| EXIT name WHEN expression SEMICOLON
	
    | GOTO name SEMICOLON                     // goto_statement
	
      // procedure_call_statement
      // entry_call_statement
	| procedure_or_entry_call
	
    | RETURN            SEMICOLON             // simple_return_statement
    | RETURN expression SEMICOLON             // simple_return_statement
	
    | REQUEUE name            SEMICOLON       // requeue_statement
    | REQUEUE name WITH ABORT SEMICOLON
	
    | delay_statement
	
    | ABORT x_name_list SEMICOLON             // abort_statement
	
    | RAISE                      SEMICOLON    // raise_statement
    | RAISE name                 SEMICOLON
    | RAISE name WITH expression SEMICOLON
	
    | qualified_expression SEMICOLON          // code_statement
    ;

// 5.1:
// compound_statement ::=
//     if_statement | case_statement
//   | loop_statement | block_statement
//   | extended_return_statement
//   | accept_statement | select_statement

compound_statement
    : if_statement
    | case_statement
    | loop_statement
    | block_statement
    | extended_return_statement
    | accept_statement
    | select_statement
    ;

// 5.1:
// null_statement ::= null;

// null_statement
//    : NULL SEMICOLON
//    ;

// 5.1:
// label ::= <<label_statement_identifier>>

label
    : LESS_LESS direct_name /*statement_identifier*/ GREATER_GREATER
    ;

// 5.1:
// statement_identifier ::= direct_name

// statement_identifier
//    : direct_name
//    ;

// 5.2:
// assignment_statement ::=
//     variable_name := expression;

// assignment_statement
//    : name ASSIGN expression SEMICOLON
//    ;

// 5.3:
// if_statement ::=
//     if condition then
//         sequence_of_statements
//     {elsif condition then
//         sequence_of_statements}
//     [else
//         sequence_of_statements]
//     end if;

if_statement
    : IF expression THEN sequence_of_statements x_elsif_stmt_list_opt x_else_stmt_opt END IF SEMICOLON
    ;

x_elsif_stmt_list_opt
    :  // empty
    | x_elsif_stmt_list
    ;

x_elsif_stmt_list
    :                   x_elsif_stmt
    | x_elsif_stmt_list x_elsif_stmt
    ;

x_elsif_stmt
    : ELSIF expression THEN sequence_of_statements
    ;
	
x_else_stmt_opt
    :  // empty
    | ELSE sequence_of_statements
    ;

// 5.4:
// case_statement ::=
//     case selecting_expression is
//         case_statement_alternative
//        {case_statement_alternative}
//     end case;

case_statement
    : CASE expression IS x_case_statement_alternative_seq END CASE SEMICOLON
    ;
	
x_case_statement_alternative_seq
    :                                  case_statement_alternative
    | x_case_statement_alternative_seq case_statement_alternative
    ;

// 5.4:
// case_statement_alternative ::=
//     when discrete_choice_list => sequence_of_statements

case_statement_alternative
    : WHEN discrete_choice_list ARROW sequence_of_statements
    ;

// 5.5:
// loop_statement ::=
//     [loop_statement_identifier:]
//     [iteration_scheme] loop
//         sequence_of_statements
//     end loop [loop_identifier];

loop_statement
    : x_statement_identifier_opt x_iteration_scheme_opt
      LOOP
         sequence_of_statements
      END LOOP x_identifier_opt SEMICOLON
    ;

x_statement_identifier_opt
    :  // empty
    | direct_name /*statement_identifier*/ COLON
    ;

x_identifier_opt
    :  // empty	
    | IDENTIFIER
    ;

// 5.5:
// iteration_scheme ::= while condition
//    | for loop_parameter_specification
//    | for iterator_specification

x_iteration_scheme_opt
    :  // empty
    | WHILE expression
    | FOR loop_parameter_specification
    | FOR iterator_specification
    ;

// 5.5:
// loop_parameter_specification ::=
//     defining_identifier in [reverse] discrete_subtype_definition

loop_parameter_specification
    : IDENTIFIER IN x_reverse_opt discrete_subtype_definition
    ;

x_reverse_opt
    :  // empty
    | REVERSE
    ;

// 5.5.2:
// iterator_specification ::=
//     defining_identifier in [reverse] iterator_name
//   | defining_identifier [: subtype_indication] of [reverse] iterable_name

iterator_specification
    : IDENTIFIER IN x_reverse_opt name
    | IDENTIFIER                          OF x_reverse_opt name
    | IDENTIFIER COLON subtype_indication OF x_reverse_opt name
    ;

// 5.6:
// block_statement ::=
//     [block_statement_identifier:]
//     [declare
//         declarative_part]
//     begin
//         handled_sequence_of_statements
//     end [block_identifier];

block_statement
    : x_statement_identifier_opt x_declarative_part_opt
          BEGIN handled_sequence_of_statements END x_identifier_opt SEMICOLON
    ;

x_declarative_part_opt
    :  // empty
    | DECLARE declarative_part
    ;

// 5.7:
// exit_statement ::=
//     exit [loop_name] [when condition];

// exit_statement
//    : EXIT x_name_opt x_when_condition_opt SEMICOLON
//    ;

// x_name_opt
//    :  // empty
//    | name
//    ;
	
// x_when_condition_opt
//    :  // empty
//    | WHEN condition
//    ;

// 5.8:
// goto_statement ::= goto label_name;

// goto_statement
//    : GOTO name SEMICOLON
//    ;

// 6.1:
// subprogram_declaration ::=
//    [overriding_indicator]
//    subprogram_specification
//    [aspect_specification];

subprogram_declaration
    : x_overriding_indicator_opt subprogram_specification x_aspect_specification_opt SEMICOLON
    ;

// 6.1:
// subprogram_specification ::=
//     procedure_specification
//   | function_specification

subprogram_specification
    : procedure_specification
    | function_specification
    ;

// 6.1:
// procedure_specification ::= procedure defining_program_unit_name parameter_profile

procedure_specification
    : PROCEDURE defining_program_unit_name parameter_profile
    ;

// 6.1:
// function_specification ::= function defining_designator parameter_and_result_profile

function_specification
    : FUNCTION defining_designator parameter_and_result_profile
    ;

// 6.1:
// designator ::= [parent_unit_name . ]identifier | operator_symbol

designator_opt
    :  // empty
    |                      IDENTIFIER
    | parent_unit_name DOT IDENTIFIER
    | operator_symbol
    ;

// 6.1:
// defining_designator ::= defining_program_unit_name | defining_operator_symbol 

defining_designator
    : defining_program_unit_name
    | defining_operator_symbol
    ;

// 6.1:
// defining_program_unit_name ::= [parent_unit_name . ]defining_identifier

defining_program_unit_name
    :                      IDENTIFIER
    | parent_unit_name DOT IDENTIFIER
    ;

// 6.1:
// operator_symbol ::= string_literal

operator_symbol
    : STRING_LITERAL
    ;

// 6.1:
// defining_operator_symbol ::= operator_symbol

defining_operator_symbol
    : operator_symbol
    ;

// 6.1:
// parameter_profile ::= [formal_part]

parameter_profile
    :  // empty
    | LPAREN x_parameter_specification_seq RPAREN // formal_part
    ;

// 6.1:
// parameter_and_result_profile ::=
//     [formal_part] return [null_exclusion] subtype_mark
//   | [formal_part] return access_definition

parameter_and_result_profile
    : parameter_profile RETURN x_null_exclusion_opt name /*subtype_mark*/
    | parameter_profile RETURN access_definition
    ;

// 6.1:
// formal_part ::=
//     (parameter_specification {; parameter_specification})

//formal_part
//    : LPAREN x_parameter_specification_seq RPAREN
//    ;

x_parameter_specification_seq
    :                                         parameter_specification
    | x_parameter_specification_seq SEMICOLON parameter_specification
    ;

// 6.1:
// parameter_specification ::=
//     defining_identifier_list : [aliased] mode [null_exclusion] subtype_mark [:= default_expression]
//   | defining_identifier_list : access_definition [:= default_expression]

parameter_specification
    : defining_identifier_list COLON x_aliased_opt mode x_null_exclusion_opt name /*subtype_mark*/ x_initializer_opt
    | defining_identifier_list COLON                                         access_definition     x_initializer_opt
    ;

// 6.1:
// mode ::= [in] | in out | out

mode
    :  // empty
    | IN
    | IN OUT
    |    OUT
    ;

// 6.3:
// subprogram_body ::=
//     [overriding_indicator] subprogram_specification [aspect_specification] is
//     declarative_part
//     begin
//     handled_sequence_of_statements
//     end [designator];

subprogram_body
    : x_overriding_indicator_opt subprogram_specification x_aspect_specification_opt IS
      declarative_part
	  BEGIN handled_sequence_of_statements END designator_opt SEMICOLON
    ;

// 6.4:
// procedure_call_statement ::=
//     procedure_name;
//   | procedure_prefix actual_parameter_part;

// procedure_call_statement
//    : name                                  SEMICOLON
//    | name /*prefix*/ actual_parameter_part SEMICOLON
//    ;

// 6.4:
// function_call ::=
//     function_name
//   | function_prefix actual_parameter_part

// function_call
//    : name
//    | prefix actual_parameter_part
//    ;

// 6.4:
// actual_parameter_part ::=
//     (parameter_association {, parameter_association})

actual_parameter_part
    : LPAREN x_parameter_association_list RPAREN
    ;

x_parameter_association_list
    :                                    parameter_association
    | x_parameter_association_list COMMA parameter_association
    ;

// 6.4:
// parameter_association ::=
//     [formal_parameter_selector_name =>] explicit_actual_parameter

parameter_association
    :                     expression // explicit_actual_parameter
    | selector_name ARROW expression // explicit_actual_parameter
    ;

// 6.4:
// explicit_actual_parameter ::= expression | variable_name

//explicit_actual_parameter
//    : expression
//    | name
//    ;

// 6.5:
// simple_return_statement ::= return [expression];

// simple_return_statement
//    : RETURN            SEMICOLON
//    | RETURN expression SEMICOLON
//    ;

// 6.5:
// extended_return_object_declaration ::=
//     defining_identifier : [aliased][constant] return_subtype_indication [:= expression]

extended_return_object_declaration
    : IDENTIFIER COLON x_aliased_opt x_constant_opt subtype_indication x_initializer_opt
    | IDENTIFIER COLON x_aliased_opt x_constant_opt access_definition  x_initializer_opt
    ;

// 6.5:
// extended_return_statement ::=
//     extended_return_object_declaration [do handled_sequence_of_statements end return];
//
// No 'return' keyword. Is it a bug?

extended_return_statement
    : RETURN extended_return_object_declaration                                              SEMICOLON
    | RETURN extended_return_object_declaration DO handled_sequence_of_statements END RETURN SEMICOLON
    ;

// 6.5:
// return_subtype_indication ::= subtype_indication | access_definition

// return_subtype_indication
//    : subtype_indication
//    | access_definition
//    ;

// 6.7:
// null_procedure_declaration ::=
//     [overriding_indicator] procedure_specification is null [aspect_specification];

// null_procedure_declaration
//    : x_overriding_indicator_opt procedure_specification IS NULL x_aspect_specification_opt SEMICOLON
//    ;

// 6.8:
// expression_function_declaration ::=
//     [overriding_indicator] function_specification is (expression) [aspect_specification];

// expression_function_declaration
//    : x_overriding_indicator_opt function_specification is LPAREN expression RPAREN x_aspect_specification_opt SEMICOLON
//    ;

// 7.1:
// package_declaration ::= package_specification;

// package_declaration
//    : package_specification SEMICOLON
//    ;

// 7.1:
// package_specification ::=
//     package defining_program_unit_name [aspect_specification] is
//     {basic_declarative_item}
//     [private
//     {basic_declarative_item}]
//     end [[parent_unit_name.]identifier]

package_specification
    : PACKAGE defining_program_unit_name x_aspect_specification_opt IS
       x_basic_declarative_item_seq_opt
       x_private_part_opt
      END x_package_tail_opt

x_package_tail_opt
    :  // empty
    | parent_unit_name DOT IDENTIFIER
    |                      IDENTIFIER
    ;

x_private_part_opt
    :  // empty
    | PRIVATE x_basic_declarative_item_seq_opt
    ;
	
x_basic_declarative_item_seq_opt
    :  // empty
    | x_basic_declarative_item_seq
    ;

x_basic_declarative_item_seq
    :                              basic_declarative_item
    | x_basic_declarative_item_seq basic_declarative_item
    ;

// 7.2:
// package_body ::=
//     package body defining_program_unit_name [aspect_specification] is
//       declarative_part
//       [begin
//            handled_sequence_of_statements]
//       end [[parent_unit_name.]identifier];

package_body
    : PACKAGE BODY defining_program_unit_name x_aspect_specification_opt IS
         declarative_part
	     x_package_body_opt
	  END x_package_tail_opt
    ;

x_package_body_opt
    :  // empty
    | BEGIN handled_sequence_of_statements
    ;

// 7.3:
// private_type_declaration ::=
//     type defining_identifier [discriminant_part] is [[abstract] tagged] [limited] private [aspect_specification];

// private_type_declaration
//    : TYPE IDENTIFIER x_discriminant_part_opt IS x_abstract_tagged_opt x_limited_opt PRIVATE x_aspect_specification_opt SEMICOLON
//    ;

x_abstract_tagged_opt
    :  // empty
    |          TAGGED
    | ABSTRACT TAGGED
    ;

// 7.3:
// private_extension_declaration ::=
// type defining_identifier [discriminant_part] is [abstract] [limited | synchronized] new ancestor_subtype_indication
//     [and interface_list] with private [aspect_specification];

// private_extension_declaration
//    : TYPE IDENTIFIER x_discriminant_part_opt IS x_abstract_opt x_limited_sync_opt NEW subtype_indication
//        x_and_interface_opt WITH PRIVATE x_aspect_specification_opt SEMICOLON
//    ;

x_limited_sync_opt
    :  // empty
    | LIMITED
    | SYNCHRONIZED
    ;

x_and_interface_opt
    :  // empty
    | AND interface_list
    ;

// 8.3.1:
// overriding_indicator ::= [not] overriding

x_overriding_indicator_opt
    :  // empty
    |     OVERRIDING
    | NOT OVERRIDING
    ;

// 8.4:
// use_clause ::= use_package_clause | use_type_clause

use_clause
    : USE x_package_name_list SEMICOLON              // use_package_clause
    | USE     TYPE x_subtype_mark_list SEMICOLON     // use_type_clause
    | USE ALL TYPE x_subtype_mark_list SEMICOLON     // use_type_clause
    ;

// 8.4:
// use_package_clause ::= use package_name {, package_name};

// use_package_clause
//    : USE x_package_name_list SEMICOLON
//    ;

x_package_name_list
    :                           name
    | x_package_name_list COMMA name
    ;

// 8.4:
// use_type_clause ::= use [all] type subtype_mark {, subtype_mark};

// use_type_clause
//    : USE x_all_opt TYPE x_subtype_mark_list SEMICOLON
//    ;
	
// x_all_opt
//    :  // empty
//    | ALL
//    ;

x_subtype_mark_list
    :                           name /*subtype_mark*/
    | x_subtype_mark_list COMMA name /*subtype_mark*/
    ;

// 8.5:
// renaming_declaration ::=
//     object_renaming_declaration
//   | exception_renaming_declaration
//   | package_renaming_declaration
//   | subprogram_renaming_declaration
//   | generic_renaming_declaration

renaming_declaration
    : object_renaming_declaration
    | exception_renaming_declaration
    | package_renaming_declaration
    | subprogram_renaming_declaration
    | generic_renaming_declaration
    ;

// 8.5.1:
// object_renaming_declaration ::=
//     defining_identifier : [null_exclusion] subtype_mark renames object_name [aspect_specification];
//   | defining_identifier : access_definition renames object_name [aspect_specification];

object_renaming_declaration
    : IDENTIFIER COLON x_null_exclusion_opt name /*subtype_mark*/ RENAMES name x_aspect_specification_opt SEMICOLON
    | IDENTIFIER COLON                 access_definition          RENAMES name x_aspect_specification_opt SEMICOLON
    ;

// 8.5.2:
// exception_renaming_declaration ::= defining_identifier : exception renames exception_name [aspect_specification];

exception_renaming_declaration
    : IDENTIFIER COLON EXCEPTION RENAMES name x_aspect_specification_opt SEMICOLON
    ;

// 8.5.3:
// package_renaming_declaration ::= package defining_program_unit_name renames package_name [aspect_specification];

package_renaming_declaration
    : PACKAGE defining_program_unit_name RENAMES name x_aspect_specification_opt SEMICOLON
    ;

// 8.5.4:
// subprogram_renaming_declaration ::=
//     [overriding_indicator] subprogram_specification renames callable_entity_name [aspect_specification];

subprogram_renaming_declaration
    : x_overriding_indicator_opt subprogram_specification RENAMES name x_aspect_specification_opt SEMICOLON
    ;

// 8.5.5:
// generic_renaming_declaration ::=
//     generic package defining_program_unit_name renames generic_package_name [aspect_specification];
//   | generic procedure defining_program_unit_name renames generic_procedure_name [aspect_specification];
//   | generic function defining_program_unit_name renames generic_function_name [aspect_specification];

generic_renaming_declaration
    : GENERIC PACKAGE   defining_program_unit_name RENAMES name x_aspect_specification_opt SEMICOLON
    | GENERIC PROCEDURE defining_program_unit_name RENAMES name x_aspect_specification_opt SEMICOLON
    | GENERIC FUNCTION  defining_program_unit_name RENAMES name x_aspect_specification_opt SEMICOLON
    ;

// 9.1:
// task_type_declaration ::=
// task type defining_identifier [known_discriminant_part] [aspect_specification] [is [new interface_list with] task_definition];

// task_type_declaration
//    : TASK TYPE IDENTIFIER x_known_discriminant_part_opt x_aspect_specification_opt x_task_tail_opt SEMICOLON
//    ;

x_task_tail_opt
    :  // empty
    | IS                         task_definition
    | IS NEW interface_list WITH task_definition
    ;

// 9.1:
// single_task_declaration ::= task defining_identifier [aspect_specification][is [new interface_list with] task_definition];

// single_task_declaration
//    : TASK IDENTIFIER x_aspect_specification_opt x_task_tail_opt SEMICOLON
//    ;

// 9.1:
// task_definition ::=
//      {task_item}
//    [ private
//      {task_item}]
//  end [task_identifier]

task_definition
    : x_task_item_seq_opt                             END x_end_opt
    | x_task_item_seq_opt PRIVATE x_task_item_seq_opt END x_end_opt
    ;

x_end_opt
    : // empty
    | IDENTIFIER
    ;

// 9.1:
// task_item ::= entry_declaration | aspect_clause

x_task_item_seq_opt
    :  // empty
    | x_task_item_seq
    ;

x_task_item_seq
    :                 task_item
    | x_task_item_seq task_item
    ;

task_item
    : entry_declaration
    | aspect_clause
    ;

// 9.1:
// task_body ::=
//     task body defining_identifier [aspect_specification] is
//        declarative_part
//     begin
//        handled_sequence_of_statements
//     end [task_identifier];

task_body
    : TASK BODY IDENTIFIER x_aspect_specification_opt IS
          declarative_part
      BEGIN
          handled_sequence_of_statements
      END x_end_opt SEMICOLON
    ;

// 9.4:
// protected_type_declaration ::=
//     protected type defining_identifier [known_discriminant_part][aspect_specification] is
//     [new interface_list with]
//     protected_definition;

// protected_type_declaration
//    : PROTECTED TYPE IDENTIFIER x_known_discriminant_part_opt x_aspect_specification_opt IS
//          x_protected_new_tail_opt protected_definition SEMICOLON
//    ;

x_protected_new_tail_opt
    :  // empty
    | NEW interface_list WITH
    ;

// 9.4:
// single_protected_declaration ::=
//     protected defining_identifier [aspect_specification] is
//     [new interface_list with]
//     protected_definition;

// single_protected_declaration
//    : PROTECTED IDENTIFIER x_aspect_specification_opt IS x_protected_new_tail_opt 
//         protected_definition SEMICOLON
//    ;

// 9.4:
// protected_definition ::=
//     { protected_operation_declaration }
//   [ private
//     { protected_element_declaration } ]
// end [protected_identifier]

protected_definition
    : x_protected_operation_declaration_seq_opt PRIVATE x_protected_element_declaration_seq_opt END x_end_opt
    ;

// 9.4:
// protected_operation_declaration ::= subprogram_declaration
//    | entry_declaration
//    | aspect_clause

x_protected_operation_declaration_seq_opt
    :  // empty
    | x_protected_operation_declaration_seq
    ;

x_protected_operation_declaration_seq
    :                                       protected_operation_declaration
    | x_protected_operation_declaration_seq protected_operation_declaration
    ;

protected_operation_declaration
    : subprogram_declaration
    | entry_declaration
    | aspect_clause
    ;

// 9.4:
// protected_element_declaration ::= protected_operation_declaration
//     | component_declaration

x_protected_element_declaration_seq_opt
    :  // empty
    | x_protected_element_declaration_seq
    ;

x_protected_element_declaration_seq
    :                                     protected_element_declaration
    | x_protected_element_declaration_seq protected_element_declaration
    ;

protected_element_declaration
    : protected_operation_declaration
    | component_declaration
    ;

// 9.4:
// protected_body ::=
//     protected body defining_identifier [aspect_specification] is
//        { protected_operation_item }
//     end [protected_identifier];

protected_body
    : PROTECTED BODY IDENTIFIER x_aspect_specification_opt IS
         x_protected_operation_item_seq_opt
      END x_end_opt SEMICOLON
    ;

// 9.4:
// protected_operation_item ::= subprogram_declaration
//    | subprogram_body
//    | entry_body
//    | aspect_clause

x_protected_operation_item_seq_opt
    :  // empty
    | x_protected_operation_item_seq
    ;

x_protected_operation_item_seq
    :                                protected_operation_item
    | x_protected_operation_item_seq protected_operation_item
    ;
	
protected_operation_item
    : subprogram_declaration
    | subprogram_body
    | entry_body
    | aspect_clause
    ;

// 9.5:
// synchronization_kind ::= By_Entry | By_Protected_Procedure | Optional

// synchronization_kind
//    : By_Entry
//    | By_Protected_Procedure
//    | Optional
//    ;
//
//   -- NOT NEEDED

// 9.5.2:
// entry_declaration ::=
//     [overriding_indicator] entry defining_identifier [(discrete_subtype_definition)] parameter_profile
//     [aspect_specification];

entry_declaration
    : x_overriding_indicator_opt
      ENTRY IDENTIFIER x_entry_parameter_opt parameter_profile x_aspect_specification_opt
	  SEMICOLON
    ;

x_entry_parameter_opt
    :  // empty
    | LPAREN discrete_subtype_definition RPAREN
    ;

// 9.5.2:
// accept_statement ::=
//     accept entry_direct_name [(entry_index)] parameter_profile
//    [do
//       handled_sequence_of_statements
//     end [entry_identifier]];

accept_statement
    : ACCEPT direct_name x_entry_index_opt parameter_profile x_accept_body_opt x_end_opt SEMICOLON
    ;

x_entry_index_opt
    :  // empty
    | LPAREN expression RPAREN
    ;

x_accept_body_opt
    :  // empty
    | DO handled_sequence_of_statements END
    ;

// 9.5.2:
// entry_index ::= expression

// 9.5.2:
// entry_body ::=
//     entry defining_identifier entry_body_formal_part entry_barrier is
//        declarative_part
//     begin
//        handled_sequence_of_statements
//     end [entry_identifier];

entry_body
    : ENTRY IDENTIFIER entry_body_formal_part WHEN expression /*entry_barrier*/ IS
          declarative_part
      BEGIN
          handled_sequence_of_statements
      END x_end_opt SEMICOLON
    ;

// 9.5.2:
// entry_body_formal_part ::= [(entry_index_specification)] parameter_profile

entry_body_formal_part
    :                                         parameter_profile
    | LPAREN entry_index_specification RPAREN parameter_profile
    ;

// 9.5.2:
// entry_barrier ::= when condition

// entry_barrier
//    : WHEN expression
//    ;

// 9.5.2:
// entry_index_specification ::= for defining_identifier in discrete_subtype_definition

entry_index_specification
    : FOR IDENTIFIER IN discrete_subtype_definition
    ;

// 9.5.3:
// entry_call_statement ::= entry_name [actual_parameter_part];

// entry_call_statement
//    : name                       SEMICOLON
//    | name actual_parameter_part SEMICOLON
//    ;

// 9.5.4:
// requeue_statement ::= requeue procedure_or_entry_name [with abort];

// requeue_statement
//    : REQUEUE name            SEMICOLON
//    | REQUEUE name WITH abort SEMICOLON
//    ;

// 9.6:
// delay_statement ::= delay_until_statement | delay_relative_statement

delay_statement
    : DELAY UNTIL expression SEMICOLON  // delay_until_statement 
    | DELAY       expression SEMICOLON  // delay_relative_statement
    ;

// 9.6:
// delay_until_statement ::= delay until delay_expression;

// delay_until_statement
//    : DELAY UNTIL expression SEMICOLON
//    ;

// 9.6:
// delay_relative_statement ::= delay delay_expression;

// delay_relative_statement
//    : DELAY expression SEMICOLON
//    ;

// 9.7:
// select_statement ::=
//     selective_accept
//   | timed_entry_call
//   | conditional_entry_call
//   | asynchronous_select

select_statement
    : selective_accept
//    | timed_entry_call
//    | conditional_entry_call
    | SELECT triggering_alternative THEN ABORT sequence_of_statements /*abortable_part*/ END SELECT SEMICOLON // asynchronous_select
    ;

// 9.7.1:
// selective_accept ::=
//     select [guard]
//        select_alternative
//   { or [guard]
//        select_alternative }
//   [ else
//        sequence_of_statements ]
//     end select;

selective_accept
    : SELECT x_selective_branch_seq x_selective_else_opt END SELECT SEMICOLON
    ;

x_selective_branch_seq
    :                           x_selective_branch
    | x_selective_branch_seq OR x_selective_branch
    ;

x_selective_branch
    :                       select_alternative
    | WHEN expression ARROW select_alternative
    ;

x_selective_else_opt
    :  // empty
    | ELSE sequence_of_statements
    ;

// 9.7.1:
// guard ::= when condition =>

// guard
//    : WHEN expression ARROW
//    ;

// 9.7.1:
// select_alternative ::=
//     accept_alternative
//   | delay_alternative
//   | terminate_alternative

select_alternative
      // accept_alternative
	: accept_statement 
    | accept_statement sequence_of_statements
	
      // delay_alternative
	| delay_statement
    | delay_statement sequence_of_statements
	
    | TERMINATE SEMICOLON   // terminate_alternative
    ;

// 9.7.1:
// accept_alternative ::=
//     accept_statement [sequence_of_statements]

// accept_alternative
//    : accept_statement 
//    | accept_statement sequence_of_statements
//    ;

// 9.7.1:
// delay_alternative ::=
//     delay_statement [sequence_of_statements]

delay_alternative
    : delay_statement
    | delay_statement sequence_of_statements
    ;

// 9.7.1:
// terminate_alternative ::= terminate;

// terminate_alternative
//    : TERMINATE SEMICOLON
//    ;

// 9.7.2:
// timed_entry_call ::=
//     select
//         entry_call_alternative
//     or
//         delay_alternative
//     end select;

timed_entry_call
    : SELECT entry_call_alternative OR delay_alternative END SELECT SEMICOLON
    ;

// 9.7.2:
// entry_call_alternative ::=
//     procedure_or_entry_call [sequence_of_statements]

entry_call_alternative
    : procedure_or_entry_call
    | procedure_or_entry_call sequence_of_statements
    ;

// 9.7.2:
// procedure_or_entry_call ::=
//     procedure_call_statement | entry_call_statement

procedure_or_entry_call
//    : procedure_call_statement 
//    | entry_call_statement
    : name                       SEMICOLON
    | name actual_parameter_part SEMICOLON
    ;

// 9.7.3:
// conditional_entry_call ::=
//     select
//        entry_call_alternative
//     else
//        sequence_of_statements
//     end select;

conditional_entry_call
    : SELECT entry_call_alternative ELSE sequence_of_statements END SELECT SEMICOLON
    ;

// 9.7.4:
// asynchronous_select ::=
//     select
//         triggering_alternative
//     then abort
//         abortable_part
// end select;

asynchronous_select
    : SELECT triggering_alternative THEN ABORT sequence_of_statements /*abortable_part*/ END SELECT SEMICOLON
    ;

// 9.7.4:
// triggering_alternative ::= triggering_statement [sequence_of_statements]

triggering_alternative
    : triggering_statement
    | triggering_statement sequence_of_statements
    ;

// 9.7.4:
// triggering_statement ::= procedure_or_entry_call | delay_statement

triggering_statement
    : procedure_or_entry_call
    | delay_statement
    ;

// 9.7.4:
// abortable_part ::= sequence_of_statements

// abortable_part
//    : sequence_of_statements
//    ;

// 9.8:
// abort_statement ::= abort task_name {, task_name};

// abort_statement
//    : ABORT x_name_list SEMICOLON
//    ;

x_name_list
    :                   name
    | x_name_list COMMA name
    ;

// 10.1.1:
// compilation ::= {compilation_unit}

compilation
    :  // empty
    | x_compilation_unit_seq
    ;

x_compilation_unit_seq
    :                        compilation_unit
    | x_compilation_unit_seq compilation_unit
    ;

// 10.1.1:
// compilation_unit ::=
//     context_clause library_item
//   | context_clause subunit

compilation_unit
    : context_clause library_item
    | context_clause SEPARATE LPAREN parent_unit_name RPAREN proper_body // subunit
    ;

// 10.1.1:
// library_item ::= [private] library_unit_declaration
//   | library_unit_body
//   | [private] library_unit_renaming_declaration

library_item
    : x_private_opt library_unit_declaration
    |               library_unit_body
    | x_private_opt library_unit_renaming_declaration
    ;
	
x_private_opt
    :  // empty
    | PRIVATE
    ;

// 10.1.1:
// library_unit_declaration ::=
//     subprogram_declaration | package_declaration
//   | generic_declaration | generic_instantiation

library_unit_declaration
    : subprogram_declaration 
    | package_specification SEMICOLON   // package_declaration
    | generic_declaration 
    | generic_instantiation
    ;

// 10.1.1:
// library_unit_renaming_declaration ::=
//     package_renaming_declaration
//   | generic_renaming_declaration
//   | subprogram_renaming_declaration

library_unit_renaming_declaration
    : package_renaming_declaration
    | generic_renaming_declaration
    | subprogram_renaming_declaration
    ;

// 10.1.1:
// library_unit_body ::= subprogram_body | package_body

library_unit_body
    : subprogram_body
    | package_body
    ;
	
// 10.1.1:
// parent_unit_name ::= name

parent_unit_name
    : name
    ;

// 10.1.2:
// context_clause ::= {context_item}

context_clause
    :  // empty
    | x_context_item_seq
    ;
	
x_context_item_seq
    :                    context_item
    | x_context_item_seq context_item
    ;

// 10.1.2:
// context_item ::= with_clause | use_clause

context_item
    : with_clause 
    | use_clause
    ;

// 10.1.2:
// with_clause ::= limited_with_clause | nonlimited_with_clause

with_clause
    : LIMITED x_private_opt WITH x_name_list SEMICOLON  // limited_with_clause
    |         x_private_opt WITH x_name_list SEMICOLON  // nonlimited_with_clause
    ;

// 10.1.2:
// limited_with_clause ::= limited [private] with library_unit_name {, library_unit_name};

// limited_with_clause
//    : LIMITED x_private_opt WITH x_name_list SEMICOLON
//    ;

// 10.1.2:
// nonlimited_with_clause ::= [private] with library_unit_name {, library_unit_name};

// nonlimited_with_clause
//    : x_private_opt WITH x_name_list SEMICOLON
//    ;

// 10.1.3:
// body_stub ::= subprogram_body_stub | package_body_stub | task_body_stub | protected_body_stub

body_stub
    : x_overriding_indicator_opt subprogram_specification IS SEPARATE x_aspect_specification_opt SEMICOLON // subprogram_body_stub
    | PACKAGE BODY IDENTIFIER IS SEPARATE x_aspect_specification_opt SEMICOLON   // package_body_stub
    | TASK BODY IDENTIFIER IS SEPARATE x_aspect_specification_opt SEMICOLON      // task_body_stub
    | PROTECTED BODY IDENTIFIER IS SEPARATE x_aspect_specification_opt SEMICOLON // protected_body_stub
    ;

// 10.1.3:
// subprogram_body_stub ::=
// [overriding_indicator] subprogram_specification is separate [aspect_specification];

// subprogram_body_stub
//    : x_overriding_indicator_opt subprogram_specification IS SEPARATE x_aspect_specification_opt SEMICOLON
//    ;

// 10.1.3:
// package_body_stub ::=
//     package body defining_identifier is separate [aspect_specification];

// package_body_stub
//    : PACKAGE BODY IDENTIFIER IS SEPARATE x_aspect_specification_opt SEMICOLON
//    ;

// 10.1.3:
// task_body_stub ::= task body defining_identifier is separate [aspect_specification];

// task_body_stub
//    : TASK BODY IDENTIFIER IS SEPARATE x_aspect_specification_opt SEMICOLON
//    ;

// 10.1.3:
// protected_body_stub ::= 
//     protected body defining_identifier is separate [aspect_specification];

// protected_body_stub
//    : PROTECTED BODY IDENTIFIER IS SEPARATE x_aspect_specification_opt SEMICOLON
//    ;

// 10.1.3:
// subunit ::= separate (parent_unit_name) proper_body

// subunit
//    : SEPARATE LPAREN parent_unit_name RPAREN proper_body
//    ;

// 11.1:
// exception_declaration ::= defining_identifier_list : exception [aspect_specification];

// exception_declaration
//    : defining_identifier_list COLON EXCEPTION x_aspect_specification_opt SEMICOLON
//    ;

// 11.2:
// handled_sequence_of_statements ::=
//     sequence_of_statements
//    [exception
//        exception_handler
//     {exception_handler}]

handled_sequence_of_statements
    : sequence_of_statements x_exception_part_opt
    ;

x_exception_part_opt
    :  // empty
    | EXCEPTION x_exception_handler_seq
    ;

x_exception_handler_seq
    :                         exception_handler
    | x_exception_handler_seq exception_handler
    ;

// 11.2:
// exception_handler ::=
//     when [choice_parameter_specification:] exception_choice {| exception_choice} => sequence_of_statements

exception_handler
    : WHEN x_choice_parameter_specification_opt x_exception_choice_list ARROW sequence_of_statements
    ;

x_choice_parameter_specification_opt
    :  // empty
    | IDENTIFIER /*choice_parameter_specification*/ COLON
    ;

x_exception_choice_list
    :                                  name
	|                                  OTHERS
    | x_exception_choice_list VERTICAL name
    | x_exception_choice_list VERTICAL OTHERS
    ;

// 11.2:
// choice_parameter_specification ::= defining_identifier

// choice_parameter_specification
//    : IDENTIFIER
//    ;

// 11.2:
// exception_choice ::= exception_name | others

// exception_choice
//   : name
//   | OTHERS
//   ;

// 11.3:
// raise_statement ::= raise;
//    | raise exception_name [with string_expression];

// raise_statement
//    : RAISE                      SEMICOLON
//    | RAISE name                 SEMICOLON
//    | RAISE name WITH expression SEMICOLON
//    ;

// 12.1:
// generic_declaration ::= generic_subprogram_declaration | generic_package_declaration

generic_declaration
      // generic_subprogram_declaration
    : generic_formal_part subprogram_specification x_aspect_specification_opt SEMICOLON
	  // generic_package_declaration
    | generic_formal_part package_specification                               SEMICOLON
    ;

// 12.1:
// generic_subprogram_declaration ::=
//     generic_formal_part subprogram_specification [aspect_specification];

// generic_subprogram_declaration
//    : generic_formal_part subprogram_specification x_aspect_specification_opt SEMICOLON
//    ;

// 12.1:
// generic_package_declaration ::=
//     generic_formal_part package_specification;

// generic_package_declaration
//    : generic_formal_part package_specification SEMICOLON
//    ;

// 12.1:
// generic_formal_part ::= generic {generic_formal_parameter_declaration | use_clause}

generic_formal_part
    : GENERIC x_generic_parameter_clause_opt
    ;

x_generic_parameter_clause_opt
    :  // empty
    | x_generic_parameter_seq
    ;

x_generic_parameter_seq
    :                         generic_formal_parameter_declaration
    |                         use_clause
    | x_generic_parameter_seq generic_formal_parameter_declaration
    | x_generic_parameter_seq use_clause
    ;

// 12.1:
// generic_formal_parameter_declaration ::=
//     formal_object_declaration
//   | formal_type_declaration
//   | formal_subprogram_declaration
//   | formal_package_declaration

generic_formal_parameter_declaration
    : formal_object_declaration
    | formal_type_declaration
    | formal_subprogram_declaration
      // formal_package_declaration
	| WITH PACKAGE IDENTIFIER IS NEW name formal_package_actual_part x_aspect_specification_opt SEMICOLON
    ;

// 12.3:
// generic_instantiation ::=
//     package defining_program_unit_name is new generic_package_name [generic_actual_part] [aspect_specification];
//   | [overriding_indicator] procedure defining_program_unit_name is new generic_procedure_name [generic_actual_part] [aspect_specification];
//   | [overriding_indicator] function defining_designator is new generic_function_name [generic_actual_part] [aspect_specification];

generic_instantiation
    :                            PACKAGE   defining_program_unit_name IS NEW name x_generic_actual_part_opt x_aspect_specification_opt SEMICOLON
    | x_overriding_indicator_opt PROCEDURE defining_program_unit_name IS NEW name x_generic_actual_part_opt x_aspect_specification_opt SEMICOLON
    | x_overriding_indicator_opt FUNCTION  defining_designator        IS NEW name x_generic_actual_part_opt x_aspect_specification_opt SEMICOLON
    ;

x_generic_actual_part_opt
    :  // empty
    | generic_actual_part
    ;

// 12.3:
// generic_actual_part ::=
//     (generic_association {, generic_association})

generic_actual_part
    : LPAREN x_generic_association_list RPAREN
    ;

x_generic_association_list
    :                                  generic_association
    | x_generic_association_list COMMA generic_association
    ;

// 12.3:
// generic_association ::=
//     [generic_formal_parameter_selector_name =>] explicit_generic_actual_parameter

generic_association
    :                     name // explicit_generic_actual_parameter
    | selector_name ARROW name // explicit_generic_actual_parameter
    ;

// 12.3:
// explicit_generic_actual_parameter ::= expression | variable_name
//    | subprogram_name | entry_name | subtype_mark
//    | package_instance_name

// explicit_generic_actual_parameter
//     : expression
// //  | name
// //  | name /*subtype_mark*/
//     ;

// 12.4:
// formal_object_declaration ::=
//     defining_identifier_list : mode [null_exclusion] subtype_mark [:= default_expression] [aspect_specification];
//   | defining_identifier_list : mode access_definition [:= default_expression] [aspect_specification];

formal_object_declaration
    : defining_identifier_list COLON mode x_null_exclusion_opt name /*subtype_mark*/ x_initializer_opt x_aspect_specification_opt SEMICOLON
    | defining_identifier_list COLON mode access_definition                          x_initializer_opt x_aspect_specification_opt SEMICOLON
    ;

// 12.5:
// formal_type_declaration ::=
//     formal_complete_type_declaration
//   | formal_incomplete_type_declaration

formal_type_declaration
       // formal_complete_type_declaration
	: TYPE IDENTIFIER x_discriminant_part_opt IS formal_type_definition x_aspect_specification_opt SEMICOLON
      // formal_incomplete_type_declaration
	| TYPE IDENTIFIER x_discriminant_part_opt           SEMICOLON
    | TYPE IDENTIFIER x_discriminant_part_opt IS TAGGED SEMICOLON
    ;

// 12.5:
// formal_complete_type_declaration ::=
//     type defining_identifier[discriminant_part] is formal_type_definition [aspect_specification];

// formal_complete_type_declaration
//    : TYPE IDENTIFIER x_discriminant_part_opt IS formal_type_definition x_aspect_specification_opt SEMICOLON
//    ;

// 12.5:
// formal_incomplete_type_declaration ::=
//     type defining_identifier[discriminant_part] [is tagged];

// formal_incomplete_type_declaration
//    : TYPE IDENTIFIER x_discriminant_part_opt           SEMICOLON
//    | TYPE IDENTIFIER x_discriminant_part_opt IS TAGGED SEMICOLON
//    ;

// 12.5:
// formal_type_definition ::=
//     formal_private_type_definition
//   | formal_derived_type_definition
//   | formal_discrete_type_definition
//   | formal_signed_integer_type_definition
//   | formal_modular_type_definition
//   | formal_floating_point_definition
//   | formal_ordinary_fixed_point_definition
//   | formal_decimal_fixed_point_definition
//   | formal_array_type_definition
//   | formal_access_type_definition
//   | formal_interface_type_definition

formal_type_definition
    : x_abstract_tagged_opt x_limited_opt PRIVATE   // formal_private_type_definition
    | x_abstract_opt x_limited_sync_opt NEW name x_formal_derived_type_tail_opt // formal_derived_type_definition
    | LPAREN LESS_GREATER RPAREN                    // formal_discrete_type_definition
    | RANGE LESS_GREATER                            // formal_signed_integer_type_definition
    | MOD LESS_GREATER                              // formal_modular_type_definition
    | DIGITS LESS_GREATER                           // formal_floating_point_definition
    | DELTA LESS_GREATER                            // formal_ordinary_fixed_point_definition
    | DELTA LESS_GREATER DIGITS LESS_GREATER        // formal_decimal_fixed_point_definition
    | array_type_definition                         // formal_array_type_definition
    | access_type_definition                        // formal_access_type_definition
    | interface_type_definition                     // formal_interface_type_definition
    ;

// 12.5.1:
// formal_private_type_definition ::= [[abstract] tagged] [limited] private

// formal_private_type_definition
//    : x_abstract_tagged_opt x_limited_opt PRIVATE
//    ;

// 12.5.1:
// formal_derived_type_definition ::=
//     [abstract] [limited | synchronized] new subtype_mark [[and interface_list]with private]

// formal_derived_type_definition
//    : x_abstract_opt x_limited_sync_opt NEW name /*subtype_mark*/ x_formal_derived_type_tail_opt
//    ;
	
x_formal_derived_type_tail_opt
    :  // empty
    | x_and_interface_opt WITH PRIVATE
    ;

// 12.5.2:
// formal_discrete_type_definition ::= (<>)

// formal_discrete_type_definition
//    : LPAREN LESS_GREATER RPAREN
//    ;

// 12.5.2:
// formal_signed_integer_type_definition ::= range <>

// formal_signed_integer_type_definition
//    : RANGE LESS_GREATER
//    ;

// 12.5.2:
// formal_modular_type_definition ::= mod <>

//formal_modular_type_definition
//    : MOD LESS_GREATER
//    ;

// 12.5.2:
// formal_floating_point_definition ::= digits <>

// formal_floating_point_definition
//    : DIGITS LESS_GREATER
//    ;

// 12.5.2:
// formal_ordinary_fixed_point_definition ::= delta <>

// formal_ordinary_fixed_point_definition
//    : DELTA LESS_GREATER
//    ;

// 12.5.2:
// formal_decimal_fixed_point_definition ::= delta <> digits <>

// formal_decimal_fixed_point_definition
//    : DELTA LESS_GREATER DIGITS LESS_GREATER
//    ;

// 12.5.3:
// formal_array_type_definition ::= array_type_definition

// formal_array_type_definition
//    : array_type_definition
//    ;

// 12.5.4:
// formal_access_type_definition ::= access_type_definition

// formal_access_type_definition
//    : access_type_definition
//    ;

// 12.5.5:
// formal_interface_type_definition ::= interface_type_definition

// formal_interface_type_definition
//    : interface_type_definition
//    ;

// 12.6:
// formal_subprogram_declaration ::= formal_concrete_subprogram_declaration
//    | formal_abstract_subprogram_declaration

formal_subprogram_declaration
      // formal_concrete_subprogram_declaration
	: WITH subprogram_specification                       x_aspect_specification_opt SEMICOLON
    | WITH subprogram_specification IS subprogram_default x_aspect_specification_opt SEMICOLON
      // formal_abstract_subprogram_declaration
	| WITH subprogram_specification IS ABSTRACT                    x_aspect_specification_opt SEMICOLON
    | WITH subprogram_specification IS ABSTRACT subprogram_default x_aspect_specification_opt SEMICOLON
    ;

// 12.6:
// formal_concrete_subprogram_declaration ::=
//     with subprogram_specification [is subprogram_default] [aspect_specification];

// formal_concrete_subprogram_declaration
//    : WITH subprogram_specification                       x_aspect_specification_opt SEMICOLON
//    | WITH subprogram_specification IS subprogram_default x_aspect_specification_opt SEMICOLON
//    ;

// 12.6:
// formal_abstract_subprogram_declaration ::=
//     with subprogram_specification is abstract [subprogram_default] [aspect_specification];

// formal_abstract_subprogram_declaration
//    : WITH subprogram_specification IS ABSTRACT                    x_aspect_specification_opt SEMICOLON
//    | WITH subprogram_specification IS ABSTRACT subprogram_default x_aspect_specification_opt SEMICOLON
//    ;

// 12.6:
// subprogram_default ::= default_name | <> | null

subprogram_default
    : name // default_name
    | LESS_GREATER
    | NULL
    ;

// 12.6:
// default_name ::= name

// default_name
//    : name
//    ;

// 12.7:
// formal_package_declaration ::=
//     with package defining_identifier is new generic_package_name formal_package_actual_part [aspect_specification];

// formal_package_declaration
//    : WITH PACKAGE IDENTIFIER IS NEW name formal_package_actual_part x_aspect_specification_opt SEMICOLON
//    ;

// 12.7:
// formal_package_actual_part ::=
//     ([others =>] <>)
//   | [generic_actual_part]
//   | (formal_package_association {, formal_package_association} [, others => <>])

formal_package_actual_part
    :  // empty
    | LPAREN              LESS_GREATER RPAREN
    | LPAREN OTHERS ARROW LESS_GREATER RPAREN
    | generic_actual_part
    | LPAREN x_formal_package_association_list                                 RPAREN
    | LPAREN x_formal_package_association_list COMMA OTHERS ARROW LESS_GREATER RPAREN
    ;

x_formal_package_association_list
    :                                         formal_package_association
    | x_formal_package_association_list COMMA formal_package_association
    ;

// 12.7:
// formal_package_association ::=
//     generic_association
//   | generic_formal_parameter_selector_name => <>

formal_package_association
    : generic_association
    | selector_name ARROW LESS_GREATER
    ;

// 13.1:
// aspect_clause ::= attribute_definition_clause
//    | enumeration_representation_clause
//    | record_representation_clause
//    | at_clause

aspect_clause
    : FOR /*local_*/name APOSTROPH attribute_designator USE expression SEMICOLON    // attribute_definition_clause
    | FOR /*local_*/name  USE array_aggregate /* enumeration_aggregate */ SEMICOLON // enumeration_representation_clause
    | FOR /*local_*/name  USE RECORD x_mod_clause_opt x_component_clause_seq_opt END RECORD SEMICOLON // record_representation_clause
    | FOR direct_name USE AT expression SEMICOLON  // at_clause
    ;

// 13.1:
// local_name ::= direct_name
//    | direct_name'attribute_designator
//    | library_unit_name

// local_name
//    : direct_name
//    | direct_name APOSTROPH attribute_designator
//    | name
//    ;

// 13.1.1:
// aspect_specification ::=
//    with aspect_mark [=> aspect_definition] {, aspect_mark [=> aspect_definition] }

x_aspect_specification_opt
    :  // empty
    | WITH x_aspect_specification_association_list // aspect_specification
    ;
	
// aspect_specification
//    : WITH x_aspect_specification_association_list
//    ;

x_aspect_specification_association_list
    :                                               x_aspect_specification_association
    | x_aspect_specification_association_list COMMA x_aspect_specification_association
    ;
	
x_aspect_specification_association
//  : aspect_mark
//  | aspect_mark ARROW expression // aspect_definition
//  ;
    : IDENTIFIER x_aspect_tail_opt
    ;

x_aspect_tail_opt
    :  // empty
    |                 ARROW expression
	| APOSTROPH Class ARROW expression
    ;
	
// 13.1.1:
// aspect_mark ::= aspect_identifier['Class]

// aspect_mark
//    : IDENTIFIER
//    | IDENTIFIER APOSTROPH Class
//    ;

// 13.1.1:
// aspect_definition ::= name | expression | identifier

// aspect_definition
// //  : name
//     : expression
// //  | IDENTIFIER
//     ;

// 13.3:
// attribute_definition_clause ::=
//     for local_name'attribute_designator use expression;
//   | for local_name'attribute_designator use name;

// attribute_definition_clause
//    : FOR local_name APOSTROPH attribute_designator USE expression SEMICOLON
// // | FOR local_name APOSTROPH attribute_designator USE name       SEMICOLON
//    ;

// 13.4:
// enumeration_representation_clause ::=
//     for first_subtype_local_name use enumeration_aggregate;

// enumeration_representation_clause
//    : FOR local_name USE array_aggregate /* enumeration_aggregate */ SEMICOLON
//    ;

// 13.4:
// enumeration_aggregate ::= array_aggregate

// enumeration_aggregate
//     : array_aggregate
//     ;

// 13.5.1:
// record_representation_clause ::=
//     for first_subtype_local_name use
//        record [mod_clause]
//        {component_clause}
//     end record;

// record_representation_clause
//    : FOR local_name USE RECORD x_mod_clause_opt x_component_clause_opt END RECORD SEMICOLON
//    ;

// 13.5.1:
// component_clause ::=
//     component_local_name at position range first_bit .. last_bit;

x_component_clause_seq_opt
    :  // empty
    | x_component_clause_seq
    ;

x_component_clause_seq
    :                        component_clause
    | x_component_clause_seq component_clause
    ;

component_clause
    : /*local_*/name AT expression RANGE simple_expression DOT_DOT simple_expression SEMICOLON
    ;

// 13.5.1:
// position ::= static_expression

// position
//    : expression
//    ;

// 13.5.1:
// first_bit ::= static_simple_expression

// first_bit
//    : simple_expression
//    ;

// 13.5.1:
// last_bit ::= static_simple_expression

// last_bit
//    : simple_expression
//    ;

// 13.8:
// code_statement ::= qualified_expression;

// code_statement
//    : qualified_expression SEMICOLON
//    ;

// 13.11.3:
// storage_pool_indicator ::= storage_pool_name | null

// storage_pool_indicator
//    : name 
//    | NULL
//    ;

// 13.12:
// restriction ::= restriction_identifier
//    | restriction_parameter_identifier => restriction_parameter_argument

// restriction
//    : IDENTIFIER
//    | IDENTIFIER ARROW expression // restriction_parameter_argument
//    ;

// 13.12:
// restriction_parameter_argument ::= name | expression

// restriction_parameter_argument
//     : name 
//     | expression
//     ;

// J.3:
// delta_constraint ::= delta static_expression [range_constraint]

//delta_constraint
//    : DELTA expression 
//    | DELTA expression range_constraint
//    ;

// J.7:
// at_clause ::= for direct_name use at expression;

// at_clause
//    : FOR direct_name USE AT expression SEMICOLON
//    ;

// J.8:
// mod_clause ::= at mod static_expression;

x_mod_clause_opt
    :  // empty
	| AT MOD expression SEMICOLON
    ;

%%

