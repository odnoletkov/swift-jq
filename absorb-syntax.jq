#!/usr/bin/env jq -jf

{
  eof: "",
  kw_associatedtype: "associatedtype",
  kw_class: "class",
  kw_deinit: "deinit",
  kw_enum: "enum",
  kw_extension: "extension",
  kw_func: "func",
  kw_import: "import",
  kw_init: "init",
  kw_inout: "inout",
  kw_let: "let",
  kw_operator: "operator",
  kw_precedencegroup: "precedencegroup",
  kw_protocol: "protocol",
  kw_struct: "struct",
  kw_subscript: "subscript",
  kw_typealias: "typealias",
  kw_var: "var",
  kw_fileprivate: "fileprivate",
  kw_internal: "internal",
  kw_private: "private",
  kw_public: "public",
  kw_static: "static",
  kw_defer: "defer",
  kw_if: "if",
  kw_guard: "guard",
  kw_do: "do",
  kw_repeat: "repeat",
  kw_else: "else",
  kw_for: "for",
  kw_in: "in",
  kw_while: "while",
  kw_return: "return",
  kw_break: "break",
  kw_continue: "continue",
  kw_fallthrough: "fallthrough",
  kw_switch: "switch",
  kw_case: "case",
  kw_default: "default",
  kw_where: "where",
  kw_catch: "catch",
  kw_throw: "throw",
  kw_as: "as",
  kw_Any: "Any",
  kw_false: "false",
  kw_is: "is",
  kw_nil: "nil",
  kw_rethrows: "rethrows",
  kw_super: "super",
  kw_self: "self",
  kw_Self: "Self",
  kw_true: "true",
  kw_try: "try",
  kw_throws: "throws",
  kw___FILE__: "__FILE__",
  kw___LINE__: "__LINE__",
  kw___COLUMN__: "__COLUMN__",
  kw___FUNCTION__: "__FUNCTION__",
  kw___DSO_HANDLE__: "__DSO_HANDLE__",
  kw__: "_",
  l_paren: "(",
  r_paren: ")",
  l_brace: "{",
  r_brace: "}",
  l_square: "[",
  r_square: "]",
  l_angle: "<",
  r_angle: ">",
  period: ".",
  period_prefix: ".",
  comma: ",",
  ellipsis: "...",
  colon: ":",
  semi: ";",
  equal: "=",
  at_sign: "@",
  pound: "#",
  amp_prefix: "&",
  arrow: "->",
  backtick: "`",
  backslash: "\\",
  exclaim_postfix: "!",
  question_postfix: "?",
  question_infix: "?",
  string_quote: "\"",
  single_quote: "'",
  multiline_string_quote: "\"\"\"",
  pound_keyPath: "#keyPath",
  pound_line: "#line",
  pound_selector: "#selector",
  pound_file: "#file",
  pound_fileID: "#fileID",
  pound_filePath: "#filePath",
  pound_column: "#column",
  pound_function: "#function",
  pound_dsohandle: "#dsohandle",
  pound_assert: "#assert",
  pound_sourceLocation: "#sourceLocation",
  pound_warning: "#warning",
  pound_error: "#error",
  pound_if: "#if",
  pound_else: "#else",
  pound_elseif: "#elseif",
  pound_endif: "#endif",
  pound_available: "#available",
  pound_fileLiteral: "#fileLiteral",
  pound_imageLiteral: "#imageLiteral",
  pound_colorLiteral: "#colorLiteral",
  integer_literal: null,
  floating_literal: null,
  string_literal: null,
  unknown: null,
  identifier: null,
  oper_binary_unspaced: null,
  oper_binary_spaced: null,
  oper_postfix: null,
  oper_prefix: null,
  dollarident: null,
  contextual_keyword: null,
  raw_string_delimiter: null,
  string_segment: null,
  string_interpolation_anchor: ")",
  kw_yield: "yield"
} as $token_text |

{
  Space: " ",
  Tab: "\t",
# VerticalTab: "\v",
  Formfeed: "\f",
  Newline: "\n",
  CarriageReturn: "\r",
  CarriageReturnLineFeed: "\r\n",
  LineComment: null,
  BlockComment: null,
  DocLineComment: null,
  DocBlockComment: null,
  GarbageText: null,
} as $trivia_text |

def trivia_text:
  (.value | strings) //
  (reduce range(.value - 1) as $_ ([$trivia_text[.kind] // error]; . + .[:1]) | add);

def token_text:
  (.leadingTrivia[] | trivia_text),
  (.tokenKind | .text // $token_text[.kind]),
  (.trailingTrivia[] | trivia_text);

[.. | select(.tokenKind?) | token_text] | add
