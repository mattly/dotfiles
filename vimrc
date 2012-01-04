filetype off
source ~/.vim/bundle/vim-pathogen.git/autoload/pathogen.vim
call pathogen#infect()

syntax on
filetype on
filetype indent on
filetype plugin on

set shell=/bin/sh

" Display
set t_Co=256
let g:solarized_contrast="high"
 set background&
colorscheme solarized

set nocompatible     " the past is better left in the past
set modelines=0      " workaround for vulnerability with spell files
set encoding=utf-8 nobomb
set spell spelllang=en_us

set noerrorbells
set visualbell

set showcmd
set ruler
set nu
set autoread
set hidden
set nobackup
set nowb
set noswapfile

set lazyredraw

set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab
set autoindent
set shiftround

set list
set listchars=tab:»\ ,trail:·,precedes:<,extends:>

set backspace=indent,eol,start     " backspace over anything

set ttyfast
set scrolloff=5                    " minimum lines to show around cursor
set sidescrolloff=5                " min characters to show
set cursorline
set colorcolumn=80
highlight OverLength ctermbg=red ctermfg=white
autocmd BufNewFile,BufRead * match OverLength /\%81v.\+/

set wildmenu
set wildmode=list:longest,full

" use per-project .virmc
set exrc
set secure

if has("mouse")
  set mouse=a
endif

nnoremap ; :
" I always hit this when I mean to hit J or I
nnoremap K <nop>

" formatting options:
" help fo-table
" c: do the same for comments, but
" r:   autoinsert comment character too
" o: ditto, but for o/O in normal node
" q: allow 'gq' to autowrap/format comments as well as normal text
" 1: Don't break a line before a one-character word
" n: recognize numbered lists
set formatoptions+=croq1n
set wrap
set linebreak
set textwidth=79
set formatprg="par -qe"

let mapleader = ','

" --- Window Tabs ---------------------------------------------------------
" tab movement, cmd-shift-(move), Command-Shift(h,l), Shift-(j,k)
nnoremap <D-S-right>  :tabnext<CR>
nnoremap <C-S-right>  :tabnext<CR>
nnoremap <D-S-l>      :tabnext<CR>

nnoremap <D-S-left>   :tabprevious<CR>
nnoremap <C-S-left>   :tabprevious<CR>
nnoremap <D-S-h>      :tabprevious<CR>

" --- Vim Windows -------------------------------------------------------------
set laststatus=2 " always show the status line
set splitbelow
set splitright

" Window and buffer movement
" cmd-opt-shift-(move) is similar to iterm
" Ctrl-(move) is easier in iterm
nnoremap <D-M-down>   <C-w><Down>   " window down
nnoremap <C-j>        <C-w><Down>

nnoremap <D-M-up>     <C-w><Up>     " window up
nnoremap <C-k>        <C-w><Up>

nnoremap <D-M-left>   <C-w><Left>   " window left
nnoremap <C-h>        <C-w><Left>

nnoremap <D-M-right>  <C-w><Right>  " window right
nnoremap <C-l>        <C-w><Right>

nnoremap <C-S-up>     :bnext<CR>    " buffer next
nnoremap <C-S-down>   :bprev<CR>    " buffer previous

