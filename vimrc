set nocompatible
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" =============================================================================
" General
" =============================================================================
  filetype plugin indent on
  syntax on
  set fileformats=unix,dos,mac          " line endings are still a thing?
  set modelines=0                       " avoid spell files vulnerability
  set autoread                          " auto-reload files from local changes
  set shell=/bin/sh                     " so that our ENV is available to vim
  set encoding=utf-8 nobomb             " People still use latin1?
  set exrc                              " use per-project .virmc
  set secure                            " but disallow autocmd, shell and write
  set nobackup                          " do not keep backups after close
  set nowritebackup                     " do not keep backups while working
  set noswapfile                        " don't keep swap files either
  set spelllang=en_us                   " When you need it, you need it.
  set tags+=../tags,../../tags,../../../tags,../../../../tags,tmp/tags


" =============================================================================
" UI
" =============================================================================
  set ruler                             " show the cursor position
  set showcmd                           " show incomplete commands
  set lazyredraw                        " speeds up certain macros and such
  " set nonumber                          " hide line numbers by default
  set shortmess=a                       " abbreviate!
  set report=0                          " always notify us about changes
  set nostartofline                     " don't jump to line start on scroll
  set ttyfast                           " we're local 99% of the time
  set scrolloff=5                       " minimum lines to show around cursor
  set sidescrolloff=5                   " min characters to show sideways
  set colorcolumn=81                    " we like short lines and we cannot lie
  set laststatus=2                      " always show the status line
  " highlight the cursor line for the current window only
  augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
  augroup END

  " Alerts
    set noerrorbells                      " shut up already
    set visualbell                        " SHUT UP ALREADY

  " Splits
    set splitbelow                        " open new horiz splits below current
    set splitright                        " open new vert splits to the right
    set fillchars=vert:\ 
    " for some reason this is making iterm2 very slow: │

  " Keyboarding
    set backspace=indent,eol,start        " backspace over anything
    set esckeys                           " we like our arrow keys?
    set ttimeoutlen=10                    " but we also hate timeouts on <Esc>

  " Folding
    set foldmethod=indent                 " really the only way that makes sense
    set foldlevelstart=99                 " open all folds by default
    set foldignore=                       " don't try to be clever

  " Wildmenu
    set wildmenu                          " wildmenu is awesome
    set wildmode=list:longest,full
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

  " Searching
    " use ack. No, not the vim-ack plugin. Ack. Instead of grep.
    set grepprg=ack
    set hlsearch                          " because awesome
    set ignorecase                        " ignore case in searches
    set smartcase                         " unless there is a capital letter
    set wrapscan                          " searches wrap EOF
    set incsearch                         " show incremental seraches

  " Net-RW
    let g:netrw_liststyle=4

  " Mouse
    if has("mouse")
      set mouse=a
    endif


" =============================================================================
" Terminal
" =============================================================================
  if exists('$ITERM_PROFILE')
    " iterm2 cursor shape for insert mode
    if exists('$TMUX')
      let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
      let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
      let &t_SI = "\<Esc>]50;CursorShape=1\x7"
      let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
  end

" =============================================================================
" GUI options
" =============================================================================
  if has("gui_running")
    set guifont="Source Code Pro":h13
    " a: visual-mode autoselect (takes over the OS selection process)
    " A: autoselect for modeless selection
    " c: use console dialogs for simple choices
    " e: don't use gui tabs, they change the height of the window
    " g: grey-out non-active menu items
    " m: show system menu bars
    set guioptions=aAcegm
    set fuoptions=maxvert,maxhorz
  endif

" =============================================================================
" Text Formatting
" =============================================================================
  set autoindent                        " auto-indent new lines
  set smartindent                       " but not blindly
  set nowrap                            " Text wrapping should be done manually
  set softtabstop=2                     " because fuck you, 8-space tabs
  set shiftwidth=2
  set tabstop=4
  set expandtab                         " turns lead to gold. Er, tabs to spaces
  set smarttab                          " go away, tabs. don't come back
  set shiftround                        " round shifts to multiple of indent
  set textwidth=80                      " wrap at 80 characters

  set cpoptions+=J                      " help cpoptions
                                        " defaults: aABceFs
                                        " a/A: read/write sets window fn
                                        " B: backslash isn't special in mapping
                                        " c: searching continues at the end of
                                        "    the match, not start of it
                                        " e: append <CR> to register execution
                                        " F: write sets fn for buffer
                                        " s: sets buffer options when entering
                                        "    buffer for the first time
                                        " ==========
                                        " J: sentences are two-spaced

  set formatoptions=cqn1                " help fo-table
                                        " defaults: tcq
                                        " t: auto-wrap text using text-width
                                        " c: auto-wrap comments also
                                        " q: auto-format comments with 'gq'
                                        " n: recognize numbered lists
                                        " 1: don't break after 1-char word

  " Whitespace Highlighting
  set list listchars=tab:»\ ,trail:·,precedes:<,extends:>

" =============================================================================
" Auto Commands
" =============================================================================
  autocmd QuickfixCmdPost grep copen    " open the quickfix list automatically

  " set folding automatically to indent, fuck you, except for diffs
  autocmd BufNewFile,BufRead * set foldmethod=indent
  autocmd BufNewFile,BufRead *.diff set foldmethod=diff

  augroup Tmux
    au!
    autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim - ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1] . '"')
    autocmd VimLeave * call system('tmux rename-window ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1])
  augroup end

source ~/.vim/functions.vim
source ~/.vim/theme.vim
source ~/.vim/status.vim
source ~/.vim/mappings.vim
source ~/.vim/plugins.vim
