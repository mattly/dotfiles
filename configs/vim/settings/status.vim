set laststatus=2                      " always show the status line

function! GitStatus()
  if exists('*fugitive#statusline')
    let branchname = fugitive#statusline()
    let branchname = substitute(branchname, '[\[\]\(\)]', '', 'g')
    let branchname = substitute(branchname, '^Git', '', '')
    if strlen(branchname) > 0
      let git = '±' . branchname
    else
      let git = ''
    end
  else
    let git = ''
  endif
  return git
endfunction

function! SyntaxStatus()
  if exists('*SyntasticStatuslineFlag')
    let toReturn = SyntasticStatuslineFlag()
    let toReturn = substitute(toReturn, '[\[\]]', ' ', 'g')
    if strlen(toReturn) > 0
      return " ".toReturn
    else
      return ''
    endif
  else
    return ''
  endif
endfunction


let stl = ""
let stl .="%n"
let stl .="%M"
let stl .="%R"
let stl .="%W"
let stl .=" "

let stl .= "%<"
let stl .= "%-.60f "

let stl .= "%{&filetype} "

let stl .= "%*"
let stl .= "%-.35{GitStatus()}"

let stl .= "%="
let stl .= "%#StatusWarning#"

let stl .= "%{SyntaxStatus()}"
let stl .= "%*"

let stl .= "%{PencilMode()}"
let stl .= "%l:%c/%L %P"

set statusline=%!stl


