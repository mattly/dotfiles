if test -d $HOME/.bin
  set PATH $HOME/.bin $PATH
end
set PATH /usr/local/sbin $PATH

if test -d $HOME/projects/ml/torch/install/bin
  set PATH $HOME/projects/ml/torch/install/bin $PATH
  set LUAPATH '/Users/mattly/.luarocks/share/lua/5.1/?.lua;/Users/mattly/.luarocks/share/lua/5.1/?/init.lua;/Users/mattly/projects/ml/torch/install/share/lua/5.1/?.lua;/Users/mattly/projects/ml/torch/install/share/lua/5.1/?/init.lua;./?.lua;/Users/mattly/projects/ml/torch/install/share/luajit-2.1.0-beta1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua'
  set LUACPATH '/Users/mattly/.luarocks/lib/lua/5.1/?.so;/Users/mattly/projects/ml/torch/install/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so'
  set LD_LIBRARY_PATH /Users/mattly/projects/ml/torch/install/lib $LD_LIBRARY_PATH
  set DYLD_LIBRARY_PATH /Users/mattly/projects/ml/torch/install/lib $DYLD_LIBRARY_PATH
  set LUA_CPATH '/Users/mattly/projects/ml/torch/install/lib/?.dylib;' $LUA_CPATH
end



if which exa >/dev/null
   set -l recent "--sort date --reverse"
   set -l long "--long --header --links --modified --time-style long-iso --git --color-scale"
   alias l="exa --classify --git-ignore"
   alias ll="exa --classify $long --git-ignore"
   alias la="exa --classify $long --all"
   alias lr="ll $recent"
   alias lra="la $recent"
   alias ls="exa"
end

if which bat >/dev/null
   alias cat="bat"
end
