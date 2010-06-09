runtime! ftdetect/*.vim
augroup filetypedetect
  au BufNewFile,BufRead *.mustache	      setf mustache

  au BufNewFile,BufRead nginx/*.conf      setf nginx
  
  au BufNewFile,BufRead Capfile,Gemfile,config.ru         setf ruby
augroup END

let g:surround_45 = "<% \r %>"
let g:surround_61 = "<%= \r %>"
