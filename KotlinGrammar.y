%token ABSTRACT
%token ACTUAL
%token ANNOTATION
%token AS
%token AS_QUEST
%token BREAK
%token BREAK_AT
%token BY
%token CATCH
%token CLASS
%token COMPANION
%token CONST
%token CONSTRUCTOR
%token CONTINUE
%token CONTINUE_AT
%token CROSSINLINE
%token DATA
%token DELEGATE
%token DO
%token DYNAMIC
%token ELSE
%token ENUM
%token EXTERNAL
%token EXPECT
%token FIELD
%token FILE
%token FINAL
%token FINALLY
%token FOR
%token FUN
%token GET
%token IF
%token IMPORT
%token IN
%token NOT_IN
%token INFIX
%token INIT
%token INLINE
%token INNER
%token INTERFACE
%token INTERNAL
%token IS
%token LATEINIT
%token NOINLINE
%token NOT_IS
%token NULL
%token OBJECT
%token OPEN
%token OPERATOR
%token OUT
%token OVERRIDE
%token PACKAGE
%token PARAM
%token PUBLIC
%token PRIVATE
%token PROPERTY
%token PROTECTED
%token RECEIVER
%token REIFIED
%token RETURN
%token RETURN_AT
%token SEALED
%token SET
%token SETPARAM
%token SUPER
%token SUPER_AT
%token SUSPEND
%token TAILREC
%token THIS
%token THIS_AT
%token THROW
%token TRY
%token TYPEALIAS
%token VAL
%token VAR
%token VARARG
%token WHEN
%token WHERE
%token WHILE

%token COLON
%token COLON_COLON
%token SEMICOLON
%token COMMA
%token APOSTROPH
%token QUOTE
%token TRIPLE_QUOTE
%token TRIPLE_QUOTE_CLOSE
%token DOT
%token DOT_DOT
%token ARROW
%token AT
%token AT_PRE_WS
%token AT_POST_WS
%token EXCL
%token EXCL_WS
%token QUEST
%token QUEST_WS
%token PLUS
%token PLUS_PLUS
%token PLUS_EQUAL
%token MINUS
%token MINUS_MINUS
%token MINUS_EQUAL
%token ASTERISK
%token MULTIPLY_EQUAL
%token SLASH
%token DIVIDE_EQUAL
%token PERCENT
%token MOD_EQUAL
%token EQUAL
%token EQUAL_EQUAL
%token EQUAL_EQUAL_EQUAL
%token NOT_EQUAL
%token NOT_EQUAL_EQUAL
%token LESS_THAN
%token LESS_THAN_EQUAL
%token GREATER_THAN
%token GREATER_THAN_EQUAL
%token LAZY_OR
%token LAZY_AND

%token L_PAREN
%token R_PAREN
%token L_CURL_PAREN
%token DOLLAR_L_CURL_PAREN
%token R_CURL_PAREN
%token L_SQUARE_PAREN
%token R_SQUARE_PAREN

%token EOF

%token IDENTIFIER

%token MULTI_LINE_STR_TEXT
%token MULTI_LINE_STR_REF
%token LINE_STR_ESCAPED_CHAR
%token LINE_STR_TEXT
%token LINE_STR_REF
%token BOOLEAN_LITERAL
%token CHARACTER_LITERAL
%token INTEGER_LITERAL
%token BIN_LITERAL
%token HEX_LITERAL
%token REAL_LITERAL
%token LONG_LITERAL
%token UNSIGNED_LITERAL
%token SHEBANG_LINE

%%

// start
// kotlinFile
//   : shebangLine? fileAnnotation* packageHeader importList topLevelObject* EOF
//   ;

// start
// script
//   : shebangLine? fileAnnotation* packageHeader importList (statement semi)* EOF
//   ;

x_file
    : x_shebang_line_opt x_file_annotation_seq_opt packageHeader x_import_list_opt x_top_level_object_seq_opt EOF
    | x_shebang_line_opt x_file_annotation_seq_opt packageHeader x_import_list_opt x_statement_semi_seq_opt EOF
    ;

x_statement_semi_seq_opt
    :
    | x_statement_semi_seq_opt statement semi
    ;

// shebangLine (used by kotlinFile, script)
//   : ShebangLine
//   ;
x_shebang_line_opt
    :
    | SHEBANG_LINE
    ;

// fileAnnotation (used by kotlinFile, script)
//   : ('@' | AT_PRE_WS) 'file' ':' (('[' unescapedAnnotation+ ']') | unescapedAnnotation)
//   ;
fileAnnotation
    : x_at_or_at_pre_ws FILE COLON x_unescaped_annotation_seq_or_single
    ;

x_file_annotation_seq_opt
    :
    | x_file_annotation_seq_opt fileAnnotation
    ;

x_unescaped_annotation_seq_or_single
    : L_SQUARE_PAREN x_unescaped_annotation_seq R_SQUARE_PAREN
    | unescapedAnnotation
    ;

// packageHeader (used by kotlinFile, script)
//   : ('package' identifier semi?)?
//   ;
packageHeader
    :
    | PACKAGE identifier x_semi_opt
    ;

// importList (used by kotlinFile, script)
//   : importHeader*
//   ;
importList
    :            importHeader
    | importList importHeader
    ;
	
x_import_list_opt
    :  // empty
    | importList
    ;

// importHeader (used by importList)
//   : 'import' identifier (('.' '*') | importAlias)? semi?
//   ;
importHeader
    : IMPORT identifier x_dot_asterisk_or_import_alias_opt x_semi_opt
    ;

x_dot_asterisk_or_import_alias_opt
    :
    | DOT ASTERISK
    | importAlias
    ;

// importAlias (used by importHeader)
//   : 'as' simpleIdentifier
//   ;
importAlias
    : AS simpleIdentifier
    ;

// topLevelObject (used by kotlinFile)
//   : declaration semis?
//   ;
topLevelObject
    : declaration x_semis_opt
    ;

x_top_level_object_seq_opt
    :  // empty
    | x_top_level_object_seq
    ;
	
x_top_level_object_seq
    :                        topLevelObject
    | x_top_level_object_seq topLevelObject
    ;

// typeAlias (used by declaration)
//   : modifiers? 'typealias' simpleIdentifier typeParameters? '=' type
//   ;
typeAlias
    : x_modifiers_opt TYPEALIAS simpleIdentifier x_type_parameters_opt EQUAL type
    ;

// declaration (used by topLevelObject, classMemberDeclaration, statement)
//   : classDeclaration
//   | objectDeclaration
//   | functionDeclaration
//   | propertyDeclaration
//   | typeAlias
//   ;
declaration
    : classDeclaration
    | objectDeclaration
    | functionDeclaration
    | propertyDeclaration
    | typeAlias
    ;

// classDeclaration (used by declaration)
//   : modifiers? ('class' | 'interface')
//     simpleIdentifier typeParameters?
//     primaryConstructor?
//     (':' delegationSpecifiers)?
//     typeConstraints?
//     (classBody | enumClassBody)?
//   ;
classDeclaration
    : x_modifiers_opt x_class_or_interface simpleIdentifier x_type_parameters_opt x_primary_constructor_opt
        x_colon_delegation_specifiers_opt x_type_constraints_opt x_class_body_or_enum_class_body_opt
    ;

x_class_or_interface
    : CLASS
    | INTERFACE
    ;

x_class_body_or_enum_class_body_opt
    :
    | classBody
    | enumClassBody
    ;

