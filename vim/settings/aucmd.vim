" =============================================================================
" Auto Commands
" =============================================================================
autocmd QuickfixCmdPost grep copen    " open the quickfix list automatically

" set folding automatically to indent, fuck you, except for diffs
autocmd BufNewFile,BufRead * set foldmethod=indent
autocmd BufNewFile,BufRead *.diff set foldmethod=diff



