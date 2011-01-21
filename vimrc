silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()

" Display
colorscheme mustang
set background=dark
" colorscheme dawn

set nocompatible     " the past is better left in the past
set modelines=0      " workaround for vulnerability with spell files
set encoding=utf-8 nobomb
set spell spelllang=en_us

set noerrorbells
set visualbell

set noautochdir

set showcmd
set ruler
set nu
set autoread
set hidden
set nobackup
set nowb
set noswapfile

syntax on
filetype on
filetype indent on
filetype plugin on

set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab
set autoindent

set list
" eol:¬
set listchars=tab:»·,trail:·,precedes:<,extends:>

set backspace=indent,eol,start     " backspace over anything

set gfn=Menlo:h14
set linespace=2                    " don't add any extra pixels between rows
set ttyfast
set scrolloff=3                    " minimum lines to show around cursor
set sidescrolloff=4                " min characters to show
set cursorline

set wildmenu
set wildmode=list:longest,full


" formatting options:
" t: automatically hard-wrap based on text-width
" c: do the same for comments, but
" r:   autoinsert comment character too
" o: ditto, but for o/O in normal node
" q: allow 'gq' to autowrap/format comments as well as normal text
" 2: use the second line of a paragraph to determine proper indentation level
set formatoptions+=tcroq2
set formatprg="par -qe"

let mapleader = ','

" --- sessions -----------------------------------------------------------
set sessionoptions=buffers,folds,curdir,tabpages
nnoremap SS :wa<cr>:mksession! ~/.vim/session/
nnoremap SO :so ~/.vim/session/

" --- Gui Window Tabs ----------------------------------------------------
" tab movement, cmd-shift-(move)
nnoremap <D-S-right>  :tabnext<CR>
nnoremap <D-S-l>      :tabnext<CR>
nnoremap <D-S-left>   :tabprevious<CR>
nnoremap <D-S-h>      :tabprevious<CR>

" --- Vim Windows ---------------------------------------------------------
set laststatus=2 " always show the status line
set splitbelow
set splitright

" Window movement, cmd-opt-shift-(move)
nnoremap <D-M-down>   <C-w><Down>
nnoremap <D-M-j>      <C-w><Down>
nnoremap <D-M-up>     <C-w><Up>
nnoremap <D-M-k>      <C-w><Up>
nnoremap <D-M-left>   <C-w><Left>
nnoremap <D-M-h>      <C-w><Left>
nnoremap <D-M-right>  <C-w><Right>
nnoremap <D-M-l>      <C-w><Right>

" --- Insert Mode --------------------------------------------------------
" option-backspace over words, emacs style
inoremap <M-Backspace> <C-[>ciw

" get out of insert moar easily
inoremap jj <Esc>

" don't use the fucking arrow keys in insert mode
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" disable the fucking help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" --- searching --------------------------------------------------------
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch
nnoremap <silent> <Esc> :call RemoveHighlight()<cr>
function! RemoveHighlight()
  if &hlsearch
    set nohlsearch
  endif
endfunction

" make search use real regexes
nnoremap / /\v
vnoremap / /\v

set grepprg=ack

" --- folding ---------------------------------------------------------
set foldmethod=indent
set foldcolumn=0
set foldnestmax=8
set foldlevel=3

" --- navigation ------------------------------------------------------

" --- Plugins ---------------------------------------------------------
let g:ragtag_global_maps = 1

nnoremap <Leader>g :Gstatus<CR>
nnoremap <Leader>T :CommandTFlush<CR>

" --- dragons ---------------------------------------------------------
" command line mappings for Ex mode, use emacs key bindings, sorry
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

nnoremap <silent> <Leader>r :!ctags --extra=+f -R *<CR><CR>

if has("gui_running")
  " a: visual-mode autoselect (takes over the OS selection process)
  " e: use the gui's tabs
  " g: grey-out non-active menu items
  " m: show system menu bars
  " t: include tear-off menu items
  set guioptions=aegmt
  " T: system toolbar
  " r: right-hand scrollbar
  " l: left-hand scrollbar
  " L: left-hand scrollbar when vertically-split window
  set guioptions-=TrlL

  set fuoptions=maxvert,maxhorz
endif


map <silent> <Leader>r :!ctags --extra=+f -R *<CR>

function! DiffOrig()
  if &diff
    wincmd p | bdel | diffoff
  else
    vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
  endif
endfunction
nnoremap <Leader>d :call DiffOrig()<cr>

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

set statusline=%<%f\ %y%#ErrorMsg#%m%{exists('*SyntasticStatuslineFlag')?SyntasticStatuslineFlag():''}%*%r%{exists('*rails#statusline')?rails#statusline():''}%{exists('*fugitive#statusline')?fugitive#statusline():''}%=%-14.(%l,%c%V%)\ %P

nmap <Leader>x <Plug>ToggleAutoCloseMappings

nnoremap <tab> %
vnoremap <tab> %


