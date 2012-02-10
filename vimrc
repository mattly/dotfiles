" Pathogen
" =============================================================================
  runtime bundle/vim-pathogen.git/autoload/pathogen.vim
  call pathogen#infect()

" General
" =============================================================================
  set nocompatible                      " why is this not the default?
  set fileformats=unix,dos,mac          " line endings are still a thing?
  set modelines=0                       " avoid spell files vulnerability
  set autoread                          " auto-reload files from local changes
  set shell=/bin/sh                     " so that our ENV is available to vim
  filetype plugin indent on
  set encoding=utf-8 nobomb             " People still use latin1?
  set exrc                              " use per-project .virmc
  set secure                            " but disallow autocmd, shell and write

" Colors and Theme
" =============================================================================
  if &t_Co >= 2 || has("gui_running")
    syntax on
    set background&
  endif
  if &t_Co >= 256 || has("gui_running")
    set hlsearch
  endif
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
    set t_Co=256
    " bar cursor in insert mode
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    " block cursor in normal mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif

  let colors='molokai'
  if g:colors == 'molokai'
    let g:molokai_original=1
    colorscheme molokai
    hi Comment        guifg=#aaaa88
    hi FoldColumn     guifg=#aaaa88 guibg=#212118
    hi Folded         guifg=#aaaa88 guibg=#212118 gui=italic
    hi VertSplit      guifg=#212118 guibg=#212118
    hi ColorColumn                  guibg=#851336
    hi OverLength     guifg=#eeeeee guibg=#F92672
  elseif g:colors == 'solarized'
    let g:solarized_contrast="high"
    colorscheme solarized
    hi OverLength     guifg=#586e75 guibg=#073642
    hi OverLength     ctermfg=240   ctermbg=235
  else
    hi OverLength guifg=#ffffff guibg=#ff0000
    hi OverLength ctermbg=red ctermfg=white
  end

" Backups
" =============================================================================
  set nobackup                          " do not keep backups after close
  set nowritebackup                     " do not keep backups while working
  set noswapfile                        " don't keep swap files either

" UI
" =============================================================================
  set ruler                             " show the cursor position
  set showcmd                           " show incomplete commands
  set lazyredraw                        " speeds up certain macros and such
  set number                            " show line numbers
  set wildmenu                          " wildmenu is awesome
  set wildmode=list:longest,full
  set backspace=indent,eol,start        " backspace over anything
  set shortmess=filtIoOA
  set report=0                          " always notify us about changes
  set nostartofline                     " don't jump to line start on scroll
  set ttyfast                           " we're local 99% of the time
  set scrolloff=5                       " minimum lines to show around cursor
  set sidescrolloff=5                   " min characters to show sideways
  set cursorline                        " highlight the current cursor line
  set colorcolumn=+1                    " highlight at 1 past textwidth
  set laststatus=2                      " always show the status line
  set noerrorbells                      " shut up already
  set visualbell                        " SHUT UP ALREADY

" Text Formatting
" =============================================================================
  set autoindent                        " auto-indent new lines
  set smartindent                       " but not blindly
  set nowrap                            " Text wrapping should be done manually
  set softtabstop=2                     " because fuck you, 8-space tabs
  set shiftwidth=2
  set tabstop=4
  set expandtab                         " turns lead to gold. Er, tabs to spaces
  set nosmarttab                        " go away, tabs. don't come back
  set shiftround                        " round shifts to multiple of indent
  set textwidth=80                      " wrap at 80 characters

  set formatoptions+=n1                 " help fo-table
                                        " defaults: tcq
                                        " t: auto-wrap text using text-width
                                        " c: auto-wrap comments also
                                        " q: auto-format comments with 'gq'
                                        " n: recognize numbered lists
                                        " 1: don't break after 1-char word

  set formatprg="par -qe"               " use par for 'gq':
                                        " http://www.nicemice.net/par/par-doc.var
                                        " e: superfluous lines removed
                                        " q: separate quote levels with newlines

  " Whitespace Highlighting
  set list listchars=tab:»\ ,trail:·,precedes:<,extends:>

