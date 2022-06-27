# objdump.vim

syntax highlighting for the output of `objdump`

## Installation
* vim-plug
```
Plug 'HE7086/objdump.vim'
```

* packer.nvim
```
use 'HE7086/objdump.vim'
```

## Example

```shell
# auto detect filetype from stdin
objdump -d -Mintel -C /usr/bin/ls | vim -
```

```shell
# by default use extension .objdump 
objdump -d -C /usr/bin/ls > ls.objdump
vim ls.objdump
```

```shell
# llvm-objdump is also supported
llvm-objdump -d /usr/bin/yes | vim
```

## Note
* while using the demangle function (-C flag) of objdump, some of the label name cannot be correctly highlighted, because they contain language specific typing and is hard to parse.
* support for arm/aarch64 is under development (might take a while)
