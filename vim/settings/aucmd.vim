" =============================================================================
" Auto Commands
" =============================================================================
autocmd QuickfixCmdPost grep copen    " open the quickfix list automatically

" set folding automatically to indent, fuck you, except for diffs
autocmd BufNewFile,BufRead * set foldmethod=indent
autocmd BufNewFile,BufRead *.diff set foldmethod=diff

autocmd FileType markdown call MatchTechWordsToAvoid()


augroup pencil
  autocmd!
  autocmd FileType markdown call pencil#init()
  autocmd FileType text call pencil#init({'wrap': 'hard'})
augroup END

if exists('$TMUX')
  augroup Tmux
    au!
    autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim - ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1] . '"')
    autocmd VimLeave * call system('tmux rename-window ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1])
  augroup end
endif
