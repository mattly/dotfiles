#!/usr/bin/env bash
brew vim

# TODO: keep track of 'any' changes

[ -z $code ] && code=$HOME/code/mattly
cd $code/dotfiles/vim/bundle

# plugin helpers
  github tpope/vim-pathogen
  github tpope/vim-repeat

# file helpers
  github tpope/vim-eunuch

# insert-mode helpers
  github Townk/vim-autoclose
  github ervandew/supertab
  github tpope/vim-endwise
  github tpope/vim-surround

# text manipulation
  github tpope/vim-commentary
  github junegunn/vim-easy-align
  github tpope/vim-abolish
  github terryma/vim-multiple-cursors

# text-objects
  github michaeljsmith/vim-indent-object
  github gcmt/wildfire.vim
  github tpope/vim-jdaddy

# writing tools
  github mikewest/vimroom
  github reedes/vim-pencil
  github reedes/vim-lexical
  github reedes/vim-wordy
  github nelstrom/vim-markdown-folding

# outlining
  github vim-voom/VOoM

# dash integration
  github rizzatti/funcoo.vim
  github rizzatti/dash.vim

# navigation
  github kien/ctrlp.vim
  github majutsushi/tagbar
  github rking/ag.vim
  github tpope/vim-vinegar

# UI and colors
  github mattly/vim-colors-pencil

# git & scm
  github tpope/vim-git
  github tpope/vim-fugitive
  github mhinz/vim-signify

# Language-Specific
# vim
  github tpope/vim-scriptease
  github dbakker/vim-lint

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
github cakebaker/scss-syntax.vim    # .scss       -> .css
github exu/pgsql.vim                # .sql        postgresql 4 life
github wavded/vim-stylus            # .styl       -> .css
github cespare/vim-toml             # .toml       :/

# TODO if "any" changes, vim ':Helptags'
