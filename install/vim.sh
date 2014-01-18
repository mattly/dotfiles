#!/usr/bin/env bash
brew vim

# TODO: keep track of 'any' changes

[ -z $code ] && code=$HOME/code/mattly
cd $code/dotfiles/vim/bundle

github tpope/vim-pathogen
github tpope/vim-endwise
github tpope/vim-repeat
github tpope/vim-surround
github tpope/vim-unimpaired
github tpope/vim-abolish
github tpope/vim-eunuch
github tpope/vim-commentary
github tpope/vim-vinegar
github ervandew/supertab
github michaeljsmith/vim-indent-object
github Townk/vim-autoclose

github mhinz/vim-startify

# writing tools
github mikewest/vimroom
github reedes/vim-wordy
github reedes/vim-pencil
github nelstrom/vim-markdown-folding

# dash integration
github rizzatti/funcoo.vim
github rizzatti/dash.vim

# Unite
github Shougo/vimproc
if did_update; then
  pushd vimproc > /dev/null
  make clean && make
  popd > /dev/null
fi
github Shougo/unite.vim
github Shougo/unite-help
github h1mesuke/unite-outline

#colors
github mattly/vim-colors-pencil

# git
github tpope/vim-git
github tpope/vim-fugitive

# syntax
github rosstimson/bats.vim          # .bats       bash unit testing
github kchmck/vim-coffee-script     # .coffee     -> .js
github guns/vim-clojure-static      # .clj        clojure syntax
github tpope/vim-fireplace          # .clj        clojure repl
github elixir-lang/vim-elixir       # .ex
github aliva/vim-fish               # .fish
github jnwhiteh/vim-golang          # .go
github wannesm/wmgraphviz.vim       # .gv         graphviz
github tpope/vim-ragtag             # .html       formatting tools
github digitaltoad/vim-jade         # .jade       -> .html
github pangloss/vim-javascript      # .js         better indenting
github groenewege/vim-less          # .less       -> .css
github mintplant/vim-literate-coffeescript
                                    # .litcoffee  -> .js
github juvenn/mustache              # .mustache   :{
github vimoutliner/vimoutliner      # .otl        vim outliner
github cakebaker/scss-syntax.vim    # .scss       -> .css
github exu/pgsql.vim                # .sql        postgresql 4 life
github wavded/vim-stylus            # .styl       -> .css
github cespare/vim-toml             # .toml       :/
github dbakker/vim-lint             # .vim        (linting, for syntastic)

# TODO if "any" changes, vim ':Helptags'
