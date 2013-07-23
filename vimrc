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
" Colors and Theme
" =============================================================================
  set background&
  function! SetColor()
    let g:solarized_termtrans=1
    colors solarized
    hi StatusLine cterm=underline
    hi StatusLineNC cterm=underline
    if &background == "light"
      hi VertSplit ctermbg=7 ctermfg=7
    else
      hi VertSplit ctermbg=8 ctermfg=8
    end
  endfunction
  call SetColor()

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

  " Unite Plugin
    let g:unite_source_history_yank_enable = 1
    let g:unite_winheight = 10
    let g:unite_split_rule = 'botright'
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])

  " RagTag
    let g:ragtag_global_maps = 1

  " Syntastic
    let g:syntastic_check_on_open=1
    let g:syntastic_html_checkers = []

  " Autoclose
    let g:AutoClosePreserveDotReg=0
    let g:AutoClosePairs_add = "'"
    let g:AutoCloseProtectedRegions = ["Comment", "String", "Character"]

  " pg-sql
    let g:sql_type_default = 'pgsql'

  " startify
  let g:startify_show_dir = 1
  let g:startify_bookmarks = [ "~/.vimrc", "~/.gitconfig" ]
  let g:startify_custom_header = [
        \ '                    / |_  / |_[  |                   (_)',
        \ ' _ .--..--.   ,--. `| |-.`| |-.| |   _   __  _   __  __   _ .--..--.',
        \ '[ `.-. .-. | `._\ : | |   | |  | |  [ \ [  ][ \ [  ][  | [ `.-. .-. |',
        \ ' | | | | | | // | |,| |,  | |, | |   \ ./ /_ \ \/ /  | |  | | | | | |',
        \ '[___||__||__]\.-;__/\__/  \__/[___][\_:  /(_) \__/  [___][___||__||__]',
        \ '                                     \__..',
        \ '',
        \ '',
        \ ]

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
    " A: autoselect for modeless selection
    " L: left-hand scrollbar when vertically-split window
    " T: system toolbar
    " a: visual-mode autoselect (takes over the OS selection process)
    " c: use console dialogs for simple choices
    " e: don't use gui tabs, they change the height of the window
    " g: grey-out non-active menu items
    " l: left-hand scrollbar
    " m: show system menu bars
    " r: right-hand scrollbar
    " t: include tear-off menu items
    set guioptions+=ALTaceglmt
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

  set formatoptions=cqn1                " help fo-table
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

" =============================================================================
" Insert Mode Mappings
" =============================================================================
  inoremap <F1> <ESC>
  " C-q: ???
  " C-w: delete word backward
  " C-e: Go to EOL
  inoremap <C-e> <C-o>$
  " C-r: Insert Register
  " C-t: Indent Shiftwidth
  " C-y: Insert char above cursor
  " C-u: Delete to beginning of line
  " C-i: <Tab> (literally, will do tab completion)
  " C-o: execute one normal mode command
  " C-p: invoke "tab completion"
  " C-[: <esc>
  " C-]: ???
  " C-a: Go to beginning of line
  inoremap <C-a> <C-o>0
  " C-s: ???
  " C-d: Unindent Shiftwidth
  " C-f: ???
  " C-g: <tmux leader> ???
  " C-h: (unix) delete backwards
  " C-j: ???
  " C-k: insert control character
  " C-l: insert Control-L
  " C-z: insert Control-Z
  " C-x: ???
  " C-c: Go to Normal Mode
  " C-v: Insert Control/Arrow character
  " C-b: insert Control-B
  " C-n: Autocomplete next
  " C-m: <enter>
  " C-,: <can't map>
  " C-.: <can't map>
  " C-/: Insert C-_
  " C-<space>: insert register