// primaryConstructor (used by classDeclaration)
//   : (modifiers? 'constructor')? classParameters
//   ;
primaryConstructor
    : classParameters
    | x_modifiers_opt CONSTRUCTOR classParameters
    ;

x_primary_constructor_opt
    :
    | primaryConstructor
    ;

// classBody (used by classDeclaration, companionObject, objectDeclaration, enumEntry, objectLiteral)
//   : '{' classMemberDeclarations '}'
//   ;
classBody
    : L_CURL_PAREN classMemberDeclarations R_CURL_PAREN
    ;

x_class_body_opt
    :
    | classBody
    ;

// classParameters (used by primaryConstructor)
//   : '(' (classParameter (',' classParameter)*)? ')'
//   ;
classParameters
    : L_PAREN R_PAREN
    | L_PAREN x_class_parameter_list R_PAREN
    ;

// classParameter (used by classParameters)
//   : modifiers? ('val' | 'var')? simpleIdentifier ':' type ('=' expression)?
//   ;
classParameter
    : x_modifiers_opt x_val_or_var_opt simpleIdentifier COLON type x_equal_expression_opt
    ;

x_class_parameter_list
    : classParameter
    | x_class_parameter_list COMMA classParameter
    ;

// delegationSpecifiers (used by classDeclaration, companionObject, objectDeclaration, objectLiteral)
//   : annotatedDelegationSpecifier (',' annotatedDelegationSpecifier)*
//   ;
delegationSpecifiers
    : x_annotation_seq_opt delegationSpecifier
    | delegationSpecifiers COMMA annotatedDelegationSpecifier
    ;

// delegationSpecifier (used by annotatedDelegationSpecifier)
//   : constructorInvocation
//   | explicitDelegation
//   | userType
//   | functionType
//   ;
delegationSpecifier
    : constructorInvocation
    | explicitDelegation
    | userType
    | functionType
    ;

// constructorInvocation (used by delegationSpecifier, unescapedAnnotation)
//   : userType valueArguments
//   ;
constructorInvocation
    : userType valueArguments
    ;

// annotatedDelegationSpecifier (used by delegationSpecifiers)
//   : annotation* delegationSpecifier
//   ;
annotatedDelegationSpecifier
    : x_annotation_seq_opt delegationSpecifier
    ;

// explicitDelegation (used by delegationSpecifier)
//   : (userType | functionType) 'by' expression
//   ;
explicitDelegation
    : x_user_type_or_function_type BY disjunction
    ;

x_user_type_or_function_type
    : userType
    | functionType
    ;

// typeParameters (used by typeAlias, classDeclaration, functionDeclaration, propertyDeclaration)
//   : '<' typeParameter (',' typeParameter)* '>'
//   ;
typeParameters
    : LESS_THAN x_type_parameter_list GREATER_THAN
    ;

x_type_parameters_opt
    :
    | typeParameters
    ;

x_type_parameter_list
    : typeParameter
    | x_type_parameter_list COMMA typeParameter
    ;

// typeParameter (used by typeParameters)
//   : typeParameterModifiers? simpleIdentifier (':' type)?
//   ;
typeParameter
    : x_type_parameter_modifiers_opt simpleIdentifier x_colon_type_opt
    ;

x_type_parameter_modifiers_opt
    :
    | typeParameterModifiers
    ;

// typeConstraints (used by classDeclaration, functionDeclaration, propertyDeclaration, anonymousFunction)
//   : 'where' typeConstraint (',' typeConstraint)*
//   ;
typeConstraints
    : WHERE x_type_constraint_list
    ;

x_type_constraints_opt
    :
    | typeConstraints
    ;

x_type_constraint_list
    : typeConstraint
    | x_type_constraint_list COMMA typeConstraint
    ;

// typeConstraint (used by typeConstraints)
//   : annotation* simpleIdentifier ':' type
//   ;
typeConstraint
    : x_annotation_seq_opt simpleIdentifier COLON type
    ;

// classMemberDeclarations (used by classBody, enumClassBody)
//   : (classMemberDeclaration semis?)*
//   ;
classMemberDeclarations
    :
    | classMemberDeclarations classMemberDeclaration x_semis_opt
    ;

// classMemberDeclaration (used by classMemberDeclarations)
//   : declaration
//   | companionObject
//   | anonymousInitializer
//   | secondaryConstructor
//   ;
classMemberDeclaration
    : declaration
    | companionObject
    | anonymousInitializer
    | secondaryConstructor
    ;

// anonymousInitializer (used by classMemberDeclaration)
//   : 'init' block
//   ;
anonymousInitializer
    : INIT block
    ;

// companionObject (used by classMemberDeclaration)
//   : modifiers? 'companion' 'object' simpleIdentifier?
//     (':' delegationSpecifiers)?
//     classBody?
//   ;
companionObject
    : x_modifiers_opt COMPANION OBJECT x_simple_identifier_opt x_colon_delegation_specifiers_opt x_class_body_opt
    ;

// functionValueParameters (used by functionDeclaration, secondaryConstructor)
//   : '(' (functionValueParameter (',' functionValueParameter)*)? ')'
//   ;
functionValueParameters
    : L_PAREN R_PAREN
    | L_PAREN x_function_value_parameter_list R_PAREN
    ;

// functionValueParameter (used by functionValueParameters)
//   : parameterModifiers? parameter ('=' expression)?
//   ;
functionValueParameter
    : x_parameter_modifiers_opt parameter x_equal_expression_opt
    ;

x_function_value_parameter_list
    : functionValueParameter
    | x_function_value_parameter_list COMMA functionValueParameter
    ;

// functionDeclaration (used by declaration)
//   : modifiers? 'fun' typeParameters?
//     (receiverType '.')?
//     simpleIdentifier functionValueParameters
//     (':' type)? typeConstraints?
//     functionBody?
//   ;
functionDeclaration
    : x_modifiers_opt FUN x_type_parameters_opt x_receiver_type_dot_opt simpleIdentifier functionValueParameters
        x_colon_type_opt x_type_constraints_opt x_function_body_opt
    ;

// functionBody (used by functionDeclaration, getter, setter, anonymousFunction)
//   : block
//   | '=' expression
//   ;
functionBody
    : block
    | x_equal_expression
    ;

x_function_body_opt
    :
    | functionBody
    ;

// variableDeclaration (used by multiVariableDeclaration, propertyDeclaration, forStatement, lambdaParameter, whenSubject)
//   : annotation* simpleIdentifier (':' type)?
//   ;
variableDeclaration
    : x_annotation_seq_opt simpleIdentifier x_colon_type_opt
    ;

x_variable_declaration_list
    : variableDeclaration
    | x_variable_declaration_list COMMA variableDeclaration
    ;

// multiVariableDeclaration (used by propertyDeclaration, forStatement, lambdaParameter)
//   : '(' variableDeclaration (',' variableDeclaration)* ')'
//   ;
multiVariableDeclaration
    : L_PAREN x_variable_declaration_list R_PAREN
    ;

// propertyDeclaration (used by declaration)
//   : modifiers? ('val' | 'var') typeParameters?
//     (receiverType '.')?
//     (multiVariableDeclaration | variableDeclaration)
//     typeConstraints?
//     (('=' expression) | propertyDelegate)? ';'?
//     ((getter? (semi? setter)?) | (setter? (semi? getter)?))
//   ;
propertyDeclaration
    : x_modifiers_opt x_val_or_var x_type_parameters_opt x_receiver_type_dot_opt x_multi_or_single_variable_declaration
        x_type_constraints_opt x_equal_expression_or_property_delegate_opt x_semicolon_opt 
        x_getter_setter_or_setter_getter
    ;

