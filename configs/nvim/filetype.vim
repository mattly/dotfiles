augroup filetypedetect
  au! BufRead,BufNewFile *.iced                             setf coffee

  au! BufRead,BufNewFile Emakefile                          setf erlang

  au! BufRead,BufNewFile gitconfig                          setf gitconfig

  au! BufRead,BufNewFile *.es6                              setf javascript

  au! BufRead,BufNewFile *.less                             setf less

  au! BufRead,BufNewFile *.md                               setf markdown

  au! BufRead,BufNewFile *.muttrc                           setf muttrc

  au! BufRead,BufNewFile nginx/*.conf                       setf nginx

  au! BufRead,BufNewFile *.ru,*.rake                        setf ruby
  au! BufRead,BufNewFile Capfile,Gemfile,Isolate,Rakefile   setf ruby
  au! BufRead,BufNewFile Vagrantfile                        setf ruby

  au! BufRead,BufNewFile *vimrc                             setf vim
augroup END

