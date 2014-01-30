set background&
colors pencil

function! ToggleBackground()
  if &background == 'light'
    set background=dark
  else
    set background=light
  end
endfunction

