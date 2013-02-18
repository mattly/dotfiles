" Head
" =============================================================================
  set nocompatible                      " why is this not the default?
  filetype off

" Packages
" =============================================================================
  set rtp+=~/.vim/bundle/vundle
  call vundle#rc()

  Bundle 'gmarik/vundle'

  Bundle 'tpope/vim-endwise'
  Bundle 'tpope/vim-git'
  Bundle 'tpope/vim-fugitive'
  Bundle 'tpope/vim-repeat'
  Bundle 'tpope/vim-surround'
  Bundle 'tpope/vim-unimpaired'
  Bundle 'tpope/vim-abolish'
  Bundle 'tpope/vim-eunuch'
  Bundle 'tpope/vim-commentary'

  Bundle 'ervandew/supertab'
  Bundle 'michaeljsmith/vim-indent-object'
  Bundle 'Townk/vim-autoclose'
  Bundle 'scrooloose/syntastic'

  Bundle 'chriskempson/base16-vim'

  " css
  Bundle 'wavded/vim-stylus'
  Bundle 'groenewege/vim-less'
  " html
  Bundle 'tpope/vim-ragtag'
  Bundle 'digitaltoad/vim-jade'
  Bundle 'juvenn/mustache'
  Bundle 'tpope/vim-markdown'
  " Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
  " javascript
  Bundle "pangloss/vim-javascript"
  Bundle 'kchmck/vim-coffee-script'
  " ruby
  Bundle 'tpope/vim-rake'

" General
" =============================================================================
  filetype plugin indent on
  set fileformats=unix,dos,mac          " line endings are still a thing?
  set modelines=0                       " avoid spell files vulnerability
  set autoread                          " auto-reload files from local changes
  set shell=/bin/sh                     " so that our ENV is available to vim
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
    set background=dark

    " a: visual-mode autoselect (takes over the OS selection process)
    set guioptions+=a
    " A: autoselect for modeless selection
    set guioptions+=A
    " c: use console dialogs for simple choices
    set guioptions+=c
    " g: grey-out non-active menu items
    set guioptions+=g
    " m: show system menu bars
    set guioptions+=m
    " t: include tear-off menu items
    set guioptions+=t

    " e: don't use gui tabs, they change the height of the window
    set guioptions-=e
    " T: system toolbar
    set guioptions-=T
    " r: right-hand scrollbar
    set guioptions-=r
    " l: left-hand scrollbar
    set guioptions-=l
    " L: left-hand scrollbar when vertically-split window
    set guioptions-=L

    set fuoptions=maxvert,maxhorz
  else
    set t_Co=256
    " set background=light
    " bar cursor in insert mode, block cursor in normal node
    if exists('$TMUX')
      let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
      let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
      let &t_SI = "\<Esc>]50;CursorShape=1\x7"
      let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
  endif

  set fillchars=vert:\ 

  colors base16-monokai
  hi Folded ctermbg=233
  hi Normal ctermbg=none
  hi StatusLine cterm=none ctermbg=233 ctermfg=39
  hi StatusLineNC cterm=none ctermbg=233 ctermfg=237
  hi VertSplit cterm=none ctermbg=233
  hi Visual cterm=none ctermbg=238 ctermfg=246
  hi ColorColumn cterm=none ctermbg=238 ctermfg=246
  hi Search cterm=none ctermbg=220 ctermfg=238
  hi TabLine cterm=none ctermbg=238 ctermfg=246
  hi TabLineSel cterm=none ctermbg=234 ctermfg=220
  hi TabLineFill ctermbg=238 ctermfg=246

" Backups (or lack thereof)
" =============================================================================
  set nobackup                          " do not keep backups after close
  set nowritebackup                     " do not keep backups while working
  set noswapfile                        " don't keep swap files either

