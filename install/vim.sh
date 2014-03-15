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
  github wellle/targets.vim

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
  github kien/rainbow_parentheses.vim

# git & scm
  github tpope/vim-git
  github tpope/vim-fugitive
  github mhinz/vim-signify

# Environment-Specific

# Clojure
  github guns/vim-clojure-static      # .clj        clojure syntax
  github guns/vim-sexp.git
  github tpope/vim-sexp-mappings-for-regular-people
  github tpope/vim-fireplace

# CSS
  github cakebaker/scss-syntax.vim    # .scss       -> .css
  github groenewege/vim-less          # .less       -> .css
  github wavded/vim-stylus            # .styl       -> .css

# Javascript
  github pangloss/vim-javascript      # .js         better indenting
  github kchmck/vim-coffee-script     # .coffee     -> .js
  github mintplant/vim-literate-coffeescript
                                      # .litcoffee  -> .js
  github digitaltoad/vim-jade         # .jade       -> .html

# Markup / Templates
  github tpope/vim-ragtag             # .html       formatting tools
  github juvenn/mustache              # .mustache   :{
  github cespare/vim-toml             # .toml       :/

# Shell
  github rosstimson/bats.vim          # .bats       bash unit testing
  github aliva/vim-fish               # .fish

# Viml
  github tpope/vim-scriptease
  github dbakker/vim-lint

# Miscellaneous
  github elixir-lang/vim-elixir       # .ex
  github jnwhiteh/vim-golang          # .go
  github wannesm/wmgraphviz.vim       # .gv         graphviz
  github exu/pgsql.vim                # .sql        postgresql 4 life

# TODO if "any" changes, vim ':Helptags'