" --- Insert Mode -------------------------------------------------------------
" option-backspace over words, emacs style
inoremap <M-Backspace> <C-[>ciw
inoremap <C-Backspace> <C-[>ciw

" disable the fucking help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" --- Ex Mode -----------------------------------------------------------------
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>
" option-backspace over words
cnoremap <M-Backspace> <S-Right> <C-W>
cnoremap <C-Backspace> <S-Right> <C-W>

cnoremap <M-Right>  <S-Right>
cnoremap <M-Left>   <S-Left>

" --- searching --------------------------------------------------------
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch
" remove the highlight
nnoremap <silent><Leader>, :noh<cr>

" make search use real regexes
nnoremap / /\v
vnoremap / /\v

set grepprg=ack\ -aH\ --nocolor

" --- spelling ----------------------------------------------------------------
if v:version >= 700
  setlocal spell spelllang=en
  nnoremap <silent><Leader>ss :set spell!<CR>
endif

" --- pasting -----------------------------------------------------------------
nnoremap <silent><Leader>sp :set paste!<CR>
nnoremap <silent><Leader>sl :set list!<CR>

" --- quickfix ----------------------------------------------------------------
autocmd QuickfixCmdPost grep copen

" --- folding -----------------------------------------------------------------
set foldmethod=indent
set foldlevelstart=99
autocmd BufNewFile,BufRead *.haml,*sass,*.scss set foldignore=
autocmd BufNewFile,BufRead * set foldmethod=indent
autocmd BufNewFile,BufRead *.diff set foldmethod=diff

" --- navigation --------------------------------------------------------------
" make the tab key match bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" rails vim shortcut
autocmd User Rails Rnavcommand config config -glob=*.* -suffix= -default=routes.rb

" toggle between relative line numbers
nnoremap <Leader>n :if &nu <bar> set nonu rnu <bar> else <bar> set nu nornu <bar> endif<CR>


" --- File Navigation ---------------------------------------------------------
let g:CommandTMatchWindowAtTop=1
silent! nnoremap <silent> <Leader>t :CommandT<CR>
nnoremap <Leader>T :CommandTFlush<CR>

nnoremap <Leader>e :e %:h/**/
cnoremap <Leader>e :e %:h/**/

let g:netrw_liststyle=4

" tags
set tags+=../tags,../../tags,../../../tags,../../../../tags,tmp/tags
map <silent> <Leader>r :!/usr/local/bin/ctags -f tags -R *<CR><CR>


" --- Text Manipulation
let g:ragtag_global_maps = 1

let g:surround_45 = "<% \r %>"
let g:surround_61 = "<%= \r %>"

" --- Git / Fugitive ----------------------------------------------------------
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>gd :w<CR>:Gdiff<CR><CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gw :Gw<CR>

" --- Visual Column Stuff -----------------------------------------------------
autocmd BufNewFile,BufRead * set nocursorcolumn
autocmd BufNewFile,BufRead *.coffee,*Cakefile set cursorcolumn
autocmd BufNewFile,BufRead *.haml,*.sass,*.scss set cursorcolumn

" --- Language-Specific Settings ----------------------------------------------

autocmd BufNewFile,BufRead *.py set tabstop=4
autocmd BufNewFile,BufRead *.py set shiftwidth=4

" --- Yankring ----------------------------------------------------------------
nnoremap <silent> <Leader>y :YRShow<CR>

" === Custom Shit =============================================================
" DiffOrig() will do a diff with of the buffer vs. its unsaved state.
" This is handy for seeing what you've changed and accepting/reverting
" changes before writing
nnoremap <Leader>d :call DiffOrig()<cr>
function! DiffOrig()
  if &diff
    wincmd p | bdel | diffoff
  else
    vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
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
vnoremap ~ ygv"=TwiddleCase(@")<CR>Pgv


" change directory to that of current file
nmap <Leader>cd :cd%:p:h<cr>

" just sudo it
cmap w!! %!sudo tee > /dev/null %

let html_use_css=1

" --- gui stuff ---------------------------------------------------------------
if has("gui_running")
  set guifont=Menlo:h12

  " a: visual-mode autoselect (takes over the OS selection process)
  " A: autoselect for modeless selection
  " c: use console dialogs for simple choices
  " e: use the gui's tabs -- not using for now, prevent macvim from resizing
  "    window on tabs
  " g: grey-out non-active menu items
  " m: show system menu bars
  " t: include tear-off menu items
  set guioptions=aAcgmt
  " T: system toolbar
  " r: right-hand scrollbar
  " l: left-hand scrollbar
  " L: left-hand scrollbar when vertically-split window
  set guioptions-=TrlL

  set fuoptions=maxvert,maxhorz
else
  " bar cursor in insert mode
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  " block cursor in normal mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"

  " '"' is the sytem clipboard
  inoremap <C-v> "*p
  nnoremap <C-c> "*yy
  vnoremap <C-c> "*y

  " vim 7.3+ makes this use the system clipboard
  " set clipboard=unnamed
endif

" --- statusline --------------------------------------------------------------

function! GitStatus()
  if exists('*fugitive#statusline')
    let branchname = fugitive#statusline()
    " let branchname = substitute(branchname, '[Git(]', '', '')
    " let branchname = substitute(branchname, ')]$', '', '')

    " let branchname = substitute(branchname, '^feature/', 'ƒ ', '')
    " let branchname = substitute(branchname, '^bug/', 'β ', '')
    " let branchname = substitute(branchname, '^hotfix/', 'λ ', '')
    " let branchname = substitute(branchname, '^chore/', 'ς ', '')

    " let maxlen = 30
    " if strlen(branchname) > maxlen
    "   let branchname = strpart(branchname, 0, maxlen)
    "   let branchname .= "…"
    " end
    if strlen(branchname) > 0
      " let git = ' ± ' . branchname . ' '
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
  else
    return ''
  end
endfunction

let rails_statusline = 0

let stl = "%<"

let stl .= "%#DiffChange#"
let stl .= "%-.60f "

let stl .= "%#DiffAdd#"
let stl .= " %{&filetype} "

let stl .= "%*"
let stl .= "%-.35{GitStatus()}"

let stl .= "%="

let stl .= "%#ErrorMsg#"
let stl .= "%{&modified > 0 ? '-dirty-' : ''}"
let stl .= "%{&modified == 1 && &modifiable == 0 ? ' ' : ''}"
let stl .= "%{&modifiable == 0 ? 'readonly' : ''}"

let stl .= "%{SyntaxStatus()}"
let stl .= "%*"

let stl .= " %c:"
let stl .= "%l/%L %P"

set statusline=%!stl

