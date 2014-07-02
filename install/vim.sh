#!/usr/bin/env bash
ok brew vim

# TODO: keep track of 'any' changes

[ -z $code ] && code=$HOME/code/mattly
destination $code/dotfiles/vim/bundle

#group start --dir=$code/dotfiles/vim/bundle

# plugin helpers
  ok github tpope/vim-pathogen
  ok github tpope/vim-repeat

# file helpers
  ok github tpope/vim-eunuch

# insert-mode helpers
  ok github Townk/vim-autoclose
  ok github ervandew/supertab
  ok github tpope/vim-endwise
  ok github tpope/vim-surround

# text manipulation
  ok github tpope/vim-commentary
  ok github junegunn/vim-easy-align
  ok github tpope/vim-abolish
  ok github terryma/vim-multiple-cursors
  ok github tpope/vim-characterize

# text-objects
  ok github michaeljsmith/vim-indent-object
  ok github gcmt/wildfire.vim
  ok github tpope/vim-jdaddy
  ok github wellle/targets.vim

# writing tools
  ok github junegunn/goyo.vim

  ok github reedes/vim-pencil
  ok github reedes/vim-lexical
  ok github reedes/vim-wordy
  ok github nelstrom/vim-markdown-folding

# outlining
  ok github vim-voom/VOoM

# dash integration
  ok github rizzatti/funcoo.vim
  ok github rizzatti/dash.vim

# navigation
  ok github kien/ctrlp.vim
  ok github majutsushi/tagbar
  ok github rking/ag.vim
  ok github tpope/vim-vinegar

# UI and colors
  ok github reedes/vim-colors-pencil
  ok github kien/rainbow_parentheses.vim

# git & scm
  ok github tpope/vim-git                 # .gitcommit
  ok github tpope/vim-fugitive
  ok github mhinz/vim-signify
  ok github idanarye/vim-merginal

# snip!
  ok github tomtom/tlib_vim
  ok github MarcWeber/vim-addon-mw-utils
  ok github garbas/vim-snipmate
  ok github honza/vim-snippets

# Language/Environment-Specific

  # Clojure
    ok github guns/vim-clojure-static       # .clj        clojure syntax
    ok github guns/vim-sexp
    ok github tpope/vim-sexp-mappings-for-regular-people
    ok github tpope/vim-fireplace

  # CSS
    ok github cakebaker/scss-syntax.vim     # .scss       -> .css
    ok github groenewege/vim-less           # .less       -> .css
    ok github wavded/vim-stylus             # .styl       -> .css

  # Javascript
    ok github pangloss/vim-javascript       # .js         better indenting
    ok github kchmck/vim-coffee-script      # .coffee     -> .js
    ok github mintplant/vim-literate-coffeescript
                                        # .litcoffee  -> .js

  # Markup / Templates
    ok github tpope/vim-ragtag              # .html       formatting tools
    ok github juvenn/mustache               # .mustache   :{
    ok github Glench/Vim-Jinja2-Syntax      # .html       jinja/nunjukcs/swig
    ok github digitaltoad/vim-jade          # .jade       -> .html

  # Shell
    ok github rosstimson/bats.vim           # .bats       bash unit testing
    ok github aliva/vim-fish                # .fish

  # Viml
    ok github tpope/vim-scriptease
    ok github dbakker/vim-lint

  # Miscellaneous
    ok github vim-scripts/csv.vim           # .csv
    ok github ekalinin/Dockerfile.vim       # Dockerfile
    ok github elixir-lang/vim-elixir        # .ex
    ok github jimenezrick/vimerl            # .erl
    ok github jnwhiteh/vim-golang           # .go
    ok github wannesm/wmgraphviz.vim        # .gv         graphviz
    ok github travitch/hasksyn              # .hs
    ok github wting/rust.vim                # .rust
    ok github toyamarinyon/vim-swift
    ok github exu/pgsql.vim                 # .sql        postgresql 4 life
    ok github andersoncustodio/vim-tmux     # tmux.config
    ok github sheerun/vim-yardoc            # yard inside .rb

# TODO if "any" changes, vim ':Helptags'

#group end
