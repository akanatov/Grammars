// CHAPTER 19 Syntax
//
// THIS chapter repeats the syntactic grammar given in Chapters 4, 6-10, 14, and 15,
// as well as key parts of the lexical grammar from Chapter 3, using the notation from §2.4.

// Productions from §3 (Lexical Structure)

// Identifier:
//    IdentifierChars but not a Keyword or BooleanLiteral or NullLiteral

// IdentifierChars:
//    JavaLetter {JavaLetterOrDigit}

// JavaLetter:
//    any Unicode character that is a "Java letter"

// JavaLetterOrDigit:
//    any Unicode character that is a "Java letter-or-digit"

// TypeIdentifier:
//    Identifier but not var

// Literal:
//    IntegerLiteral
//    FloatingPointLiteral
//    BooleanLiteral
//    CharacterLiteral
//    StringLiteral
//    NullLiteral


%token INTEGER_LITERAL
%token FLOATING_POINT_LITERAL
%token TRUE
%token FALSE
%token CHARACTER_LITERAL
%token STRING_LITERAL
%token NULL
%token BOOLEAN
%token FLOAT
%token DOUBLE
%token BYTE
%token SHORT
%token INT
%token LONG
%token CHAR
%token IDENTIFIER
%token DOT
%token LBRACKET
%token RBRACKET
%token EXTENDS
%token AMPERSAND
%token LESS
%token GREATER
%token COMMA
%token QUESTION
%token SUPER
%token PACKAGE
%token SEMICOLON
%token IMPORT
%token STAR
%token STATIC
%token MODULE
%token LBRACE
%token RBRACE
%token OPEN
%token REQUIRES
%token TRANSITIVE
%token EXPORTS
%token TO
%token OPENS
%token USES
%token PROVIDES
%token WITH
%token COMMA
%token CLASS
%token ENUM
%token IMPLEMENTS
%token PUBLIC
%token PROTECTED
%token PRIVATE
%token ABSTRACT
%token FINAL
%token STRICTFP
%token TRANSIENT
%token SYNCHRONIZED
%token NATIVE
%token DEFAULT
%token EQUAL
%token VOID
%token THIS
%token ELLIPSIS
%token THROWS
%token LPAREN
%token RPAREN
%token SUPER
%token INTERFACE
%token AT
%token VAR
%token ASSERT
%token COLON
%token DO
%token WHILE
%token BREAK
%token CONTINUE
%token RETURN
%token THROW
%token IF
%token ELSE
%token SWITCH
%token CASE
%token FOR
%token TRY
%token CATCH
%token VERT
%token FINALLY
%token NEW
%token COLON_COLON
%token ARROW
%token MULT_EQUAL
%token SLASH_EQUAL
%token PERCENT_EQUAL
%token PLUS_EQUAL
%token MINUS_EQUAL
%token LESS_LESS_EQUAL
%token GREATER_GREATER_EQUAL
%token GREATER_GREATER_GREATER_EQUAL
%token AMPERSAND_EQUAL
%token CARET_EQUAL
%token VERT_EQUAL
%token VERT_VERT
%token AMP_AMP
%token CARET
%token EQUAL_EQUAL
%token NOT_EQUAL
%token LESS_EQUAL
%token GREATER_EQUAL
%token INSTANCEOF
%token LESS_LESS
%token GREATER_GREATER
%token GREATER_GREATER_GREATER
%token PLUS
%token MINUS
%token STAR
%token SLASH
%token PERCENT
%token PLUS_PLUS
%token MINUS_MINUS
%token TILDE
%token EXCLAMATION

%start CompilationUnit

%%

// Productions from §4 (Types, Values, and Variables)

// Type:          -- never used
//    PrimitiveType
//    ReferenceType
//
// UnannType:
//    UnannPrimitiveType
//    UnannReferenceType

Type
    : PrimitiveType
	| ReferenceType
	;
	
PrimitiveType
    : AnnotationSeqOpt NumericType
	| AnnotationSeqOpt BOOLEAN
	;

// PrimitiveType:
//    {Annotation} NumericType
//    {Annotation} boolean
//
// UnannPrimitiveType:
//    NumericType
//    boolean

// NumericType:
//    IntegralType
//    FloatingPointType
	
NumericType
    : IntegralType
	| FLOAT
	| DOUBLE
	;

// IntegralType:
//    (one of) byte short int long char

IntegralType
    : BYTE
	| SHORT
	| INT
	| LONG
	| CHAR
	;
	
// FloatingPointType:
//    (one of) float double

// ReferenceType:
//    ClassOrInterfaceType
//    TypeVariable
//    ArrayType
//	
// UnannReferenceType:
//    UnannClassOrInterfaceType
//    UnannTypeVariable
//    UnannArrayType
	
ReferenceType
    : ClassType   // includes TypeVariable
	| ArrayType
	;

// ClassOrInterfaceType:
//    ClassType
//    InterfaceType
//
// UnannClassOrInterfaceType:
//    UnannClassType
//    UnannInterfaceType

// ClassType:
//                           {Annotation} TypeIdentifier [TypeArguments]
//    PackageName          . {Annotation} TypeIdentifier [TypeArguments]
//    ClassOrInterfaceType . {Annotation} TypeIdentifier [TypeArguments]
//
// UnannClassType:
//                                             TypeIdentifier [TypeArguments]
//    PackageName               . {Annotation} TypeIdentifier [TypeArguments]
//    UnannClassOrInterfaceType . {Annotation} TypeIdentifier [TypeArguments]

ClassType
	:                  AnnotationSeq IDENTIFIER TypeArgumentsOpt
	| CompoundName                              TypeArgumentsOpt
	| CompoundName DOT AnnotationSeq IDENTIFIER TypeArgumentsOpt
	;

// InterfaceType:
//    ClassType
//
// UnannInterfaceType:
//    UnannClassType

// TypeVariable:
//    {Annotation} TypeIdentifier
//
// UnannTypeVariable:
//    TypeIdentifier

// ArrayType:
//    PrimitiveType        Dims
//    ClassOrInterfaceType Dims
//    TypeVariable         Dims
//
// UnannArrayType:
//    UnannPrimitiveType        Dims
//    UnannClassOrInterfaceType Dims
//    UnannTypeVariable         Dims
	
ArrayType
    : PrimitiveType Dims
	| ClassType     Dims
	;

// Dims:
//    {Annotation} [ ] {{Annotation} [ ]}

DimsOpt
    :  // empty
	| Dims
	;
	
Dims
    :      AnnotationSeqOpt LBRACKET RBRACKET
	| Dims AnnotationSeqOpt LBRACKET RBRACKET
	;
	
// TypeParameter:
//    {TypeParameterModifier} TypeIdentifier [TypeBound]

TypeParameter
    : AnnotationSeqOpt IDENTIFIER ExtendClauseOpt
	;
	
ExtendClauseOpt
    :  // empty	
	| EXTENDS ClassType                     // ClassOrInterfaceType; TypeVariable is also here
	| EXTENDS ClassType AdditionalBoundSeq  // ClassOrInterfaceType
	;

