let g:goyo_width=85
let g:goyo_margin_top=0
let g:goyo_margin_bottom=0

let g:goyo_settings = {
  \ 'autoindent': "off",
  \ 'cindent': "off",
  \ 'colorcolumn': 0,
  \ 'cursorcolumn': "off",
  \ 'cursorline': "off",
  \ 'formatoptions': "ant",
  \ 'indentexpr': "",
  \ 'linebreak': "on",
  \ 'list': "off",
  \ 'number': "off",
  \ 'showmode': "off",
  \ 'wrap': "on",
  \ }

function! s:goyo_enter()
  " silent !tmux set status off
  let t:revert = {}
  for [k, v] in items(g:goyo_settings)
    execute printf("let t:revert[\"%s\"] = &%s", k, k)
    if v == "on"
      execute printf("setlocal %s", k)
    elseif v == "off"
      execute printf("setlocal no%s", k)
    else
      execute printf("setlocal %s=%s", k, string(v))
    endif
  endfor
  set shortmess+=W
  set spell
  hi NonText guifg=bg
endfunction

function! s:goyo_leave()
  " silent !tmux set status on
  set shortmess-=W
  for [k, v] in items(t:revert)
    execute printf("let %s = %s", k, string(v))
  endfor
  hi clear
endfunction

autocmd! User GoyoEnter
autocmd! User GoyoLeave
autocmd  User GoyoEnter nested call <SID>goyo_enter()
autocmd  User GoyoLeave nested call <SID>goyo_leave()
