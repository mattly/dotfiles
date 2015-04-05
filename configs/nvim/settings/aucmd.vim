" =============================================================================
" Auto Commands
" =============================================================================
autocmd QuickfixCmdPost grep copen    " open the quickfix list automatically

" trigger autoread when idle
autocmd CursorHold,CursorHoldI * checktime

" hide quickfix from the bufferlist
augroup QFix
  autocmd!
  autocmd FileType qf setlocal nobuflisted
augroup end



