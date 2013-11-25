
" toggles us between no line numbers, and absolute and relative line numbers
function! LineNumbers()
  if &nu
    set nonu rnu
  elseif &rnu
    set nonu nornu
  else
    set nornu nu
  endif
endfunction

" UPPER CASE -> lower case -> Title Case
" from http://vim.wikia.com/wiki/Switching_case_of_characters
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
