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

" pencil
let g:pencil#autoformat = 0
augroup pencil
  autocmd!
  autocmd FileType markdown call pencil#init()
  autocmd FileType text call pencil#init({'wrap': 'hard'})
augroup END

