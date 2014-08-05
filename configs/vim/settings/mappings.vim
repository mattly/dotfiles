let mapleader = ','                     " backslash doesn't make sense to me.

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
" Visual Mode Mappings
" =============================================================================
  vnoremap <F1> <ESC>
  " help visual-operators
  " keep selections when indenting in visual mode
  xnoremap > >gv
  xnoremap < <gv
  " make search use real regexes
  xnoremap / /\v
  " call twiddlecase
  xnoremap ~ ygv"=TwiddleCase(@")<CR>Pgv

  " Easy Align
  xmap <CR> <Plug>(EasyAlign)

  " yank to system clipboard
  xnoremap <Leader>y "*y

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
  " -: <vinegar> go to directory listing
  " _: (orig) Go to Start of This Line
  " _: Create new split
  nnoremap _ <C-w>s
  " =: Indent Accordingly
  " +: Go to Start of Next Line
  " q: Record macro
  nnoremap q: <nop>
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
  " |: create vertical split
  nnoremap \| <C-w>v
  " a: insert after character
  " A: insert at end of line
  " s: replace character ----------------------- never use
  " S: (orig) Replace line
  " S: Write the current buffer
  nnoremap S :w<CR>
  " d: Delete leader
  " D: Delete till end of line
  " f: Find fowards
  " F: Find backwards
  " g: Goto leader ( :help g )
  " G: Goto EOF
  " h: Go one character left ------------------- never use ?
  " H: Goto top of window ---------------------- never use
  " j: Go one line down
  " J: Join lines
  " k: Go one line up
  " K (orig): Lookup word under cursor with keywordprg
  " K: Grep word under cursor
  nnoremap <silent> K :grep! <cword><CR><CR>
  " l: Go one character right ------------------ never use ?
  " L: Goto bottom of window ------------------- never use
  " ;: Repeat last f, t, F, or T
  " :: Goto Command Mode
  " ': Go to Mark
  " ": Register Leader
  " z: fold leader
  " za: toggle current fold
  " zA: recursively open/close current fold
  " zc: close current fold
  " zC: recursively close current fold
  " zi: switch folding on or off
  " zj: move down to top of next fold
  " zk: move up to bottom of previous fold
  " zm: reduce `foldlevel` by one
  " zM: close all folds
  " zo: open current fold
  " zO: recursively open current fold
  " zr: increase `foldlevel` by one
  " zR: open all folds
  " zv: expand folds to reveal cursor
  " ZZ: write and quit (:x) -------------------- never use
  " ZQ: quit without writing (:q!) ------------- never use
  " x: Delete one character
  " X: (orig) Delete Character backwards
  " X: Close window or buffer intelligently
  nnoremap X :call CloseWindowOrKillBuffer()<CR>
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
  " //: Clear search highlighting
  nnoremap // :nohlsearch<CR>
  " ?: Search Backwards
  " toggle current fold easier
  nnoremap <Space> za
  " Enter: mapped by wildfire
  " Backspace: mapped by wildfire

" =============================================================================
" Normal Mode Control Mappings
" =============================================================================

  " C-q: (used for terminal flow control)
  " C-w*: Window leader   :help CTRL-W
  " C-e: goto EOL
  nnoremap <C-e> $
  " C-r: Redo
  " C-t: Go Backwards in the Tag Stack
  " C-t*: Tab operation leader
  " C-y: Scroll window one line up ------------- never use
  " C-u: Scroll half screen up
  " C-i: Go forward in Jump List
  " C-o: Go back in the Jump List
  " C-p: (orig) Previous Cursor (or, go up one line?)
  " C-p: <Plugin> Invoke Ctrl-p in file mode
  " C-[: <esc>
  " C-]: Go foward in the Tag Stack
  " C-a: Go to beginning of Line
  nnoremap <C-a> 0
  " C-s: Save
  nnoremap <C-s> :w<CR>
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
  " C-x: Quit All
  nnoremap <C-x> :qa<CR>
  " C-c: Cycle through Splits
  nnoremap <c-c> <c-w>w
  " C-v: ??? ------------------------------------
  " C-b: Scroll full screen backward
  " C-n: ??? ------------------------------------
  " C-m: <Enter, cant' map>
  " C-,: <can't map>
  " C-.: <can't map>
  " C-/: ??? ------------------------------------

" =============================================================================
" Normal Mode Leader Mappings
" =============================================================================
  " leader mappings:
  "   a   Toggle Autoformat mode
  " nnoremap <Leader>a
  "   b   CTRL-p Buffer mode
  nnoremap <Leader>b :CtrlPBuffer<CR>
  "   c   Regen ctags
  nnoremap <silent> <Leader>c :!/usr/local/bin/ctags -f tags -R *<CR><CR>
  "   d   open current word in dictionary.app
  nnoremap <silent> <Leader>d :!open dict://<cword><CR><CR>
  "   f   CTRL-p File mode
  nnoremap <Leader>f :CtrlP<CR>

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
  "       haven't needed this in a while
  " nnoremap <leader>k :syntax sync fromstart<cr>
  nnoremap <leader>k :Ag<space>

  "   m   Open in Marked.app
  nnoremap <leader>m :!open -a "Marked 2.app" %<CR><CR>
  "   o   Open this cWORD
  nnoremap <silent><Leader>o :!open -g <cWORD><CR><CR>
  "   p   paste from system clipboard
  "   P   paste from system clipboard
  nnoremap <Leader>p "*p
  nnoremap <Leader>P "*P
  "   r   CTRL-p in MRU file mode
  nnoremap <silent><Leader>r :CtrlPMRU<CR>
  "
  " - s - Spelling
  "   sa  - add word to dictionary
  "   sn  - next misspelling
  "   sp  - previous misspelling
  "   ss  - toggle spelling
  "   s?  - spelling suggestions
  " nnoremap <Leader>ss :setlocal spell!<CR>
  " nnoremap <Leader>sn ]s
  " nnoremap <Leader>sp ]p
  " nnoremap <Leader>sa zg
  " nnoremap <Leader>s? z=
  "   s   Lexical spelling suggestion     defined in plugins.vim
  "   t   Lexical thesaurus suggestion    defined in plugins.vim
  "
  "   S   Source current buffer
  nnoremap <silent><Leader>S :source %<CR>
  "   v   reload Vim config
  nnoremap <silent><Leader>v :so ~/.vimrc<CR>
  "   w   strip trailing whitespace
  nnoremap <leader>w :StripTrailingWhitespaces<CR>

  "   x   next buffer
  nnoremap <silent><Leader>x :bn<CR>
  "   y   yank to system clipboard, follow with normal yank operations
  "   Y   yank to system clipboard, current line
  nnoremap <Leader>y "*y
  nnoremap <Leader>Y "*Y
  "   z   previous buffer
  nnoremap <silent><Leader>z :bp<CR>


" Function Mappings
" =============================================================================
  " these are mostly for toggles
  nnoremap <silent><F1> :call ToggleBackground()<CR>
  nnoremap <silent><F2> :setlocal spell!<CR>
  nnoremap <silent><F3> :VoomToggle pandoc<CR>
  nnoremap <silent><F4> :call WriteMode()<CR>

  nnoremap <silent><F5> :setlocal nu!<CR>:SignifyToggle<CR>
  function! ToggleFoldColumn()
    if &foldcolumn == 0
      set foldcolumn=2
    else
      set foldcolumn=0
    endif
  endfunction
  nnoremap <silent><F6> :call ToggleFoldColumn()<CR>
  nnoremap <silent><F7> :setlocal cursorline!<CR>
  nnoremap <silent><F8> :setlocal cursorcolumn!<CR>

