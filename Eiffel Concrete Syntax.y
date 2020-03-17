// Eiffel BNF-E Syntax
//
// Some related references:
//
// https://slebok.github.io/zoo/eiffel/iso-25436-2006/connected/index.html
// https://www.eiffel.org/doc/eiffel/Eiffel_programming_language_syntax

%token Boolean_constant
%token Character_constant
%token Integer_constant
%token Manifest_string
%token Real_constant

%token IDENTIFIER 

%token ARROW            //  ->
%token BSLASH_BSLASH    //  \\
%token CARET            //  ^
%token COLON
%token COLON_EQUAL      //  :=
%token COMMA
%token DOLLAR
%token DOT
%token DOT_DOT          //  ..
%token EQUAL            //  =
%token EXCLAMATION      //  !
%token GREATER          //  >
%token GREATER_EQUAL    //  >=
%token GREATER_GREATER  //  >>
%token LBRACE
%token LBRACKET
%token LESS             //  <
%token LESS_EQUAL       //  <=
%token LESS_LESS        //  <<  /* */
%token LPAREN
%token MINUS            //  -
%token PLUS             //  +
%token QUESTION         // ?
%token RBRACE
%token RBRACKET
%token RPAREN
%token SEMICOLON
%token SLASH            
%token SLASH_EQUAL      //  /=
%token SLASH_SLASH      //  //
%token SLASH_TILDE      //  /~
%token STAR             //  *
%token TILDE            //  ~

%token ACROSS
%token AGENT
%token ALIAS
%token ALL
%token AND
%token AS
%token ASSIGN
%token ATTRIBUTE
%token CHECK
%token CLASS
%token CONVERT
%token CREATE
%token CURRENT   // Current
%token DEBUG
%token DEFERRED
%token DO
%token ELSE
%token ELSEIF
%token END
%token ENSURE
%token EXPANDED
%token EXPORT
%token EXTERNAL
%token FEATURE
%token FROM
%token FROZEN
%token IF
%token IMPLIES
%token INHERIT
%token INSPECT
%token INVARIANT
%token LIKE
%token LOCAL
%token LOOP
%token NONE
%token NOT
%token NOTE
%token OBSOLETE
%token OLD
%token ONCE
%token ONLY
%token OR
%token PRECURSOR
%token REDEFINE
%token RENAME
%token REQUIRE
%token RESCUE
%token RESULT
%token RETRY
%token SELECT
%token SOME
%token THEN
%token TUPLE
%token UNDEFINE
%token UNTIL
%token VARIANT
%token WHEN
%token XOR

%start Program

%%

Program
    :         Class_declaration
    | Program Class_declaration
    ;
	
// Class names

// Class_name
//    : IDENTIFIER
//    ;

// Class declarations

Class_declaration
    : Notes_opt Class_header Formal_generics_opt Obsolete_opt Inheritance_opt Creators_opt Converters_opt Features_opt
	              Notes_opt Invariant_opt Notes_opt END
    ;

// Notes

Notes_opt
    :  // empty
    | Notes
    ;
	
Notes
    : NOTE Note_list_opt
	;
	
Note_list_opt
    :  // empty
    | Note_list
	;

Note_list
    :                     Note_entry
    | Note_list SEMICOLON Note_entry
	;
	
Note_entry
    : IDENTIFIER COLON /* Note_name */ Note_values
    ;

// Note_name ::= Identifier ":"

Note_values
    :                   Note_item
    | Note_values COMMA Note_item
    ;

Note_item
    : IDENTIFIER
    | Manifest_constant
    ;

// Class headers

Class_header
    : Header_mark_opt CLASS IDENTIFIER /* Class_name */
    ;

Header_mark_opt
    :  // empty
    | DEFERRED
    | EXPANDED
    | FROZEN
    ;

// Obsolete marks

Obsolete_opt
    :  // empty
    | OBSOLETE Manifest_string // Message
    ;

//Message ::= Manifest_string

// Feature parts

Features_opt
    :  // empty
    | Features
    ;
	
Features
    :          Feature_clause
	| Features Feature_clause
	;

