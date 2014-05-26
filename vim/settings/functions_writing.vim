let g:writing = 0
let g:old_wrap=&wrap
function! WriteMode()
  if g:writing == 0
    let g:writing = 1
    " set columns=80
    set shortmess+=W
    let g:old_wrap = &wrap
    set wrap
    set colorcolumn=0
    set noruler
    set linebreak
    set nocursorline
    set nocursorcolumn
    set nolist
    set nonumber
    set noshowmode
    set laststatus=0
    hi NonText guifg=bg
    if has("gui_running")
      let g:transparency = &transparency
      set transparency=0
      let g:vimroom_guibackground=synIDattr(hlID('Normal'), 'bg#')
    endif
    :VimroomToggle
  else
    :VimroomToggle
    let g:writing = 0
    set showmode
    set shortmess-=W
    set wrap=g:old_wrap
    hi clear
    if has("gui_running")
      set transparency=g:transparency
    endif
  endif
endfunction

