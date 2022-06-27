function! DetectObjdump()
    let l:line1 = getline(1)
    let l:line2 = getline(2)
    let l:line3 = getline(3)
    let l:line4 = getline(4)
    let l:line5 = getline(5)
    let l:line6 = getline(6)

    if (l:line1 =~# 'In archive .*:'
        \ || l:line1 =~ '')
        \ && (l:line2 =~ ''
        \ || l:line2 =~# '.*:\s*file format .*')
        \ && (l:line4 =~# 'Disassembly of section .*:'
        \ || l:line5 =~# 'Disassembly of section .*:'
        \ || l:line6 =~# 'Disassembly of section .*:')
        setfiletype objdump
    endif
endfunction

augroup filetypedetect
    autocmd BufRead,BufNewFile *.objdump setfiletype objdump
    autocmd BufRead,BufNewFile * call DetectObjdump()
    autocmd StdinReadPost * call DetectObjdump()
augroup END