x_equal_expression_or_property_delegate_opt
    :
    | x_equal_expression
    | propertyDelegate
    ;

x_getter_setter_or_setter_getter
    : x_getter_opt x_semi_setter_opt
    | x_setter_opt x_semi_getter_opt
    ;

x_semi_setter_opt
    :
    | x_semi_opt setter
    ;

x_semi_getter_opt
    :
    | x_semi_opt getter
    ;

// propertyDelegate (used by propertyDeclaration)
//   : 'by' expression
//   ;
propertyDelegate
    : BY disjunction
    ;

// getter (used by propertyDeclaration)
//   : modifiers? 'get'
//   | modifiers? 'get' '(' ')'
//     (':' type)?
//     functionBody
//   ;
getter
    : x_modifiers_opt GET
    | x_modifiers_opt GET L_PAREN R_PAREN x_colon_type_opt functionBody
    ;

x_getter_opt
    :
    | getter
    ;

// setter (used by propertyDeclaration)
//   : modifiers? 'set'
//   | modifiers? 'set' '(' parameterWithOptionalType ')' (':' type)?
//     functionBody
//   ;
setter
    : x_modifiers_opt SET
    | x_modifiers_opt SET L_PAREN parameterWithOptionalType R_PAREN  x_colon_type_opt functionBody
    ;

x_setter_opt
    :
    | setter
    ;

// parametersWithOptionalType (used by anonymousFunction)
//   : '(' (parameterWithOptionalType (',' parameterWithOptionalType)*)? ')'
//   ;
parametersWithOptionalType
    : L_PAREN R_PAREN
    | L_PAREN x_parameter_with_optional_type_list R_PAREN
    ;

// parameterWithOptionalType (used by setter, parametersWithOptionalType)
//   : parameterModifiers? simpleIdentifier (':' type)?
//   ;
parameterWithOptionalType
    : x_parameter_modifiers_opt simpleIdentifier x_colon_type_opt
    ;

x_parameter_with_optional_type_list
    : parameterWithOptionalType
    | x_parameter_with_optional_type_list COMMA parameterWithOptionalType
    ;

// parameter (used by functionValueParameter, functionTypeParameters)
//   : simpleIdentifier ':' type
//   ;
parameter
    : simpleIdentifier COLON type
    ;

// objectDeclaration (used by declaration)
//   : modifiers? 'object' simpleIdentifier (':' delegationSpecifiers)? classBody?
//   ;
objectDeclaration
    : x_modifiers_opt OBJECT simpleIdentifier x_colon_delegation_specifiers_opt x_class_body_opt
    ;

// secondaryConstructor (used by classMemberDeclaration)
//   : modifiers? 'constructor' functionValueParameters
//     (':' constructorDelegationCall)? block?
//   ;
secondaryConstructor
    : x_modifiers_opt CONSTRUCTOR functionValueParameters  x_colon_constructor_delegation_call_opt x_block_opt
    ;

x_colon_constructor_delegation_call_opt
    :
    | COLON constructorDelegationCall
    ;

// constructorDelegationCall (used by secondaryConstructor)
//   : 'this' valueArguments
//   | 'super' valueArguments
//   ;
constructorDelegationCall
    : THIS valueArguments
    | SUPER valueArguments
    ;

// enumClassBody (used by classDeclaration)
//   : '{' enumEntries? (';' classMemberDeclarations)? '}'
//   ;
enumClassBody
    : L_CURL_PAREN x_enum_entries_opt x_semicolon_class_member_declarations_opt R_CURL_PAREN
    ;

x_semicolon_class_member_declarations_opt
    :
    | SEMICOLON classMemberDeclarations
    ;

// enumEntries (used by enumClassBody)
//   : enumEntry (',' enumEntry)* ','?
//   ;
enumEntries
    : x_enum_entry_list
    | x_enum_entry_list COMMA
    ;

x_enum_entries_opt
    :
    | enumEntries
    ;

// enumEntry (used by enumEntries)
//   : modifiers? simpleIdentifier valueArguments? classBody?
//   ;
enumEntry
    : x_modifiers_opt simpleIdentifier x_value_arguments_opt x_class_body_opt
    ;

x_enum_entry_list
    : enumEntry
    | enumEntries COMMA enumEntry
    ;

// type (used by typeAlias, classParameter, typeParameter, typeConstraint, functionDeclaration, variableDeclaration, getter, setter, parameterWithOptionalType, parameter, typeProjection, functionType, functionTypeParameters, parenthesizedType, infixOperation, asExpression, lambdaParameter, anonymousFunction, superExpression, typeTest, catchBlock)
//   : typeModifiers? (parenthesizedType | nullableType | typeReference | functionType)
//   ;
type
    : x_type_modifiers_opt x_type_tail
    ;

x_type_tail
    : parenthesizedType
    | nullableType
    | typeReference
    | functionType
    ;

// typeReference (used by type, nullableType, receiverType)
//   : userType
//   | 'dynamic'
//   ;
typeReference
    : userType
    | DYNAMIC
    ;

// nullableType (used by type, receiverType)
//   : (typeReference | parenthesizedType) quest+
//   ;
nullableType
    : x_type_reference_or_parenthesized_type x_quest_seq
    ;

x_type_reference_or_parenthesized_type
    : typeReference
    | parenthesizedType
    ;

// quest (used by nullableType)
//   : '?'
//   | QUEST_WS
//   ;
quest
    : QUEST
    | QUEST_WS
    ;

x_quest_seq
    : quest
    | x_quest_seq quest
    ;

// userType (used by delegationSpecifier, constructorInvocation, explicitDelegation, typeReference, parenthesizedUserType, unescapedAnnotation)
//   : simpleUserType ('.' simpleUserType)*
//   ;
userType
    : simpleUserType
    | userType DOT simpleUserType
    ;

// simpleUserType (used by userType)
//   : simpleIdentifier typeArguments?
//   ;
simpleUserType
    : simpleIdentifier x_type_arguments_opt
    ;

// typeProjection (used by typeArguments)
//   : typeProjectionModifiers? type
//   | '*'
//   ;
typeProjection
    : x_type_projection_modifiers_opt type
    | ASTERISK
    ;

x_type_projection_list
    : typeProjection
    | x_type_projection_list COMMA typeProjection
    ;

// typeProjectionModifiers (used by typeProjection)
//   : typeProjectionModifier+
//   ;
typeProjectionModifiers
    : typeProjectionModifier
    | typeProjectionModifiers typeProjectionModifier
    ;

x_type_projection_modifiers_opt
    :
    | typeProjectionModifiers
    ;

// typeProjectionModifier (used by typeProjectionModifiers)
//   : varianceModifier
//   | annotation
//   ;
typeProjectionModifier
    : varianceModifier
    | annotation
    ;

// functionType (used by delegationSpecifier, explicitDelegation, type)
//   : (receiverType '.')? functionTypeParameters '->' type
//   ;
functionType
    : x_receiver_type_dot_opt functionTypeParameters ARROW type
    ;

// functionTypeParameters (used by functionType)
//   : '(' (parameter | type)? (',' (parameter | type))* ')'
//   ;
functionTypeParameters
    : L_PAREN x_parameter_or_type_list_opt R_PAREN
    ;

