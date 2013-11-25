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