" UI
" =============================================================================
  set ruler                             " show the cursor position
  set showcmd                           " show incomplete commands
  set lazyredraw                        " speeds up certain macros and such
  set nonumber                          " hide line numbers by default
  set wildmenu                          " wildmenu is awesome
  set wildmode=list:longest,full
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
  set shortmess=filtIoOA
  set report=0                          " always notify us about changes
  set nostartofline                     " don't jump to line start on scroll
  set ttyfast                           " we're local 99% of the time
  set scrolloff=5                       " minimum lines to show around cursor
  set sidescrolloff=5                   " min characters to show sideways
  " set cursorline                        " highlight the current cursor line
  " set colorcolumn=+1,+2,+3,+4,+5        " highlight at 1 past textwidth
  set laststatus=2                      " always show the status line
  set noerrorbells                      " shut up already
  set visualbell                        " SHUT UP ALREADY

" Keyboarding
" =============================================================================
  set backspace=indent,eol,start        " backspace over anything
  set esckeys                           " we like our arrow keys?
  set ttimeoutlen=10                    " but we also hate timeouts on <Esc>

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
  set textwidth=85                      " wrap at 80 characters

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
  "   gd  - write, git diff HEAD
  "   gs  - git status
  "   gw  - write, git add
  "   k   fix syntax highlighting
  "   n   line number toggling
  "   p   paste from system clipboard
  "   r   regen ctags
  "   sa  - add word to dictionary
  "   sn  - next misspelling
  "   sp  - previous misspelling
  "   ss  - toggle spelling
  "   s?  - spelling suggestions
  "   tp  - toggle paste mode
  "   y   yank to system clipboard, follow with normal yank operations
  "   Y   yank to system clipboard, current line
  "   ,   turn off search highlighting

  " I always hit this when I mean I, O or J
  nnoremap K <Nop>

  " repeat moves the cursor back to where it was
  nnoremap . .`[

  " keep selections when indenting in visual mode
  vnoremap > >gv
  vnoremap < <gv

  " record a quick macro in the Q slot, play back with qq
  nnoremap Q @q

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

  " autoclose pairs
  let g:AutoClosePairs_add = "'"
  let g:AutoCloseProtectedRegions = ["Comment", "String", "Character"]


  " fix syntax highlighting
  nnoremap <leader>k :syntax sync fromstart<cr>

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
  set spelllang=en_us                   " When you need it, you need it.
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
  au BufRead,BufNewFile Capfile,Gemfile,Isolate,Rakefile  setf ruby
  au BufRead,BufNewFile *vimrc                            setf vim

  " use cursorcolumn in whitespace-sensitive file formats
  " au Filetype coffee,python,haml,sass,slim set cursorcolumn

  " The python way... yuk, but I can deal
  au Filetype python set tabstop=4 shiftwidth=4

  autocmd FileType html
        \ let b:AutoClosePairs = AutoClose#DefaultPairsModified("<>", "")

" Splits
" =============================================================================
  set splitbelow                        " open new horiz splits below current
  set splitright                        " open new vert splits to the right

  nnoremap <C-j>        <C-w><Down>
  nnoremap <C-k>        <C-w><Up>
  nnoremap <C-h>        <C-w><Left>
  nnoremap <C-l>        <C-w><Right>

" File Navigation
" =============================================================================
  let g:netrw_liststyle=4

  " change directory to that of current file
  nmap <Leader>cd :cd%:p:h<cr>

  " ctags-related
  set tags+=../tags,../../tags,../../../tags,../../../../tags,tmp/tags
  map <silent> <Leader>r :!/usr/local/bin/ctags -f tags -R *<CR><CR>

" Fugitive and GitV
" =============================================================================
  nnoremap <Leader>gs :Gstatus<CR>
  nnoremap <silent> <Leader>gd :w<CR>:Gdiff<CR><CR>
  nnoremap <Leader>gb :Gblame<CR>
  nnoremap <Leader>gw :Gw<CR>

" Utilities
" =============================================================================
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
  nnoremap <Leader>Y "*Y
  vnoremap <Leader>y "*y
  nnoremap <Leader>p "*p
  nnoremap <Leader>P "*P

  nnoremap <Leader>tp :set paste!<CR>

" Mouse
" =============================================================================
  if has("mouse")
    set mouse=a
  endif

" Miscellaneous Plugins
" =============================================================================
  let g:ragtag_global_maps = 1
  let g:syntastic_check_on_open=1
  " prevent autoclose from setting some Esc-leading mappings
  let g:AutoClosePreserveDotReg=0

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