" =============================================================================
" Normal Mode Lower / Upper Mappings
" =============================================================================
  nnoremap <F1> <ESC>
  " !: Filter motion through external program
  " !!: Filter lines through external program
  " @: Play macro
  " @@: Repeat previous macro
  " #: Search backward ------------------------- same as N
  " $: Go to End of Line
  " %: Matching Motion (ie, (), [], etc)
  " ^: Go to Start of Line
  " &: Synonym for :s, repeat last substitute -- never use
  " *: Search Forward -------------------------- same as n
  " (: Move Sentence Backwards ----------------- never use
  " ): Move Sentence Forward ------------------- never use
  " - (orig): Go to Start of Previous Line
  " -: Decrement number
  nnoremap - <c-x>
  " _: Go to Start of This Line ---------------- same as ^
  " =: Indent Accordingly
  " +(orig): Go to Start of Next Line
  " +: Increment number
  nnoremap + <c-a>
  " q: Record macro
  " Q (orig): Switch to "Ex" mode
  " Q: Play back macro in q slot, record it with 'qq'
  nnoremap Q @q
  " w: Move word forward
  " W: Move word forward ----------------------- same as w
  " e: Move to end of word forward
  " E: Move to end of forward word ------------- same as e
  " r: Replace character ----------------------- never use
  " R: Replace mode   -------------------------- never use
  " t: Find till fowards
  " T: Find till backwards
  " y: yank leader
  " Y: Yank line
  " u: Undo
  " U (orig): Undo all changes on last modified line
  " U: Redo
  nnoremap U <C-r>
  " i: Insert Mode
  " I: Insert Mode, Start of Line
  " o: Insert Line Below
  " O: Insert Line Above
  " p: Paste
  " P: Paste Before
  " [: Navigation Backwards Leader ------------- never use
  " {: Beginning of Paragraph ------------------ never use
  " ]: Navigation Forwards Leader -------------- never use
  " }: End of Paragraph ------------------------ never use
  " \: Vim-commentary Leader
  " a: insert after character
  " A: insert at end of line
  " s: replace character ----------------------- never use
  " S: Replace line ---------------------------- never use
  " d: Delete leader
  " D: Delete till end of line
  " f: Find fowards
  " F: Find backwards
  " g: Goto leader
  " G: Goto EOF
  " h: Go one character left ------------------- never use ?
  " H: Goto top of window ---------------------- never use
  " j: Go one line down
  " J: Join lines
  " k: Go one line up
  " K (orig): Lookup word under cursor with keywordprg
  " K: I always hit this when I mean I, O or J
  nnoremap K <Nop>
  " l: Go one character right ------------------ never use ?
  " L: Goto bottom of window ------------------- never use
  " ;: Command Mode
  nnoremap ; :
  " :: Goto Command Mode
  " ': Go to Mark
  " ": Register Leader
  " z: fold leader
  " ZZ: write and quit (:x) -------------------- never use
  " ZQ: quit without writing (:q!) ------------- never use
  " x: Delete one character
  " X: Delete Character backwards -------------- never use
  " c: Change text
  " C: Change rest of line
  " v: Visual mode
  " V: Visual line mode
  " b: Move word backward
  " B: Move word backward ---------------------- same as b
  " n: Find next occurence
  " N: Find next occurence backward
  " m: Set Mark
  " M: Move cursor to mid-screen --------------- never use
  " ,: Leader
  " <: Indent Left
  " .: Repeat (and move cursor back to start)
  nnoremap . .`[
  " >: Indent Right
  " /: Search (and use real regexes)
  nnoremap / /\v
  " ?: Search Backwards

" =============================================================================
" Normal Mode Control Mappings
" =============================================================================

  " C-q: <intercepted by terminal ?>
  " C-w: Window leader
  " C-e: goto EOL
  nnoremap <C-e> $
  " C-r: Redo
  " C-t: Go Backwards in the Tag Stack
  " C-t*: Tab operation leader
  " C-y: Scroll window one line up ------------- never use
  " C-u: Scroll half screen up
  " C-i: Go forward in Jump List
  " C-o: Go back in the Jump List
  " C-p: Previous Cursor (or, go up one line?)
  " C-[: <esc>
  " C-]: Go foward in the Tag Stack
  " C-a: Go to beginning of Line
  nnoremap <C-a> 0
  " C-s: ??? -----------------------------------
  " C-d: Scroll half screen down
  " C-f: Scroll full screen down
  " C-g: <tmux leader>, vim: Prints current file name
  " C-h: Go split left
  nnoremap <C-h>        <C-w><Left>
  " C-j: Go split down
  nnoremap <C-j>        <C-w><Down>
  " C-k: Go split up
  nnoremap <C-k>        <C-w><Up>
  " C-l: Go split right
  nnoremap <C-l>        <C-w><Right>
  " C-:: <can't map>
  " C-': <can't map>
  " C-z: <unix> Suspend process
  " C-x: ??? ------------------------------------
  " C-c: Cycle through Splits
  nnoremap <c-c> <c-w>w
  " C-v: ??? ------------------------------------
  " C-b: Scroll full screen backward
  " C-n: ??? ------------------------------------
  " C-m: <Enter>
  " C-,: <can't map>
  " C-.: <can't map>
  " C-/: ??? ------------------------------------

" =============================================================================
" Normal Mode Leader Mappings
" =============================================================================
  let mapleader = ','                   " backslash doesn't make sense to me.
  " leader mappings:
  "   bd  - background dark
  nnoremap <Leader>bd :set background=dark<CR>tc :call SetColor()<CR>
  "   bl  - background light
  nnoremap <Leader>bl :set background=light<CR>tc :call SetColor()<CR>
  "   cd  change directory to that of current file
  nnoremap <Leader>cd :cd%:p:h<cr>
  "   d   diff current buffer with written file
  "
  " - g - Git
  "   gb  - git blame
  nnoremap <Leader>gb :Gblame<CR>
  "   gd  - write, git diff HEAD
  nnoremap <silent> <Leader>gd :w<CR>:Gdiff<CR><CR>
  "   gs  - git status
  nnoremap <Leader>gs :Gstatus<CR>
  "   gw  - write, git add
  nnoremap <Leader>gw :Gw<CR>
  "
  "   k   fix syntax highlighting
  nnoremap <leader>k :syntax sync fromstart<cr>
  "   n   line number toggling
  nnoremap <Leader>n :call LineNumbers()<CR>
  "   p   paste from system clipboard
  "   P   paste from system clipboard
  nnoremap <Leader>p "*p
  nnoremap <Leader>P "*P
  "   r   regen ctags
  nnoremap <silent> <Leader>r :!/usr/local/bin/ctags -f tags -R *<CR><CR>
  "
  " - s - Spelling
  "   sa  - add word to dictionary
  "   sn  - next misspelling
  "   sp  - previous misspelling
  "   ss  - toggle spelling
  "   s?  - spelling suggestions
  nnoremap <Leader>ss :setlocal spell!<CR>
  nnoremap <Leader>sn ]s
  nnoremap <Leader>sp ]p
  nnoremap <Leader>sa zg
  nnoremap <Leader>s? z=
  "
  "   tp  - toggle paste mode
  nnoremap <Leader>tp :set paste!<CR>
  "
  " - u - Unite
  "   uf  open unite in recursive file search mode
  nnoremap <Leader>uf :<C-u>Unite -start-insert file_rec/async:!<CR>
  "   uF  open unite in MRU file mode
  nnoremap <Leader>uF :<C-u>Unite file_mru/async:!<CR>
  "   uh  open unite in help mode
  nnoremap <Leader>uh :<C-u>Unite -start-insert help<CR>
  "   uo  open unite in outline mode
  nnoremap <Leader>uo :<C-u>Unite outline<CR>
  "   uy   open unite in yank history
  nnoremap <Leader>uy :<C-u>Unite -quick-match history/yank<CR>
  "
  "   y   yank to system clipboard, follow with normal yank operations
  "   Y   yank to system clipboard, current line
  nnoremap <Leader>y "*y
  nnoremap <Leader>Y "*Y
  "   ,   turn off search highlighting
  nnoremap <silent><Leader>, :noh<cr>

" =============================================================================
" Visual Mode Mappings
" =============================================================================
  vnoremap <F1> <ESC>
  " help visual-operators
  " keep selections when indenting in visual mode
  vnoremap > >gv
  vnoremap < <gv
  " make search use real regexes
  vnoremap / /\v
  " call twiddlecase
  vnoremap ~ ygv"=TwiddleCase(@")<CR>Pgv

  " yank to system clipboard
  vnoremap <Leader>y "*y


" =============================================================================
" Command Mode Mappings
" =============================================================================
  cnoremap w!! %!sudo tee > /dev/null %
  cnoremap <C-h> <s-left>
  cnoremap <C-l> <s-right>
  " emacs customs
  cnoremap <C-a> <Home>
  cnoremap <C-e> <End>

" =============================================================================
" Auto Commands
" =============================================================================
  autocmd QuickfixCmdPost grep copen    " open the quickfix list automatically

  " set folding automatically to indent, fuck you, except for diffs
  autocmd BufNewFile,BufRead * set foldmethod=indent
  autocmd BufNewFile,BufRead *.diff set foldmethod=diff

" =============================================================================
" File Formats
" =============================================================================
  au BufRead,BufNewFile Emakefile                         setf erlang
  au BufRead,BufNewFile gitconfig                         setf gitconfig
  au BufRead,BufNewFile *.less                            setf less
  au BufRead,BufNewFile *.md                              setf markdown
  au BufRead,BufNewFile nginx/*.conf                      setf nginx
  au BufRead,BufNewFile *.ru,*.rake                       setf ruby
  au BufRead,BufNewFile Capfile,Gemfile,Isolate,Rakefile  setf ruby
  au BufRead,BufNewFile *vimrc                            setf vim

" =============================================================================
" Utilities
" =============================================================================

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

" =============================================================================
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