// TypeParameterModifier:
//    Annotation
//
// TypeBound:
//    extends TypeVariable
//    extends ClassOrInterfaceType {AdditionalBound}

// AdditionalBound:
//    & InterfaceType

AdditionalBoundSeqOpt
    :  // empty
	| AdditionalBoundSeq
	;
	
AdditionalBoundSeq
    :                    AMPERSAND ClassType /* InterfaceType */
	| AdditionalBoundSeq AMPERSAND ClassType /* InterfaceType */
	;

TypeArgumentsOpt
    :  // empty
	| TypeArguments
	;
	
TypeArguments
    : LESS TypeArgumentList GREATER
	;

// TypeArguments:
//    < TypeArgumentList >

TypeArgumentList
    :                        TypeArgument
	| TypeArgumentList COMMA TypeArgument
	;

// TypeArgumentList:
//    TypeArgument {, TypeArgument}	

TypeArgument
    : ReferenceType
    | AnnotationSeqOpt QUESTION ExtendsSuperTailOpt // Wildcard
	;
	
// TypeArgument:
//    ReferenceType
//    Wildcard	

// Wildcard:
//    {Annotation} ? [WildcardBounds]

// WildcardBounds:
//    extends ReferenceType
//    super ReferenceType

ExtendsSuperTailOpt
    :  // empty
	| EXTENDS ReferenceType
    | SUPER ReferenceType
    ;	

// Productions from §6 (Names)

CompoundName
    :                  IDENTIFIER
	| CompoundName DOT IDENTIFIER
	;
	
// ModuleName:
//                 Identifier
//    ModuleName . Identifier
//
// PackageName:
//                  Identifier
//    PackageName . Identifier
//
// TypeName:
//                        TypeIdentifier
//    PackageOrTypeName . TypeIdentifier
//
// ExpressionName:
//                    Identifier
//    AmbiguousName . Identifier

//PackageOrTypeName:
//                        Identifier
//    PackageOrTypeName . Identifier
//
//AmbiguousName:
//                    Identifier
//    AmbiguousName . Identifier

// Productions from §7 (Packages and Modules)

CompilationUnit
    : PackageDeclarationOpt ImportDeclarationSeqOpt TypeDeclarationSeqOpt  // OrdinaryCompilationUnit
    |                       ImportDeclarationSeqOpt ModuleDeclaration      // ModularCompilationUnit
	;
	
// CompilationUnit:
//    OrdinaryCompilationUnit
//    ModularCompilationUnit

// OrdinaryCompilationUnit:
//    [PackageDeclaration] {ImportDeclaration} {TypeDeclaration}

// ModularCompilationUnit:
//    {ImportDeclaration} ModuleDeclaration

PackageDeclaration
    : AnnotationSeqOpt PACKAGE CompoundName SEMICOLON
	;
	
PackageDeclarationOpt
    :  // empty
	| PackageDeclaration
	;
	
//PackageDeclaration:
//    {PackageModifier} package Identifier {. Identifier} ;
//
//PackageModifier:
//    Annotation

ImportDeclaration
    : IMPORT        CompoundName                SEMICOLON  // SingleTypeImportDeclaration
    | IMPORT        CompoundName DOT STAR       SEMICOLON  // TypeImportOnDemandDeclaration
    | IMPORT STATIC CompoundName DOT IDENTIFIER SEMICOLON  // SingleStaticImportDeclaration
    | IMPORT STATIC CompoundName DOT STAR       SEMICOLON  // StaticImportOnDemandDeclaration
    ;
	
ImportDeclarationSeq
    :                      ImportDeclaration
	| ImportDeclarationSeq ImportDeclaration
	;
	
ImportDeclarationSeqOpt
    :  // empty
	| ImportDeclarationSeq
	;

// ImportDeclaration:
//   SingleTypeImportDeclaration
//   TypeImportOnDemandDeclaration
//   SingleStaticImportDeclaration
//   StaticImportOnDemandDeclaration
	
// SingleTypeImportDeclaration:
//    import TypeName ;

// TypeImportOnDemandDeclaration:
//    import PackageOrTypeName . * ;

// SingleStaticImportDeclaration:
//    import static TypeName . Identifier ;

// StaticImportOnDemandDeclaration:
//    import static TypeName . * ;

TypeDeclaration
    : ClassDeclaration
    | InterfaceDeclaration
	| SEMICOLON
    ;
	
TypeDeclarationSeqOpt
    :  // empty
	| TypeDeclarationSeq
	;
	
TypeDeclarationSeq
    :                    TypeDeclaration
	| TypeDeclarationSeq TypeDeclaration
	;
	
// TypeDeclaration:
//    ClassDeclaration
//    InterfaceDeclaration
//    ;

ModuleDeclaration
    : AnnotationSeqOpt      MODULE CompoundName LBRACE ModuleDirectiveSeqOpt RBRACE
	| AnnotationSeqOpt OPEN MODULE CompoundName LBRACE ModuleDirectiveSeqOpt RBRACE
	;
	
ModuleDirectiveSeqOpt
    :  // empty
    | ModuleDirectiveSeq
    ;

ModuleDirectiveSeq
    :                    ModuleDirective
    | ModuleDirectiveSeq ModuleDirective	
	;

// ModuleDeclaration:
//    {Annotation} [open] module Identifier {. Identifier} { {ModuleDirective} }

ModuleDirective
    : REQUIRES            CompoundName SEMICOLON
	| REQUIRES TRANSITIVE CompoundName SEMICOLON
	| REQUIRES STATIC     CompoundName SEMICOLON
	
    | EXPORTS CompoundName                     SEMICOLON
	| EXPORTS CompoundName TO CompoundNameList SEMICOLON
	
    | OPENS CompoundName                     SEMICOLON
	| OPENS CompoundName TO CompoundNameList SEMICOLON
	
    | USES CompoundName SEMICOLON
	
    | PROVIDES CompoundName WITH CompoundNameList SEMICOLON
	;
	
CompoundNameList
    :                        CompoundName
	| CompoundNameList COMMA CompoundName
	;

// ModuleDirective:
//    requires {RequiresModifier} ModuleName ;
//    exports PackageName [to ModuleName {, ModuleName}] ;
//    opens PackageName [to ModuleName {, ModuleName}] ;
//    uses TypeName ;
//    provides TypeName with TypeName {, TypeName} ;

// RequiresModifier:
//    (one of) transitive static

// Productions from §8 (Classes)

ClassDeclaration
       // NormalClassDeclaration
    : ModifierSeqOpt CLASS IDENTIFIER TypeParametersOpt SuperclassOpt SuperinterfacesOpt ClassBody
       // EnumDeclaration
	| ModifierSeqOpt ENUM IDENTIFIER SuperinterfacesOpt EnumBody
	;

// ClassDeclaration:
//    NormalClassDeclaration
//    EnumDeclaration

// EnumDeclaration:
//    {ClassModifier} enum TypeIdentifier [Superinterfaces] EnumBody
	
