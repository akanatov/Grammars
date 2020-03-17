// whitespace-item → U+0000, U+0009, U+000B, U+000C, or U+0020
%token WHITESPACE_ITEM
// line-break → U+000A
// line-break → U+000D
// line-break → U+000D followed by U+000A
%token LINE_BREAK
%token SL_COMMENT
%token OPEN_ML_COMMENT
%token CLOSE_ML_COMMENT
// comment-text-item → Any Unicode scalar value except U+000A or U+000D
%token NON_EOL
// multiline-comment-text-item → Any Unicode scalar value except /* or */
%token NON_ML_COMMENT
// identifier-head → Upper- or lowercase letter A through Z
// identifier-head → _
// identifier-head → U+00A8, U+00AA, U+00AD, U+00AF, U+00B2–U+00B5, or U+00B7–U+00BA
// identifier-head → U+00BC–U+00BE, U+00C0–U+00D6, U+00D8–U+00F6, or U+00F8–U+00FF
// identifier-head → U+0100–U+02FF, U+0370–U+167F, U+1681–U+180D, or U+180F–U+1DBF
// identifier-head → U+1E00–U+1FFF
// identifier-head → U+200B–U+200D, U+202A–U+202E, U+203F–U+2040, U+2054, or U+2060–U+206F
// identifier-head → U+2070–U+20CF, U+2100–U+218F, U+2460–U+24FF, or U+2776–U+2793
// identifier-head → U+2C00–U+2DFF or U+2E80–U+2FFF
// identifier-head → U+3004–U+3007, U+3021–U+302F, U+3031–U+303F, or U+3040–U+D7FF
// identifier-head → U+F900–U+FD3D, U+FD40–U+FDCF, U+FDF0–U+FE1F, or U+FE30–U+FE44
// identifier-head → U+FE47–U+FFFD
// identifier-head → U+10000–U+1FFFD, U+20000–U+2FFFD, U+30000–U+3FFFD, or U+40000–U+4FFFD
// identifier-head → U+50000–U+5FFFD, U+60000–U+6FFFD, U+70000–U+7FFFD, or U+80000–U+8FFFD
// identifier-head → U+90000–U+9FFFD, U+A0000–U+AFFFD, U+B0000–U+BFFFD, or U+C0000–U+CFFFD
// identifier-head → U+D0000–U+DFFFD or U+E0000–U+EFFFD
%token IDENTIFIER_HEAD
%token IDENTIFIER_CHARACTER
%token APOSTROPHE
%token DOLLAR
%token COMMA
%token ASSOCIATED_TYPE
%token CLASS
%token DEINIT
%token ENUM
%token EXTENSION
%token FILE_PRIVATE
%token FUNC
%token IMPORT
%token INIT
%token INOUT
%token INTERNAL
%token LET
%token OPEN
%token OPERATOR
%token PRIVATE
%token PROTOCOL
%token PUBLIC
%token RETHROWS
%token STATIC
%token STRUCT
%token SUBSCRIPT
%token TYPEALIAS
%token VAR
%token BREAK
%token CASE
%token CONTINUE
%token DEFAULT
%token DEFER
%token DO
%token ELSE
%token FALLTHROUGH
%token FOR
%token GUARD
%token IF
%token IN
%token REPEAT
%token RETURN
%token SWITCH
%token WHERE
%token WHILE
%token AS
%token ANY
%token CATCH
%token FALSE
%token IS
%token NIL
%token SUPER
%token SELF
%token SSELF
%token THROW
%token THROWS
%token TRUE
%token TRY
%token UNDERSCORE
%token N_AVAILABLE
%token N_DSOHANDLE
%token N_COLOR_LITERAL
%token N_COLUMN
%token N_ELSE
%token N_ELSE_IF
%token N_ENDIF
%token N_ERROR
%token N_FILE
%token N_FILE_LITERAL
%token N_FUNCTION
%token N_IF
%token N_IMAGE_LITERAL
%token N_LINE
%token N_SELECTOR
%token N_SOURCE_LOCATION
%token N_WARNING
%token N_KEY_PATH
%token SETTER
%token GETTER
%token ASSOCIATIVITY
%token CONVENIENCE
%token DYNAMIC
%token DID_SET
%token FINAL
%token GET
%token INFIX
%token INDIRECT
%token LAZY
%token LEFT
%token MUTATING
%token NONE
%token NONMUTATING
%token OPTIONAL
%token OVERRIDE
%token POSTFIX
%token PRECEDENCE
%token PREFIX
%token PPROTOCOL
%token REQUIRED
%token RIGHT
%token SET
%token TTYPE
%token UNOWNED
%token UNOWNED_SAFE
%token UNOWNED_UNSAFE
%token WEAK
%token WILL_SET
%token L_PAR
%token R_PAR
%token L_CURL_PAR
%token R_CURL_PAR
%token L_SQR_PAR
%token R_SQR_PAR
%token DOT
%token COLON
%token SEMICOLON
%token EQUAL
%token AT
%token HASH_TAG
%token DOUBLE_EQUAL
%token AMPERSAND
%token R_ARROW
%token L_ARROW
%token QUESTION
%token EXCLAMATION
// nil-literal → nil
%token MINUS
%token BIN_LITERAL_PREFIX
// binary-digit → Digit 0 or 1
%token BIN_DIGIT
%token OCT_LITERAL_PREFIX
// octal-digit → Digit 0 through 7
%token OCTAL_DIGIT
// decimal-digit → Digit 0 through 9
%token DECIMAL_DIGIT
// hexadecimal-digit → Digit 0 through 9, a through f, or A through F
%token HEXADECIMAL_DIGIT
%token HEX_LITERAL_PREFIX
// floating-point-e → e | E
%token FLOATING_POINT_E
// floating-point-p → p | P
%token FLOATING_POINT_P
%token PLUS
%token CITATION_MARK
%token QUOTED_TEXT_ITEM
%token ML_QUOTED_TEXT_ITEM
%token BACKSLASH
// unicode-scalar-digits → Between one and eight hexadecimal digits
%token UNICODE_SCALAR_DIGIT
// quoted-text-item → Any Unicode scalar value except ", \, U+000A, or U+000D
%token QUOTED_TEXT_CHAR
// operator-head → / | = | - | + | ! | * | % | < | > | & | | | ^ | ~ | ?
// operator-head → U+00A1–U+00A7
// operator-head → U+00A9 or U+00AB
// operator-head → U+00AC or U+00AE
// operator-head → U+00B0–U+00B1
// operator-head → U+00B6, U+00BB, U+00BF, U+00D7, or U+00F7
// operator-head → U+2016–U+2017
// operator-head → U+2020–U+2027
// operator-head → U+2030–U+203E
// operator-head → U+2041–U+2053
// operator-head → U+2055–U+205E
// operator-head → U+2190–U+23FF
// operator-head → U+2500–U+2775
// operator-head → U+2794–U+2BFF
// operator-head → U+2E00–U+2E7F
// operator-head → U+3001–U+3003
// operator-head → U+3008–U+3020
// operator-head → U+3030
%token OPERATOR_HEAD
// operator-character → operator-head
// operator-character → U+0300–U+036F
// operator-character → U+1DC0–U+1DFF
// operator-character → U+20D0–U+20FF
// operator-character → U+FE00–U+FE0F
// operator-character → U+FE20–U+FE2F
// operator-character → U+E0100–U+E01EF
%token OPERATOR_CHARACTER
%token ELLIPSIS
%token SOME
%token RED
%token GREEN
%token BLUE
%token ALPHA
%token RESOURCE_NAME
%token OS
%token ARCH
%token SWIFT
%token COMPILER
%token CAN_IMPORT
%token TARGET_ENVIRONMENT
%token MAC_OS
%token IOS
%token IOS_APPLICATION_EXTENSION
%token MAC_OS_APPLICATION_EXTENSION
%token WATCHOS
%token TVOS
%token I386
%token X86_64
%token ARM
%token ARM64
%token SIMULATOR
%token MAC_CATALYST
%token DOUBLE_AMPERSAND
%token DOUBLE_BAR
%token BAR
%token LESS_THAN
%token GREATER_THAN
%token GREATER_OR_EQUAL_TO
%token FILE_COLON
%token NATURAL_NUMBER
%token ASTERISK
%token LINE_COLON
%token NO_BRACKET_PUNCTUATION
%token LOWER_THAN
%token HIGHER_THAN
%token PRECEDENCE_GROUP
%token ASSIGNMENT

// -----------------------LEXICAL RULES IN TOKENS------------------------------
%token DECIMAL_DIGITS  			// decimal-digits → decimal-digit decimal-digits opt
%token OPERATOR_RULE 			// operator → operator-head operator-characters opt
         						// operator → dot-operator-head dot-operator-characters
%token X_OPERATOR_RULE_OPT
%token IDENTIFIER 				// identifier → identifier-head identifier-characters opt
                  				// identifier → ` identifier-head identifier-characters opt `
                  				// identifier → implicit-parameter-name
                  				// identifier → property-wrapper-projection
%token X_IDENTIFIER_OPT
%token NUMERIC_LITERAL  		// numeric-literal → -opt integer-literal | -opt floating-point-literal
%token STATIC_STRING_LITERAL 	// static-string-literal → string-literal-opening-delimiter quoted-text opt string-literal-closing-delimiter
								// static-string-literal → multiline-string-literal-opening-delimiter multiline-quoted-text opt multiline-string-literal-closing-delimiter
%token IDENTIFIER_LIST          // identifier-list → identifier | identifier , identifier-list
%token BOOLEAN_LITERAL          // boolean-literal → true | false
%token LITERAL                  // literal → numeric-literal | string-literal | boolean-literal | nil-literal
// ----------------------------------------------------------------------------

%start top_level_declaration

%%

keyword
	: ASSOCIATED_TYPE
	| CLASS
	| DEINIT
	| ENUM
	| EXTENSION
	| FILE_PRIVATE
	| FUNC
	| IMPORT
	| INIT
	| INOUT
	| INTERNAL
	| LET
	| OPEN
	| OPERATOR
	| PRIVATE
	| PROTOCOL
	| PUBLIC
	| RETHROWS
	| STATIC
	| STRUCT
	| SUBSCRIPT
	| TYPEALIAS
	| VAR
	| BREAK
	| CASE
	| CONTINUE
	| DEFAULT
	| DEFER
	| DO
	| ELSE
	| FALLTHROUGH
	| FOR
	| GUARD
	| IF
	| IN
	| REPEAT
	| RETURN
	| SWITCH
	| WHERE
	| WHILE
	| AS
	| ANY
	| CATCH
	| FALSE
	| IS
	| NIL
	| SUPER
	| SELF
	| SSELF
	| THROW
	| THROWS
	| TRUE
	| TRY
	| UNDERSCORE
	| N_AVAILABLE
	| N_COLOR_LITERAL
	| N_COLUMN
	| N_ELSE
	| N_ELSE_IF
	| N_ENDIF
	| N_ERROR
	| N_FILE
	| N_FILE_LITERAL
	| N_FUNCTION
	| N_IF
	| N_IMAGE_LITERAL
	| N_LINE
	| N_SELECTOR
	| N_SOURCE_LOCATION
	| N_WARNING
	| ASSOCIATIVITY
	| CONVENIENCE
	| DYNAMIC
	| DID_SET
	| FINAL
	| GET
	| INFIX
	| INDIRECT
	| LAZY
	| LEFT
	| MUTATING
	| NONE
	| NONMUTATING
	| OPTIONAL
	| OVERRIDE
	| POSTFIX
	| PRECEDENCE
	| PREFIX
	| PPROTOCOL
	| REQUIRED
	| RIGHT
	| SET
	| TTYPE
	| UNOWNED
	| WEAK
	| WILL_SET
    ;


