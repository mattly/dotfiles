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

" signify
let g:signify_vcs_list = ['git', 'hg']
let g:signify_disable_by_default = 1

" ctrl-p
let g:ctrlp_map = ''
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0

" pencil
let g:pencil#autoformat = 0
let g:pencil#joinspaces = 1
augroup pencil
  autocmd!
  autocmd FileType markdown call pencil#init()
  autocmd FileType text call pencil#init({'wrap': 'hard'})
  autocmd FileType mail call pencil#init({'wrap': 'hard'})
augroup END

" lexical
let g:lexical#thesaurus = ['~/.vim/thesaurus/mthesaur.txt',]
let g:lexical#spell_key = '<leader>s'
let g:lexical#thesaurus_key = '<leader>t'
augroup lexical
  autocmd!
  autocmd FileType markdown call lexical#init()
  autocmd FileType text call lexical#init()
augroup END

" vimroom
let g:vimroom_sidebar_height=1
let g:vimroom_width=74