Feature_clause
    : FEATURE Clients_opt /* Header_comment */ Feature_declaration_list_opt
    ;

Feature_declaration_list_opt
    :  // empty
    | Feature_declaration_list
    ;
	
Feature_declaration_list
    :                                    Feature_declaration
	| Feature_declaration_list SEMICOLON Feature_declaration
	;

// Header_comment ::= Comment

// Feature declarations

Feature_declaration
    : New_feature_list Formal_arguments_opt Query_mark_opt Feature_value_opt /* Declaration_body */
    ;

// Declaration_body
//    : [Formal_arguments] Query_mark_opt [Feature_value]
//    ;

Query_mark_opt
    :  // empty
    | COLON Type /* Type_mark */ Assigner_mark_opt
    ;

Type_mark_opt
    :  // empty
    | COLON Type /* Type_mark */
    ;
	
// Type_mark
//    : COLON Type
//    ;

Feature_value_opt
    :  // empty
    | Explicit_value_opt Obsolete_opt /* Header_comment */ Attribute_or_routine_opt
    ;

Explicit_value_opt
    :  // empty
	| EQUAL Manifest_constant
    ;

// New feature lists

New_feature_list
    :                        New_feature
    | New_feature_list COMMA New_feature
    ;

New_feature
    :        IDENTIFIER Alias_opt // Extended_feature_name
    | FROZEN IDENTIFIER Alias_opt // Extended_feature_name
    ;

// Feature bodies

Attribute_or_routine_opt
    :  // empty
    | Precondition_opt Local_declarations_opt Feature_body Postcondition_opt Rescue_opt END
    ;

Feature_body
    : DEFERRED    // Deferred
    | Effective_routine
    | ATTRIBUTE Compound  // Attribute
    ;

// Feature names

// Extended_feature_name
// //  : IDENTIFIER //  Feature_name
//    : IDENTIFIER Alias_opt
//    ;

// Feature_name
//    : IDENTIFIER
//    ;

Alias_opt
    :  // empty
    | ALIAS Manifest_string /* '"' Alias_name '"' */ Convert_opt
    ;

// Alias_name
//    : Operator
//    | LBRACKET RBRACKET  /* Bracket */
//    ;

// Bracket
//    : LBRACKET RBRACKET
//    ;

Convert_opt
    :  // empty
    | CONVERT
	;
	
// Operators

// Operator
//    : Unary
//    | Binary
//    ;

Unary
    : NOT
    | PLUS    //  +
    | MINUS   //  -
    | Free_unary
    ;

Binary
    : PLUS            //  +
    | MINUS           //  -
    | STAR            //  *
    | SLASH           //  /
    | SLASH_SLASH     //  //
    | BSLASH_BSLASH   //  \\
    | CARET           //  ^
    | DOT_DOT         //  ..
    | LESS            //  <
    | GREATER         //  >
    | LESS_EQUAL      // <=
    | GREATER_EQUAL   //  >=
    | AND
    | OR
    | XOR
    | AND THEN
    | OR ELSE
    | IMPLIES
    | Free_binary
    ;

Free_unary
    : Manifest_string
    ;
	
Free_binary
    : Manifest_string
    ;
	
// Note:
// Free_unary and Free_binary are free operators that are distinct from (respectively)
// the standard unary and binary operators (one- or two-character symbols) explicitly
// listed in the Unary and Binary productions.
// See Definition: Free operator in the standard for more precision.

// Assigner marks

Assigner_mark_opt
    :  // empty
    | ASSIGN IDENTIFIER /* Feature_name */
    ;

// Inheritance parts

Inheritance_opt
    :  // empty
    | Inheritance
    ;
	
Inheritance
    :             Inherit_clause
    | Inheritance Inherit_clause
    ;

Inherit_clause
    : INHERIT                                          Parent_list
    | INHERIT LBRACE NONE RBRACE /* Non_conformance */ Parent_list
    ;

// Non_conformance
//    : LBRACE NONE RBRACE
//    ;

Parent_list
    :                       Parent
    | Parent_list SEMICOLON Parent
    ;

Parent
    : Class_type Feature_adaptation_opt
    ;