//// GRAMMAR OF WHITESPACE
//
//// whitespace → whitespace-item whitespace opt
// whitespace
//	: whitespace_item x_whitespace_opt
//    ;
//x_whitespace_opt
//	:
//	| whitespace
//    ;
//
//// whitespace-item → line-break
//// whitespace-item → comment
//// whitespace-item → multiline-comment
// whitespace_item
//	: LINE_BREAK
//	| WHITESPACE_ITEM
//	| comment
//	| multiline_comment
//    ;
//
//// comment → // comment-text line-break
// comment
//	: SL_COMMENT comment_text LINE_BREAK
//    ;
//
//// multiline-comment → /* multiline-comment-text */
// multiline_comment
//	: OPEN_ML_COMMENT multiline_comment_text CLOSE_ML_COMMENT
//    ;
//
//// comment-text → comment-text-item comment-text opt
// comment_text
//	: NON_EOL x_comment_text_opt
//    ;
// x_comment_text_opt
//	:
//	| comment_text
//    ;
//
//// multiline-comment-text → multiline-comment-text-item multiline-comment-text opt
// multiline_comment_text
//	: multiline_comment_text_item x_multiline_comment_text_opt
//    ;
// x_multiline_comment_text_opt
//	:
//	| x_multiline_comment_text_opt
//    ;
//
//// multiline-comment-text-item → multiline-comment
//// multiline-comment-text-item → comment-text-item
// multiline_comment_text_item
//	: multiline_comment
//	| NON_EOL
//	| NON_ML_COMMENT
//    ;
//
//
//// GRAMMAR OF AN IDENTIFIER
//
//// identifier → identifier-head identifier-characters opt
//// identifier → ` identifier-head identifier-characters opt `
//// identifier → implicit-parameter-name
//// identifier → property-wrapper-projection
// identifier
//	: IDENTIFIER_HEAD x_identifier_characters_opt
//	| APOSTROPHE x_identifier_characters_opt APOSTROPHE
//	| implicit_parameter_name
//	| property_wrapper_projection
//    ;
// x_identifier_opt
//	:
//	| identifier
//    ;
//
//// identifier-list → identifier | identifier , identifier-list
// identifier_list
//	: identifier
//	| identifier_list COMMA identifier
//    ;
//
//// identifier-character → Digit 0 through 9
//// identifier-character → U+0300–U+036F, U+1DC0–U+1DFF, U+20D0–U+20FF, or U+FE20–U+FE2F
//// identifier-character → identifier-head
// identifier_character
//	: IDENTIFIER_CHARACTER
//	| IDENTIFIER_HEAD
//    ;
//
//// identifier-characters → identifier-character identifier-characters opt
// identifier_characters
//	: x_identifier_characters_opt identifier_character
//    ;
// x_identifier_characters_opt
//	:
//	| identifier_characters
//    ;
//
//// implicit-parameter-name → $ decimal-digits
// implicit_parameter_name
//	: DOLLAR decimal_digits
//    ;
//
//// property-wrapper-projection → $ identifier-characters
// property_wrapper_projection
//	: DOLLAR identifier_characters
//    ;
//
//
//// GRAMMAR OF A LITERAL
//
//// literal → numeric-literal | string-literal | boolean-literal | nil-literal
// literal
//	: numeric_literal
//	| string_literal
//	| boolean_literal
//	| NIL
//    ;
//
//// numeric-literal → -opt integer-literal | -opt floating-point-literal
//x_minus_opt
//	:
//	| MINUS
//    ;
//numeric_literal
//	: x_minus_opt integer_literal
//	| x_minus_opt floating_point_literal
//    ;
//
//// boolean-literal → true | false
//boolean_literal
//	: TRUE
//	| FALSE
//    ;
//
//
//// GRAMMAR OF AN INTEGER LITERA
//
//// integer-literal → binary-literal
//// integer-literal → octal-literal
//// integer-literal → decimal-literal
//// integer-literal → hexadecimal-literal
//integer_literal
//	: binary_literal
//	| octal_literal
//	| decimal_literal
//	| hexadecimal_literal
//    ;
//
//// binary-literal → 0b binary-digit binary-literal-characters opt
//binary_literal
//	: BIN_LITERAL_PREFIX BIN_DIGIT x_binary_literal_characters_opt
//
//// binary-literal-character → binary-digit | _
//binary_literal_character
//	: BIN_DIGIT
//	| UNDERSCORE
//    ;
//// binary-literal-characters → binary-literal-character binary-literal-characters opt
//binary_literal_characters
//	: binary_literal_character x_binary_literal_characters_opt
//    ;
//x_binary_literal_characters_opt
//	:
//	| binary_literal_characters
//    ;
//
//// octal-literal → 0o octal-digit octal-literal-characters opt
//octal_literal
//	: OCT_LITERAL_PREFIX OCTAL_DIGIT x_octal_literal_characters_opt
//    ;
//
//// octal-literal-character → octal-digit | _
//octal_literal_character
//	: OCTAL_DIGIT
//	| UNDERSCORE
//    ;
//
//// octal-literal-characters → octal-literal-character octal-literal-characters opt
//octal_literal_characters
//	: octal_literal_character x_octal_literal_characters_opt
//    ;
//x_octal_literal_characters_opt
//	:
//	| octal_literal_characters
//    ;
//
//// decimal-literal → decimal-digit decimal-literal-characters opt
//decimal_literal
//	: DECIMAL_DIGIT x_decimal_literal_characters_opt
//    ;
//
//// decimal-digits → decimal-digit decimal-digits opt
//decimal_digits
//	: DECIMAL_DIGIT x_decimal_digits_opt
//    ;
//x_decimal_digits_opt
//	:
//	| decimal_digits
//    ;
//
//// decimal-literal-character → decimal-digit | _
//decimal_literal_character
//	: DECIMAL_DIGIT
//	| UNDERSCORE
//    ;
//// decimal-literal-characters → decimal-literal-character decimal-literal-characters opt
//decimal_literal_characters
//	: decimal_literal_character x_decimal_literal_characters_opt
//    ;
//x_decimal_literal_characters_opt
//	:
//	| decimal_literal_characters
//    ;
//
//// hexadecimal-literal → 0x hexadecimal-digit hexadecimal-literal-characters opt
//hexadecimal_literal
//	: HEX_LITERAL_PREFIX HEXADECIMAL_DIGIT x_hexadecimal_literal_characters_opt
//    ;
//
//// hexadecimal-literal-character → hexadecimal-digit | _
//hexadecimal_literal_character
//	: HEXADECIMAL_DIGIT
//	| UNDERSCORE
//    ;
//
//// hexadecimal-literal-characters → hexadecimal-literal-character hexadecimal-literal-characters opt
//hexadecimal_literal_characters
//	: hexadecimal_literal_character x_hexadecimal_literal_characters_opt
//    ;
//x_hexadecimal_literal_characters_opt
//	:
//	| hexadecimal_literal_characters
//    ;
//
//
//// GRAMMAR OF A FLOATING-POINT LITERAL
//
//// floating-point-literal → decimal-literal decimal-fraction opt decimal-exponent opt
//// floating-point-literal → hexadecimal-literal hexadecimal-fraction opt hexadecimal-exponent
//floating_point_literal
//	: decimal_literal x_decimal_fraction_opt x_decimal_exponent_opt
//	| hexadecimal_literal x_hexadecimal_fraction_opt x_hexadecimal_exponent_opt
//    ;
//
//// decimal-fraction → . decimal-literal
//decimal_fraction
//	: DOT decimal_literal
//    ;
//x_decimal_fraction_opt
//	:
//	| decimal_fraction
//
//// decimal-exponent → floating-point-e sign opt decimal-literal
//decimal_exponent
//	: FLOATING_POINT_E x_sign_opt decimal_literal
//    ;
//x_decimal_exponent_opt
//	:
//	| decimal_exponent
//    ;
//
//// hexadecimal-fraction → . hexadecimal-digit hexadecimal-literal-characters opt
//hexadecimal_fraction
//	: DOT HEXADECIMAL_DIGIT x_hexadecimal_literal_characters_opt
//    ;
//x_hexadecimal_fraction_opt
//	:
//	| hexadecimal_fraction
//    ;
//
//// hexadecimal-exponent → floating-point-p sign opt decimal-literal
//hexadecimal_exponent
//	: FLOATING_POINT_P x_sign_opt decimal_literal
//    ;
//x_hexadecimal_exponent_opt
//	:
//	| hexadecimal_exponent
//    ;
//
//// sign → + | -
//sign
//	: PLUS
//	| MINUS
//    ;
//x_sign_opt
//	:
//	| sign
//    ;
//
//
//// GRAMMAR OF A STRING LITERAL
//
//// string-literal → static-string-literal | interpolated-string-literal
//string_literal
//	: static_string_literal
//	| interpolated_string_literal
//    ;
//
//// string-literal-opening-delimiter → extended-string-literal-delimiter opt "
//string_literal_opening_delimiter
//	: x_extended_string_literal_delimiter_opt CITATION_MARK
//    ;
//
//// string-literal-closing-delimiter → " extended-string-literal-delimiter opt
//string_literal_closing_delimiter
//	: CITATION_MARK x_extended_string_literal_delimiter_opt
//    ;
//
//// static-string-literal → string-literal-opening-delimiter quoted-text opt string-literal-closing-delimiter
//// static-string-literal → multiline-string-literal-opening-delimiter multiline-quoted-text opt multiline-string-literal-closing-delimiter
//static_string_literal
//	: string_literal_opening_delimiter x_quoted_text_opt string_literal_closing_delimiter
//	| multiline_string_literal_openinig_delimiter x_multiline_quoted_text_opt multiline_string_literal_closing_delimiter
//    ;
//
//// multiline-string-literal-opening-delimiter → extended-string-literal-delimiter """
//multiline_string_literal_openinig_delimiter
//	: extended_string_literal_delimiter CITATION_MARK CITATION_MARK CITATION_MARK
//    ;
//
//// multiline-string-literal-closing-delimiter → """ extended-string-literal-delimiter
//multiline_string_literal_closing_delimiter
//	: CITATION_MARK CITATION_MARK CITATION_MARK extended_string_literal_delimiter
//    ;
//
//// extended-string-literal-delimiter → # extended-string-literal-delimiter opt
//extended_string_literal_delimiter
//	: HASH_TAG x_extended_string_literal_delimiter_opt
//    ;
//x_extended_string_literal_delimiter_opt
//	:
//	| extended_string_literal_delimiter
//    ;
//
//
//// quoted-text → quoted-text-item quoted-text opt
//quoted_text
//	: quoted_text_item x_quoted_text_opt
//    ;
//x_quoted_text_opt
//	:
//	| quoted_text
//    ;
//
//// quoted-text-item → escaped-character
//quoted_text_item
//	: escaped_character
//	| QUOTED_TEXT_CHAR
//    ;
//
//// multiline-quoted-text → multiline-quoted-text-item multiline-quoted-text opt
//multiline_quoted_text
//	: multiline_quoted_text_item x_multiline_quoted_text_opt
//    ;
//x_multiline_quoted_text_opt
//	:
//	| multiline_quoted_text
//    ;
//
//// multiline-quoted-text-item → escaped-character
//// multiline-quoted-text-item → Any Unicode scalar value except \
//// multiline-quoted-text-item → escaped-newline
//multiline_quoted_text_item
//	: escaped_character
//	| multiline_quoted_text_seq
//	| escaped_newline
//    ;
//multiline_quoted_text_seq
//	:
//	| multiline_quoted_text_seq ML_QUOTED_TEXT_ITEM
//    ;
//
//// interpolated-string-literal → string-literal-opening-delimiter interpolated-text opt string-literal-closing-delimiter
//// interpolated-string-literal → multiline-string-literal-opening-delimiter interpolated-text opt multiline-string-literal-closing-delimiter
//interpolated_string_literal
//	: string_literal_opening_delimiter x_interpolated_text_opt string_literal_closing_delimiter
//	| multiline_string_literal_openinig_delimiter x_interpolated_text_opt multiline_string_literal_closing_delimiter
//    ;
//
//// interpolated-text → interpolated-text-item interpolated-text opt
//interpolated_text
//	: interpolated_text_item x_interpolated_text_opt
//    ;
//x_interpolated_text_opt
//	:
//	| interpolated_text
//    ;
//
//// interpolated-text-item → \( expression ) | quoted-text-item
//interpolated_text_item
//	: BACKSLASH L_PAR expression R_PAR
//	| quoted_text_item
//    ;
//
//// multiline-interpolated-text → multiline-interpolated-text-item multiline-interpolated-text opt
////multiline_interpolated_text
////	: multiline_interpolated_text_item x_multiline_interpolated_text_opt
////x_multiline_interpolated_text_opt
////	:
////	| multiline_interpolated_text
////    ;
//
//
//// multiline-interpolated-text-item → \( expression ) | multiline-quoted-text-item
////multiline_interpolated_text_item
////	: BACKSLASH L_PAR expression R_PAR
////	| multiline_quoted_text_item
////    ;
//
//// escape-sequence → \ extended-string-literal-delimiter
//escape_sequence
//	: BACKSLASH extended_string_literal_delimiter
//    ;
//// escaped-character → escape-sequence 0 | escape-sequence \ | escape-sequence t | escape-sequence n | escape-sequence r | escape-sequence " | escape-sequence '
//// escaped-character → escape-sequence u { unicode-scalar-digits }
//escaped_character
//	: escape_sequence '0'
//	| escape_sequence BACKSLASH
//	| escape_sequence 't'
//	| escape_sequence 'n'
//	| escape_sequence 'r'
//	| escape_sequence CITATION_MARK
//	| escape_sequence APOSTROPHE
//	| escape_sequence 'u' L_CURL_PAR unicode_scalar_digits R_CURL_PAR
//    ;
//
//// unicode-scalar-digits → Between one and eight hexadecimal digits
//unicode_scalar_digits
//	: HEXADECIMAL_DIGIT
//	| HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT
//	| HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT
//	| HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT
//	| HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT
//	| HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT
//	| HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT
//	| HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT
//	| HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT
//    ;
//
//// escaped-newline → escape-sequence whitespace opt line-break
//escaped_newline
//	: escape_sequence x_whitespace_opt LINE_BREAK
//    ;
//
//
//// GRAMMAR OF OPERATORS
//
//
//// operator → operator-head operator-characters opt
//// operator → dot-operator-head dot-operator-characters
//operator
//	: OPERATOR_HEAD x_operator_characters_opt
//	| DOT dot_operator_characters
//    ;
//x_operator_opt
//	:
//	| operator
//	;
//
//// operator-characters → operator-character operator-characters opt
//operator_characters
//	: OPERATOR_CHARACTER x_operator_characters_opt
//    ;
//x_operator_characters_opt
//	:
//	| operator_characters
//    ;
//
//
//// dot-operator-character → . | operator-character
//dot_operator_character
//	: DOT
//	| OPERATOR_CHARACTER
//    ;
//
//// dot-operator-characters → dot-operator-character dot-operator-characters opt
//dot_operator_characters
//	: dot_operator_character x_dot_operator_characters_opt
//    ;
//x_dot_operator_characters_opt
//	:
//	| dot_operator_characters
//    ;
//
//// binary-operator → operator (collapsed)
//
//// prefix-operator → operator (collapsed)
//
//// postfix-operator → operator (collapsed)