x_parameter_or_type
    : parameter
    | type
    ;

x_parameter_or_type_list_opt
    :
    | x_parameter_or_type
    | x_parameter_or_type_list_opt COMMA x_parameter_or_type
    ;

// parenthesizedType (used by type, nullableType, receiverType)
//   : '(' type ')'
//   ;
parenthesizedType
    : L_PAREN type R_PAREN
    ;

// receiverType (used by functionDeclaration, propertyDeclaration, functionType, callableReference)
//   : typeModifiers? (parenthesizedType | nullableType | typeReference)
//   ;
receiverType
    : x_type_modifiers_opt x_receiver_type_tail
    ;

x_receiver_type_tail
    : parenthesizedType
    | nullableType
    | typeReference
    ;

x_receiver_type_opt
    :
    | receiverType
    ;

// parenthesizedUserType (used by parenthesizedUserType)
//   : '(' userType ')'
//   | '(' parenthesizedUserType ')'
//   ;
// parenthesizedUserType
//     : L_PAREN userType R_PAREN
//     | L_PAREN parenthesizedUserType R_PAREN
//     ;

// statements (used by block, lambdaLiteral)
//   : (statement (semis statement)* semis?)?
//   ;
statements
    :
    | x_statement_list
    | x_statement_list semis
    ;

x_statement_list
    : statement
    | x_statement_list semis statement
    ;

// statement (used by script, statements, controlStructureBody)
//   : (label | annotation)* (declaration | assignment | loopStatement | expression)
//   ;
statement
    : x_label_or_annotation_seq_opt x_statement_tail
    ;

x_label_or_annotation
    : label
    | annotation
    ;

x_label_or_annotation_seq_opt
    :
    | x_label_or_annotation_seq_opt x_label_or_annotation
    ;

x_statement_tail
    : declaration
    | assignment
    | loopStatement
    | disjunction
    ;

// label (used by statement, unaryPrefix, annotatedLambda)
//   : simpleIdentifier ('@' | AT_POST_WS)
//   ;
label
    : simpleIdentifier x_at_or_at_post_ws
    ;

x_label_opt
    :
    | label
    ;

// controlStructureBody (used by forStatement, whileStatement, doWhileStatement, ifExpression, whenEntry)
//   : block
//   | statement
//   ;
controlStructureBody
    : block
    | statement
    ;

x_control_structure_body_opt
    :
    | controlStructureBody
    ;

// block (used by anonymousInitializer, functionBody, secondaryConstructor, controlStructureBody, tryExpression, catchBlock, finallyBlock)
//   : '{' statements '}'
//   ;
block
    : L_CURL_PAREN statements R_CURL_PAREN
    ;

x_block_opt
    :
    | block
    ;

// loopStatement (used by statement)
//   : forStatement
//   | whileStatement
//   | doWhileStatement
//   ;
loopStatement
    : forStatement
    | whileStatement
    | doWhileStatement
    ;

// forStatement (used by loopStatement)
//   : 'for'
//     '(' annotation* (variableDeclaration | multiVariableDeclaration) 'in' expression ')'
//     controlStructureBody?
//   ;
forStatement
    : FOR L_PAREN x_annotation_seq_opt x_multi_or_single_variable_declaration IN disjunction R_PAREN 
        x_control_structure_body_opt
    ;

// whileStatement (used by loopStatement)
//   : 'while' '(' expression ')' controlStructureBody
//   | 'while' '(' expression ')' ';'
//   ;
whileStatement
    : WHILE L_PAREN disjunction R_PAREN controlStructureBody
    | WHILE L_PAREN disjunction R_PAREN SEMICOLON
    ;

// doWhileStatement (used by loopStatement)
//   : 'do' controlStructureBody? 'while' '(' expression ')'
//   ;
doWhileStatement
    : DO x_control_structure_body_opt WHILE L_PAREN disjunction R_PAREN
    ;

// assignment (used by statement)
//   : directlyAssignableExpression '=' expression
//   | assignableExpression assignmentAndOperator expression
//   ;
assignment
    : directlyAssignableExpression EQUAL disjunction
    | assignableExpression assignmentAndOperator disjunction
    ;

// semi (used by script, packageHeader, importHeader, propertyDeclaration, whenEntry)
//   : EOF
//   ;
semi
    : EOF
    ;

x_semi_opt
    :
    | semi
    ;

// semis (used by topLevelObject, classMemberDeclarations, statements)
//   : EOF
//   ;
semis
    : EOF
    ;

x_semis_opt
    :
    | semis
    ;

// expression (used by classParameter, explicitDelegation, functionValueParameter, functionBody, propertyDeclaration, propertyDelegate, statement, forStatement, whileStatement, doWhileStatement, assignment, indexingSuffix, valueArgument, parenthesizedExpression, collectionLiteral, lineStringExpression, multiLineStringExpression, ifExpression, whenSubject, whenCondition, rangeTest, jumpExpression)
//   : disjunction
//   ;
//expression
//    : disjunction
//    ;

x_expression_opt
    :
    | disjunction // original rule: expression
    ;

x_expression_list
    :                         disjunction
    | x_expression_list COMMA disjunction
    ;

// disjunction (used by expression)
//   : conjunction ('||' conjunction)*
//   ;
disjunction
    :                     conjunction
    | disjunction LAZY_OR conjunction
    ;

// conjunction (used by disjunction)
//   : equality ('&&' equality)*
//   ;
conjunction
    :                      equality
    | conjunction LAZY_AND equality
    ;

// equality (used by conjunction)
//   : comparison (equalityOperator comparison)*
//   ;
equality
    :                           comparison
    | equality equalityOperator comparison
    ;

// comparison (used by equality)
//   : infixOperation (comparisonOperator infixOperation)?
//   ;
comparison
    : infixOperation
    | infixOperation comparisonOperator infixOperation
    ;

// infixOperation (used by comparison)
//   : elvisExpression ((inOperator elvisExpression) | (isOperator type))*
//   ;
infixOperation
    : elvisExpression x_infix_operation_tail_seq_opt
    ;

x_in_operator_elvis_expression
    : inOperator elvisExpression
    ;

x_infix_operation_tail
    : x_in_operator_elvis_expression
    | typeTest
    ;

x_infix_operation_tail_seq_opt
    :
    | x_infix_operation_tail_seq_opt x_infix_operation_tail
    ;

// elvisExpression (used by infixOperation)
//   : infixFunctionCall (elvis infixFunctionCall)*
//   ;
elvisExpression
    :                       infixFunctionCall
    | elvisExpression elvis infixFunctionCall
    ;

// elvis (used by elvisExpression)
//   : '?' ':'
//   ;
elvis
    : QUEST COLON
    ;

// infixFunctionCall (used by elvisExpression)
//   : rangeExpression (simpleIdentifier rangeExpression)*
//   ;
infixFunctionCall
    :                                    rangeExpression
    | infixFunctionCall simpleIdentifier rangeExpression
    ;

// rangeExpression (used by infixFunctionCall)
//   : additiveExpression ('..' additiveExpression)*
//   ;
rangeExpression
    :                         additiveExpression
    | rangeExpression DOT_DOT additiveExpression
    ;

// additiveExpression (used by rangeExpression)
//   : multiplicativeExpression (additiveOperator multiplicativeExpression)*
//   ;
additiveExpression
    :                                     multiplicativeExpression
    | additiveExpression additiveOperator multiplicativeExpression
    ;

