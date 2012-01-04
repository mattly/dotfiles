runtime! ftdetect/*.vim
augroup filetypedetect
  au BufNewFile,BufRead gitconfig                         setf gitconfig
  au BufNewFile,BufRead *.less                            setf less
  au BufNewFile,BufRead *.mustache                        setf mustache
  au BufNewFile,BufRead nginx/*.conf                      setf nginx
  au BufRead,BufNewFile *.pp                              setf puppet
  au BufNewFile,BufRead Capfile,Gemfile,Isolate,config.ru setf ruby
  au BufNewFile,BufRead *vimrc                            setf vim
augroup END