Feature_adaptation_opt
    :  // empty
    | Undefine_opt Redefine_opt Rename_opt New_exports_opt Select_opt END
    ;

// Rename clauses

Rename_opt
    :  // empty
    | RENAME Rename_list
    ;

Rename_list
    :                   Rename_pair
    | Rename_list COMMA Rename_pair
    ;

Rename_pair
    : IDENTIFIER /* Feature_name */ AS IDENTIFIER Alias_opt /* Extended_feature_name */
    ;

// Clients

Clients_opt
    :  // empty
    | Clients
    ;
	
Clients 
    : LBRACE Class_list RBRACE
	;

Class_list
    :                  IDENTIFIER /* Class_name */
	| Class_list COMMA IDENTIFIER /* Class_name */
	;

// Export adaptation

New_exports_opt
    :  // empty
    | EXPORT New_export_list
	;

New_export_list
    :                           New_export_item
	| New_export_list SEMICOLON New_export_item
	;

New_export_item
    : Clients                Feature_set
//  | Clients /* Header_comment */ Feature_set
	;

Feature_set
    : Feature_list
    | ALL
	;

Feature_list
    :                    IDENTIFIER /* Feature_name */
	| Feature_list COMMA IDENTIFIER /* Feature_name */
	;

// Formal argument and entity declarations

Formal_arguments_opt
    :  // empty
    | Formal_arguments
    ;
	
Formal_arguments
    : LPAREN Entity_declaration_list RPAREN
	;

Entity_declaration_list_opt
    :  // empty
    | Entity_declaration_list
    ;

Entity_declaration_list
    :                                   Entity_declaration_group
    | Entity_declaration_list SEMICOLON Entity_declaration_group
	;

Entity_declaration_group
    : Identifier_list COLON Type /* Type_mark */
	;

Identifier_list
    :                       IDENTIFIER
    | Identifier_list COMMA IDENTIFIER
	;

// Routine bodies

// Deferred
//    : DEFERRED
//    ;

Effective_routine
    : Internal
    | External
	;

Internal
    : DO                          Compound   // Routine_mark
    | ONCE                        Compound   // Routine_mark - Once
    | ONCE LPAREN Key_list RPAREN Compound   // Routine_mark - Once
    ;

// Routine_mark
//    : DO
//    | Once
//    ;

// Once
//    : ONCE
//    | ONCE LPAREN Key_list RPAREN
//    ;

Key_list
    :                Manifest_string
    | Key_list COMMA Manifest_string
	;

// Local variable declarations

Local_declarations_opt
    :  // empty
    | LOCAL Entity_declaration_list_opt
	;

// Instructions

Compound 
    :                    Instruction
    | Compound SEMICOLON Instruction
	;

Instruction
    : Creation_instruction
    | Call
	
    | Variable COLON_EQUAL /* := */ Expression  // Assignment
    | Expression COLON_EQUAL Expression         // Assigner_call
	
    | Conditional
    | Multi_branch
    | Loop
	
    | DEBUG                        Compound END  // Debug
    | DEBUG LPAREN Key_list RPAREN Compound END  // Debug
	
    | Precursor
	
    | CHECK Assertion       END  // Check
    | CHECK Assertion Notes END  // Check
	
    | RETRY  // Retry
    ;

// Assertions

Precondition_opt
    :  // empty
    | REQUIRE      Assertion
    | REQUIRE ELSE Assertion
	;

Postcondition_opt
    :  // empty
    | ENSURE      Assertion Only_opt
	| ENSURE THEN Assertion Only_opt
	;

Invariant_opt
    :  // empty
    | INVARIANT Assertion
	;

Assertion
    :  // empty
    | Real_Assertion
    ;
	
Real_Assertion
    :                          Assertion_clause
    | Real_Assertion SEMICOLON Assertion_clause
    ;

Assertion_clause
    :                                 Unlabeled_assertion_clause
    | IDENTIFIER COLON /* Tag_mark */ Unlabeled_assertion_clause
    ;

Unlabeled_assertion_clause
    : Boolean_expression
//  | Comment
    | CLASS
    ;