// multiplicativeExpression (used by additiveExpression)
//   : asExpression (multiplicativeOperator asExpression)*
//   ;
multiplicativeExpression
    :                                                 asExpression
    | multiplicativeExpression multiplicativeOperator asExpression
    ;

// asExpression (used by multiplicativeExpression)
//   : prefixUnaryExpression (asOperator type)?
//   ;
asExpression
    : prefixUnaryExpression
    | prefixUnaryExpression asOperator type
    ;

// prefixUnaryExpression (used by asExpression, assignableExpression)
//   : unaryPrefix* postfixUnaryExpression
//   ;
prefixUnaryExpression
    : x_unary_prefix_seq_opt postfixUnaryExpression
    ;

// unaryPrefix (used by prefixUnaryExpression)
//   : annotation
//   | label
//   | prefixUnaryOperator
//   ;
unaryPrefix
    : annotation
    | label
    | prefixUnaryOperator
    ;

x_unary_prefix_seq_opt
    :
    | x_unary_prefix_seq_opt unaryPrefix
    ;

// postfixUnaryExpression (used by prefixUnaryExpression, directlyAssignableExpression)
//   : primaryExpression
//   | primaryExpression postfixUnarySuffix+
//   ;
postfixUnaryExpression
    : primaryExpression
    | primaryExpression x_postfix_unary_suffix_seq
    ;

// postfixUnarySuffix (used by postfixUnaryExpression)
//   : postfixUnaryOperator
//   | typeArguments
//   | callSuffix
//   | indexingSuffix
//   | navigationSuffix
//   ;
postfixUnarySuffix
    : postfixUnaryOperator
    | typeArguments
    | callSuffix
    | indexingSuffix
    | navigationSuffix
    ;

x_postfix_unary_suffix_seq
    : postfixUnarySuffix
    | x_postfix_unary_suffix_seq postfixUnarySuffix
    ;

// directlyAssignableExpression (used by assignment, parenthesizedDirectlyAssignableExpression)
//   : postfixUnaryExpression assignableSuffix
//   | simpleIdentifier
//   | parenthesizedDirectlyAssignableExpression
//   ;
directlyAssignableExpression
    : postfixUnaryExpression assignableSuffix
    | simpleIdentifier
    | parenthesizedDirectlyAssignableExpression
    ;

// parenthesizedDirectlyAssignableExpression (used by directlyAssignableExpression)
//   : '(' directlyAssignableExpression ')'
//   ;
parenthesizedDirectlyAssignableExpression
    : L_PAREN directlyAssignableExpression R_PAREN
    ;

// assignableExpression (used by assignment, parenthesizedAssignableExpression)
//   : prefixUnaryExpression
//   | parenthesizedAssignableExpression
//   ;
assignableExpression
    : prefixUnaryExpression
    | parenthesizedAssignableExpression
    ;

// parenthesizedAssignableExpression (used by assignableExpression)
//   : '(' assignableExpression ')'
//   ;
parenthesizedAssignableExpression
    : L_PAREN assignableExpression R_PAREN
    ;

// assignableSuffix (used by directlyAssignableExpression)
//   : typeArguments
//   | indexingSuffix
//   | navigationSuffix
//   ;
assignableSuffix
    : typeArguments
    | indexingSuffix
    | navigationSuffix
    ;

// indexingSuffix (used by postfixUnarySuffix, assignableSuffix)
//   : '[' expression (',' expression)* ']'
//   ;
indexingSuffix
    : L_SQUARE_PAREN x_expression_list R_SQUARE_PAREN
    ;

// navigationSuffix (used by postfixUnarySuffix, assignableSuffix)
//   : memberAccessOperator (simpleIdentifier | parenthesizedExpression | 'class')
//   ;
navigationSuffix
    : memberAccessOperator x_navigation_suffix_tail
    ;

x_navigation_suffix_tail
    : simpleIdentifier
    | parenthesizedExpression
    | CLASS
    ;

// callSuffix (used by postfixUnarySuffix)
//   : typeArguments? valueArguments? annotatedLambda
//   | typeArguments? valueArguments
//   ;
callSuffix
    : x_type_arguments_opt x_value_arguments_opt annotatedLambda
    | x_type_arguments_opt valueArguments
    ;

// annotatedLambda (used by callSuffix)
//   : annotation* label? lambdaLiteral
//   ;
annotatedLambda
    : x_annotation_seq_opt x_label_opt lambdaLiteral
    ;

// typeArguments (used by simpleUserType, postfixUnarySuffix, assignableSuffix, callSuffix)
//   : '<' typeProjection (',' typeProjection)* '>'
//   ;
typeArguments
    : LESS_THAN x_type_projection_list GREATER_THAN
    ;

x_type_arguments_opt
    :
    | typeArguments
    ;

// valueArguments (used by constructorInvocation, constructorDelegationCall, enumEntry, callSuffix)
//   : '(' ')'
//   | '(' valueArgument (',' valueArgument)* ')'
//   ;
valueArguments
    : L_PAREN R_PAREN
    | L_PAREN x_value_argument_list R_PAREN
    ;

x_value_arguments_opt
    :
    | valueArguments
    ;

// valueArgument (used by valueArguments)
//   : annotation? (simpleIdentifier '=')? '*'? expression
//   ;
valueArgument
    : x_annotation_opt x_simple_identifier_equal_opt x_asterist_opt disjunction // original rule: expression
    ;

x_value_argument_list
    : valueArgument
    | x_value_argument_list COMMA valueArgument
    ;

// primaryExpression (used by postfixUnaryExpression)
//   : parenthesizedExpression
//   | simpleIdentifier
//   | literalConstant
//   | stringLiteral
//   | callableReference
//   | functionLiteral
//   | objectLiteral
//   | collectionLiteral
//   | thisExpression
//   | superExpression
//   | ifExpression
//   | whenExpression
//   | tryExpression
//   | jumpExpression
//   ;
primaryExpression
    : parenthesizedExpression
    | simpleIdentifier
    | literalConstant
    | stringLiteral
    | callableReference
    | functionLiteral
    | objectLiteral
    | collectionLiteral
    | thisExpression
    | superExpression
    | ifExpression
    | whenExpression
    | tryExpression
    | jumpExpression
    ;

// parenthesizedExpression (used by navigationSuffix, primaryExpression)
//   : '(' expression ')'
//   ;
parenthesizedExpression
    : L_PAREN disjunction R_PAREN
    ;

// collectionLiteral (used by primaryExpression)
//   : '[' expression (',' expression)* ']'
//   | '[' ']'
//   ;
collectionLiteral
    : L_SQUARE_PAREN x_expression_list R_SQUARE_PAREN
    | L_SQUARE_PAREN R_SQUARE_PAREN
    ;

// literalConstant (used by primaryExpression)
//   : BooleanLiteral
//   | IntegerLiteral
//   | HexLiteral
//   | BinLiteral
//   | CharacterLiteral
//   | RealLiteral
//   | 'null'
//   | LongLiteral
//   | UnsignedLiteral
//   ;
literalConstant
    : BOOLEAN_LITERAL
    | INTEGER_LITERAL
    | HEX_LITERAL
    | BIN_LITERAL
    | CHARACTER_LITERAL
    | REAL_LITERAL
    | LONG_LITERAL
    | UNSIGNED_LITERAL
    | NULL
    ;