// NormalClassDeclaration:
//    {ClassModifier} class TypeIdentifier [TypeParameters] [Superclass] [Superinterfaces] ClassBody

TypeParametersOpt
    :  // empty
    | TypeParameters
	;
	
TypeParameters
    : LESS TypeParameterList GREATER
	;
	
// TypeParameters:
//    < TypeParameterList >	

TypeParameterList
    :                         TypeParameter
	| TypeParameterList COMMA TypeParameter
	;
	
// TypeParameterList:
//    TypeParameter {, TypeParameter}

SuperclassOpt
    :  // empty
    | EXTENDS ClassType
	;
	
// Superclass:
//    extends ClassType

SuperinterfacesOpt
    :  // empty
	| IMPLEMENTS InterfaceTypeList
	;
	
// Superinterfaces:
//    implements InterfaceTypeList

InterfaceTypeList
    :                         ClassType /* InterfaceType */
    | InterfaceTypeList COMMA ClassType /* InterfaceType */
	;

// InterfaceTypeList:
//    InterfaceType {, InterfaceType}

ClassBody
    : LBRACE                         RBRACE
	| LBRACE ClassBodyDeclarationSeq RBRACE
	;
	
ClassBodyDeclarationSeq
    :                         ClassBodyDeclaration
	| ClassBodyDeclarationSeq ClassBodyDeclaration
	;
	
// ClassBody:
//    { {ClassBodyDeclaration} }

// ClassModifier:
//     (one of) Annotation public protected private abstract static final                     strictfp
// FieldModifier:
//     (one of) Annotation public protected private          static final transient volatile
// MethodModifier:
//     (one of) Annotation public protected private abstract static final synchronized native strictfp
// ConstructorModifier:
//     (one of) Annotation public protected private
// InterfaceModifier:
//     (one of) Annotation public protected private abstract static                           strictfp	
// InterfaceMethodModifier:
//     (one of) Annotation public           private abstract static        default            strictfp	
// ConstantModifier:
//     (one of) Annotation public                            static final
// AnnotationTypeElementModifier:
//     (one of) Annotation public                   abstract
// VariableModifier:
//     (one of) Annotation                                          final	
	
Modifier  // -- Common production for all kinds of modifiers. Yes, it's a "superset", but well... :-)
    : Annotation
	| PUBLIC
	| PROTECTED
	| PRIVATE
	| ABSTRACT
	| STATIC
	| FINAL
	| STRICTFP
	| TRANSIENT
	| SYNCHRONIZED
	| NATIVE
	| DEFAULT
	;

ModifierSeq
    :             Modifier
	| ModifierSeq Modifier
	;
	
ModifierSeqOpt
    : // empty
	| ModifierSeq
	;

ClassBodyDeclaration
      // ClassMemberDeclaration
  	: FieldDeclaration
    | MethodDeclaration
    | ClassDeclaration
	| InterfaceDeclaration
	
    |        Block   // InstanceInitializer
    | STATIC Block   // StaticInitializer
    | ConstructorDeclaration	
	| SEMICOLON
	;

// ClassBodyDeclaration:
//    ClassMemberDeclaration
//    InstanceInitializer
//    StaticInitializer
//    ConstructorDeclaration

// ClassMemberDeclaration:
//    FieldDeclaration
//    MethodDeclaration
//    ClassDeclaration
//    InterfaceDeclaration
//    ;

// InstanceInitializer:
//    Block

// StaticInitializer:
//    static Block
	
FieldDeclaration
    : ModifierSeqOpt Type VariableDeclaratorList SEMICOLON
    ;
	
// FieldDeclaration:
//    {FieldModifier} UnannType VariableDeclaratorList ;

VariableDeclaratorList
    :                              VariableDeclarator
    | VariableDeclaratorList COMMA VariableDeclarator
    ;

// VariableDeclaratorList:
//    VariableDeclarator {, VariableDeclarator}

// VariableDeclarator:
//    VariableDeclaratorId [= VariableInitializer]

VariableDeclarator
    : IDENTIFIER DimsOpt
    | IDENTIFIER DimsOpt EQUAL Expression
	| IDENTIFIER DimsOpt EQUAL ArrayInitializer
	;

// VariableDeclaratorId:
//    Identifier [Dims]
//
// VariableInitializer:
//    Expression
//    ArrayInitializer

MethodDeclaration
    : ModifierSeqOpt MethodHeader MethodBody
	;
	
// MethodDeclaration:
//    {MethodModifier} MethodHeader MethodBody

MethodHeader
    :                                 Result MethodDeclarator ThrowsOpt
    | TypeParameters AnnotationSeqOpt Result MethodDeclarator ThrowsOpt
	;

// MethodHeader:
//                                Result MethodDeclarator [Throws]
//    TypeParameters {Annotation} Result MethodDeclarator [Throws]

Result
    : Type
    | VOID
	;

// Result:
//    UnannType
//    void
	
MethodDeclarator
    : IDENTIFIER LPAREN                                             RPAREN DimsOpt
	| IDENTIFIER LPAREN                         FormalParameterList RPAREN DimsOpt
	| IDENTIFIER LPAREN ReceiverParameter COMMA                     RPAREN DimsOpt
	| IDENTIFIER LPAREN ReceiverParameter COMMA FormalParameterList RPAREN DimsOpt
	;
	
// MethodDeclarator:
//    Identifier ( [ReceiverParameter ,] [FormalParameterList] ) [Dims]

ReceiverParameter
    : AnnotationSeqOpt Type                THIS
	| AnnotationSeqOpt Type IDENTIFIER DOT THIS
	;

// ReceiverParameter:
//    {Annotation} UnannType [Identifier .] this
	
FormalParameterList
    :                           FormalParameter
    | FormalParameterList COMMA FormalParameter
	;

// FormalParameterList:
//    FormalParameter {, FormalParameter}
	
FormalParameter
    : ModifierSeqOpt Type IDENTIFIER DimsOpt                    // VariableDeclaratorId
    | ModifierSeqOpt Type AnnotationSeqOpt ELLIPSIS IDENTIFIER  // VariableArityParameter
	;

// FormalParameter:
//    {VariableModifier} UnannType VariableDeclaratorId
//    VariableArityParameter
//
// VariableArityParameter:
//    {VariableModifier} UnannType {Annotation} ... Identifier
//
// VariableDeclaratorId:
//    Identifier [Dims]

ThrowsOpt
    :  // empty
    | THROWS ExceptionTypeList
	;

// Throws:
//    throws ExceptionTypeList

ExceptionTypeList
    :                         ClassType
    | ExceptionTypeList COMMA ClassType
	;

// ExceptionTypeList:
//    ExceptionType {, ExceptionType}

// ExceptionType:
//    ClassType
//    TypeVariable  -- actually, it's a part of ClassType

MethodBody
    : Block
	| SEMICOLON
    ;

// MethodBody:
//    Block
//    ;

ConstructorDeclaration
    : ModifierSeqOpt ConstructorDeclarator ThrowsOpt ConstructorBody
	;

// ConstructorDeclaration:
//    {ConstructorModifier} ConstructorDeclarator [Throws] ConstructorBody