// Tag_mark ::= Tag ":"

// Tag
//    : IDENTIFIER
//    ;

// Note:
//  Unlabeled_assertion_clause of the form class can be used only in a postcondition.
// It marks a feature that does not depend on object state and can be called
// without a target object using non-object call of the form {CLASS_NAME}.feature_name (arguments).

// "Old" postcondition expressions

// Old
//    : OLD Expression
//    ;

// "Only" postcondition clauses

Only_opt
    :  // empty
    | ONLY
    | ONLY Feature_list
    ;

// Check instructions

// Check
//    : CHECK Assertion       END
//    | CHECK Assertion Notes END
//    ;

// Variants

Variant_opt
    :  // empty
    | VARIANT                                 Expression
    | VARIANT IDENTIFIER COLON /* Tag_mark */ Expression
	;

// Precursor

Precursor
    : PRECURSOR Parent_qualification_opt Actuals_opt
	;

Parent_qualification_opt
    :  // empty
    | LBRACE IDENTIFIER /* Class_name */ RBRACE
	;

// Redefinition

Redefine_opt
    :  // empty
    | REDEFINE Feature_list
	;

// Undefine clauses

Undefine_opt
    :  // empty
    | UNDEFINE Feature_list
	;

// Types

Type
    : Class_type // Class_or_tuple_type
    | TUPLE Tuple_parameter_list_opt // Tuple_type // Class_or_tuple_type
    | QUESTION IDENTIFIER /* Formal_generic_name */
	      // Another kind of Formal_generic_name - just IDENTIFIER -
          // is covered by Class_type branch
    | Anchored
    ;

// Class_or_tuple_type
//    : Class_type
//    | Tuple_type
//    ;

Class_type
    :                 IDENTIFIER /* Class_name */ Actual_generics_opt
    | Attachment_mark IDENTIFIER /* Class_name */ Actual_generics_opt
	;

Attachment_mark
    : QUESTION     // ?
    | EXCLAMATION  // !
	;

Anchored
    :                 LIKE Anchor
    | Attachment_mark LIKE Anchor
	;

Anchor
    : IDENTIFIER /* Feature_name */
    | CURRENT   // Current
    ;

// Actual generic parameters

Actual_generics_opt
    :  // empty
    | LBRACKET Type_list RBRACKET
    ;

Type_list
    :                 Type
    | Type_list COMMA Type
    ;

// Formal generic parameters

Formal_generics_opt
    :  // empty
    | LBRACKET Formal_generic_list RBRACKET
    ;

Formal_generic_list
    :                           Formal_generic
    | Formal_generic_list COMMA Formal_generic
    ;

Formal_generic
    :        Formal_generic_name Constraint_opt
    | FROZEN Formal_generic_name Constraint_opt
    ;

Formal_generic_name
    :          IDENTIFIER
    | QUESTION IDENTIFIER
	;

// Generic constraints

Constraint_opt
    :  // empty
    | ARROW /* -> */ Constraining_types Constraint_creators_opt
    ;

Constraining_types
    : Single_constraint 
    | LBRACE Constraint_list RBRACE // Multiple_constraint
    ;

Single_constraint
    : Type Renaming_opt
    ;

Renaming_opt
    :  // empty
    | RENAME Rename_list /* Rename */ END
    ;

// Multiple_constraint
//    : LBRACE Constraint_list RBRACE
//    ;

Constraint_list
    :                       Single_constraint
    | Constraint_list COMMA Single_constraint
    ;

Constraint_creators_opt
    :  // empty
    | CREATE Feature_list END
    ;

// Manifest arrays

Manifest_array
    : Manifest_array_type_opt LESS_LESS Expression_list GREATER_GREATER  // << ... >>
    ;

Manifest_array_type_opt
    :  // empty
    | LBRACE Type RBRACE
    ;

Expression_list  // may be empty
    :                       Expression
    | Expression_list COMMA Expression
	;

// Tuple types

// Tuple_type
//    : TUPLE Tuple_parameter_list_opt  // TUPLE
//    ;

