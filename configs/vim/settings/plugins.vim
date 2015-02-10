" RagTag
let g:ragtag_global_maps = 1

" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_html_checkers = []
" workaround for syntastic/sh.vim, its shebang reader, and fish
autocmd FileType sh let b:shell='bash'

" Javascript
let g:javascript_conceal = 1

" pg-sql
let g:sql_type_default = 'pgsql'

" signify
let g:signify_vcs_list = ['git', 'hg']
let g:signify_disable_by_default = 1

" pencil
let g:pencil#autoformat = 0
let g:pencil#joinspaces = 1
augroup pencil
  autocmd!
  autocmd FileType markdown call pencil#init()
  autocmd FileType text call pencil#init({'wrap': 'hard'})
  autocmd FileType mail call pencil#init({'wrap': 'hard'})
  autocmd FileType gitcommit call pencil#init({'wrap': 'hard', 'autoformat': 1})
augroup END

" lexical
let g:lexical#thesaurus = ['~/.vim/thesaurus/mthesaur.txt',]
let g:lexical#spell_key = '<leader>s'
let g:lexical#thesaurus_key = '<leader>t'
augroup lexical
  autocmd!
  autocmd FileType markdown call lexical#init()
  autocmd FileType text call lexical#init()
  autocmd FileType mail call lexical#init()
  autocmd FileType gitcommit call lexical#init()
augroup END

" incsearch
let g:incsearch#auto_nohlsearch=1

" ultisnips
let g:UltiSnipsExpandTrigger="<C-g>"
let g:UltiSnipsJumpForwardTrigger="<C-g>"
let g:UltiSnipsJumpBackwardTrigger="<C-n>"

" ctrl-p
if executable("ag")
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  let g:ctrlp_use_caching = 0
endif
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
" \ 'link': 'some_bad_symbolic_links',