ConstructorDeclarator
    : TypeParametersOpt IDENTIFIER LPAREN                                             RPAREN
	| TypeParametersOpt IDENTIFIER LPAREN                         FormalParameterList RPAREN
	| TypeParametersOpt IDENTIFIER LPAREN ReceiverParameter COMMA                     RPAREN
	| TypeParametersOpt IDENTIFIER LPAREN ReceiverParameter COMMA FormalParameterList RPAREN
	;

// ConstructorDeclarator:
//    [TypeParameters] SimpleTypeName ( [ReceiverParameter ,] [FormalParameterList] )
	
// SimpleTypeName:
//    TypeIdentifier

ConstructorBody
    : LBRACE                                               RBRACE
	| LBRACE                               BlockStatements RBRACE
	| LBRACE ExplicitConstructorInvocation                 RBRACE
	| LBRACE ExplicitConstructorInvocation BlockStatements RBRACE
	;

// ConstructorBody:
//    { [ExplicitConstructorInvocation] [BlockStatements] }

ExplicitConstructorInvocation
    :                  TypeArgumentsOpt THIS  LPAREN ArgumentListOpt RPAREN SEMICOLON
    |                  TypeArgumentsOpt SUPER LPAREN ArgumentListOpt RPAREN SEMICOLON
    | CompoundName DOT TypeArgumentsOpt SUPER LPAREN ArgumentListOpt RPAREN SEMICOLON
    |      Primary DOT TypeArgumentsOpt SUPER LPAREN ArgumentListOpt RPAREN SEMICOLON
    ;
		   
// ExplicitConstructorInvocation:
//                     [TypeArguments] this  ( [ArgumentList] ) ;
//                     [TypeArguments] super ( [ArgumentList] ) ;
//    ExpressionName . [TypeArguments] super ( [ArgumentList] ) ;
//           Primary . [TypeArguments] super ( [ArgumentList] ) ;

EnumBody
    : LBRACE EnumConstantListOpt       EnumBodyDeclarationsOpt RBRACE
	| LBRACE EnumConstantListOpt COMMA EnumBodyDeclarationsOpt RBRACE
	;

// EnumBody:
//    { [EnumConstantList] [,] [EnumBodyDeclarations] }

EnumConstantListOpt
    :  // empty
	| EnumConstantList
	;

EnumConstantList
    :                        EnumConstant
    | EnumConstantList COMMA EnumConstant
	;
	
// EnumConstantList:
//    EnumConstant {, EnumConstant}

EnumConstant
    : AnnotationSeqOpt IDENTIFIER
	| AnnotationSeqOpt IDENTIFIER                               ClassBody
	| AnnotationSeqOpt IDENTIFIER LPAREN ArgumentListOpt RPAREN
	| AnnotationSeqOpt IDENTIFIER LPAREN ArgumentListOpt RPAREN ClassBody
	;
	
// EnumConstant:
//    {EnumConstantModifier} Identifier [( [ArgumentList] )] [ClassBody]
//
// EnumConstantModifier:
//    Annotation

EnumBodyDeclarationsOpt
    :  // empty
    | SEMICOLON
	| SEMICOLON ClassBodyDeclarationSeq
	;

// EnumBodyDeclarations:
//    ; {ClassBodyDeclaration}

// Productions from §9 (Interfaces)

InterfaceDeclaration
    : NormalInterfaceDeclaration
	| AnnotationTypeDeclaration
	;

// InterfaceDeclaration:
//    NormalInterfaceDeclaration
//    AnnotationTypeDeclaration
	
NormalInterfaceDeclaration
    : ModifierSeqOpt INTERFACE IDENTIFIER TypeParametersOpt ExtendsInterfacesOpt InterfaceBody
	;
	
// NormalInterfaceDeclaration:
//    {InterfaceModifier} interface TypeIdentifier [TypeParameters] [ExtendsInterfaces] InterfaceBody	

ExtendsInterfacesOpt
    :  // empty
	| EXTENDS InterfaceTypeList
	;
	
// ExtendsInterfaces:
//    extends InterfaceTypeList

InterfaceBody
    : LBRACE                               RBRACE
	| LBRACE InterfaceMemberDeclarationSeq RBRACE
	;

// InterfaceBody:
//    { {InterfaceMemberDeclaration} }

InterfaceMemberDeclarationSeq
    :                               InterfaceMemberDeclaration
	| InterfaceMemberDeclarationSeq InterfaceMemberDeclaration
	;
	
InterfaceMemberDeclaration
    : ConstantDeclaration
    | InterfaceMethodDeclaration
    | ClassDeclaration
    | InterfaceDeclaration
    | SEMICOLON
	;
	
// InterfaceMemberDeclaration:
//    ConstantDeclaration
//    InterfaceMethodDeclaration
//    ClassDeclaration
//    InterfaceDeclaration
//    ;
	
ConstantDeclaration
    : ModifierSeqOpt Type VariableDeclaratorList SEMICOLON
	;
	
// ConstantDeclaration:
//    {ConstantModifier} UnannType VariableDeclaratorList ;

InterfaceMethodDeclaration
    : ModifierSeqOpt MethodHeader MethodBody
	;

// InterfaceMethodDeclaration:
//    {InterfaceMethodModifier} MethodHeader MethodBody

AnnotationTypeDeclaration
    : ModifierSeqOpt AT INTERFACE IDENTIFIER LBRACE AnnotationTypeMemberDeclarationSeqOpt RBRACE
	;

// AnnotationTypeDeclaration:
//    {InterfaceModifier} @ interface TypeIdentifier AnnotationTypeBody
//	
// AnnotationTypeBody:
//    { {AnnotationTypeMemberDeclaration} }

AnnotationTypeMemberDeclarationSeqOpt
    :  // empty
	| AnnotationTypeMemberDeclarationSeq
	;
	
AnnotationTypeMemberDeclarationSeq
    :                                    AnnotationTypeMemberDeclaration
	| AnnotationTypeMemberDeclarationSeq AnnotationTypeMemberDeclaration
	;

AnnotationTypeMemberDeclaration
    : AnnotationTypeElementDeclaration
	| ConstantDeclaration
	| ClassDeclaration
	| InterfaceDeclaration
	| SEMICOLON
    ;

// AnnotationTypeMemberDeclaration:
//    AnnotationTypeElementDeclaration
//    ConstantDeclaration
//    ClassDeclaration
//    InterfaceDeclaration
//    ;
	
AnnotationTypeElementDeclaration
    : ModifierSeqOpt Type IDENTIFIER LPAREN RPAREN DimsOpt                      SEMICOLON
	| ModifierSeqOpt Type IDENTIFIER LPAREN RPAREN DimsOpt DEFAULT ElementValue SEMICOLON
	;

// AnnotationTypeElementDeclaration:
//    {AnnotationTypeElementModifier} UnannType Identifier ( ) [Dims] [DefaultValue] ;
//
// DefaultValue:
//    default ElementValue

