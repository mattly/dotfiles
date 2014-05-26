let g:writing = 0

let g:old_wrap=&wrap
function! WriteMode()
  if g:writing == 0
    let t:writing_revert = {
          \ 'wrap': &wrap,
          \ 'colorcolumn': &colorcolumn,
          \ 'cursorline': &cursorline,
          \ 'cursorcolumn': &cursorcolumn,
          \ 'list': &list,
          \ 'number': &number
          \}
    let g:writing = 1
    set shortmess+=W
    set wrap
    set colorcolumn=0
    set linebreak
    set nocursorline
    set nocursorcolumn
    set nolist
    set nonumber
    set noshowmode
    hi NonText guifg=bg
    if has("gui_running")
      let g:transparency = &transparency
      set transparency=0
    endif
    silent !tmux set status off
    :Goyo
  else
    :Goyo
    silent !tmux set status on
    let g:writing = 0
    set showmode
    set shortmess-=W
    for [k,v] in items(t:writing_revert)
      execute printf("let &%s = %s", k, string(v))
    endfor
    hi clear
    if has("gui_running")
      set transparency=g:transparency
    endif
  endif
endfunction