" Folding
" =============================================================================
  set foldmethod=indent                 " really the only way that makes sense
  set foldlevelstart=99                 " open all folds by default
  set foldignore=                       " don't try to be clever

" Mappings
" =============================================================================
  let mapleader = ','                   " because fuck you
  " leader mappings:
  "   cd  change directory to that of current file
  "   d   diff current buffer with written file
  "   gb  - git blame
  "   gd  - write, diff against HEAD
  "   gs  - git status
  "   gw  - write, add to index
  "   m   open in Marked.app
  "   n   line number toggling
  "   p   paste from system clipboard
  "   r   regen ctags
  "   s   spelling:
  "   sa  - add word to dictionary
  "   sn  - next misspelling
  "   sp  - previous misspelling
  "   ss  - toggle spelling
  "   s?  - suggestions
  "   t   NERDTree
  "   y   yank to system clipboard, follow with normal yank operations
  "   ,   turn off search highlighting
  "   _   PLUGIN: intro to tcomment commands, see 'help tcomment-maps'

  " I always hit this when I mean I, O or J
  nnoremap K <Nop>

  " quick escape out of insert mode
  inoremap jj <Esc>

  " repeat moves the cursor back to where it was
  nnoremap . .`[

  " disable the fucking help
  inoremap <F1> <ESC>
  nnoremap <F1> <ESC>
  vnoremap <F1> <ESC>

  " --- Stealing a few things from emacs
  " nav bindings
  inoremap <C-a> <C-o>0
  cnoremap <C-a> <Home>
  nnoremap <C-a> 0
  inoremap <C-e> <C-o>$
  cnoremap <C-e> <End>
  nnoremap <C-e> $

  " option-backspace over words
  " this does NOT work in terminal vim, only macvim
  inoremap <M-Backspace> <M-[>ciw
  cnoremap <M-Backspace> <S-Right> <C-W>

  cnoremap <M-Right>  <S-Right>
  cnoremap <M-Left>   <S-Left>

  " open this in Marked
  nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>

" Searching
" =============================================================================
  set ignorecase                        " ignore case in searches
  set smartcase                         " unless there is a capital letter
  set wrapscan                          " searches wrap EOF
  set incsearch                         " show incremental seraches
  " remove the highlight with ,,
  nnoremap <silent><Leader>, :noh<cr>

  " make search use real regexes
  nnoremap / /\v
  vnoremap / /\v

  " use ack. No, not the vim-ack plugin. Ack. Instead of grep.
  set grepprg=ack\ -aH\ --nocolor       " --no-color because that fucks us up
                                        " -a: search all types, except ignored
                                        " -H: prints the filename

" Spelling
" =============================================================================
  set spell spelllang=en_us             " When you need it, you need it.
  " toggle spelling
  nnoremap <Leader>ss :setlocal spell!<CR>
  " n: next, p: previous, a: add, ?: suggest
  nnoremap <Leader>sn ]s
  nnoremap <Leader>sp ]p
  nnoremap <Leader>sa zg
  nnoremap <Leader>s? z=

" Auto Commands
" =============================================================================
  autocmd QuickfixCmdPost grep copen    " open the quickfix list automatically

  " set folding automatically to indent, fuck you, except for diffs
  autocmd BufNewFile,BufRead * set foldmethod=indent
  autocmd BufNewFile,BufRead *.diff set foldmethod=diff

" File Formats
" =============================================================================
  au BufRead,BufNewFile gitconfig                         setf gitconfig
  au BufRead,BufNewFile *.less                            setf less
  au BufRead,BufNewFile nginx/*.conf                      setf nginx
  au BufRead,BufNewFile *.ru,*.rake                       setf ruby
  au BufRead,BufNewFile Capfile,GemFile,Isolate,Rakefile  setf ruby
  au BufRead,BufNewFile *vimrc                            setf vim

  " use cursorcolumn in whitespace-sensitive file formats
  au Filetype coffee,python,haml,sass set cursorcolumn

  " The python way... yuk, but I can deal
  au Filetype python set tabstop=4 shiftwidth=4

" Buffers
" =============================================================================
  " switch between recent buffers
  nnoremap <C-S-up>     :bnext<CR>
  nnoremap <C-S-down>   :bprev<CR>

" Splits
" =============================================================================
  set splitbelow                        " open new horiz splits below current
  set splitright                        " open new vert splits to the right

  " in MacVim, this is like switching splits in iTerm
  nnoremap <D-M-down>   <C-w><Down>
  nnoremap <D-M-up>     <C-w><Up>
  nnoremap <D-M-left>   <C-w><Left>
  nnoremap <D-M-right>  <C-w><Right>

  " in iTerm, this feels more natural
  nnoremap <C-j>        <C-w><Down>
  nnoremap <C-k>        <C-w><Up>
  nnoremap <C-h>        <C-w><Left>
  nnoremap <C-l>        <C-w><Right>

" Tabs
" =============================================================================
  nnoremap <D-S-right> :tabnext<CR>
  nnoremap <D-S-left> :tabprevious<CR>

  nnoremap <C-right> :tabnext<CR>
  nnoremap <C-left> :tabprevious<CR>

" File Navigation
" =============================================================================
  let g:netrw_liststyle=4

  " change directory to that of current file
  nmap <Leader>cd :cd%:p:h<cr>

  " ctags-related
  set tags+=../tags,../../tags,../../../tags,../../../../tags,tmp/tags
  map <silent> <Leader>r :!/usr/local/bin/ctags -f tags -R *<CR><CR>

  " for the ctrlp plugin
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

  " for NERDTree
  nnoremap <Leader>t :NERDTree<CR>
  let g:NERDTreeMapJumpNextSibling="S-j"
  let g:NERDTreeMapJumpPrevSibling="S-k"

" Fugitive and Vim
" =============================================================================
  nnoremap <Leader>gs :Gstatus<CR>
  nnoremap <silent> <Leader>gd :w<CR>:Gdiff<CR><CR>
  nnoremap <Leader>gb :Gblame<CR>
  nnoremap <Leader>gw :Gw<CR>

" Utilities
" ==========================================================================================
  " just sudo it
  cnoremap w!! %!sudo tee > /dev/null %

  " toggle line number modes with <leader>n
  nnoremap <Leader>n :call LineNumbers()<CR>
  function! LineNumbers()
    if &nu
      set nonu rnu
    elseif &rnu
      set nonu nornu
    else
      set nornu nu
    endif
  endfunction

  " Highlight parts of lines longer than 85 characters
  " autocmd BufNewFile,BufRead * match OverLength /\%86v.\+/
  let longlines=0
  nnoremap <Leader>8 :call LongLines()<CR>
  function! LongLines()
    if g:longlines==0
      match OverLength /\%82v.\+/
      let g:longlines=1
    else
      match OverLength //
      let g:longlines=0
    endif
  endfunction
  call LongLines()

  " Stoner Coder Bro says:
  "   whoa, i totally changed this file brah! Like, what happened?
  " Now you can help stoner coder bro figure out what he did
  nnoremap <Leader>d :call DiffOrig()<CR>
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

" Pasteboard
" =============================================================================
  " For yanking to / pasting from system clipboard
  " for terminal vim, requires the one included with MacVim
  nnoremap <Leader>y "*y
  vnoremap <Leader>y "*y
  nnoremap <Leader>p "*p

" Mouse
" =============================================================================
  if has("mouse")
    set mouse=a
  endif

" Miscellaneous Plugins
" =============================================================================
  let g:ragtag_global_maps = 1
  let g:syntastic_check_on_open=1

" Sessions
" =============================================================================
  set sessionoptions=buffers,folds,curdir,tabpages
  nnoremap SS :wa<CR>:mksession! ~/.vim/session/
  nnoremap SO :so ~/.vim/session/

" Status Line
" =============================================================================
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

  let rails_statusline = 0

  let stl = "%<"

  " let stl .= "%#DiffAdd#"
  let stl .= "%n "

  " let stl .= "%#DiffChange#"
  let stl .= "%-.60f "

  " let stl .= "%#DiffAdd#"
  let stl .= "%{&filetype} "

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