// Annotation:
//    NormalAnnotation
//    MarkerAnnotation
//    SingleElementAnnotation
	
Annotation
    : AT CompoundName                                     // MarkerAnnotation
    | AT CompoundName LPAREN                      RPAREN  // NormalAnnotation
    | AT CompoundName LPAREN ElementValuePairList RPAREN  // NormalAnnotation
    | AT CompoundName LPAREN ElementValue         RPAREN  // SingleElementAnnotation
	;
	
AnnotationSeq
    :               Annotation
	| AnnotationSeq Annotation
	;
	
AnnotationSeqOpt
    :  // empty
	| AnnotationSeq
	;

// NormalAnnotation:
//    @ TypeName ( [ElementValuePairList] )

ElementValuePairList
    :                            IDENTIFIER EQUAL ElementValue
    | ElementValuePairList COMMA IDENTIFIER EQUAL ElementValue
	;

// ElementValuePairList:
//    ElementValuePair {, ElementValuePair}

// ElementValuePair:
//    Identifier = ElementValue

ElementValue
    : ConditionalExpression
	
       // ElementValueArrayInitializer
    | LBRACE                        RBRACE
    | LBRACE ElementValueList       RBRACE
	| LBRACE ElementValueList COMMA RBRACE
	| LBRACE                  COMMA RBRACE
	   
    | Annotation
	;

// ElementValue:
//    ConditionalExpression
//    ElementValueArrayInitializer
//    Annotation
	
// ElementValueArrayInitializer:
//    { [ElementValueList] [,] }

ElementValueList
    :                        ElementValue
    | ElementValueList COMMA ElementValue
	;

// ElementValueList:
//    ElementValue {, ElementValue}

// MarkerAnnotation:
//    @ TypeName

// SingleElementAnnotation:
//    @ TypeName ( ElementValue )

// Productions from §10 (Arrays)

ArrayInitializer
    : LBRACE                               RBRACE
	| LBRACE                         COMMA RBRACE
	| LBRACE VariableInitializerList       RBRACE
	| LBRACE VariableInitializerList COMMA RBRACE
	;

// ArrayInitializer:
//    { [VariableInitializerList] [,] }

VariableInitializerList
    :                               Expression        // VariableInitializer
	|                               ArrayInitializer  // VariableInitializer
    | VariableInitializerList COMMA Expression
	| VariableInitializerList COMMA ArrayInitializer
	;
	
// VariableInitializerList:
//    VariableInitializer {, VariableInitializer}

// Productions from §14 (Blocks and Statements)

Block
    : LBRACE                 RBRACE
    | LBRACE BlockStatements RBRACE
	;

// Block:
//    { [BlockStatements] }
	
BlockStatements
    :                 BlockStatement
    | BlockStatements BlockStatement
	;
	
// BlockStatements:
//    BlockStatement {BlockStatement}

BlockStatement
    : LocalVariableDeclaration SEMICOLON
    | ClassDeclaration
    | Statement
	;
	
// BlockStatement:
//    LocalVariableDeclarationStatement
//    ClassDeclaration
//    Statement

// LocalVariableDeclarationStatement:
//    LocalVariableDeclaration ;

LocalVariableDeclaration
    : ModifierSeqOpt Type VariableDeclaratorList
	| ModifierSeqOpt VAR  VariableDeclaratorList
	;

// LocalVariableDeclaration:
//    {VariableModifier} LocalVariableType VariableDeclaratorList
//
// LocalVariableType:
//    UnannType
//    var

Statement
    : IDENTIFIER COLON Statement  // LabeledStatement
	| StatementWithoutTrailingSubstatement
    | IfStatement
    | WhileStatement
    | ForStatement
	;
	
// Statement:
//    StatementWithoutTrailingSubstatement
//    LabeledStatement
//    IfThenStatement
//    IfThenElseStatement
//    WhileStatement
//    ForStatement

// StatementNoShortIf:
//    StatementWithoutTrailingSubstatement
//    LabeledStatementNoShortIf
//    IfThenElseStatementNoShortIf
//    WhileStatementNoShortIf
//    ForStatementNoShortIf

StatementWithoutTrailingSubstatement
    : Block
	
    | SEMICOLON             // EmptyStatement
	
    | ExpressionStatement
	
      // AssertStatement
    | ASSERT Expression                  SEMICOLON
    | ASSERT Expression COLON Expression SEMICOLON
  
    | SwitchStatement
	
       // DoStatement
    | DO Statement WHILE LPAREN Expression RPAREN SEMICOLON

	   // BreakStatement
	| BREAK            SEMICOLON
    | BREAK IDENTIFIER SEMICOLON
	
       // ContinueStatement
    | CONTINUE            SEMICOLON
	| CONTINUE IDENTIFIER SEMICOLON
	
       // ReturnStatement
	| RETURN            SEMICOLON
    | RETURN Expression SEMICOLON

      // SynchronizedStatement
	| SYNCHRONIZED LPAREN Expression RPAREN Block
	
     // ThrowStatement
	| THROW Expression SEMICOLON
	
    | TryStatement
	;

// StatementWithoutTrailingSubstatement:
//    Block
//    EmptyStatement
//    ExpressionStatement
//    AssertStatement
//    SwitchStatement
//    DoStatement
//    BreakStatement
//    ContinueStatement
//    ReturnStatement
//    SynchronizedStatement
///   ThrowStatement
//    TryStatement

// EmptyStatement:
//    ;

// LabeledStatement:
//    Identifier : Statement
//
// LabeledStatementNoShortIf:
//    Identifier : StatementNoShortIf

ExpressionStatement
    : StatementExpression SEMICOLON
	;

// ExpressionStatement:
//    StatementExpression ;

StatementExpression
    : Assignment
    | PreIncrementExpression
    | PreDecrementExpression
    | PostIncrementExpression
    | PostDecrementExpression
    | MethodInvocation
    | ClassInstanceCreationExpression
	;
	
// StatementExpression:
//    Assignment
//    PreIncrementExpression
//    PreDecrementExpression
//    PostIncrementExpression
//    PostDecrementExpression
//    MethodInvocation
//    ClassInstanceCreationExpression

IfStatement
    : IF LPAREN Expression RPAREN Statement ElseTailOpt
	;
	
ElseTailOpt
    :  // empty
	| ELSE Statement
	;

// IfThenStatement:
//    if ( Expression ) Statement
//
// IfThenElseStatement:
//    if ( Expression ) StatementNoShortIf else Statement
//
// IfThenElseStatementNoShortIf:
//    if ( Expression ) StatementNoShortIf else StatementNoShortIf

// AssertStatement:
//    assert Expression ;
//    assert Expression : Expression ;

SwitchStatement
    : SWITCH LPAREN Expression RPAREN LBRACE SwitchCases RBRACE
	;
	
SwitchCases
    :             SwitchCase
	| SwitchCases SwitchCase
	;
	
SwitchCase
    : SwitchLabels BlockStatements
	| SwitchLabels
	;

// SwitchStatement:
//    switch ( Expression ) SwitchBlock

