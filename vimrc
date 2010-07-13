silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()

set nocompatible " the past is better left in the past

set encoding=utf-8 nobomb

set noautochdir

set sessionoptions=buffers,folds,curdir,tabpages
" Session Management
nnoremap SS :wa<cr>:mksession! ~/.vim/session/
nnoremap SO :so ~/.vim/session/

set noerrorbells
set visualbell

set showcmd
set ruler
set autoread
set hidden
set nobackup
set nowb
set noswapfile

set spell spelllang=en_us

set expandtab shiftwidth=2 tabstop=2 " ruby and javascript
set smarttab
set autoindent

set scrolloff=3		" minimum lines to show around cursor
set sidescrolloff=4	" min characters to show
set linebreak
set wrap
set nolist
set showbreak=>
set whichwrap+=<,>,h,l
" formatting options:
" t: automatically hard-wrap based on text-width
" c: do the same for comments, but
" r:   autoinsert comment character too
" o: ditto, but for o/O in normal node
" q: allow 'gq' to autowrap/format comments as well as normal text
" 2: use the second line of a paragraph to determine proper indentation level
set formatoptions+=tcroq2
set formatprg="par -qe"
set listchars=tab:»·,trail:·,precedes:<,extends:>
set nolist
set cursorline

set laststatus=2
set backspace=indent,eol,start	" backspace over anything

inoremap <M-Backspace> <C-[>ciw

" get out of insert moar easily
inoremap jj <Esc>

set gdefault
set ignorecase
set smartcase
set wrapscan
set incsearch hlsearch
nnoremap <Esc> :call RemoveHighlight()<cr>
function! RemoveHighlight()
  if &hlsearch
    set nohlsearch
  endif
endfunction

" colorscheme mustang
colorscheme dawn

set foldmethod=indent
set foldcolumn=0
set foldnestmax=8
set foldlevel=3

" F2 toggles folding
nnoremap <F2> za
" F1 opens all folding
nnoremap <F1> zR
" F3 closes all folding
nnoremap <F3> zM

" command line mappings for Ex mode, use emacs key bindings, sorry
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

" set our leader:
let mapleader = ','

nnoremap <Leader>a :Ack 

if has("gui_running")
	set gfn=Menlo:h13
	set linespace=1
  " a: visual-mode autoselect (takes over the OS selection process)
  " e: use the gui's tabs
  " g: grey-out non-active menu items
  " m: show system menu bars
  " t: include tear-off menu items
  " T: system toolbar
  " r: right-hand scrollbar
  " l: left-hand scrollbar
  " L: left-hand scrollbar when vertically-split window
  set guioptions=aegmt
  set guioptions-=TrlL

  set fuoptions=maxvert,maxhorz

  " set lines=35 columns=100
endif

set scrolloff=10

set switchbuf=usetab
set splitbelow

set wildmenu
set wildmode=list:longest

function! DiffOrig()
  if &diff
    wincmd p | bdel | diffoff
  else
    vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
  endif
endfunction
nnoremap FD :call DiffOrig()<cr>

syntax on
filetype plugin indent on

nnoremap <C-t> :FufRenewCache<cr>:FufFile**/<cr>
nnoremap <C-q> :FufBuffer<cr>
nnoremap <C-z> :FufDir**/<cr>
nnoremap <C-l> :FufLine<cr>

let g:fuf_keyOpenTabpage='<S-CR>'

" window and tab movement, cmd-shift-(move) for tabs, cmd-option-(move) for
" windows
nnoremap <D-S-right> :tabnext<cr>
nnoremap <D-S-l> :tabnext<cr>
nnoremap <D-S-left> :tabprevious<cr>
nnoremap <D-S-h> :tabprevious<cr>

nnoremap <D-M-down> :wincmd j<cr>
nnoremap <D-M-j> :wincmd j<cr>
nnoremap <D-M-up> :wincmd k<cr>
nnoremap <D-M-k> :wincmd k<cr>
nnoremap <D-M-left> :wincmd h<cr>
nnoremap <D-M-h> :wincmd h<cr>
nnoremap <D-M-right> :wincmd l<cr>
nnoremap <D-M-l> :wincmd l<cr>

" jump to last cursor position when opening a file; don't do it when writing a
" commit log entry

autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if &filetype !~ "commit\c"
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal g`\""
    endif
  end
endfunction

" turn some ragtag stuff on globally
let g:ragtag_global_maps = 1

" NERDTree crap

nnoremap <D-d> :NERDTree<cr>
" let loaded_nerd_tree = 1
let NERDTreeShowHidden = 1

set statusline=%<%f\ %h%m%r%y%=%{exists('*rails#statusline')?rails#statusline():''}%{exists('*fugitive#statusline')?fugitive#statusline():''}%#ErrorMsg#%{exists('*SyntasticStatuslineFlag')?SyntasticStatuslineFlag():''}%-14.(%l,%c%V%)\ %P