// GRAMMAR OF A TYPE


// type → function-type
// type → array-type
// type → dictionary-type
// type → type-identifier
// type → tuple-type
// type → optional-type
// type → implicitly-unwrapped-optional-type
// type → protocol-composition-type
// type → opaque-type
// type → metatype-type
// type → self-type
// type → Any
// type → ( type )
type
	: function_type
	| array_type
	| dictionary_type
	| type_identifier
	| tuple_type
	| optional_type
	| implicitly_unwrapped_optional_type
	| protocol_composition_type
	| opaque_type
	| metatype_type
	| SSELF
	| ANY
	| L_PAR type R_PAR
    ;
//x_type_opt
//	:
//	| type
//    ;


// GRAMMAR OF A TYPE ANNOTATION


// type-annotation → : attributes opt inoutopt type
type_annotation
	: type
	| INOUT type
	| attributes  type
	| attributes INOUT type
    ;
x_type_annotation_opt
	:
	| type_annotation
    ;
x_inout_opt
	:
	| INOUT


// GRAMMAR OF A TYPE IDENTIFIER

// type-identifier → type-name generic-argument-clause opt | type-name generic-argument-clause opt . type-identifier
type_identifier
	: IDENTIFIER x_generic_argument_clause_opt
	| IDENTIFIER x_generic_argument_clause_opt DOT type_identifier
    ;
x_type_identifier_opt
	: 
	| type_identifier
    ;

// type-name → identifier (collapsed)


// GRAMMAR OF A TUPLE TYPE

// tuple-type → ( ) | ( tuple-type-element , tuple-type-element-list )
tuple_type
	: L_PAR R_PAR
	| L_PAR tuple_type_element COMMA tuple_type_element_list R_PAR
    ;
x_tuple_type_opt
	:
	| tuple_type
    ;

// tuple-type-element-list → tuple-type-element | tuple-type-element , tuple-type-element-list
tuple_type_element_list
	: tuple_type_element
	| tuple_type_element_list COMMA tuple_type_element
    ;

// tuple-type-element → element-name type-annotation | type
tuple_type_element
	: IDENTIFIER type_annotation
	| type
    ;

// element-name → identifier (collapsed)


// GRAMMAR OF A FUNCTION TYPE

// function-type → attributes opt function-type-argument-clause throwsopt -> type
function_type
	: x_attributes_opt function_type_argument_clause x_throws_opt R_ARROW type
    ;
x_throws_opt
	:
	| THROWS
    ;
x_rethrows_opt
	:
	| RETHROWS
    ;

// function-type-argument-clause → ( )
// function-type-argument-clause → ( function-type-argument-list ...opt )
function_type_argument_clause
	: L_PAR R_PAR
	| L_PAR function_type_argument_list x_ellipsis_opt R_PAR
    ;
x_ellipsis_opt
	: 
	| ELLIPSIS
    ;

// function-type-argument-list → function-type-argument | function-type-argument , function-type-argument-list
function_type_argument_list
	: function_type_argument
	| function_type_argument COMMA function_type_argument_list
    ;

// function-type-argument → attributes opt inoutopt type | argument-label type-annotation
function_type_argument
	: x_attributes_opt x_inout_opt type
	| IDENTIFIER type_annotation
    ;

// argument-label → identifier (collapsed)


// GRAMMAR OF AN ARRAY TYPE

// array-type → [ type ]
array_type
	: L_SQR_PAR type R_SQR_PAR
    ;


// GRAMMAR OF A DICTIONARY TYPE

// dictionary-type → [ type : type ]
dictionary_type
	: L_SQR_PAR type COLON type R_SQR_PAR
    ;


// GRAMMAR OF AN OPTIONAL TYPE

// optional-type → type ?
optional_type
	: type QUESTION
    ;


// GRAMMAR OF AN IMPLICITLY UNWRAPPED OPTIONAL TYPE

// implicitly-unwrapped-optional-type → type !
implicitly_unwrapped_optional_type
	: type EXCLAMATION
    ;


// GRAMMAR OF A PROTOCOL COMPOSITION TYPE

// protocol-composition-type → type-identifier & protocol-composition-continuation
protocol_composition_type
	: type_identifier AMPERSAND protocol_composition_continuation
    ;

// protocol-composition-continuation → type-identifier | protocol-composition-type
protocol_composition_continuation
	: type_identifier
	| protocol_composition_type
    ;


// GRAMMAR OF AN OPAQUE TYPE

// opaque-type → some type
opaque_type
	: SOME type
    ;


// GRAMMAR OF A METATYPE TYPE

// metatype-type → type . Type | type . Protocol
metatype_type
	: type DOT TTYPE
	| type DOT PPROTOCOL
    ;


// GRAMMAR OF A SELF TYPE

// self-type → Self (collapsed)


// GRAMMAR OF A TYPE INHERITANCE CLAUSE

// type-inheritance-clause → : type-inheritance-list
type_inheritance_clause
	: COLON type_inheritance_list
    ;
x_type_inheritance_clause_opt
	:
	| type_inheritance_clause
    ;

// type-inheritance-list → type-identifier | type-identifier , type-inheritance-list
type_inheritance_list
	: type_identifier
	| type_identifier COMMA type_inheritance_list
    ;


// GRAMMAR OF AN EXPRESSION

// expression → try-operator opt prefix-expression binary-expressions opt
expression
	: try_operator prefix_expression x_binary_expressions_opt
    | prefix_expression x_binary_expressions_opt
    ;
x_expression_opt
	:
	| expression
    ;

// expression-list → expression | expression , expression-list
//expression_list
//	: expression
//	| expression COMMA expression_list
//    ;


// GRAMMAR OF A PREFIX EXPRESSION

// prefix-expression → prefix-operator opt postfix-expression
// prefix-expression → in-out-expression
prefix_expression
	: X_OPERATOR_RULE_OPT postfix_expression
	| in_out_expression
    ;

// in-out-expression → & identifier
in_out_expression
	: AMPERSAND IDENTIFIER
    ;


// GRAMMAR OF A TRY EXPRESSION

// try-operator → try | try ? | try !
try_operator
	: TRY
	| TRY QUESTION
	| TRY EXCLAMATION
    ;
x_try_operator_opt
	:
	| try_operator
    ;


// GRAMMAR OF A BINARY EXPRESSION

// binary-expression → binary-operator prefix-expression
// binary-expression → assignment-operator try-operator opt prefix-expression
// binary-expression → conditional-operator try-operator opt prefix-expression
// binary-expression → type-casting-operator
binary_expression
	: OPERATOR prefix_expression
	| EQUAL x_try_operator_opt prefix_expression
	| conditional_operator x_try_operator_opt prefix_expression
	| type_casting_operator
    ;

// binary-expressions → binary-expression binary-expressions opt
binary_expressions
	: binary_expression x_binary_expressions_opt
    ;
x_binary_expressions_opt
	:
	| binary_expressions
    ;


// GRAMMAR OF AN ASSIGNMENT OPERATOR

// assignment-operator → = (collapsed)


// GRAMMAR OF A CONDITIONAL OPERATOR

// conditional-operator → ? expression :
conditional_operator
	: QUESTION expression EXCLAMATION
    ;


// GRAMMAR OF A TYPE-CASTING OPERATOR

// type-casting-operator → is type
// type-casting-operator → as type
// type-casting-operator → as ? type
// type-casting-operator → as ! type
type_casting_operator
	: IS type
	| AS type
	| AS QUESTION type
	| AS EXCLAMATION type
    ;


// GRAMMAR OF A PRIMARY EXPRESSION

// primary-expression → identifier generic-argument-clause opt
// primary-expression → literal-expression
// primary-expression → self-expression
// primary-expression → superclass-expression
// primary-expression → closure-expression
// primary-expression → parenthesized-expression
// primary-expression → tuple-expression
// primary-expression → implicit-member-expression
// primary-expression → wildcard-expression
// primary-expression → key-path-expression
// primary-expression → selector-expression
// primary-expression → key-path-string-expression
primary_expression
	: IDENTIFIER x_generic_argument_clause_opt
	| literal_expression
	| self_expression
	| superclass_expression
	| closure_expression
	| parenthesized_expression
	| tuple_expression
	| implicit_member_expression
	| UNDERSCORE
	| key_path_expression
	| selector_expression
	| key_path_string_expression
    ;