Tuple_parameter_list_opt
    :  // empty
    | LBRACKET Tuple_parameters RBRACKET
    ;

Tuple_parameters
    : Type_list
    | Entity_declaration_list
    ;

// Manifest tuples

Manifest_tuple
    : LBRACKET Expression_list RBRACKET
    ;

// Converter clauses

Converters_opt
    :  // empty
    | CONVERT Converter_list
    ;

Converter_list
    :                      Converter
    | Converter_list COMMA Converter
    ;

Converter
    : IDENTIFIER /* Feature_name */ LPAREN LBRACE Type_list RBRACE LPAREN // Conversion_procedure
    | IDENTIFIER /* Feature_name */ COLON LBRACE Type_list RBRACE         // Conversion_query
    ;

// Conversion_procedure
//    : IDENTIFIER /* Feature_name */ LPAREN LBRACE Type_list RBRACE LPAREN
//    ;

// Conversion_query
//    : IDENTIFIER /* Feature_name */ COLON LBRACE Type_list RBRACE
//    ;

// Select clauses

Select_opt
    :  // empty
    | SELECT Feature_list
    ;

// Conditionals

Conditional
    : IF Then_part_list Else_part_opt END
    ;

Then_part_list
    :                       Then_part
    | Then_part_list ELSEIF Then_part
    ;

Then_part
    : Boolean_expression THEN Compound
    ;

Else_part_opt
    :  // empty
    | ELSE Compound
    ;

Conditional_expression
    : IF Then_part_expression_list ELSE Expression END
    ;

Then_part_expression_list
    :                                  Then_part_expression
    | Then_part_expression_list ELSEIF Then_part_expression
    ;

Then_part_expression
    : Boolean_expression THEN Expression
    ;

// Multi-branch instructions

Multi_branch
    : INSPECT Expression When_part_list_opt Else_part_opt END
    ;

When_part_list_opt
    :  // empty
    | When_part_list
    ;
	
When_part_list
    :                When_part
    | When_part_list When_part
    ;

When_part
    : WHEN Choices THEN Compound
    ;

Choices
    :               Choice
    | Choices COMMA Choice
    ;

Choice
    : Constant      x_Interval_tail_opt      // Single constant OR Constant_interval
    | Manifest_type x_Type_interval_tail_opt // Single type OR Type_interval
    ;

x_Interval_tail_opt
    :  // empty
	| DOT_DOT Constant
    ;
	
x_Type_interval_tail_opt
    :  // empty
    | DOT_DOT Manifest_type
    ;
	
// Constant_interval
//    : Constant DOT_DOT Constant
//    ;

// Type_interval
//    : Manifest_type DOT_DOT Manifest_type
//    ;

// Loops

Loop
    : Iteration_opt Initialization_opt Invariant_opt Exit_condition_opt Loop_body Variant_opt END
    ;

Iteration_opt
    :  // empty
    | ACROSS Expression AS IDENTIFIER
    ;

Initialization_opt
    :  // empty
    | FROM Compound
    ;

Exit_condition_opt
    :  // empty
    | UNTIL Boolean_expression
    ;

Loop_body
    : LOOP Compound
    | ALL  Boolean_expression
    | SOME Boolean_expression
    ;

// Debug instructions

// Debug
//    : DEBUG                        Compound END
//    | DEBUG LPAREN Key_list RPAREN Compound END
//    ;

// Attribute bodies

// Attribute
//    : ATTRIBUTE Compound
//    ;

// Entities and variables

Entity
    : Variable
    | Read_only
    ;

Variable
    : IDENTIFIER /* Feature_name */  // Variable_attribute AND (maybe) a Local
    | RESULT // part of Local production
    ;

// Variable_attribute
//    : Feature_name
//    ;

Local
    : IDENTIFIER
    | RESULT   //  Result
    ;

Read_only
    : IDENTIFIER     // Formal
//  | Feature_name   // Constant_attribute -- covered by the prev. branch
    | CURRENT        // Current
    ;

// Formal
//    : IDENTIFIER
//    ;

// Constant_attribute
//    : Feature_name
//    ;

// Creators parts

Creators_opt
    :  // empty
    | Creators
    ;

