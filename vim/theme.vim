set background&
function! SetColor()
  " let g:solarized_termtrans=1
  " colors solarized
  colors base16-tomorrow
  hi StatusLine cterm=underline ctermbg=none
  hi StatusLineNC cterm=underline ctermbg=none
  " hi VertSplit ctermbg=8 ctermfg=8
endfunction
call SetColor()