// SwitchBlock:
//    { {SwitchBlockStatementGroup} {SwitchLabel} }

// SwitchBlockStatementGroup:
//    SwitchLabels BlockStatements

SwitchLabels
    :              SwitchLabel
	| SwitchLabels SwitchLabel
	;
	
// SwitchLabels:
//    SwitchLabel {SwitchLabel}

SwitchLabel
    : CASE Expression COLON
    | DEFAULT         COLON
	;

// SwitchLabel:
//    case ConstantExpression :
//    case EnumConstantName :
//    default :

// ConstantExpression:
//    Expression

// EnumConstantName:
//    Identifier

WhileStatement
    : WHILE LPAREN Expression RPAREN Statement
	;
	
// WhileStatement:
//    while ( Expression ) Statement
//
// WhileStatementNoShortIf:
//    while ( Expression ) StatementNoShortIf

// DoStatement:
//    do Statement while ( Expression ) ;

ForStatement
    : BasicForStatement
    | EnhancedForStatement
	;

// ForStatement:
//    BasicForStatement
//    EnhancedForStatement
//
// ForStatementNoShortIf:
//    BasicForStatementNoShortIf
//    EnhancedForStatementNoShortIf

BasicForStatement
    : FOR LPAREN ForInitOpt SEMICOLON            SEMICOLON ForUpdateOpt RPAREN Statement
	| FOR LPAREN ForInitOpt SEMICOLON Expression SEMICOLON ForUpdateOpt RPAREN Statement
	;
	
// BasicForStatement:
//    for ( [ForInit] ; [Expression] ; [ForUpdate] ) Statement
//
// BasicForStatementNoShortIf:
//    for ( [ForInit] ; [Expression] ; [ForUpdate] ) StatementNoShortIf

ForInitOpt
    :  // empty
    | StatementExpressionList
    | LocalVariableDeclaration
	;
	
// ForInit:
//    StatementExpressionList
//    LocalVariableDeclaration

ForUpdateOpt
    :  // empty
	| StatementExpressionList
	;
	
// ForUpdate:
//    StatementExpressionList
	
StatementExpressionList
    :                               StatementExpression
    | StatementExpressionList COMMA StatementExpression
	;
	
// StatementExpressionList:
//    StatementExpression {, StatementExpression}

EnhancedForStatement
    : FOR LPAREN ModifierSeqOpt Type IDENTIFIER DimsOpt COLON Expression RPAREN Statement
	| FOR LPAREN ModifierSeqOpt VAR  IDENTIFIER DimsOpt COLON Expression RPAREN Statement
	;
	
// EnhancedForStatement:
//    for ( {VariableModifier} LocalVariableType VariableDeclaratorId : Expression ) Statement
//
// EnhancedForStatementNoShortIf:
//    for ( {VariableModifier} LocalVariableType VariableDeclaratorId : Expression ) StatementNoShortIf

// BreakStatement:
//    break [Identifier] ;

// ContinueStatement:
//    continue [Identifier] ;

// ReturnStatement:
//    return [Expression] ;

// ThrowStatement:
//    throw Expression ;

// SynchronizedStatement:
//    synchronized ( Expression ) Block

TryStatement
    : TRY Block Catches FinallyOpt
	| TRY Block         Finally
    | TRY ResourceSpecification Block CatchesOpt FinallyOpt // TryWithResourcesStatement
	;

// TryStatement:
//    try Block Catches
//    try Block [Catches] Finally
//    TryWithResourcesStatement

CatchesOpt
    :  // empty
	| Catches
	;
	
Catches
    :         CatchClause
	| Catches CatchClause
	;
	
// Catches:
//    CatchClause {CatchClause}

CatchClause
    : CATCH LPAREN CatchFormalParameter RPAREN Block
	;

// CatchClause:
//    catch ( CatchFormalParameter ) Block

CatchFormalParameter
    : ModifierSeqOpt CatchType IDENTIFIER DimsOpt
	;

// CatchFormalParameter:
//    {VariableModifier} CatchType VariableDeclaratorId
//
// VariableDeclaratorId:
//    Identifier [Dims]

CatchType
    :                ClassType
    | CatchType VERT ClassType
	;

// CatchType:
//    UnannClassType {| ClassType}

FinallyOpt
    :  // empty
	| Finally
	;
	
Finally
    : FINALLY Block
	;
	
// Finally:
//    finally Block

// TryWithResourcesStatement:
//    try ResourceSpecification Block [Catches] [Finally]

ResourceSpecification
    : LPAREN ResourceList           RPAREN
	| LPAREN ResourceList SEMICOLON RPAREN
	;

// ResourceSpecification:
//    ( ResourceList [;] )

ResourceList
    :                        Resource
    | ResourceList SEMICOLON Resource
	;

// ResourceList:
//    Resource {; Resource}

Resource
    : ModifierSeqOpt Type IDENTIFIER EQUAL Expression
	| ModifierSeqOpt VAR  IDENTIFIER EQUAL Expression
	| CompoundName   // VariableAccess
	| FieldAccess    // VariableAccess
	;
	
// Resource:
//    {VariableModifier} LocalVariableType Identifier = Expression
//    VariableAccess
//
// VariableAccess:
//    ExpressionName
//    FieldAccess

// Productions from §15 (Expressions)

Primary
    : PrimaryNoNewArray
      // ArrayCreationExpression
	| NEW PrimitiveType  DimExprs DimsOpt
    | NEW ClassType      DimExprs DimsOpt
    | NEW PrimitiveType  Dims ArrayInitializer
    | NEW ClassType      Dims ArrayInitializer
	;

// Primary:
//    PrimaryNoNewArray
//    ArrayCreationExpression

DimExprs
    :          DimExpr
    | DimExprs DimExpr
	;
	
// DimExprs:
//    DimExpr {DimExpr}

DimExpr
    : AnnotationSeqOpt LBRACKET Expression RBRACKET
	;
	
// DimExpr:
//    {Annotation} [ Expression ]
	
PrimaryNoNewArray
      // Literals
	: INTEGER_LITERAL
    | FLOATING_POINT_LITERAL
    | TRUE                         // BOOLEAN_LITERAL
	| FALSE                        // BOOLEAN_LITERAL
    | CHARACTER_LITERAL
    | STRING_LITERAL
    | NULL                         // NULL_LITERAL

    | ClassLiteral
    | THIS
    | CompoundName DOT THIS
    | RPAREN Expression LPAREN
    | ClassInstanceCreationExpression
    | FieldAccess
    | ArrayAccess
    | MethodInvocation
    | MethodReference
	;

// PrimaryNoNewArray:
//    Literal
//    ClassLiteral
//    this
//    TypeName . this
//    ( Expression )
//    ClassInstanceCreationExpression
//    FieldAccess
//    ArrayAccess
//    MethodInvocation
//    MethodReference

// ArrayCreationExpression:
//    new PrimitiveType        DimExprs [Dims]
//    new ClassOrInterfaceType DimExprs [Dims]
//    new PrimitiveType        Dims ArrayInitializer
//    new ClassOrInterfaceType Dims ArrayInitializer
	