// GRAMMAR OF A LITERAL EXPRESSION

// literal-expression → literal
// literal-expression → array-literal | dictionary-literal | playground-literal
// literal-expression → #file | #line | #column | #function | #dsohandle
literal_expression
	: LITERAL
	| array_literal
	| dictionary_literal
	| playground_literal
	| HASH_TAG N_FILE
	| HASH_TAG N_LINE
	| HASH_TAG N_COLUMN
	| HASH_TAG N_FUNCTION
	| HASH_TAG N_DSOHANDLE
    ;


// array-literal → [ array-literal-items opt ]
array_literal
	: L_SQR_PAR x_array_literal_items_opt R_SQR_PAR
    ;


// array-literal-items → array-literal-item ,opt | array-literal-item , array-literal-items
array_literal_items
	: expression x_comma_opt
	| expression COMMA array_literal_items
    ;
x_array_literal_items_opt
	: 
	| array_literal_items
    ;
x_comma_opt
	:
	| COMMA
    ;

// array-literal-item → expression (collapsed)

// dictionary-literal → [ dictionary-literal-items ] | [ : ]
dictionary_literal
	: L_SQR_PAR dictionary_literal_items R_SQR_PAR
	| L_SQR_PAR COLON R_SQR_PAR
    ;

// dictionary-literal-items → dictionary-literal-item ,opt | dictionary-literal-item , dictionary-literal-items
dictionary_literal_items
	: dictionary_literal_item x_comma_opt
	| dictionary_literal_item COMMA dictionary_literal_items
    ;

// dictionary-literal-item → expression : expression
dictionary_literal_item
	: expression COLON expression
    ;

// playground-literal → #colorLiteral ( red : expression , green : expression , blue : expression , alpha : expression )
// playground-literal → #fileLiteral ( resourceName : expression )
// playground-literal → #imageLiteral ( resourceName : expression )
playground_literal
	: HASH_TAG N_COLOR_LITERAL L_PAR RED COLON expression COMMA GREEN COLON expression COMMA BLUE COLON expression COMMA ALPHA expression R_PAR
	| HASH_TAG N_FILE_LITERAL L_PAR RESOURCE_NAME COLON expression R_PAR
	| N_IMAGE_LITERAL L_PAR RESOURCE_NAME COLON expression R_PAR
    ;


// GRAMMAR OF A SELF EXPRESSION

// self-expression → self | self-method-expression | self-subscript-expression | self-initializer-expression
self_expression
	: SELF
	| self_method_expression
	| self_subscript_expression
	| self_initializer_expression
    ;

// self-method-expression → self . identifier
self_method_expression
	: SELF DOT IDENTIFIER
    ;

// self-subscript-expression → self [ function-call-argument-list ]
self_subscript_expression
	: SELF L_SQR_PAR function_call_argument_list R_SQR_PAR
    ;

// self-initializer-expression → self . init
self_initializer_expression
	: SELF DOT INIT
    ;


// GRAMMAR OF A SUPERCLASS EXPRESSION

// superclass-expression → superclass-method-expression | superclass-subscript-expression | superclass-initializer-expression
superclass_expression
	: superclass_method_expression
	| superclass_subscipt_expression
	| superclass_initializer_expression
    ;

// superclass-method-expression → super . identifier
superclass_method_expression
	: SUPER DOT IDENTIFIER
    ;

// superclass-subscript-expression → super [ function-call-argument-list ]
superclass_subscipt_expression
	: SUPER L_SQR_PAR function_call_argument_list R_SQR_PAR
    ;

// superclass-initializer-expression → super . init
superclass_initializer_expression
	: SUPER DOT INIT
    ;


// GRAMMAR OF A CLOSURE EXPRESSION

// closure-expression → { closure-signature opt statements opt }
closure_expression
	: L_SQR_PAR x_closure_signature_opt x_statements_opt R_SQR_PAR
    ;

// closure-signature → capture-list opt closure-parameter-clause throwsopt function-result opt in
// closure-signature → capture-list in
closure_signature
	: x_capture_list_opt closure_parameter_clause x_throws_opt x_function_result_opt IN
	| capture_list IN
    ;
x_closure_signature_opt
	:
	| closure_signature
    ;

// closure-parameter-clause → ( ) | ( closure-parameter-list ) | identifier-list
closure_parameter_clause
	: L_PAR R_PAR
	| L_PAR closure_parameter_list R_PAR
	| IDENTIFIER_LIST
    ;

// closure-parameter-list → closure-parameter | closure-parameter , closure-parameter-list
closure_parameter_list
	: closure_parameter
	| closure_parameter COMMA closure_parameter_list
    ;

// closure-parameter → closure-parameter-name type-annotation opt
// closure-parameter → closure-parameter-name type-annotation ...
closure_parameter
	: IDENTIFIER
	| type_annotation
	| IDENTIFIER type_annotation ELLIPSIS
    ;

// closure-parameter-name → identifier (collapsed)

// capture-list → [ capture-list-items ]
capture_list
	: L_SQR_PAR capture_list_items R_SQR_PAR
    ;
x_capture_list_opt
	: 
	| capture_list
    ;

// capture-list-items → capture-list-item | capture-list-item , capture-list-items
capture_list_items
	: capture_list_item
	| capture_list_item COMMA capture_list_items
    ;

// capture-list-item → capture-specifier opt expression
capture_list_item
	: x_capture_specifier_opt expression
    ;

// capture-specifier → weak | unowned | unowned(safe) | unowned(unsafe)
capture_specifier
	: WEAK
	| UNOWNED
	| UNOWNED_SAFE
	| UNOWNED_UNSAFE
    ;
x_capture_specifier_opt
	:
	| capture_specifier
    ;


// GRAMMAR OF A IMPLICIT MEMBER EXPRESSION

// implicit-member-expression → . identifier
implicit_member_expression
	: DOT IDENTIFIER
    ;


// GRAMMAR OF A PARENTHESIZED EXPRESSION

// parenthesized-expression → ( expression )
parenthesized_expression
	: L_PAR expression R_PAR
    ;


// GRAMMAR OF A TUPLE EXPRESSION

// tuple-expression → ( ) | ( tuple-element , tuple-element-list )
tuple_expression
	: L_PAR R_PAR
	| L_PAR tuple_element COMMA tuple_element_list R_PAR
    ;

// tuple-element-list → tuple-element | tuple-element , tuple-element-list
tuple_element_list
	: tuple_element
	| tuple_element COMMA tuple_element_list
    ;

// tuple-element → expression | identifier : expression
tuple_element
	: expression
	| IDENTIFIER COLON expression
    ;


// GRAMMAR OF A WILDCARD EXPRESSION

// wildcard-expression → _ (collapsed)


// GRAMMAR OF A KEY-PATH EXPRESSION

// key-path-expression → \ type opt . key-path-components
key_path_expression
	: BACKSLASH type DOT key_path_components
	| BACKSLASH DOT key_path_components
    ;

// key-path-components → key-path-component | key-path-component . key-path-components
key_path_components
	: key_path_component
	| key_path_component DOT key_path_components
    ;


// key-path-component → identifier key-path-postfixes opt | key-path-postfixes
key_path_component
	: IDENTIFIER x_key_path_postfixes_opt
	| key_path_postfixes
    ;

// key-path-postfixes → key-path-postfix key-path-postfixes opt
key_path_postfixes
	: key_path_postfix x_key_path_postfixes_opt
    ;
x_key_path_postfixes_opt
	:
	| key_path_postfixes
    ;

// key-path-postfix → ? | ! | self | [ function-call-argument-list ]
key_path_postfix
	: QUESTION
	| EXCLAMATION
	| SELF
	| L_SQR_PAR function_call_argument_list R_SQR_PAR
    ;


// GRAMMAR OF A SELECTOR EXPRESSION

// selector-expression → #selector ( expression )
// selector-expression → #selector ( getter: expression )
// selector-expression → #selector ( setter: expression )
selector_expression
	: N_SELECTOR L_PAR expression R_PAR
	| N_SELECTOR L_PAR GETTER COLON expression R_PAR
	| N_SELECTOR L_PAR SETTER COLON expression R_PAR
    ;


// GRAMMAR OF A KEY-PATH STRING EXPRESSION

// key-path-string-expression → #keyPath ( expression )
key_path_string_expression
	: N_KEY_PATH L_PAR expression R_PAR
    ;


// GRAMMAR OF A POSTFIX EXPRESSION

// postfix-expression → primary-expression
// postfix-expression → postfix-expression postfix-operator
// postfix-expression → function-call-expression
// postfix-expression → initializer-expression
// postfix-expression → explicit-member-expression
// postfix-expression → postfix-self-expression
// postfix-expression → subscript-expression
// postfix-expression → forced-value-expression
// postfix-expression → optional-chaining-expression
postfix_expression
	: primary_expression
	| postfix_expression OPERATOR_RULE
	| function_call_expression
	| initializer_expression
	| explicit_memeber_expression
	| postfix_self_expression
	| subscript_expression
	| forced_value_expression
	| optional_chaining_expression
    ;


// GRAMMAR OF A FUNCTION CALL EXPRESSION

// function-call-expression → postfix-expression function-call-argument-clause
// function-call-expression → postfix-expression function-call-argument-clause opt trailing-closure
function_call_expression
	: postfix_expression function_call_argument_clause
	| postfix_expression closure_expression
	| postfix_expression function_call_argument_clause closure_expression
    ;

// function-call-argument-clause → ( ) | ( function-call-argument-list )
function_call_argument_clause
	: L_PAR R_PAR
	| L_PAR function_type_argument_list R_PAR
    ;

// function-call-argument-list → function-call-argument | function-call-argument , function-call-argument-list
function_call_argument_list
	: function_call_argument
	| function_call_argument COMMA function_call_argument_list
    ;

// function-call-argument → expression | identifier : expression
// function-call-argument → operator | identifier : operator
function_call_argument
	: expression
	| IDENTIFIER COLON expression
	| OPERATOR_RULE
	| IDENTIFIER COLON OPERATOR

// trailing-closure → closure-expression (collapsed)


// GRAMMAR OF AN INITIALIZER EXPRESSION

// initializer-expression → postfix-expression . init
// initializer-expression → postfix-expression . init ( argument-names )
initializer_expression
	: postfix_expression DOLLAR INIT
	| postfix_expression DOT INIT L_PAR argument_names R_PAR
    ;


// GRAMMAR OF AN EXPLICIT MEMBER EXPRESSION

// explicit-member-expression → postfix-expression . decimal-digits
// explicit-member-expression → postfix-expression . identifier generic-argument-clause opt
// explicit-member-expression → postfix-expression . identifier ( argument-names )
explicit_memeber_expression
	: postfix_expression DOT DECIMAL_DIGITS
	| postfix_expression DOT IDENTIFIER x_generic_argument_clause_opt
	| postfix_expression DOT IDENTIFIER L_PAR argument_names R_PAR
    ;

// argument-names → argument-name argument-names opt 
argument_names
	: argument_name x_argument_names_opt
    ;
x_argument_names_opt
	:
	| argument_names
    ;

// argument-name → identifier :
argument_name
	: IDENTIFIER COLON
    ;


// GRAMMAR OF A POSTFIX SELF EXPRESSION

// postfix-self-expression → postfix-expression . self
postfix_self_expression
	: postfix_expression DOT SELF
    ;


// GRAMMAR OF A SUBSCRIPT EXPRESSION

// subscript-expression → postfix-expression [ function-call-argument-list ]
subscript_expression
	: postfix_expression L_SQR_PAR function_call_argument_list R_SQR_PAR
    ;


// GRAMMAR OF A FORCED-VALUE EXPRESSION