Creators
    :          Creation_clause
    | Creators Creation_clause
    ;

Creation_clause
    : CREATE Clients_opt /* Header_comment */ Creation_procedure_list
    ;

Creation_procedure_list
    :                               IDENTIFIER /* Creation_procedure */
    | Creation_procedure_list COMMA IDENTIFIER /* Creation_procedure */
    ;

// Creation_procedure
//    : IDENTIFIER /* Feature_name */
//    ;

// Creation instructions

Creation_instruction
    : CREATE Explicit_creation_type_opt Creation_call
    ;

Explicit_creation_type_opt
    :  // empty
    | LBRACE Type RBRACE
    ;

Creation_call
    : Variable Explicit_creation_call_opt
    ;

Explicit_creation_call_opt
    :  // empty
    | DOT Unqualified_call
    ;

// Creation expressions

Creation_expression
    : CREATE Explicit_creation_type_opt Explicit_creation_call_opt
    ;

// Equality expressions

Equality
    : Expression Comparison Expression
    ;

Comparison
    : EQUAL         // =
    | SLASH_EQUAL   //  /=
    | TILDE         //  ~
    | SLASH_TILDE   //  /~
    ;

// Assignments

// Assignment
//    : Variable COLON_EQUAL Expression  // :=
//    ;

// Assigner calls

// Assigner_call
//    : Expression COLON_EQUAL Expression
//    ;

// Feature calls

Call
    : Object_call
    | Non_object_call
    ;

Object_call
    :            Unqualified_call
    | Target DOT Unqualified_call
    ;

Unqualified_call
    : IDENTIFIER /* Feature_name */ Actuals_opt
    ;

Target
    : Local
    | Read_only
    | Call
    | LPAREN Expression RPAREN // Parenthesized_target
    ;

// Parenthesized_target ::= ( Expression )

Non_object_call
    : LBRACE Type RBRACE DOT Unqualified_call
    ;

// Actual arguments

Actuals_opt
    :  // empty
    | Actuals
    ;
	
Actuals
    : LPAREN Actual_list RPAREN
    ;

Actual_list
    :                   Expression
    | Actual_list COMMA Expression
    ;

// Object test

Object_test
    : LBRACE IDENTIFIER COLON Type RBRACE Expression
    ;

// Rescue clauses

Rescue_opt
    :  // empty
    | RESCUE Compound
    ;

// Retry
//    : RETRY
//    ;

// Agents

Agent
    : Call_agent
    | Inline_agent
    ;

Call_agent
    : AGENT Call_agent_body
    ;

Inline_agent
    : AGENT Formal_arguments_opt Type_mark_opt Attribute_or_routine_opt Agent_actuals_opt
    ;

// Call agent bodies

Call_agent_body
    : Agent_qualified
    | Agent_unqualified
    ;

Agent_qualified
    : Agent_target DOT Agent_unqualified
    ;

Agent_unqualified
    : IDENTIFIER /* Feature_name */ Agent_actuals_opt
    ;

Agent_target
    : Entity
    | Parenthesized
    | Manifest_type
    ;

Agent_actuals_opt
    :  // empty
    | LPAREN Agent_actual_list RPAREN
    ;

Agent_actual_list
    :                         Agent_actual
    | Agent_actual_list COMMA Agent_actual
    ;

Agent_actual
    : Expression
    |               QUESTION   // Placeholder
    | Manifest_type QUESTION   // Placeholder
    ;

// Placeholder
//    :               QUESTION
//    | Manifest_type QUESTION
//    ;
	
// Expressions

Expression
    : Basic_expression
    | Special_expression
    ;

Basic_expression
    : Read_only
    | Local
    | Call
    | Precursor
    | Equality
    | Parenthesized
    | OLD Expression  // Old
    | Operator_expression
    | Bracket_expression
    | Creation_expression
    | Conditional_expression
    ;

Special_expression
    : Manifest_constant
    | Manifest_array
    | Manifest_tuple
    | Agent
    | Object_test
    | Once_string
    | Address
    ;

Parenthesized
    : LPAREN Expression RPAREN
    ;