ClassLiteral
    : CompoundName BracketsOpt DOT CLASS
	| NumericType  BracketsOpt DOT CLASS
    | BOOLEAN      BracketsOpt DOT CLASS
    | VOID                     DOT CLASS
	;

// ClassLiteral:
//    TypeName {[ ]}    . class
//    NumericType {[ ]} . class
//    boolean {[ ]}     . class
//    void              . class

BracketsOpt
    :  // empty
    | Brackets
	;
	
Brackets
    :          LBRACKET RBRACKET
	| Brackets LBRACKET RBRACKET
	;
	
ClassInstanceCreationExpression
    :                  UnqualifiedClassInstanceCreationExpression
    | CompoundName DOT UnqualifiedClassInstanceCreationExpression
    | Primary      DOT UnqualifiedClassInstanceCreationExpression
	;

// ClassInstanceCreationExpression:
//                     UnqualifiedClassInstanceCreationExpression
//    ExpressionName . UnqualifiedClassInstanceCreationExpression
//    Primary        . UnqualifiedClassInstanceCreationExpression

UnqualifiedClassInstanceCreationExpression
    : NEW TypeArgumentsOpt AnnotatedCompoundName TypeArgumentsOrDiamondOpt LPAREN ArgumentListOpt RPAREN
	| NEW TypeArgumentsOpt AnnotatedCompoundName TypeArgumentsOrDiamondOpt LPAREN ArgumentListOpt RPAREN ClassBody
	;

// UnqualifiedClassInstanceCreationExpression:
//    new [TypeArguments] ClassOrInterfaceTypeToInstantiate ( [ArgumentList] ) [ClassBody]
//
// ClassOrInterfaceTypeToInstantiate:
//    {Annotation} Identifier {. {Annotation} Identifier} [TypeArgumentsOrDiamond]
	
AnnotatedCompoundName
    :                           AnnotationSeqOpt IDENTIFIER
	| AnnotatedCompoundName DOT AnnotationSeqOpt IDENTIFIER
	;
	
TypeArgumentsOrDiamondOpt
	:  // empty
	| TypeArguments
	| LESS GREATER
	;

// TypeArgumentsOrDiamond:
//    TypeArguments
//    <>

FieldAccess
    : Primary                DOT IDENTIFIER
    |                  SUPER DOT IDENTIFIER
    | CompoundName DOT SUPER DOT IDENTIFIER
	;

// FieldAccess:
//             Primary . Identifier
//               super . Identifier
//    TypeName . super . Identifier
	
ArrayAccess
    : CompoundName      LBRACKET Expression RBRACKET
    | PrimaryNoNewArray LBRACKET Expression RBRACKET
	;

// ArrayAccess:
//    ExpressionName [ Expression ]
//    PrimaryNoNewArray [ Expression ]
	
MethodInvocation
    :                                             IDENTIFIER LPAREN ArgumentListOpt RPAREN
    | CompoundName           DOT TypeArgumentsOpt IDENTIFIER LPAREN ArgumentListOpt RPAREN  // TypeName or ExpressionName
    | Primary                DOT TypeArgumentsOpt IDENTIFIER LPAREN ArgumentListOpt RPAREN
    |                  SUPER DOT TypeArgumentsOpt IDENTIFIER LPAREN ArgumentListOpt RPAREN
    | CompoundName DOT SUPER DOT TypeArgumentsOpt IDENTIFIER LPAREN ArgumentListOpt RPAREN  // TypeName
	;

// MethodInvocation:
//                                       MethodName ( [ArgumentList] )
//    TypeName         . [TypeArguments] Identifier ( [ArgumentList] )
//    ExpressionName   . [TypeArguments] Identifier ( [ArgumentList] )
//    Primary          . [TypeArguments] Identifier ( [ArgumentList] )
//    super            . [TypeArguments] Identifier ( [ArgumentList] )
//    TypeName . super . [TypeArguments] Identifier ( [ArgumentList] )
//	
// MethodName:
//    Identifier

ArgumentListOpt
    :  // empty
	| ArgumentList
	;
	
ArgumentList
    :                    Expression
    | ArgumentList COMMA Expression
	;
	
// ArgumentList:
//    Expression {, Expression}

MethodReference
    : CompoundName           COLON_COLON TypeArgumentsOpt IDENTIFIER
    | Primary                COLON_COLON TypeArgumentsOpt IDENTIFIER
    | ReferenceType          COLON_COLON TypeArgumentsOpt IDENTIFIER
    |                  SUPER COLON_COLON TypeArgumentsOpt IDENTIFIER
    | CompoundName DOT SUPER COLON_COLON TypeArgumentsOpt IDENTIFIER
    | ClassType              COLON_COLON TypeArgumentsOpt NEW
    | ArrayType              COLON_COLON                  NEW
	;

// MethodReference:
//    ExpressionName   :: [TypeArguments] Identifier
//    Primary          :: [TypeArguments] Identifier
//    ReferenceType    :: [TypeArguments] Identifier
//               super :: [TypeArguments] Identifier
//    TypeName . super :: [TypeArguments] Identifier
//    ClassType        :: [TypeArguments] new
//    ArrayType        ::                 new

Expression
    : LambdaExpression
    | AssignmentExpression
	;

// Expression:
//    LambdaExpression
//    AssignmentExpression
	
LambdaExpression
    : LambdaParameters ARROW Expression
	| LambdaParameters ARROW Block
	;

// LambdaExpression:
//    LambdaParameters -> LambdaBody
//
// LambdaBody:
//    Expression
//    Block

LambdaParameters
    : LPAREN                     RPAREN
	| LPAREN LambdaParameterList RPAREN
//	| LPAREN IdentifierList      RPAREN
	| IDENTIFIER
	;

// LambdaParameters:
//    ( [LambdaParameterList] )
//    Identifier

LambdaParameterList
   :                           LambdaParameter
   | LambdaParameterList COMMA LambdaParameter
   ;
   
/*   
IdentifierList
    :                      IDENTIFIER
	| IdentifierList COMMA IDENTIFIER
	;
*/
// LambdaParameterList:
//    LambdaParameter {, LambdaParameter}
//    Identifier {, Identifier}

LambdaParameter
    : ModifierSeqOpt Type                           IDENTIFIER DimsOpt  // VariableDeclaratorId
	| ModifierSeqOpt VAR                            IDENTIFIER DimsOpt  // VariableDeclaratorId
    | ModifierSeqOpt Type AnnotationSeqOpt ELLIPSIS IDENTIFIER          // VariableArityParameter
	| IDENTIFIER
	;

// LambdaParameter:
//    {VariableModifier} LambdaParameterType Identifier [Dims] // VariableDeclaratorId
//    {VariableModifier} UnannType {Annotation} ... Identifier // VariableArityParameter
//	
// LambdaParameterType:
//    UnannType
//    var

AssignmentExpression
    : ConditionalExpression
    | Assignment
	;
	
// AssignmentExpression:
//    ConditionalExpression
//    Assignment

Assignment
    : LeftHandSide AssignmentOperator Expression
	;