// stringLiteral (used by primaryExpression)
//   : lineStringLiteral
//   | multiLineStringLiteral
//   ;
stringLiteral
    : lineStringLiteral
    | multiLineStringLiteral
    ;

// lineStringLiteral (used by stringLiteral)
//   : '"' (lineStringContent | lineStringExpression)* '"'
//   ;
lineStringLiteral
    : QUOTE x_line_string_literal_body_seq_opt QUOTE
    ;

x_line_string_literal_body
    : lineStringContent
    | lineStringExpression
    ;

x_line_string_literal_body_seq_opt
    :
    | x_line_string_literal_body_seq_opt x_line_string_literal_body
    ;

// multiLineStringLiteral (used by stringLiteral)
//   : '"""' (multiLineStringContent | multiLineStringExpression | '"')*
//     TRIPLE_QUOTE_CLOSE
//   ;
multiLineStringLiteral
    : TRIPLE_QUOTE x_multi_line_string_literal_body_seq_opt TRIPLE_QUOTE_CLOSE
    ;

x_multi_line_string_literal_body
    : multiLineStringContent
    | multiLineStringExpression
    | QUOTE
    ;

x_multi_line_string_literal_body_seq_opt
    :
    | x_multi_line_string_literal_body_seq_opt x_multi_line_string_literal_body
    ;

// lineStringContent (used by lineStringLiteral)
//   : LineStrText
//   | LineStrEscapedChar
//   | LineStrRef
//   ;
lineStringContent
    : LINE_STR_TEXT
    | LINE_STR_ESCAPED_CHAR
    | LINE_STR_REF
    ;

// lineStringExpression (used by lineStringLiteral)
//   : '${' expression '}'
//   ;
lineStringExpression
    : DOLLAR_L_CURL_PAREN disjunction R_CURL_PAREN
    ;

// multiLineStringContent (used by multiLineStringLiteral)
//   : MultiLineStrText
//   | '"'
//   | MultiLineStrRef
//   ;
multiLineStringContent
    : MULTI_LINE_STR_TEXT
    | QUOTE
    | MULTI_LINE_STR_REF
    ;

// multiLineStringExpression (used by multiLineStringLiteral)
//   : '${' expression '}'
//   ;
multiLineStringExpression
    : DOLLAR_L_CURL_PAREN disjunction R_CURL_PAREN
    ;

// lambdaLiteral (used by annotatedLambda, functionLiteral)
//   : '{' statements '}'
//   | '{' lambdaParameters? '->' statements '}'
//   ;
lambdaLiteral
    : L_CURL_PAREN statements R_CURL_PAREN
    | L_CURL_PAREN x_lambda_parameters_opt ARROW statements R_CURL_PAREN
    ;

// lambdaParameters (used by lambdaLiteral)
//   : lambdaParameter (',' lambdaParameter)*
//   ;
lambdaParameters
    : lambdaParameter
    | lambdaParameters COMMA lambdaParameter
    ;

x_lambda_parameters_opt
    :
    | lambdaParameters
    ;

// lambdaParameter (used by lambdaParameters)
//   : variableDeclaration
//   | multiVariableDeclaration (':' type)?
//   ;
lambdaParameter
    : variableDeclaration
    | multiVariableDeclaration x_colon_type_opt
    ;

// anonymousFunction (used by functionLiteral)
//   : 'fun' (type '.')? parametersWithOptionalType
//     (':' type)? typeConstraints?
//     functionBody?
//   ;
anonymousFunction
    : FUN x_type_dot_opt parametersWithOptionalType x_colon_type_opt x_type_constraints_opt x_function_body_opt
    ;

x_type_dot_opt
    :
    | type DOT
    ;

// functionLiteral (used by primaryExpression)
//   : lambdaLiteral
//   | anonymousFunction
//   ;
functionLiteral
    : lambdaLiteral
    | anonymousFunction
    ;

// objectLiteral (used by primaryExpression)
//   : 'object' ':' delegationSpecifiers classBody
//   | 'object' classBody
//   ;
objectLiteral
    : OBJECT COLON delegationSpecifiers classBody
    | OBJECT classBody
    ;

// thisExpression (used by primaryExpression)
//   : 'this'
//   | THIS_AT
//   ;
thisExpression
    : THIS
    | THIS_AT
    ;

// superExpression (used by primaryExpression)
//   : 'super' ('<' type '>')? ('@' simpleIdentifier)?
//   | SUPER_AT
//   ;
superExpression
    : SUPER x_paren_type_paren_opt x_at_simple_identifier_opt
    | SUPER_AT
    ;

x_paren_type_paren_opt
    :
    | LESS_THAN type GREATER_THAN
    ;

x_at_simple_identifier_opt
    :
    | AT simpleIdentifier
    ;

// ifExpression (used by primaryExpression)
//   : 'if' '(' expression ')'
//     (controlStructureBody | ';')
//   | 'if' '(' expression ')'
//     controlStructureBody? ';'? 'else' (controlStructureBody | ';')
//   ;
ifExpression
    : IF L_PAREN disjunction R_PAREN x_control_structure_body_or_semicolon
    | IF L_PAREN disjunction R_PAREN x_control_structure_body_opt x_semicolon_opt 
        ELSE x_control_structure_body_or_semicolon
    ;

x_control_structure_body_or_semicolon
    : controlStructureBody
    | SEMICOLON
    ;

// whenSubject (used by whenExpression)
//   : '(' (annotation* 'val' variableDeclaration '=')? expression ')'
//   ;
whenSubject
    : L_PAREN x_when_subject_condition_opt disjunction R_PAREN
    ;

x_when_subject_condition_opt
    :
    | x_annotation_seq_opt VAL variableDeclaration EQUAL
    ;

x_when_subject_opt
    :
    | whenSubject
    ;

// whenExpression (used by primaryExpression)
//   : 'when' whenSubject? '{' whenEntry* '}'
//   ;
whenExpression
    : WHEN x_when_subject_opt R_CURL_PAREN x_when_entry_seq_opt R_CURL_PAREN
    ;

// whenEntry (used by whenExpression)
//   : whenCondition (',' whenCondition)* '->' controlStructureBody semi?
//   | 'else' '->' controlStructureBody semi?
//   ;
whenEntry
    : x_when_condition_list ARROW controlStructureBody x_semi_opt
    | ELSE ARROW controlStructureBody x_semi_opt
    ;

x_when_condition_list
    : whenCondition
    | x_when_condition_list COMMA whenCondition
    ;

x_when_entry_seq_opt
    :
    | x_when_entry_seq_opt whenEntry
    ;

// whenCondition (used by whenEntry)
//   : expression
//   | rangeTest
//   | typeTest
//   ;
whenCondition
    : disjunction
    | rangeTest
    | typeTest
    ;

// rangeTest (used by whenCondition)
//   : inOperator expression
//   ;
rangeTest
    : inOperator disjunction
    ;

// typeTest (used by whenCondition)
//   : isOperator type
//   ;
typeTest
    : isOperator type
    ;

// tryExpression (used by primaryExpression)
//   : 'try' block ((catchBlock+ finallyBlock?) | finallyBlock)
//   ;
tryExpression
    : TRY block x_catch_block_seq_finally_block
    | TRY block finallyBlock
    ;

x_catch_block_seq_finally_block
    : x_catch_block_seq
    | x_catch_block_seq finallyBlock
    ;