Address
    : DOLLAR Variable
    ;

Once_string
    : ONCE Manifest_string
    ;

Boolean_expression
    : Basic_expression
    | Boolean_constant
    | Object_test
    ;

// Operator expressions

Operator_expression
    : Unary_expression
    | Binary_expression
    ;

Unary_expression
    : Unary Expression
    ;

Binary_expression
    : Expression Binary Expression
    ;

// Bracket expressions

Bracket_expression
    : Bracket_target RBRACKET Actuals LBRACKET
    ;

Bracket_target
    : Target
    | Once_string
    | Manifest_constant
    | Manifest_tuple
    ;

// Constants

Constant
    : Manifest_constant
    | IDENTIFIER /* Feature_name */  // Constant_attribute
    ;

// Constant_attribute ::= Feature_name

// Manifest constants

Manifest_constant
    :               Manifest_value
    | Manifest_type Manifest_value
    ;

Manifest_type
    : LBRACE Type RBRACE
    ;

Manifest_value
    : Boolean_constant
    | Character_constant
    | Integer_constant
    | Real_constant
    | Manifest_string
    | Manifest_type
    ;

/********************

Sign ::= "+" | "-"

Integer_constant ::= [Sign] Integer

Character_constant ::= " ' " Character " ' "

Boolean_constant ::= True | False

Real_constant ::= [Sign] Real

// Manifest strings

Manifest_string ::= Basic_manifest_string | Verbatim_string

Basic_manifest_string ::= ' " ' String_content ' " '

String_content ::= {Simple_string Line_wrapping_part ...}+

Verbatim_string ::= Verbatim_string_opener Line_sequence Verbatim_string_closer

Verbatim_string_opener ::= ' " ' [Simple_string] Open_bracket

Verbatim_string_closer ::= Close_bracket [Simple_string] ' " '

Open_bracket ::= "[" | "{"

Close_bracket ::= "]" | "}"

Line_sequence ::= {Simple_string New_line ...}+

// Note:
// Exactly the same Simple_string (including embedded white space, if any)
// should be used in Verbatim_string_opener and Verbatim_string_closer
// of the same verbatim string.

********************/

// External routines

External
    : EXTERNAL Manifest_string /* External_language */ External_name_opt
    ;

// External_language ::= Unregistered_language | Registered_language
//
// Unregistered_language ::= Manifest_string

External_name_opt
    :  // empty
    | ALIAS Manifest_string
    ;

/***************

// Note:
// If the inline keyword is used in the Registered_language part,
// then External_name part is the inline code on the specified language.

// Registered languages

Registered_language ::= C_external | C++_external | DLL_external

// External signatures

External_signature ::= signature [External_argument_types] [: External_type]

External_argument_types ::= "(" External_type_list ")"

External_type_list ::= {External_type "," ...}*

External_type ::= Simple_string

// External file use

External_file_use ::= use External_file_list

External_file_list ::= {External_file "," ... }+

External_file ::= External_user_file | External_system_file

External_user_file ::= ' " ' Simple_string ' " '

External_system_file ::= "<" Simple_string ">"

// C externals

C_external ::= ' " ' C [inline] [ External_signature ] [ External_file_use ] ' " '

// C++ externals

C++_external ::= ' " ' C++ inline [ External_signature ] [ External_file_use ] ' " '

// DLL externals

DLL_external ::= ' " ' dll [windows] DLL_identifier [DLL_index] [[ External_signature ] [ External_file_use ] ' " '

DLL_identifier ::= Simple_string

DLL_index ::= Integer

// Comments

Comment ::= "- -" {Simple_string Comment_break ...}*

Comment_break ::= New_line [Blanks_or_tabs] "- -"

// Integers

Integer ::= [Integer_base] Digit_sequence

Integer_base ::= "0" Integer_base_letter

Integer_base_letter ::= "b" | "c" | "x" | "B" | "C" | "X"

Digit_sequence ::= Digit+

Digit ::= "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" | "a" | "b" | "c" | "d" | "e" | "f" | "A" | "B" | "C" | "D" | "E" | "F" | "_"

**************/