// Assignment:
//    LeftHandSide AssignmentOperator Expression
	
LeftHandSide
    : CompoundName
    | FieldAccess
    | ArrayAccess
	;
	
// LeftHandSide:
//    ExpressionName
//    FieldAccess
//    ArrayAccess

AssignmentOperator
    : EQUAL
    | MULT_EQUAL
	| SLASH_EQUAL
	| PERCENT_EQUAL
    | PLUS_EQUAL
    | MINUS_EQUAL
    | LESS_LESS_EQUAL
    | GREATER_GREATER_EQUAL
    | GREATER_GREATER_GREATER_EQUAL
	| AMPERSAND_EQUAL
    | CARET_EQUAL
    | VERT_EQUAL
	;
	
// AssignmentOperator:
//    (one of) = *= /= %= += -= <<= >>= >>>= &= ^= |=

ConditionalExpression
    : ConditionalOrExpression ConditionalTailOpt
	;

ConditionalTailOpt
    :  // empty
    | QUESTION Expression COLON ConditionalExpression
    | QUESTION Expression COLON LambdaExpression
	;

// ConditionalExpression:
//    ConditionalOrExpression
//    ConditionalOrExpression ? Expression : ConditionalExpression
//    ConditionalOrExpression ? Expression : LambdaExpression
	
ConditionalOrExpression
    :                                   ConditionalAndExpression
    | ConditionalOrExpression VERT_VERT ConditionalAndExpression
	;
	
// ConditionalOrExpression:
//                               ConditionalAndExpression
//    ConditionalOrExpression || ConditionalAndExpression

ConditionalAndExpression
    :                                  InclusiveOrExpression
    | ConditionalAndExpression AMP_AMP InclusiveOrExpression
	;
	
// ConditionalAndExpression:
//                                InclusiveOrExpression
//    ConditionalAndExpression && InclusiveOrExpression

InclusiveOrExpression
    :                            ExclusiveOrExpression
    | InclusiveOrExpression VERT ExclusiveOrExpression
	;
	
// InclusiveOrExpression:
//                            ExclusiveOrExpression
//    InclusiveOrExpression | ExclusiveOrExpression

ExclusiveOrExpression
    :                             AndExpression
    | ExclusiveOrExpression CARET AndExpression
	;

// ExclusiveOrExpression:
//                            AndExpression
//    ExclusiveOrExpression ^ AndExpression

AndExpression
    :                         EqualityExpression 
    | AndExpression AMPERSAND EqualityExpression
	;

// AndExpression:
//                    EqualityExpression 
//    AndExpression & EqualityExpression
	
EqualityExpression
    :                                RelationalExpression
    | EqualityExpression EQUAL_EQUAL RelationalExpression
    | EqualityExpression NOT_EQUAL   RelationalExpression
	;

// EqualityExpression:
//                          RelationalExpression
//    EqualityExpression == RelationalExpression
//    EqualityExpression != RelationalExpression
	
RelationalExpression
    :                                    ShiftExpression
    | RelationalExpression LESS          ShiftExpression
    | RelationalExpression GREATER       ShiftExpression
    | RelationalExpression LESS_EQUAL    ShiftExpression
    | RelationalExpression GREATER_EQUAL ShiftExpression
    | RelationalExpression INSTANCEOF    ReferenceType
	;

// RelationalExpression:
//                           ShiftExpression
//    RelationalExpression < ShiftExpression
//    RelationalExpression > ShiftExpression
//    RelationalExpression <= ShiftExpression
//    RelationalExpression >= ShiftExpression
//    RelationalExpression instanceof ReferenceType

ShiftExpression
    :                                         AdditiveExpression
    | ShiftExpression LESS_LESS               AdditiveExpression
    | ShiftExpression GREATER_GREATER         AdditiveExpression
    | ShiftExpression GREATER_GREATER_GREATER AdditiveExpression
	;

// ShiftExpression:
//                       AdditiveExpression
//    ShiftExpression << AdditiveExpression
//    ShiftExpression >> AdditiveExpression
//    ShiftExpression >>> AdditiveExpression

AdditiveExpression
    :                          MultiplicativeExpression
    | AdditiveExpression PLUS  MultiplicativeExpression
    | AdditiveExpression MINUS MultiplicativeExpression
	;

// AdditiveExpression:
//                         MultiplicativeExpression
//    AdditiveExpression + MultiplicativeExpression
//    AdditiveExpression - MultiplicativeExpression
	
MultiplicativeExpression
    :                                  UnaryExpression
    | MultiplicativeExpression STAR    UnaryExpression
    | MultiplicativeExpression SLASH   UnaryExpression
    | MultiplicativeExpression PERCENT UnaryExpression
	;

// MultiplicativeExpression:
//                               UnaryExpression
//    MultiplicativeExpression * UnaryExpression
//    MultiplicativeExpression / UnaryExpression
//    MultiplicativeExpression % UnaryExpression
	
UnaryExpression
    : PreIncrementExpression
    | PreDecrementExpression
    | PLUS  UnaryExpression
	| MINUS UnaryExpression
	| UnaryExpressionNotPlusMinus
	;

// UnaryExpression:
//    PreIncrementExpression
//    PreDecrementExpression
//    + UnaryExpression
//    - UnaryExpression
//    UnaryExpressionNotPlusMinus
	
PreIncrementExpression
    : PLUS_PLUS UnaryExpression
	;
	
// PreIncrementExpression:
//    ++ UnaryExpression

PreDecrementExpression
    : MINUS_MINUS UnaryExpression
	;
	
// PreDecrementExpression:
//    -- UnaryExpression

UnaryExpressionNotPlusMinus
    : PostfixExpression
    | TILDE       UnaryExpression
	| EXCLAMATION UnaryExpression
	| CastExpression
	;
	
// UnaryExpressionNotPlusMinus:
//    PostfixExpression
//    ~ UnaryExpression
//    ! UnaryExpression
//    CastExpression

PostfixExpression
    : Primary
    | CompoundName
    | PostIncrementExpression
    | PostDecrementExpression
	;
	
// PostfixExpression:
//    Primary
//    ExpressionName
//    PostIncrementExpression
//    PostDecrementExpression

PostIncrementExpression
    : PostfixExpression PLUS_PLUS
	;
	
// PostIncrementExpression:
//    PostfixExpression ++

PostDecrementExpression
    : PostfixExpression MINUS_MINUS
	;

// PostDecrementExpression:
//    PostfixExpression --

CastExpression
    : LPAREN PrimitiveType                       RPAREN UnaryExpression
	| LPAREN ReferenceType AdditionalBoundSeqOpt RPAREN UnaryExpressionNotPlusMinus
    | LPAREN ReferenceType AdditionalBoundSeqOpt RPAREN LambdaExpression
	;

// CastExpression:
//    ( PrimitiveType                   ) UnaryExpression
//    ( ReferenceType {AdditionalBound} ) UnaryExpressionNotPlusMinus
//    ( ReferenceType {AdditionalBound} ) LambdaExpression

%%


