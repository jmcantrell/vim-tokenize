" Filename:      tokenize.vim
" Description:   Get a pattern that will split the current line
" Maintainer:    Jeremy Cantrell <jmcantrell@gmail.com>
" Last Modified: Sat 2011-12-17 01:56:50 (-0500)

if exists('g:tokenize_loaded') || &cp
    finish
endif

let g:tokenize_loaded = 1

let s:save_cpo = &cpo
set cpo&vim

function! Tokenize(delim)
    let line = getline('.')
    let pats = []
    for col in split(line, a:delim)
        call add(pats, '\([^'.a:delim.']*\)')
    endfor
    return '^'.join(pats, a:delim).'$'
endfunction

function! TokenizeTab()
    return Tokenize('\t')
endfunction

function! TokenizeComma()
    return Tokenize(',')
endfunction

function! TokenizePrompt()
    return Tokenize(input('Delimiter: '))
endfunction

if !hasmapto('<plug>TokenizeTab', 'n')
    nmap <unique> ,t<tab> <plug>TokenizeTab
endif

if !hasmapto('<plug>TokenizeTab', 'v')
    vmap <unique> ,t<tab> <plug>TokenizeTab
endif

nmap <unique> <script> <plug>TokenizeTab :%s/<c-r>=TokenizeTab()<cr>
vmap <unique> <script> <plug>TokenizeTab :'<,'>s/<c-r>=TokenizeTab()<cr>

if !hasmapto('<plug>TokenizeComma', 'n')
    nmap <unique> ,t, <plug>TokenizeComma
endif

if !hasmapto('<plug>TokenizeComma', 'v')
    vmap <unique> ,t, <plug>TokenizeComma
endif

nmap <unique> <script> <plug>TokenizeComma :%s/<c-r>=TokenizeComma()<cr>
vmap <unique> <script> <plug>TokenizeComma :'<,'>s/<c-r>=TokenizeComma()<cr>

if !hasmapto('<plug>TokenizePrompt', 'n')
    nmap <unique> ,tt <plug>TokenizePrompt
endif

if !hasmapto('<plug>TokenizePrompt', 'v')
    vmap <unique> ,tt <plug>TokenizePrompt
endif

nmap <unique> <script> <plug>TokenizePrompt :%s/<c-r>=TokenizePrompt()<cr>
vmap <unique> <script> <plug>TokenizePrompt :'<,'>s/<c-r>=TokenizePrompt()<cr>

let &cpo = s:save_cpo