// catchBlock (used by tryExpression)
//   : 'catch' '(' annotation* simpleIdentifier ':' type ')' block
//   ;
catchBlock
    : CATCH L_PAREN x_annotation_seq_opt simpleIdentifier COLON type R_PAREN block
    ;

x_catch_block_seq
    : catchBlock
    | x_catch_block_seq catchBlock
    ;

// finallyBlock (used by tryExpression)
//   : 'finally' block
//   ;
finallyBlock
    : FINALLY block
    ;

// jumpExpression (used by primaryExpression)
//   : 'throw' expression
//   | ('return' | RETURN_AT) expression?
//   | 'continue'
//   | CONTINUE_AT
//   | 'break'
//   | BREAK_AT
//   ;
jumpExpression
    : THROW disjunction
    | x_return_or_return_at x_expression_opt
    | CONTINUE
    | CONTINUE_AT
    | BREAK
    | BREAK_AT
    ;

x_return_or_return_at
    : RETURN
    | RETURN_AT
    ;

// callableReference (used by primaryExpression)
//   : (receiverType? '::' (simpleIdentifier | 'class'))
//   ;
callableReference
    : x_receiver_type_opt COLON_COLON simpleIdentifier
    | x_receiver_type_opt COLON_COLON CLASS
    ;

// assignmentAndOperator (used by assignment)
//   : '+='
//   | '-='
//   | '*='
//   | '/='
//   | '%='
//   ;
assignmentAndOperator
    : PLUS_EQUAL
    | MINUS_EQUAL
    | MULTIPLY_EQUAL
    | DIVIDE_EQUAL
    | MOD_EQUAL
    ;

// equalityOperator (used by equality)
//   : '!='
//   | '!=='
//   | '=='
//   | '==='
//   ;
equalityOperator
    : NOT_EQUAL
    | NOT_EQUAL_EQUAL
    | EQUAL_EQUAL
    | EQUAL_EQUAL_EQUAL
    ;

// comparisonOperator (used by comparison)
//   : '<'
//   | '>'
//   | '<='
//   | '>='
//   ;
comparisonOperator
    : LESS_THAN
    | GREATER_THAN
    | LESS_THAN_EQUAL
    | GREATER_THAN_EQUAL
    ;

// inOperator (used by infixOperation, rangeTest)
//   : 'in'
//   | NOT_IN
//   ;
inOperator
    : IN
    | NOT_IN
    ;

// isOperator (used by infixOperation, typeTest)
//   : 'is'
//   | NOT_IS
//   ;
isOperator
    : IS
    | NOT_IS
    ;

// additiveOperator (used by additiveExpression)
//   : '+'
//   | '-'
//   ;
additiveOperator
    : PLUS
    | MINUS
    ;

// multiplicativeOperator (used by multiplicativeExpression)
//   : '*'
//   | '/'
//   | '%'
//   ;
multiplicativeOperator
    : ASTERISK
    | SLASH
    | PERCENT
    ;

// asOperator (used by asExpression)
//   : 'as'
//   | 'as?'
//   ;
asOperator
    : AS
    | AS_QUEST
    ;

// prefixUnaryOperator (used by unaryPrefix)
//   : '++'
//   | '--'
//   | '-'
//   | '+'
//   | excl
//   ;
prefixUnaryOperator
    : PLUS_PLUS
    | MINUS_MINUS
    | MINUS
    | PLUS
    | excl
    ;

// postfixUnaryOperator (used by postfixUnarySuffix)
//   : '++'
//   | '--'
//   | '!' excl
//   ;
postfixUnaryOperator
    : PLUS_PLUS
    | MINUS_MINUS
    | EXCL excl
    ;

// excl (used by prefixUnaryOperator, postfixUnaryOperator)
//   : '!'
//   | EXCL_WS
//   ;
excl
    : EXCL
    | EXCL_WS
    ;

// memberAccessOperator (used by navigationSuffix)
//   : '.'
//   | safeNav
//   | '::'
//   ;
memberAccessOperator
    : DOT
    | safeNav
    | COLON_COLON
    ;

// safeNav (used by memberAccessOperator)
//   : '?' '.'
//   ;
safeNav
    : QUEST DOT
    ;

// modifiers (used by typeAlias, classDeclaration, primaryConstructor, classParameter, companionObject, functionDeclaration, propertyDeclaration, getter, setter, objectDeclaration, secondaryConstructor, enumEntry)
//   : annotation
//   | modifier+
//   ;
modifiers
    : annotation
    | x_modifier_seq
    ;

x_modifiers_opt
    :
    | modifiers
    ;

// parameterModifiers (used by functionValueParameter, parameterWithOptionalType)
//   : annotation
//   | parameterModifier+
//   ;
parameterModifiers
    : annotation
    | x_parameter_modifier_seq
    ;

x_parameter_modifiers_opt
    :
    | parameterModifiers
    ;

// modifier (used by modifiers)
//   : classModifier
//   | memberModifier
//   | visibilityModifier
//   | functionModifier
//   | propertyModifier
//   | inheritanceModifier
//   | parameterModifier
//   | platformModifier
//   ;
modifier
    : classModifier
    | memberModifier
    | visibilityModifier
    | functionModifier
    | CONST // original rule: propertyModifier
    | inheritanceModifier
    | parameterModifier
    | platformModifier
    ;

x_modifier_seq
    : modifier
    | x_modifier_seq modifier
    ;

// typeModifiers (used by type, receiverType)
//   : typeModifier+
//   ;
typeModifiers
    : x_type_modifier_seq
    ;

x_type_modifiers_opt
    :
    | typeModifiers
    ;

// typeModifier (used by typeModifiers)
//   : annotation
//   | 'suspend'
//   ;
typeModifier
    : annotation
    | SUSPEND
    ;

x_type_modifier_seq
    : typeModifier
    | x_type_modifier_seq typeModifier
    ;

// classModifier (used by modifier)
//   : 'enum'
//   | 'sealed'
//   | 'annotation'
//   | 'data'
//   | 'inner'
//   ;
classModifier
    : ENUM
    | SEALED
    | ANNOTATION
    | DATA
    | INNER
    ;

// memberModifier (used by modifier)
//   : 'override'
//   | 'lateinit'
//   ;
memberModifier
    : OVERRIDE
    | LATEINIT
    ;

// visibilityModifier (used by modifier)
//   : 'public'
//   | 'private'
//   | 'internal'
//   | 'protected'
//   ;
visibilityModifier
    : PUBLIC
    | PRIVATE
    | INTERNAL
    | PROTECTED
    ;

// varianceModifier (used by typeProjectionModifier, typeParameterModifier)
//   : 'in'
//   | 'out'
//   ;
varianceModifier
    : IN
    | OUT
    ;

// typeParameterModifiers (used by typeParameter)
//   : typeParameterModifier+
//   ;
typeParameterModifiers
    : x_type_parameter_modifier_seq
    ;

// typeParameterModifier (used by typeParameterModifiers)
//   : reificationModifier
//   | varianceModifier
//   | annotation
//   ;
typeParameterModifier
    : reificationModifier
    | varianceModifier
    | annotation
    ;

x_type_parameter_modifier_seq
    : typeParameterModifier
    | x_type_parameter_modifier_seq typeParameterModifier
    ;

