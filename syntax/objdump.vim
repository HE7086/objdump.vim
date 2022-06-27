if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn match objdumpError      /<internal disassembler error>/
syn match objdumpError      /(bad)/

syn match objdumpOffset     /[+-]/
syn match objdumpNumber     /[+-]\?\<\(0x\)\?[[:xdigit:]]\+\>/ contains=objdumpOffset

syn match objdumpRegister   /\<[re]\?[abcd][xhl]\>/
syn match objdumpRegister   /\<[re]\?[sd]il\?\>/
syn match objdumpRegister   /\<[re]\?[sbi]pl\?\>/
syn match objdumpRegister   /\<r[[:digit:]]\+[dwb]\?\>/
syn match objdumpRegister   /\<[cdefgs]s\>/
syn match objdumpRegister   /\<[xyz]mm[[:digit:]]\+\>/
syn match objdumpRegister   /\<[re]\?iz\>/

syn match objdumpAt         /@/
syn match objdumpSection    / \.[[:alpha:]][[:alpha:]_\.-]*:/he=e-1
syn match objdumpSection    /@[[:alnum:]_][[:alnum:]._-]\+/hs=s+1 contains=objdumpAt,objdumpNumber

syn match objdumpLabel      /<[[:alnum:]_.,@\-:<>()+ ]\+>/hs=s+1,he=e-1 contains=objdumpSection,objdumpNumber
syn match objdumpHexDump    /:[[:space:]]\([[:xdigit:]]\{2}[[:space:]]\)\+/hs=s+1

syn region objdumpComment   start="/\*" end="\*/"
syn match  objdumpComment   /[#;!|].*/ contains=objdumpLabel
syn match  objdumpStatement "//.*" contains=cStatement

syn match objdumpSpecial    display contained "\\\(x\x\+\|\o\{1,3}\|.\|$\)"
syn region objdumpString    start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=objdumpSpecial
syn region objdumpString    start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=objdumpSpecial

syn match objdumpFormat     /:[[:space:]]\+file format/
syn match objdumpTitle      /^.\+:[[:space:]]\+file format.*$/ contains=objdumpFormat

syn match objdumpData       /\([XYZ]MM\|[FQD]\)\?WORD/
syn keyword objdumpData     BYTE PTR

" special cases of opcodes that matches hex numbers
syn keyword objdumpOpecode  add adc dec fadd

syn case match

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_objdump_syntax_inits")
  if version < 508
    let did_objdump_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  " Comment
  HiLink objdumpComment     Comment
  " Constant: String, Character, Number, Boolean, Float
  HiLink objdumpNumber      Number
  HiLink objdumpString      String
  " Identifier: Function
  HiLink objdumpHexDump     Identifier
  " Statement: Conditional, Repeat, Label, Operator, Keyword, Exception
  HiLink objdumpStatement   Statement
  HiLink objdumpLabel       Label
  " PreProc: Include, Define, Macro, PreCondit
  HiLink objdumpData        Define
  " Macro
  " Type: StorageClass, Structure, Typedef
  HiLink objdumpRegister    StorageClass
  HiLink objdumpTitle       Typedef
  " Special: SpecialChar, Tag, Delimiter, SpecialComment, Debug
  HiLink objdumpSpecial     SpecialChar
  HiLink objdumpSection     Special
  " Underlined
  " Ignore
  " Error
  HiLink objdumpError       Error
  " Todo

  delcommand HiLink
endif

let b:current_syntax = "objdump"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8 sts=4 sw=2
