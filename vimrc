filetype off
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()

syntax on
filetype on
filetype indent on
filetype plugin on

" Display
set t_Co=256
set background=dark
let g:solarized_contrast="high"
colorscheme solarized
" colorscheme dawn
"
if has('gui_running')
  function! ToggleBackground()
    if (g:solarized_style=="dark")
      set background=light
      let g:solarized_style="light"
    else
      set background=dark
      let g:solarized_style="dark"
    end
    colorscheme solarized
  endfunction
  silent! nnoremap <F5> :call ToggleBackground()<CR>
else
  let g:solarized_termcolors=16
endif


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

set guifont=Menlo:h14
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

nnoremap <C-h>        <C-w><Left>
nnoremap <C-l>        <C-w><Right>
nnoremap <C-j>        <C-w><Up>
nnoremap <C-k>        <C-w><Down>

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

" --- spelling -------------------------------------------------------
if v:version >= 700
  setlocal spell spelllang=en
  nmap <LocalLeader>ss :set spell!<CR>
endif

" --- quickfix --------------------------------------------------------
autocmd QuickfixCmdPost grep copen

" --- folding ---------------------------------------------------------
set foldmethod=indent
set foldlevelstart=99
autocmd BufNewFile,BufRead *.haml,*sass,*.scss set foldignore=/

" --- navigation ------------------------------------------------------
" make the tab key match bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" toggle between relative line numbers
nnoremap <Leader>n :if &nu <bar> set nonu rnu <bar> else <bar> set nu nornu <bar> endif<CR>

" --- Plugins ---------------------------------------------------------
au BufRead,BufNewFile *.pp              set filetype=puppet

" --- RagTag ----------------------------------------------------------
let g:ragtag_global_maps = 1

" --- Git / Fugitive --------------------------------------------------
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>gd :w<CR>:Gdiff<CR><CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gw :Gw<CR>

" --- File Navigation -------------------------------------------------
let g:CommandTMatchWindowAtTop=1
silent! nnoremap <silent> <Leader>t :CommandT<CR>
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
autocmd User Rails Rnavcommand -suffix=.rb lib app/lib

" --- Visual Column Stuff ---------------------------------------------
autocmd BufNewFile,BufRead * set nocursorcolumn
autocmd BufNewFile,BufRead *.coffee,*Cakefile set cursorcolumn
autocmd BufNewFile,BufRead *.haml,*.sass,*.scss set cursorcolumn

let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_color_change_percent=5

" disable IndentGuides for all filetypes except those where indent is
" significant
autocmd BufNewFile,BufRead * :IndentGuidesDisable
autocmd BufNewFile,BufRead *.coffee,*Cakefile :IndentGuidesEnable
autocmd BufNewFile,BufRead *.haml,*.sass,*.scss :IndentGuidesEnable

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

" --- gui stuff -------------------------------------------------------
if has("gui_running")
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
endif


set statusline=%<%f\ %y%q%#ErrorMsg#%m%{exists('*SyntasticStatuslineFlag')?SyntasticStatuslineFlag():''}%*%r%{exists('*rails#statusline')?rails#statusline():''}%{exists('*fugitive#statusline')?fugitive#statusline():''}%=%-14.(%l,%c%V%)\ %P

