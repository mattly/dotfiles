function! GitStatus()
  if exists('*fugitive#statusline')
    let branchname = fugitive#statusline()
    if strlen(branchname) > 0
      let git = ' ± '
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

let stl = "%<"

let stl .= "%-.60f "

let stl .= "%{&filetype} "

let stl .= "%*"
let stl .= "%-.35{GitStatus()}"

let stl .= "%="
let stl .= "%#StatusWarning#"

let stl .= "%{&modified > 0 ? '-dirty-' : ''}"
let stl .= "%{&modified == 1 && &modifiable == 0 ? ' ' : ''}"

let stl .= "%{&modifiable == 0 ? '-readonly-' : ''}"

let stl .= "%{SyntaxStatus()}"
let stl .= "%*"

let stl .= " %c:"
let stl .= "%l/%L %P"

set statusline=%!stl


