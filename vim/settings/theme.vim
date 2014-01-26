set background&
let g:pencil_higher_contrast_ui=1
colors pencil

function! ToggleBackground()
  if &background == 'light'
    set background=dark
  else
    set background=light
  end
endfunction