// forced-value-expression → postfix-expression !
forced_value_expression
	: postfix_expression EXCLAMATION
    ;


// GRAMMAR OF AN OPTIONAL-CHAINING EXPRESSION

// optional-chaining-expression → postfix-expression ?
optional_chaining_expression
	: postfix_expression QUESTION
    ;


// GRAMMAR OF A STATEMENT

// statement → expression ;opt
// statement → declaration ;opt
// statement → loop-statement ;opt
// statement → branch-statement ;opt
// statement → labeled-statement ;opt
// statement → control-transfer-statement ;opt
// statement → defer-statement ;opt
// statement → do-statement ;opt
// statement → compiler-control-statement
statement
	: expression x_semicolon_opt
	| declaration x_semicolon_opt
	| loop_statement x_semicolon_opt
	| branch_statement x_semicolon_opt
	| labeled_statement
	| control_transfer_statement x_semicolon_opt
	| defer_statement x_semicolon_opt
	| do_statement x_semicolon_opt
	| compiler_control_statement
    ;
x_semicolon_opt
	:
	| SEMICOLON
    ;

// statements → statement statements opt
statements
	: statement x_statements_opt
    ;
x_statements_opt
	:
	| statements
    ;


// GRAMMAR OF A LOOP STATEMENT

// loop-statement → for-in-statement
// loop-statement → while-statement
// loop-statement → repeat-while-statement
loop_statement
	: for_in_statement
	| while_statement
	| repeat_while_statement
    ;


// GRAMMAR OF A FOR-IN STATEMENT

// for-in-statement → for caseopt pattern in expression where-clause opt code-block
for_in_statement
	: FOR x_case_opt pattern IN expression x_where_clause_opt code_block
    ;
x_case_opt
	:
	| CASE
    ;


// GRAMMAR OF A WHILE STATEMENT

// while-statement → while condition-list code-block
while_statement
	: WHILE condition_list code_block
    ;

// condition-list → condition | condition , condition-list
condition_list
	: condition
	| condition COMMA condition_list
    ;

// condition → expression | availability-condition | case-condition | optional-binding-condition
condition
	: expression
	| availability_condition
	| case_condition
	| optional_binding_condition
    ;

// case-condition → case pattern initializer
case_condition
	: CASE pattern initializer
    ;

// optional-binding-condition → let pattern initializer | var pattern initializer
optional_binding_condition
	: LET pattern initializer
	| VAR pattern initializer
    ;


// GRAMMAR OF A REPEAT-WHILE STATEMENT

// repeat-while-statement → repeat code-block while expression
repeat_while_statement
	: REPEAT code_block WHILE expression


// GRAMMAR OF A BRANCH STATEMENT

// branch-statement → if-statement
// branch-statement → guard-statement
// branch-statement → switch-statement
branch_statement
	: if_statement
	| guard_statement
	| switch_statement
    ;


// GRAMMAR OF AN IF STATEMENT

// if-statement → if condition-list code-block else-clause opt
if_statement
	: IF condition_list code_block x_else_clause_opt
    ;

// else-clause → else code-block | else if-statement
else_clause
	: ELSE code_block
	| ELSE if_statement
    ;
x_else_clause_opt
	:
	| else_clause
    ;


// GRAMMAR OF A GUARD STATEMENT

// guard-statement → guard condition-list else code-block
guard_statement
	: GUARD condition_list ELSE code_block
    ;


// GRAMMAR OF A SWITCH STATEMENT

// switch-statement → switch expression { switch-cases opt }
switch_statement
	: SWITCH expression L_CURL_PAR x_switch_cases_opt R_CURL_PAR
    ;

// switch-cases → switch-case switch-cases opt
switch_cases
	: switch_case
	| switch_cases switch_case
    ;
x_switch_cases_opt
	:
	| switch_cases
    ;

// switch-case → case-label statements
// switch-case → default-label statements
// switch-case → conditional-switch-case
switch_case
	: case_label statements
	| default_label statements
	| condition_switch_case
    ;

// case-label → attributes opt case case-item-list :
case_label
	: x_attributes_opt CASE case_item_list COLON
    ;

// case-item-list → pattern where-clause opt | pattern where-clause opt , case-item-list
case_item_list
	: pattern x_where_clause_opt
	| pattern x_where_clause_opt COMMA case_item_list
    ;
    
// default-label → attributes opt default :
default_label
	: x_attributes_opt DEFAULT COLON
    ;

// where-clause → where where-expression
where_clause
	: WHERE expression
    ;
x_where_clause_opt
	: 
	| where_clause
    ;

// where-expression → expression (collapsed)

// conditional-switch-case → switch-if-directive-clause switch-elseif-directive-clauses opt switch-else-directive-clause opt endif-directive
condition_switch_case
	: switch_if_directive_clause x_switch_elseif_directive_clauses_opt switch_else_directive_clause N_ENDIF
	| switch_if_directive_clause x_switch_elseif_directive_clauses_opt N_ENDIF
    ;

// switch-if-directive-clause → if-directive compilation-condition switch-cases opt
switch_if_directive_clause
	: N_IF compilation_condition x_switch_cases_opt
    ;

// switch-elseif-directive-clauses → elseif-directive-clause switch-elseif-directive-clauses opt
switch_elseif_directive_clauses
	: elseif_directive_clause
	| switch_elseif_directive_clauses elseif_directive_clause
    ;
x_switch_elseif_directive_clauses_opt
	:
	| switch_elseif_directive_clauses
    ;

// switch-elseif-directive-clause → elseif-directive compilation-condition switch-cases opt
//switch_elseif_directive_clause
//	: elseif_directive
//	| compilation_condition
//	| x_switch_cases_opt
//    ;

// switch-else-directive-clause → else-directive switch-cases opt
switch_else_directive_clause
	: N_ELSE x_switch_cases_opt
    ;


// GRAMMAR OF A LABELED STATEMENT

// labeled-statement → statement-label loop-statement
// labeled-statement → statement-label if-statement
// labeled-statement → statement-label switch-statement
// labeled-statement → statement-label do-statement
labeled_statement
	: statement_label loop_statement
	| statement_label if_statement
	| statement_label switch_statement
	| statement_label do_statement
    ;

// statement-label → label-name :
statement_label
	: IDENTIFIER COLON
    ;

// label-name → identifier (collapsed)


// GRAMMAR OF A CONTROL TRANSFER STATEMENT

// control-transfer-statement → break-statement
// control-transfer-statement → continue-statement
// control-transfer-statement → fallthrough-statement
// control-transfer-statement → return-statement
// control-transfer-statement → throw-statement
control_transfer_statement
	: break_statement
	| continue_statement
	| FALLTHROUGH
	| return_statement
	| throw_statement
    ;


// GRAMMAR OF A BREAK STATEMENT

// break-statement → break label-name opt
break_statement
	: BREAK X_IDENTIFIER_OPT


// GRAMMAR OF A CONTINUE STATEMENT

// continue-statement → continue label-name opt
continue_statement
	: CONTINUE X_IDENTIFIER_OPT
    ;


// GRAMMAR OF A FALLTHROUGH STATEMENT

// fallthrough-statement → fallthrough (collapsed)


// GRAMMAR OF A RETURN STATEMENT

// return-statement → return expression opt
return_statement
	: RETURN x_expression_opt
    ;


// GRAMMAR OF A THROW STATEMENT

// throw-statement → throw expression
throw_statement
	: THROW expression
    ;


// GRAMMAR OF A DEFER STATEMENT

// defer-statement → defer code-block
defer_statement
	: DEFER code_block
    ;


// GRAMMAR OF A DO STATEMENT

// do-statement → do code-block catch-clauses opt
do_statement
	: DO code_block x_catch_clauses_opt
	| catch_clause x_catch_clauses_opt
	| CATCH x_pattern_opt x_where_clause_opt code_block
    ;

// catch-clauses → catch-clause catch-clauses opt
catch_clauses
	: catch_clause x_catch_clauses_opt
    ;
x_catch_clauses_opt
	:
	| catch_clauses
    ;

// catch-clause → catch pattern opt where-clause opt code-block
catch_clause
	: CATCH x_pattern_opt x_where_clause_opt code_block




// GRAMMAR OF A COMPILER CONTROL STATEMENT

// compiler-control-statement → conditional-compilation-block
// compiler-control-statement → line-control-statement
// compiler-control-statement → diagnostic-statement
compiler_control_statement
	: conditional_compilation_block
	| line_control_statement
	| diagnostic_statement
    ;


// GRAMMAR OF A CONDITIONAL COMPILATION BLOCK

// conditional-compilation-block → if-directive-clause elseif-directive-clauses opt else-directive-clause opt endif-directive
conditional_compilation_block
	: if_directive_clause x_elseif_directive_clauses_opt x_else_directive_clause_opt N_ENDIF
    ;

// if-directive-clause → if-directive compilation-condition statements opt
if_directive_clause
	: N_IF compilation_condition x_statements_opt
    ;

// elseif-directive-clauses → elseif-directive-clause elseif-directive-clauses opt
elseif_directive_clauses
	: elseif_directive_clause x_elseif_directive_clauses_opt
    ;
x_elseif_directive_clauses_opt
	:
	| elseif_directive_clauses
    ;

// elseif-directive-clause → elseif-directive compilation-condition statements opt
elseif_directive_clause
	: N_ELSE_IF compilation_condition x_statements_opt
    ;

// else-directive-clause → else-directive statements opt
else_directive_clause
	: N_ELSE x_statements_opt
    ;
x_else_directive_clause_opt
	:
	| else_directive_clause
    ;

// if-directive → #if (collapsed)

// elseif-directive → #elseif (collapsed)

// else-directive → #else (collapsed)

// endif-directive → #endif (collapsed)

// compilation-condition → platform-condition
// compilation-condition → identifier
// compilation-condition → boolean-literal
// compilation-condition → ( compilation-condition )
// compilation-condition → ! compilation-condition
// compilation-condition → compilation-condition && compilation-condition
// compilation-condition → compilation-condition || compilation-condition
compilation_condition
	: platform_condition
	| IDENTIFIER
	| BOOLEAN_LITERAL
	| L_PAR compilation_condition R_PAR
	| EXCLAMATION compilation_condition
	| compilation_condition DOUBLE_AMPERSAND compilation_condition
	| compilation_condition DOUBLE_BAR compilation_condition
    ;

// platform-condition → os ( operating-system )
// platform-condition → arch ( architecture )
// platform-condition → swift ( >= swift-version ) | swift ( < swift-version )
// platform-condition → compiler ( >= swift-version ) | compiler ( < swift-version )
// platform-condition → canImport ( module-name )
// platform-condition → targetEnvironment ( environment )
platform_condition
	: OS L_PAR operating_system R_PAR
	| ARCH L_PAR architecture R_PAR
	| SWIFT L_PAR GREATER_OR_EQUAL_TO swift_version R_PAR
	| SWIFT L_PAR LESS_THAN swift_version R_PAR
	| COMPILER L_PAR GREATER_OR_EQUAL_TO swift_version R_PAR
	| COMPILER L_PAR LESS_THAN swift_version R_PAR
	| CAN_IMPORT L_PAR IDENTIFIER R_PAR
	| TARGET_ENVIRONMENT L_PAR environment R_PAR
    ;


// operating-system → macOS | iOS | watchOS | tvOS
operating_system
	: MAC_OS
	| IOS
	| WATCHOS
	| TVOS
    ;

// architecture → i386 | x86_64 | arm | arm64
architecture
	: I386
	| X86_64
	| ARM
	| ARM64
    ;

// swift-version → decimal-digits swift-version-continuation opt
swift_version
	: DECIMAL_DIGITS x_swift_version_continuation_opt
    ;