// functionModifier (used by modifier)
//   : 'tailrec'
//   | 'operator'
//   | 'infix'
//   | 'inline'
//   | 'external'
//   | 'suspend'
//   ;
functionModifier
    : TAILREC
    | OPERATOR
    | INFIX
    | INLINE
    | EXTERNAL
    | SUSPEND
    ;

// propertyModifier (used by modifier)
//   : 'const'
//   ;
//propertyModifier
//    : CONST
//    ;

// inheritanceModifier (used by modifier)
//   : 'abstract'
//   | 'final'
//   | 'open'
//   ;
inheritanceModifier
    : ABSTRACT
    | FINAL
    | OPEN
    ;

// parameterModifier (used by parameterModifiers, modifier)
//   : 'vararg'
//   | 'noinline'
//   | 'crossinline'
//   ;
parameterModifier
    : VARARG
    | NOINLINE
    | CROSSINLINE
    ;

x_parameter_modifier_seq
    : parameterModifier
    | x_parameter_modifier_seq parameterModifier
    ;

// reificationModifier (used by typeParameterModifier)
//   : 'reified'
//   ;
reificationModifier
    : REIFIED
    ;

// platformModifier (used by modifier)
//   : 'expect'
//   | 'actual'
//   ;
platformModifier
    : EXPECT
    | ACTUAL
    ;

// annotation (used by annotatedDelegationSpecifier, typeConstraint, variableDeclaration, typeProjectionModifier, statement, forStatement, unaryPrefix, annotatedLambda, valueArgument, whenSubject, catchBlock, modifiers, parameterModifiers, typeModifier, typeParameterModifier)
//   : singleAnnotation
//   | multiAnnotation
//   ;
annotation
    : singleAnnotation
    | multiAnnotation
    ;

x_annotation_opt
    :
    | annotation
    ;

x_annotation_seq_opt
    :
    | x_annotation_seq_opt annotation
    ;

// singleAnnotation (used by annotation)
//   : annotationUseSiteTarget unescapedAnnotation
//   | ('@' | AT_PRE_WS) unescapedAnnotation
//   ;
singleAnnotation
    : annotationUseSiteTarget unescapedAnnotation
    | x_at_or_at_pre_ws unescapedAnnotation
    ;

// multiAnnotation (used by annotation)
//   : annotationUseSiteTarget '[' unescapedAnnotation+ ']'
//   | ('@' | AT_PRE_WS) '[' unescapedAnnotation+ ']'
//   ;
multiAnnotation
    : annotationUseSiteTarget L_SQUARE_PAREN x_unescaped_annotation_seq R_SQUARE_PAREN
    | x_at_or_at_pre_ws       L_SQUARE_PAREN x_unescaped_annotation_seq R_SQUARE_PAREN
    ;

// annotationUseSiteTarget (used by singleAnnotation, multiAnnotation)
//   : ('@' | AT_PRE_WS)
//     ('field' | 'property' | 'get' | 'set' | 'receiver' | 'param' | 'setparam' | 'delegate') ':'
//   ;
annotationUseSiteTarget
    : x_at_or_at_pre_ws x_annotation_use_site_target_tail COLON
    ;

x_annotation_use_site_target_tail
    : FIELD
    | PROPERTY
    | GET
    | SET
    | RECEIVER
    | PARAM
    | SETPARAM
    | DELEGATE
    ;

// unescapedAnnotation (used by fileAnnotation, singleAnnotation, multiAnnotation)
//   : constructorInvocation
//   | userType
//   ;
unescapedAnnotation
    : constructorInvocation
    | userType
    ;

x_unescaped_annotation_seq
    : unescapedAnnotation
    | x_unescaped_annotation_seq unescapedAnnotation
    ;

// simpleIdentifier (used by importAlias, typeAlias, classDeclaration, classParameter, typeParameter, typeConstraint, companionObject, functionDeclaration, variableDeclaration, parameterWithOptionalType, parameter, objectDeclaration, enumEntry, simpleUserType, label, infixFunctionCall, directlyAssignableExpression, navigationSuffix, valueArgument, primaryExpression, superExpression, catchBlock, callableReference, identifier)
//   : Identifier
//   | 'abstract'
//   | 'annotation'
//   | 'by'
//   | 'catch'
//   | 'companion'
//   | 'constructor'
//   | 'crossinline'
//   | 'data'
//   | 'dynamic'
//   | 'enum'
//   | 'external'
//   | 'final'
//   | 'finally'
//   | 'get'
//   | 'import'
//   | 'infix'
//   | 'init'
//   | 'inline'
//   | 'inner'
//   | 'internal'
//   | 'lateinit'
//   | 'noinline'
//   | 'open'
//   | 'operator'
//   | 'out'
//   | 'override'
//   | 'private'
//   | 'protected'
//   | 'public'
//   | 'reified'
//   | 'sealed'
//   | 'tailrec'
//   | 'set'
//   | 'vararg'
//   | 'where'
//   | 'field'
//   | 'property'
//   | 'receiver'
//   | 'param'
//   | 'setparam'
//   | 'delegate'
//   | 'file'
//   | 'expect'
//   | 'actual'
//   | 'const'
//   | 'suspend'
//   ;
simpleIdentifier
    : IDENTIFIER
    | ABSTRACT
    | ANNOTATION
    | BY
    | CATCH
    | COMPANION
    | CONSTRUCTOR
    | CROSSINLINE
    | DATA
    | DYNAMIC
    | ENUM
    | EXTERNAL
    | FINAL
    | FINALLY
    | GET
    | IMPORT
    | INFIX
    | INIT
    | INLINE
    | INNER
    | INTERNAL
    | LATEINIT
    | NOINLINE
    | OPEN
    | OPERATOR
    | OUT
    | OVERRIDE
    | PRIVATE
    | PROTECTED
    | PUBLIC
    | REIFIED
    | SEALED
    | TAILREC
    | SET
    | VARARG
    | WHERE
    | FIELD
    | PROPERTY
    | RECEIVER
    | PARAM
    | SETPARAM
    | DELEGATE
    | FILE
    | EXPECT
    | ACTUAL
    | CONST
    | SUSPEND
    ;

x_simple_identifier_opt
    :
    | simpleIdentifier
    ;

x_simple_identifier_dot_list
    :                                  simpleIdentifier
    | x_simple_identifier_dot_list DOT simpleIdentifier
    ;

// identifier (used by packageHeader, importHeader)
//   : simpleIdentifier ('.' simpleIdentifier)*
//   ;
identifier
    : x_simple_identifier_dot_list
    ;

// COMMONS

x_val_or_var
    : VAL
    | VAR
    ;

x_val_or_var_opt
    :
    | x_val_or_var
    ;

x_at_or_at_pre_ws
    : AT
    | AT_PRE_WS
    ;

x_at_or_at_post_ws
    : AT
    | AT_POST_WS
    ;

x_equal_expression
    : EQUAL disjunction
    ;

x_equal_expression_opt
    :
    | x_equal_expression
    ;

x_receiver_type_dot_opt
    :
    | receiverType DOT
    ;

x_colon_type_opt
    :
    | COLON type
    ;

x_simple_identifier_equal_opt
    :
    | simpleIdentifier EQUAL
    ;

x_semicolon_opt
    :
    | SEMICOLON
    ;

x_asterist_opt
    :
    | ASTERISK
    ;

x_colon_delegation_specifiers_opt
    :
    | COLON delegationSpecifiers
    ;

x_multi_or_single_variable_declaration
    : multiVariableDeclaration
    | variableDeclaration
    ;