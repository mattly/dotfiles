" intelligently close a window - 
" via https://github.com/skwp/dotfiles/blob/master/vim/settings/yadr-window-killer.vim
function! CloseWindowOrKillBuffer()
  let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

  if number_of_windows_to_this_buffer > 1
    wincmd c
  else
    bdelete
  endif
endfunction

" use ranger as a file chooser
" https://www.reddit.com/r/vim/comments/2va2og/ranger_the_cli_file_manager_xpost_from/
function! RangerChooser()
  let temp = tempname()
  exec 'silent !ranger --choosefiles=' . shellescape(temp)
  if !filereadable(temp)
    redraw!
    " Nothing to read.
    return
  endif
  let names = readfile(temp)
  if empty(names)
    redraw!
    " Nothing to open.
    return
  endif
  " Edit the first item.
  exec 'edit ' . fnameescape(names[0])
  " Add any remaning items to the arg list/buffer list.
  for name in names[1:]
    exec 'argadd ' . fnameescape(name)
  endfor
  redraw!
endfunction