// swift-version-continuation → . decimal-digits swift-version-continuation opt
swift_version_continuation
	: DOT DECIMAL_DIGITS x_swift_version_continuation_opt
    ;
x_swift_version_continuation_opt
	:
	| swift_version_continuation
    ;

// module-name → identifier (collapsed)

// environment → simulator | macCatalyst
environment
	: SIMULATOR
	| MAC_CATALYST
    ;


// GRAMMAR OF A LINE CONTROL STATEMENT

// line-control-statement → #sourceLocation ( file: file-name , line: line-number )
// line-control-statement → #sourceLocation ( )
line_control_statement
	: N_SOURCE_LOCATION L_PAR FILE_COLON STATIC_STRING_LITERAL COMMA LINE_COLON NATURAL_NUMBER R_PAR
	| N_SOURCE_LOCATION L_PAR R_PAR
    ;

// line-number → A decimal integer greater than zero (collapsed)

// file-name → static-string-literal (collapsed)


// GRAMMAR OF A COMPILE-TIME DIAGNOSTIC STATEMENT

// diagnostic-statement → #error ( diagnostic-message )
// diagnostic-statement → #warning ( diagnostic-message )
diagnostic_statement
	: N_ERROR L_PAR STATIC_STRING_LITERAL R_PAR
	| N_WARNING L_PAR STATIC_STRING_LITERAL R_PAR
    ;

// diagnostic-message → static-string-literal (collapsed)


// GRAMMAR OF AN AVAILABILITY CONDITION

// availability-condition → #available ( availability-arguments )
availability_condition
	: N_AVAILABLE L_PAR availability_arguments R_PAR
    ;

// availability-arguments → availability-argument | availability-argument , availability-arguments
availability_arguments
	: availability_argument 
	| availability_argument COMMA availability_arguments
    ;

// availability-argument → platform-name platform-version
availability_argument
	: platform_name platform_version
    ;

// availability-argument → * (collapsed)

// platform-name → iOS | iOSApplicationExtension
// platform-name → macOS | macOSApplicationExtension
// platform-name → watchOS
// platform-name → tvOS
platform_name
	: IOS
	| IOS_APPLICATION_EXTENSION
	| MAC_OS
	| MAC_OS_APPLICATION_EXTENSION
	| WATCHOS
	| TVOS
    ;

// platform-version → decimal-digits
// platform-version → decimal-digits . decimal-digits
// platform-version → decimal-digits . decimal-digits . decimal-digits
platform_version
	: DECIMAL_DIGITS
	| DECIMAL_DIGITS DOT DECIMAL_DIGITS
	| DECIMAL_DIGITS DOT DECIMAL_DIGITS DOT DECIMAL_DIGITS
    ;


// GRAMMAR OF A DECLARATION

// declaration → import-declaration
// declaration → constant-declaration
// declaration → variable-declaration
// declaration → typealias-declaration
// declaration → function-declaration
// declaration → enum-declaration
// declaration → struct-declaration
// declaration → class-declaration
// declaration → protocol-declaration
// declaration → initializer-declaration
// declaration → deinitializer-declaration
// declaration → extension-declaration
// declaration → subscript-declaration
// declaration → operator-declaration
// declaration → precedence-group-declaration
declaration
	: import_declaration
	| constant_declaration
	| variable_declaration
	| typealias_declaration
	| function_declaration
	| enum_declaration
	| struct_declaration
	| class_declaration
	| protocol_declaration
	| initializer_declaration
	| deinitializer_declaration
	| extension_declaration
	| subscript_declaration
	| operator_declaration
	| precedence_group_declaration
	;

// declarations → declaration declarations opt
//declarations
//	: declaration x_declarations_opt
//	;
//x_declarations_opt
//	:
//	| declarations
//	;


// GRAMMAR OF A TOP-LEVEL DECLARATION

// top-level-declaration → statements opt
top_level_declaration
	: x_statements_opt
	;


// GRAMMAR OF A CODE BLOCK

// code-block → { statements opt }
code_block
	: L_CURL_PAR x_statements_opt R_CURL_PAR
	;
x_code_block_opt
	:
	| code_block
    ;


// GRAMMAR OF AN IMPORT DECLARATION

// import-declaration → attributes opt import import-kind opt import-path
import_declaration
	: x_attributes_opt IMPORT x_import_kind_opt import_path
    ;

// import-kind → typealias | struct | class | enum | protocol | let | var | func
import_kind
	: TYPEALIAS
	| STRUCT
	| CLASS
	| ENUM
	| PROTOCOL
	| LET
	| VAR
	| FUNC
    ;
x_import_kind_opt
	:
	| import_kind
    ;

// import-path → import-path-identifier | import-path-identifier . import-path
import_path
	: import_path_identifier
	| import_path_identifier DOT import_path
    ;

// import-path-identifier → identifier | operator
import_path_identifier
	: IDENTIFIER
	| OPERATOR_RULE
    ;


// GRAMMAR OF A CONSTANT DECLARATION

// constant-declaration → attributes opt declaration-modifiers opt let pattern-initializer-list
constant_declaration
	: x_attributes_opt x_declaration_modifiers_opt LET pattern_initializer_list
    ;

// pattern-initializer-list → pattern-initializer | pattern-initializer , pattern-initializer-list
pattern_initializer_list
	: pattern_initializer
	| pattern_initializer COMMA pattern_initializer_list
    ;

// pattern-initializer → pattern initializer opt
pattern_initializer
	: pattern x_initializer_opt
    ;

// initializer → = expression
initializer
	: EQUAL expression
    ;
x_initializer_opt
	:
	| initializer
    ;


// GRAMMAR OF A VARIABLE DECLARATION

// variable-declaration → variable-declaration-head pattern-initializer-list
// variable-declaration → variable-declaration-head variable-name type-annotation code-block
// variable-declaration → variable-declaration-head variable-name type-annotation getter-setter-block
// variable-declaration → variable-declaration-head variable-name type-annotation getter-setter-keyword-block
// variable-declaration → variable-declaration-head variable-name initializer willSet-didSet-block
// variable-declaration → variable-declaration-head variable-name type-annotation initializer opt willSet-didSet-block
variable_declaration
	: variable_declaration_head pattern_initializer_list
	| variable_declaration_head IDENTIFIER type_annotation code_block
	| variable_declaration_head IDENTIFIER type_annotation getter_setter_block
	| variable_declaration_head IDENTIFIER type_annotation getter_setter_keyword_block
	| variable_declaration IDENTIFIER initializer willset_didset_block
	| variable_declaration_head IDENTIFIER type_annotation x_initializer_opt willset_didset_block
    ;

// variable-declaration-head → attributes opt declaration-modifiers opt var
variable_declaration_head
	: x_attributes_opt x_declaration_modifiers_opt VAR
    ;

// variable-name → identifier (collapsed)

// getter-setter-block → code-block
// getter-setter-block → { getter-clause setter-clause opt }
// getter-setter-block → { setter-clause getter-clause }
getter_setter_block
	: code_block
	| L_CURL_PAR getter_clause x_setter_keyword_clause_opt R_CURL_PAR
	| L_CURL_PAR setter_clause getter_clause R_CURL_PAR
    ;

// getter-clause → attributes opt mutation-modifier opt get code-block
getter_clause
	: x_attributes_opt x_mutation_modifier_opt GET code_block
    ;

// setter-clause → attributes opt mutation-modifier opt set setter-name opt code-block
setter_clause
	: x_attributes_opt x_mutation_modifier_opt SET x_setter_name_opt code_block
    ;

// setter-name → ( identifier ) (???)
setter_name
	: L_PAR IDENTIFIER R_PAR
    ;
x_setter_name_opt
	:
	| setter_name
    ;

// getter-setter-keyword-block → { getter-keyword-clause setter-keyword-clause opt }
// getter-setter-keyword-block → { setter-keyword-clause getter-keyword-clause }
getter_setter_keyword_block
	: L_CURL_PAR getter_keyword_clause x_setter_keyword_clause_opt R_CURL_PAR
	| L_CURL_PAR setter_keyword_clause getter_keyword_clause R_CURL_PAR
    ;

// getter-keyword-clause → attributes opt mutation-modifier opt get
getter_keyword_clause
	: x_attributes_opt x_mutation_modifier_opt GET
    ;

// setter-keyword-clause → attributes opt mutation-modifier opt set
setter_keyword_clause
	: x_attributes_opt x_mutation_modifier_opt SET
    ;
x_setter_keyword_clause_opt
	: 
	| setter_keyword_clause
    ;

// willSet-didSet-block → { willSet-clause didSet-clause opt }
// willSet-didSet-block → { didSet-clause willSet-clause opt }
willset_didset_block
	: L_CURL_PAR willset_clause x_didset_clause_opt R_CURL_PAR
	| L_CURL_PAR didset_clause x_willset_clause_opt R_CURL_PAR
    ;

// willSet-clause → attributes opt willSet setter-name opt code-block
willset_clause
	: x_attributes_opt WILL_SET x_setter_name_opt code_block
    ;
x_willset_clause_opt
	:
	| willset_clause
    ;

// didSet-clause → attributes opt didSet setter-name opt code-block
didset_clause
	: x_attributes_opt DID_SET x_setter_name_opt code_block
    ;
x_didset_clause_opt
	: 
	| didset_clause
    ;


// GRAMMAR OF A TYPE ALIAS DECLARATION

// typealias-declaration → attributes opt access-level-modifier opt typealias typealias-name generic-parameter-clause opt typealias-assignment
typealias_declaration
	: x_attributes_opt x_access_level_modifier_opt TYPEALIAS IDENTIFIER x_generic_parameter_clause_opt typealias_assignment
    ;

// typealias-name → identifier (collapsed)

// typealias-assignment → = type
typealias_assignment
	: EQUAL type
    ;
x_typealias_assignment_opt
	: 
	| typealias_assignment
    ;


// GRAMMAR OF A FUNCTION DECLARATION

// function-declaration → function-head function-name generic-parameter-clause opt function-signature generic-where-clause opt function-body opt
function_declaration
	: function_head function_name x_generic_parameter_clause_opt function_signature x_generic_where_clause_opt x_code_block_opt
    ;

// function-head → attributes opt declaration-modifiers opt func
function_head
	: x_attributes_opt x_declaration_modifiers_opt FUNC
    ;

// function-name → identifier | operator
function_name
	: IDENTIFIER
	| OPERATOR_RULE
    ;

// function-signature → parameter-clause throwsopt function-result opt
// function-signature → parameter-clause rethrows function-result opt
function_signature
	: parameter_clause x_throws_opt x_function_result_opt
	| parameter x_rethrows_opt x_function_result_opt
    ;

// function-result → -> attributes opt type
function_result
	: L_ARROW x_attributes_opt type
    ;
x_function_result_opt
	:
	| function_result
    ;

// function-body → code-block (collapsed)

// parameter-clause → ( ) | ( parameter-list )
parameter_clause
	: L_PAR R_PAR
	| L_PAR parameter_list R_PAR
    ;

// parameter-list → parameter | parameter , parameter-list
parameter_list
	: parameter
	| parameter COMMA parameter_list
    ;

// parameter → external-parameter-name opt local-parameter-name type-annotation default-argument-clause opt
// parameter → external-parameter-name opt local-parameter-name type-annotation
// parameter → external-parameter-name opt local-parameter-name type-annotation ...
parameter
	: X_IDENTIFIER_OPT IDENTIFIER type_annotation x_default_argument_clause_opt
	| X_IDENTIFIER_OPT IDENTIFIER type_annotation ELLIPSIS
    ;

// external-parameter-name → identifier (collapsed)

// local-parameter-name → identifier (collapsed)

// default-argument-clause → = expression
default_argument_clause
	: EQUAL expression
    ;
x_default_argument_clause_opt
	:
	| default_argument_clause
    ;


