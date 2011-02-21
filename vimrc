filetype off
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()

syntax on
filetype on
filetype indent on
filetype plugin on

" Display
set t_Co=256
colorscheme mustang
set background=dark
" colorscheme dawn

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

set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab
set autoindent

set list
" eol:¬
set listchars=tab:»\ ,trail:·,precedes:<,extends:>

set backspace=indent,eol,start     " backspace over anything

set gfn=Menlo:h14
set ttyfast
set scrolloff=3                    " minimum lines to show around cursor
set sidescrolloff=4                " min characters to show
set cursorline

set wildmenu
set wildmode=list:longest,full

nnoremap ; :

" formatting options:
" help fo-table
" t: automatically hard-wrap based on text-width
" c: do the same for comments, but
" r:   autoinsert comment character too
" o: ditto, but for o/O in normal node
" q: allow 'gq' to autowrap/format comments as well as normal text
" 1: Don't break a line before a one-character word
" n: recognize numbered lists
set formatoptions+=tcroq1n
set wrap
set linebreak
set textwidth=79
" set colorcolumn=85
set formatprg="par -qe"

let mapleader = ','

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

" don't use the fucking arrow keys in insert mode
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" disable the fucking help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" --- Ex Mode ------------------------------------------------------------
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>
" option-backspace over words
cnoremap <M-Backspace> <S-Right> <C-W>
cnoremap <M-Right>  <S-Right>
cnoremap <M-Left>   <S-Left>


" --- searching --------------------------------------------------------
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch
" remove the highlight
nnoremap <silent> <Esc> :noh<cr>

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
" make the tab key match bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" toggle between relative line numbers
nnoremap <Leader>n :if &nu <bar> set nonu rnu <bar> else <bar> set nu nornu <bar> endif<CR>

" --- Plugins ---------------------------------------------------------
" --- RagTag ----------------------------------------------------------
let g:ragtag_global_maps = 1

" --- Git / Fugitive --------------------------------------------------
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>gd :w<CR>:Gdiff<CR><CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gw :Gw<CR>

" --- File Navigation -------------------------------------------------
let g:CommandTMatchWindowAtTop=1
nnoremap <Leader>T :CommandTFlush<CR>

nnoremap <Leader>e :e **/
cnoremap <Leader>e **/

" tags
set tags+=../tags,../../tags,../../../tags,../../../../tags,tmp/tags
map <silent> <Leader>r :!/usr/local/bin/ctags -f tags -R *<CR><CR>


" Rails.vim custom nav
autocmd User Rails Rnavcommand -suffix=.rb processor app/processors
autocmd User Rails Rnavcommand -suffix=.rb ernie app/ernie
autocmd User Rails Rnavcommand -suffix=.sass sass app/stylesheets
autocmd User Rails Rnavcommand -suffix=.coffee coffee app/coffeescripts

" --- Indent Guides ---------------------------------------------------
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_color_change_percent=5


" --- Yankring --------------------------------------------------------
nnoremap <silent> <Leader>y :YRShow<CR>

" === Custom Shit =====================================================
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

" --- gui stuff -------------------------------------------------------
if has("gui_running")
  " a: visual-mode autoselect (takes over the OS selection process)
  " e: use the gui's tabs
  " g: grey-out non-active menu items
  " m: show system menu bars
  " t: include tear-off menu items
  set guioptions=aAcegmt
  " T: system toolbar
  " r: right-hand scrollbar
  " l: left-hand scrollbar
  " L: left-hand scrollbar when vertically-split window
  set guioptions-=TrlL

  set fuoptions=maxvert,maxhorz
endif


set statusline=%<%f\ %y%#ErrorMsg#%m%{exists('*SyntasticStatuslineFlag')?SyntasticStatuslineFlag():''}%*%r%{exists('*rails#statusline')?rails#statusline():''}%{exists('*fugitive#statusline')?fugitive#statusline():''}%=%-14.(%l,%c%V%)\ %P

