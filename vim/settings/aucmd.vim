" =============================================================================
" Auto Commands
" =============================================================================
autocmd QuickfixCmdPost grep copen    " open the quickfix list automatically

" set folding automatically to indent, fuck you, except for diffs
autocmd BufNewFile,BufRead * set foldmethod=indent
autocmd BufNewFile,BufRead *.diff set foldmethod=diff

autocmd FileType markdown call MatchTechWordsToAvoid()


if exists('$TMUX')
  augroup Tmux
    au!
    autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim - ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1] . '"')
    autocmd VimLeave * call system('tmux rename-window ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1])
  augroup end
endif
