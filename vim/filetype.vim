runtime! ftdetect/*.vim
augroup filetypedetect
  au BufNewFile,BufRead *.coffee		      setf coffee
  au BufNewFile,BufRead Cakefile          setf coffee

  au BufNewFile,BufRead *.mustache	      setf mustache

  au BufNewFile,BufRead nginx/*.conf      setf nginx
  
  au BufNewFile,BufRead Capfile           setf ruby
augroup END