// GRAMMAR OF AN ENUMERATION DECLARATION

// enum-declaration → attributes opt access-level-modifier opt union-style-enum
// enum-declaration → attributes opt access-level-modifier opt raw-value-style-enum
enum_declaration
	: x_attributes_opt x_access_level_modifier_opt union_style_enum
	| x_attributes_opt x_access_level_modifier_opt raw_value_style_enum
    ;

// union-style-enum → indirectopt enum enum-name generic-parameter-clause opt type-inheritance-clause opt generic-where-clause opt { union-style-enum-members opt }
union_style_enum
	: x_indirect_opt ENUM IDENTIFIER x_generic_parameter_clause_opt x_type_inheritance_clause_opt x_generic_where_clause_opt L_SQR_PAR x_union_style_enum_members_opt R_SQR_PAR
    ;
x_indirect_opt
	:
	| INDIRECT
    ;

// union-style-enum-members → union-style-enum-member union-style-enum-members opt
union_style_enum_members
	: union_style_enum_member x_union_style_enum_members_opt
    ;
x_union_style_enum_members_opt
	:
	| union_style_enum_members
    ;

// union-style-enum-member → declaration | union-style-enum-case-clause | compiler-control-statement
union_style_enum_member
	: declaration
	| union_style_enum_case_clause
	| compiler_control_statement
    ;

// union-style-enum-case-clause → attributes opt indirectopt case union-style-enum-case-list
union_style_enum_case_clause
	: x_attributes_opt x_indirect_opt CASE union_style_enum_case_list
    ;

// union-style-enum-case-list → union-style-enum-case | union-style-enum-case , union-style-enum-case-list
union_style_enum_case_list
	: union_style_enum_case
	| union_style_enum_case COMMA union_style_enum_case_list
    ;

// union-style-enum-case → enum-case-name tuple-type opt
union_style_enum_case
	: IDENTIFIER x_tuple_type_opt
    ;

// enum-name → identifier (collapsed)

// enum-case-name → identifier (collapsed)

// raw-value-style-enum → enum enum-name generic-parameter-clause opt type-inheritance-clause generic-where-clause opt { raw-value-style-enum-members }
raw_value_style_enum
	: ENUM IDENTIFIER x_generic_parameter_clause_opt type_inheritance_clause x_generic_where_clause_opt L_SQR_PAR raw_value_style_enum_members R_SQR_PAR
    ;

// raw-value-style-enum-members → raw-value-style-enum-member raw-value-style-enum-members opt
raw_value_style_enum_members
	: raw_value_style_enum_member x_raw_value_style_enum_members_opt
    ;
x_raw_value_style_enum_members_opt
	:
	| raw_value_style_enum_members
    ;
   
// raw-value-style-enum-member → declaration | raw-value-style-enum-case-clause | compiler-control-statement
raw_value_style_enum_member
	: declaration 
	| raw_value_style_enum_case_clause
	| compiler_control_statement
    ;

// raw-value-style-enum-case-clause → attributes opt case raw-value-style-enum-case-list
raw_value_style_enum_case_clause
	: x_attributes_opt CASE raw_value_style_enum_case_list
    ;

// raw-value-style-enum-case-list → raw-value-style-enum-case | raw-value-style-enum-case , raw-value-style-enum-case-list
raw_value_style_enum_case_list
	: raw_value_style_enum_case
	| raw_value_style_enum_case COMMA raw_value_style_enum_case_list
    ;

// raw-value-style-enum-case → enum-case-name raw-value-assignment opt
raw_value_style_enum_case
	: IDENTIFIER x_raw_value_assignment_opt
    ;

// raw-value-assignment → = raw-value-literal
raw_value_assignment
	: EQUAL raw_value_literal
    ;
x_raw_value_assignment_opt
	: 
	| raw_value_assignment
    ;

// raw-value-literal → numeric-literal | static-string-literal | boolean-literal
raw_value_literal
	: NUMERIC_LITERAL
	| STATIC_STRING_LITERAL
	| BOOLEAN_LITERAL
    ;


// GRAMMAR OF A STRUCTURE DECLARATION

// struct-declaration → attributes opt access-level-modifier opt struct struct-name generic-parameter-clause opt type-inheritance-clause opt generic-where-clause opt struct-body
struct_declaration
	: x_attributes_opt x_access_level_modifier_opt STRUCT IDENTIFIER x_generic_parameter_clause_opt x_type_inheritance_clause_opt x_generic_where_clause_opt struct_body
    ;

// struct-name → identifier (collapsed)

// struct-body → { struct-members opt }
struct_body
	: L_SQR_PAR x_struct_members_opt R_SQR_PAR
    ;

// struct-members → struct-member struct-members opt
struct_members
	: struct_member x_struct_members_opt
    ;
x_struct_members_opt
	:
	| struct_members
    ;

// struct-member → declaration | compiler-control-statement
struct_member
	: declaration
	| compiler_control_statement
    ;


// GRAMMAR OF A CLASS DECLARATION

// class-declaration → attributes opt access-level-modifier opt finalopt class class-name generic-parameter-clause opt type-inheritance-clause opt generic-where-clause opt class-body
// class-declaration → attributes opt final access-level-modifier opt class class-name generic-parameter-clause opt type-inheritance-clause opt generic-where-clause opt class-body
class_declaration
	: x_attributes_opt x_access_level_modifier_opt x_final_opt CLASS IDENTIFIER x_generic_parameter_clause_opt x_type_inheritance_clause_opt x_generic_where_clause_opt class_body
	| x_attributes_opt FINAL x_access_level_modifier_opt CLASS IDENTIFIER x_generic_parameter_clause_opt x_type_inheritance_clause_opt x_generic_where_clause_opt class_body
    ;
x_final_opt
	: 
	| FINAL
    ;

// class-name → identifier (collapsed)

// class-body → { class-members opt }
class_body
	: L_SQR_PAR x_class_members_opt R_SQR_PAR
    ;

// class-members → class-member class-members opt
class_members
	: class_member x_class_members_opt
    ;
x_class_members_opt
	:
	| class_members
    ;

// class-member → declaration | compiler-control-statement
class_member
	: declaration
	| compiler_control_statement
    ;


// GRAMMAR OF A PROTOCOL DECLARATION

// protocol-declaration → attributes opt access-level-modifier opt protocol protocol-name type-inheritance-clause opt generic-where-clause opt protocol-body
protocol_declaration
	: x_attributes_opt x_access_level_modifier_opt PROTOCOL IDENTIFIER x_type_inheritance_clause_opt x_generic_where_clause_opt protocol_body
    ;

// protocol-name → identifier (collapsed)

// protocol-body → { protocol-members opt }
protocol_body
	: L_SQR_PAR x_protocol_members_opt R_SQR_PAR
    ;

// protocol-members → protocol-member protocol-members opt
protocol_members
	: protocol_member x_protocol_members_opt
    ;
x_protocol_members_opt
	:
	| protocol_members
    ;

// protocol-member → protocol-member-declaration | compiler-control-statement
protocol_member
	: protocol_member_declaration
	| compiler_control_statement
    ;

// protocol-member-declaration → protocol-property-declaration
// protocol-member-declaration → protocol-method-declaration
// protocol-member-declaration → protocol-initializer-declaration
// protocol-member-declaration → protocol-subscript-declaration
// protocol-member-declaration → protocol-associated-type-declaration
// protocol-member-declaration → typealias-declaration
protocol_member_declaration
	: protocol_property_declaration
	| protocol_method_declaration
	| protocol_initializer_declaration
	| protocol_subscript_declaration
	| protocol_associated_type_declaration
	| typealias_declaration
    ;


// GRAMMAR OF A PROTOCOL PROPERTY DECLARATION

// protocol-property-declaration → variable-declaration-head variable-name type-annotation getter-setter-keyword-block
protocol_property_declaration
	: variable_declaration_head IDENTIFIER type_annotation getter_setter_keyword_block
    ;

// GRAMMAR OF A PROTOCOL METHOD DECLARATION

// protocol-method-declaration → function-head function-name generic-parameter-clause opt function-signature generic-where-clause opt
protocol_method_declaration
	: function_head function_name x_generic_parameter_clause_opt function_signature x_generic_where_clause_opt
    ;


// GRAMMAR OF A PROTOCOL INITIALIZER DECLARATION

// protocol-initializer-declaration → initializer-head generic-parameter-clause opt parameter-clause throwsopt generic-where-clause opt
// protocol-initializer-declaration → initializer-head generic-parameter-clause opt parameter-clause rethrows generic-where-clause opt
protocol_initializer_declaration
	: initializer_head x_generic_parameter_clause_opt parameter_clause x_throws_opt x_generic_where_clause_opt
	| initializer_head x_generic_parameter_clause_opt parameter_clause x_rethrows_opt x_generic_where_clause_opt
    ;


// GRAMMAR OF A PROTOCOL SUBSCRIPT DECLARATION

// protocol-subscript-declaration → subscript-head subscript-result generic-where-clause opt getter-setter-keyword-block
protocol_subscript_declaration
	: subscript_head subscript_result x_generic_where_clause_opt getter_setter_keyword_block
    ;


// GRAMMAR OF A PROTOCOL ASSOCIATED TYPE DECLARATION

// protocol-associated-type-declaration → attributes opt access-level-modifier opt associatedtype typealias-name type-inheritance-clause opt typealias-assignment opt generic-where-clause opt
protocol_associated_type_declaration
	: x_attributes_opt x_access_level_modifier_opt ASSOCIATED_TYPE IDENTIFIER x_type_inheritance_clause_opt x_typealias_assignment_opt x_generic_where_clause_opt
    ;


// GRAMMAR OF AN INITIALIZER DECLARATION

// initializer-declaration → initializer-head generic-parameter-clause opt parameter-clause throwsopt generic-where-clause opt initializer-body
// initializer-declaration → initializer-head generic-parameter-clause opt parameter-clause rethrows generic-where-clause opt initializer-body
initializer_declaration
	: initializer_head x_generic_argument_clause_opt parameter_clause x_throws_opt x_generic_where_clause_opt code_block
	| initializer_head x_generic_argument_clause_opt parameter_clause RETHROWS x_generic_where_clause_opt code_block
    ;


// initializer-head → attributes opt declaration-modifiers opt init
// initializer-head → attributes opt declaration-modifiers opt init ?
// initializer-head → attributes opt declaration-modifiers opt init !
initializer_head
	: x_attributes_opt x_declaration_modifiers_opt INIT
	| x_attributes_opt x_declaration_modifiers_opt INIT QUESTION
	| x_attributes_opt x_declaration_modifiers_opt INIT EXCLAMATION
    ;

// initializer-body → code-block (collapsed)


// GRAMMAR OF A DEINITIALIZER DECLARATION

// deinitializer-declaration → attributes opt deinit code-block
deinitializer_declaration
	: x_attributes_opt DEINIT code_block
    ;


// GRAMMAR OF AN EXTENSION DECLARATION

// extension-declaration → attributes opt access-level-modifier opt extension type-identifier type-inheritance-clause opt generic-where-clause opt extension-body
extension_declaration
	: x_attributes_opt x_access_level_modifier_opt EXTENSION type_identifier x_type_inheritance_clause_opt x_generic_where_clause_opt extension_body
    ;

// extension-body → { extension-members opt }
extension_body
	: L_SQR_PAR x_extension_members_opt R_SQR_PAR
    ;

// extension-members → extension-member extension-members opt

extension_members
	: extension_member x_extension_members_opt
    ;
x_extension_members_opt
	:
	| extension_members
    ;

// extension-member → declaration | compiler-control-statement
extension_member
	: declaration
	| compiler_control_statement
    ;


// GRAMMAR OF A SUBSCRIPT DECLARATION

// subscript-declaration → subscript-head subscript-result generic-where-clause opt code-block
// subscript-declaration → subscript-head subscript-result generic-where-clause opt getter-setter-block
// subscript-declaration → subscript-head subscript-result generic-where-clause opt getter-setter-keyword-block
subscript_declaration
	: subscript_head subscript_result x_generic_where_clause_opt getter_setter_block
	| subscript_head subscript_result x_generic_where_clause_opt getter_setter_keyword_block
    ;

// subscript-head → attributes opt declaration-modifiers opt subscript generic-parameter-clause opt parameter-clause
subscript_head
	: x_attributes_opt x_declaration_modifiers_opt SUBSCRIPT x_generic_parameter_clause_opt parameter_clause
    ;

// subscript-result → -> attributes opt type
subscript_result
	: x_attributes_opt type
    ;


// GRAMMAR OF AN OPERATOR DECLARATION

// operator-declaration → prefix-operator-declaration | postfix-operator-declaration | infix-operator-declaration
operator_declaration
	: prefix_operator_declaration
	| postfix_operator_declaration
	| infix_operator_declaration
    ;

// prefix-operator-declaration → prefix operator operator
prefix_operator_declaration
	: PREFIX OPERATOR OPERATOR_RULE
    ;

// postfix-operator-declaration → postfix operator operator
postfix_operator_declaration
	: POSTFIX OPERATOR OPERATOR_RULE
    ;

// infix-operator-declaration → infix operator operator infix-operator-group opt
infix_operator_declaration
	: INFIX OPERATOR OPERATOR_RULE x_infix_operator_group_opt
    ;

// infix-operator-group → : precedence-group-name
infix_operator_group
	: COLON IDENTIFIER
    ;
x_infix_operator_group_opt
	:
	| infix_operator_group
    ;


// GRAMMAR OF A PRECEDENCE GROUP DECLARATION

// precedence-group-declaration → precedencegroup precedence-group-name { precedence-group-attributes opt }
precedence_group_declaration
	: PRECEDENCE_GROUP IDENTIFIER L_SQR_PAR x_precedence_group_attributes_opt R_SQR_PAR
    ;

// precedence-group-attributes → precedence-group-attribute precedence-group-attributes opt
precedence_group_attributes
	: precedence_group_attribute x_precedence_group_attributes_opt
    ;
x_precedence_group_attributes_opt
	:
	| precedence_group_attributes
    ;

// precedence-group-attribute → precedence-group-relation
// precedence-group-attribute → precedence-group-assignment
// precedence-group-attribute → precedence-group-associativity
precedence_group_attribute
	: precedence_group_relation
	| precedence_group_assignment
	| precedence_group_associativity
    ;

// precedence-group-relation → higherThan : precedence-group-names
// precedence-group-relation → lowerThan : precedence-group-names
precedence_group_relation
	: HIGHER_THAN COLON precedence_group_names
	| LOWER_THAN COLON precedence_group_names
    ;

// precedence-group-assignment → assignment : boolean-literal
precedence_group_assignment
	: ASSIGNMENT COLON BOOLEAN_LITERAL
    ;

// precedence-group-associativity → associativity : left
// precedence-group-associativity → associativity : right
// precedence-group-associativity → associativity : none
precedence_group_associativity
	: ASSOCIATIVITY COLON LEFT
	| ASSOCIATIVITY COLON RIGHT
	| ASSOCIATIVITY COLON NONE
    ;

// precedence-group-names → precedence-group-name | precedence-group-name , precedence-group-names
precedence_group_names
	: IDENTIFIER
	| IDENTIFIER COMMA precedence_group_names
    ;

// precedence-group-name → identifier (collapsed)

// GRAMMAR OF A DECLARATION MODIFIER

// declaration-modifier → class | convenience | dynamic | final | infix | lazy | optional | override | postfix | prefix | required | static | unowned | unowned ( safe ) | unowned ( unsafe ) | weak
// declaration-modifier → access-level-modifier
// declaration-modifier → mutation-modifier
declaration_modifier
	: CLASS 
	| CONVENIENCE
	| DYNAMIC
	| FINAL
	| INFIX
	| LAZY
	| OPTIONAL
	| OVERRIDE
	| POSTFIX
	| PREFIX
	| REQUIRED
	| STATIC
	| UNOWNED
	| UNOWNED_SAFE
	| UNOWNED_UNSAFE
	| WEAK
	| access_level_modifier
	| mutation_modifier
    ;

// declaration-modifiers → declaration-modifier declaration-modifiers opt
declaration_modifiers
	: declaration_modifier x_declaration_modifiers_opt
    ;
x_declaration_modifiers_opt
	:
	| declaration_modifiers
    ;

// access-level-modifier → private | private ( set )
// access-level-modifier → fileprivate | fileprivate ( set )
// access-level-modifier → internal | internal ( set )
// access-level-modifier → public | public ( set )
// access-level-modifier → open | open ( set )
access_level_modifier
	: PRIVATE // Potentially shift/reduce
	| PRIVATE L_PAR SET R_PAR
	| FILE_PRIVATE
	| FILE_PRIVATE L_PAR SET R_PAR
	| INTERNAL
	| INTERNAL L_PAR SET R_PAR
	| PUBLIC
	| PUBLIC L_PAR SET R_PAR
	| OPEN
	| OPEN L_PAR SET R_PAR
    ;
x_access_level_modifier_opt
	: access_level_modifier
    ;

// mutation-modifier → mutating | nonmutating
mutation_modifier
	: MUTATING
	| NONMUTATING
    ;
x_mutation_modifier_opt
	:
	| mutation_modifier
    ;


// GRAMMAR OF AN ATTRIBUTE

// attribute → @ attribute-name attribute-argument-clause opt
attribute
	: AT IDENTIFIER x_attribute_argument_clause_opt
    ;

// attribute-name → identifier (collapsed)


// attribute-argument-clause → ( balanced-tokens opt )
attribute_argument_clause
	: L_PAR x_balanced_tokens_opt R_PAR
    ;
x_attribute_argument_clause_opt
	: 
	| attribute_argument_clause
    ;

// attributes → attribute attributes opt
attributes
	: attribute
	| attributes attribute
    ;
x_attributes_opt
	:
	| attributes
    ;

// balanced-tokens → balanced-token balanced-tokens opt
balanced_tokens
	: balanced_token x_balanced_tokens_opt
    ;
x_balanced_tokens_opt
	:
	| balanced_tokens
    ;

// balanced-token → ( balanced-tokens opt )
// balanced-token → [ balanced-tokens opt ]
// balanced-token → { balanced-tokens opt }
// balanced-token → Any identifier, keyword, literal, or operator
// balanced-token → Any punctuation except (, ), [, ], {, or }
balanced_token
	: L_PAR x_balanced_tokens_opt R_PAR
	| L_SQR_PAR x_balanced_tokens_opt R_SQR_PAR
	| L_CURL_PAR x_balanced_tokens_opt R_CURL_PAR
	| IDENTIFIER
	| keyword
	| LITERAL
	| NO_BRACKET_PUNCTUATION
    ;


// GRAMMAR OF A PATTERN

// pattern → wildcard-pattern type-annotation opt
// pattern → identifier-pattern type-annotation opt
// pattern → value-binding-pattern
// pattern → tuple-pattern type-annotation opt
// pattern → enum-case-pattern
// pattern → optional-pattern
// pattern → type-casting-pattern
// pattern → expression-pattern
pattern
	: UNDERSCORE x_type_annotation_opt
	| IDENTIFIER x_type_annotation_opt
	| value_binding_pattern
	| tuple_pattern x_type_annotation_opt
	| enum_case_pattern
	| optional_pattern
	| type_casting_pattern
	| expression
    ;
x_pattern_opt
	:
	| pattern
    ;


// GRAMMAR OF A WILDCARD PATTERN

// wildcard-pattern → _ (collapsed)


// GRAMMAR OF AN IDENTIFIER PATTERN

// identifier-pattern → identifier (collapsed)


// GRAMMAR OF A VALUE-BINDING PATTERN

// value-binding-pattern → var pattern | let pattern
value_binding_pattern
	: VAR pattern
	| LET pattern
    ;


// GRAMMAR OF A TUPLE PATTERN

// tuple-pattern → ( tuple-pattern-element-list opt )
tuple_pattern
	: L_PAR x_tuple_pattern_element_list_opt R_PAR
    ;
x_tuple_pattern_opt
	:
	| tuple_pattern
    ;

// tuple-pattern-element-list → tuple-pattern-element | tuple-pattern-element , tuple-pattern-element-list
tuple_pattern_element_list
	: tuple_pattern_element
	| tuple_pattern_element COMMA tuple_pattern_element_list
    ;
x_tuple_pattern_element_list_opt
	:
	| tuple_pattern_element_list
    ;

// tuple-pattern-element → pattern | identifier : pattern
tuple_pattern_element
	: pattern
	| IDENTIFIER COLON pattern
    ;


// GRAMMAR OF AN ENUMERATION CASE PATTERN

// enum-case-pattern → type-identifier opt . enum-case-name tuple-pattern opt
enum_case_pattern
	: x_type_identifier_opt COMMA IDENTIFIER x_tuple_pattern_opt
    ;


// GRAMMAR OF AN OPTIONAL PATTERN

// optional-pattern → identifier-pattern ?
optional_pattern
	: IDENTIFIER EXCLAMATION
    ;


// GRAMMAR OF A TYPE CASTING PATTERN

// type-casting-pattern → is-pattern | as-pattern
type_casting_pattern
	: is_pattern
	| as_pattern
    ;

// is-pattern → is type
is_pattern
	: IS type
    ;

// as-pattern → pattern as type
as_pattern
	: pattern AS type
    ;


// GRAMMAR OF AN EXPRESSION PATTERN

// expression-pattern → expression (collapsed)


// GRAMMAR OF A GENERIC PARAMETER CLAUSE

// generic-parameter-clause → < generic-parameter-list >
generic_parameter_clause
	: LESS_THAN generic_parameter_list GREATER_THAN
    ;
x_generic_parameter_clause_opt
	:
	| generic_parameter_clause
    ;

// generic-parameter-list → generic-parameter | generic-parameter , generic-parameter-list
generic_parameter_list
	: generic_parameter
	| generic_parameter COMMA generic_parameter_list
    ;

// generic-parameter → type-name
// generic-parameter → type-name : type-identifier
// generic-parameter → type-name : protocol-composition-type
generic_parameter
	: IDENTIFIER
	| IDENTIFIER COLON type_identifier
	| IDENTIFIER COLON protocol_composition_type
    ;

// generic-where-clause → where requirement-list
generic_where_clause
	: WHERE requirement_list
    ;
x_generic_where_clause_opt
	:
	| generic_where_clause
    ;

// requirement-list → requirement | requirement , requirement-list
requirement_list
	: requirement | requirement COMMA requirement_list
    ;

// requirement → conformance-requirement | same-type-requirement
requirement
	: conformance_requirement
	| same_type_requirement
    ;

// conformance-requirement → type-identifier : type-identifier
// conformance-requirement → type-identifier : protocol-composition-type
conformance_requirement
	: type_identifier COLON type_identifier
	| type_identifier COLON protocol_composition_type
    ;

// same-type-requirement → type-identifier == type
same_type_requirement
	: type_identifier DOUBLE_EQUAL type
    ;


// GRAMMAR OF A GENERIC ARGUMENT CLAUSE

// generic-argument-clause → < generic-argument-list >
generic_argument_clause
	: LESS_THAN generic_argument_list GREATER_THAN
    ;
x_generic_argument_clause_opt
	:
	| generic_argument_clause
    ;

// generic-argument-list → generic-argument | generic-argument , generic-argument-list
generic_argument_list
	: type
	| generic_argument_list COMMA type
    ;

// generic-argument → type (collapsed)

%%