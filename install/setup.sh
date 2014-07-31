#!/usr/bin/env bash
getDir () {
  fname=$1
  [ -h $fname ] && fname=$(readlink $fname)
  echo "$(cd "$(dirname $fname)" && pwd)"
}
# used by loader to find core/ and stdlib/
BORK_SOURCE_DIR="$(getDir $(getDir ${BASH_SOURCE[0]}))"
BORK_SCRIPT_DIR=$PWD
BORK_WORKING_DIR=$PWD
operation="satisfy"
case "$1" in
  status) operation="$1"
esac
is_compiled () { return 0; }
arguments () {
  op=$1
  shift
  case $op in
    get)
      key=$1
      shift
      value=
      while [ -n "$1" ] && [ -z "$value" ]; do
        this=$1
        shift
        if [ ${this:0:2} = '--' ]; then
          tmp=${this:2}       # strip off leading --
          param=${tmp%%=*}    # everything before =
          val=${tmp##*=}      # everything after =
          if [ "$param" = $key ]; then value=$val; fi
        fi
      done
      [ -n $value ] && echo "$value"
      ;;
    *) return 1 ;;
  esac
}
bag () {
  action=$1
  varname=$2
  shift 2
  if [ "$action" != "init" ]; then
    length=$(eval "echo \${#$varname[*]}")
    last=$(( length - 1 ))
  fi
  case "$action" in
    init) eval "$varname=( )" ;;
    push) eval "$varname[$length]=\"$1\"" ;;
    pop) eval "unset $varname[$last]=" ;;
    read)
      [ "$length" -gt 0 ] && echo $(eval "echo \${$varname[$last]}") ;;
    size) echo $length ;;
    filter)
      index=0
      (( limit=$2 ))
      [ "$limit" -eq 0 ] && limit=-1
      while [ "$index" -lt $length ]; do
        line=$(eval "echo \${$varname[$index]}")
        if str_matches "$line" "$1"; then
          [ -n "$3" ] && echo $index || echo $line
          [ "$limit" -ge $index ] && return
        fi
        (( index++ ))
      done ;;
    find) echo $(bag filter $varname $1 1) ;;
    index) echo $(bag filter $varname $1 1 1) ;;
    set)
      idx=$(bag index $varname "^$1=")
      [ -z "$idx" ] && idx=$length
      eval "$varname[$idx]=\"$1=$2\""
      ;;
    get)
      line=$(bag filter $varname "^$1=" 1)
      echo "${line##*=}" ;;
    *) return 1 ;;
  esac
}
bake () { eval "$*"; }
md5cmd () {
  case $1 in
    Darwin)
      [ -z "$2" ] && echo "md5" || echo "md5 -q $2"
      ;;
    Linux)
      [ -z "$2" ] && arg="" || arg="$2 "
      echo "md5sum $arg| awk '{print \$1}'"
      ;;
    *) return 1 ;;
  esac
}
permission_cmd () {
  case $1 in
    Linux) echo "stat --printf '%a'" ;;
    Darwin) echo "stat -f '%Lp'" ;;
    *) return 1 ;;
  esac
}
STATUS_OK=0
STATUS_MISSING=10
STATUS_OUTDATED=11
STATUS_PARTIAL=12
STATUS_MISMATCH_UPGRADE=13
STATUS_MISMATCH_CLOBBER=14
STATUS_CONFLICT_UPGRADE=20
STATUS_CONFLICT_CLOBBER=21
STATUS_CONFLICT_HALT=25
STATUS_BAD_ARGUMENTS=30
STATUS_FAILED_ARGUMENTS=31
STATUS_FAILED_ARGUMENT_PRECONDITION=32
STATUS_FAILED_PRECONDITION=33
STATUS_UNSUPPORTED_PLATFORM=34
_status_for () {
  case "$1" in
    $STATUS_OK) echo "ok" ;;
    $STATUS_MISSING) echo "missing" ;;
    $STATUS_OUTDATED) echo "outdated" ;;
    $STATUS_PARTIAL) echo "partial" ;;
    $STATUS_MISMATCH_UPGRADE) echo "mismatch (upgradable)" ;;
    $STATUS_MISMATCH_CLOBBER) echo "mismatch (clobber required)" ;;
    $STATUS_CONFLICT_UPGRADE) echo "conflict (upgradable)" ;;
    $STATUS_CONFLICT_CLOBBER) echo "conflict (clobber required)" ;;
    $STATUS_CONFLICT_HALT) echo "conflict (unresolvable)" ;;
    $STATUS_BAD_ARGUMENT) echo "error (bad arguments)" ;;
    $STATUS_FAILED_ARGUMENTS) echo "error (failed arguments)" ;;
    $STATUS_FAILED_ARGUMENT_PRECONDITION) echo "error (failed argument precondition)" ;;
    $STATUS_FAILED_PRECONDITION) echo "error (failed precondition)" ;;
    $STATUS_UNSUPPORTED_PLATFORM) echo "error (unsupported platform)" ;;
    *)    echo "unknown status: $1" ;;
  esac
}
needs_exec () {
  [ -z "$1" ] && return 1
  [ -z "$2" ] && running_status=0 || running_status=$2
  path=$(bake "which $1")
  if [ "$?" -gt 0 ]; then
    echo "missing required exec: $1"
    retval=$((running_status+1))
    return $retval
  else return $running_status
  fi
}
platform=$(uname -s)
is_platform () {
  [ "$platform" = $1 ]
  return $?
}
platform_is () {
  [ "$platform" = $1 ]
  return $?
}
baking_platform=
baking_platform_is () {
  [ -z "$baking_platform" ] && baking_platform=$(bake uname -s)
  [ "$baking_platform" = $1 ]
  return $?
}
str_contains () {
  str_matches "$1" "^$2\$"
}
str_get_field () {
  echo $(echo "$1" | awk '{print $'"$2"'}')
}
str_item_count () {
  accum=0
  for item in $1; do
    ((accum++))
  done
  echo $accum
}
str_matches () {
  $(echo "$1" | grep -E "$2" > /dev/null)
  return $?
}
str_replace () {
  echo $(echo "$1" | sed -E 's|'"$2"'|'"$3"'|g')
}
bork_performed_install=0
bork_performed_upgrade=0
bork_performed_error=0
did_install () { [ "$bork_performed_install" -eq 1 ] && return 0 || return 1; }
did_upgrade () { [ "$bork_performed_upgrade" -eq 1 ] && return 0 || return 1; }
did_update () {
  if did_install; then return 0
  elif did_upgrade; then return 0
  else return 1
  fi
}
_changes_reset () {
  bork_performed_install=0
  bork_performed_upgrade=0
  bork_performed_error=0
  last_change_type=
}
_changes_complete () {
  status=$1
  action=$2
  last_change_type=$action
  if [ "$status" -gt 0 ]; then bork_performed_error=1
  elif [ "$action" = "install" ]; then bork_performed_install=1
  elif [ "$action" = "upgrade" ]; then bork_performed_upgrade=1
  else
    echo "unknown action $2, exiting"
    exit 1
  fi
  [ "$status" -gt 0 ] && echo "* failure"
}
BORK_DESTINATION=$BORK_WORKING_DIR
destination () {
  BORK_DESTINATION=$1
  if [ ! -d "$1" ]; then
    echo "missing destination: $1"
    return 1
  fi
}
include () {
  if [ -e "$BORK_SCRIPT_DIR/$1" ]; then
    . "$BORK_SCRIPT_DIR/$1"
  else
    echo "include: $BORK_SCRIPT_DIR/$1: No such file or directory"
    exit 1
  fi
}
_ok_run () {
  fn=$1
  shift
  if is_compiled; then (cd $BORK_DESTINATION; $fn $*)
  else (cd $BORK_DESTINATION; . $fn $*)
  fi
}
_checked_len=0
_checking () {
  type=$1
  shift
  check_str="$type: $*"
  _checked_len=${#check_str}
  echo -n "$check_str"$'\r'
}
_checked () {
  report="$*"
  (( pad=$_checked_len - ${#report} ))
  i=1
  while [ "$i" -le $pad ]; do
    report+=" "
    (( i++ ))
  done
  echo "$report"
}
_conflict_approve () {
  if [ -n "$BORK_CONFLICT_RESOLVE" ]; then
    return $BORK_CONFLICT_RESOLVE
  fi
  echo
  echo "== Warning! Assertion: $*"
  echo "Attempting to satisfy has resulted in a conflict.  Satisfying this may overwrite data."
  _yesno "Do you want to continue?"
  return $?
}
_yesno () {
  answered=0
  answer=
  while [ "$answered" -eq 0 ]; do
    read -p "$* (yes/no) " answer
    if [[ "$answer" == 'y' || "$answer" == "yes" || "$answer" == "n" || "$answer" == "no" ]]; then
      answered=1
    else
      echo "Valid answers are: yes y no n" >&2
    fi
  done
  [[ "$answer" == 'y' || "$answer" == 'yes' ]]
}
ok () {
  assertion=$1
  shift
  _changes_reset
  fn=$(_lookup_type $assertion)
  if [ -z "$fn" ]; then
    echo "not found: $assertion" 1>&2
    return 1
  fi
  case $operation in
    echo) echo "$fn $*" ;;
    status)
      _checking "checking" $assertion $*
      output=$(_ok_run $fn "status" $*)
      status=$?
      _checked "$(_status_for $status): $assertion $*"
      [ "$status" -ne 0 ] && [ -n "$output" ] && echo "$output"
      return $status ;;
    satisfy)
      _checking "checking" $assertion $*
      status_output=$(_ok_run $fn "status" $*)
      status=$?
      _checked "$(_status_for $status): $assertion $*"
      case $status in
        0) : ;;
        10)
          _ok_run $fn install $*
          _changes_complete $? 'install'
          ;;
        11|12|13)
          echo "$status_output"
          _ok_run $fn upgrade $*
          _changes_complete $? 'upgrade'
          ;;
        20)
          echo "$status_output"
          _conflict_approve $assertion $*
          if [ "$?" -eq 0 ]; then
            echo "Resolving conflict..."
            _ok_run $fn upgrade $*
            _changes_complete $? 'upgrade'
          else
            echo "Conflict unresolved."
          fi
          ;;
        *)
          echo "-- sorry, bork doesn't handle this response yet"
          echo "$status_output"
          ;;
      esac
      if did_update; then
        echo "verifying $last_change_type: $assertion $*"
        output=$(_ok_run $fn "status" $*)
        status=$?
        if [ "$status" -gt 0 ]; then
          echo "* $last_change_type failed"
          _checked "$(_status_for $status)"
          echo "$output"
        else
          echo "* success"
        fi
        return 1
      fi
      ;;
  esac
}
bag init bork_assertion_types
register () {
  file=$1
  type=$(basename $file '.sh')
  if [ -e "$BORK_SCRIPT_DIR/$file" ]; then
    file="$BORK_SCRIPT_DIR/$file"
  else
    exit 1
  fi
  bag set bork_assertion_types $type $file
}
_lookup_type () {
  assertion=$1
  if is_compiled; then
    echo "type_$assertion"
    return
  fi
  fn=$(bag get bork_assertion_types $assertion)
  if [ -n "$fn" ]; then
    echo "$fn"
    return
  fi
  bork_official="$BORK_SOURCE_DIR/types/$(echo $assertion).sh"
  if [ -e "$bork_official" ]; then
    echo "$bork_official"
    return
  fi
  local_script="$BORK_SCRIPT_DIR/$assertion"
  if [ -e "$local_script" ]; then
    echo "$local_script"
    return
  fi
  return 1
}
type_brew () {
  action=$1
  name=$2
  shift 2
  if [ -z "$name" ]; then
    case $action in
      desc)
        echo "asserts presence of packages installed via homebrew on mac os x" 
        echo "* brew                  (installs homebrew)"
        echo "* brew package-name     (instals package)"
        ;;
      status)
        baking_platform_is "Darwin" || return $STATUS_UNSUPPORTED_PLATFORM
        needs_exec "ruby" || return $STATUS_FAILED_PRECONDITION
        path=$(bake which brew)
        [ "$?" -gt 0 ] && return $STATUS_MISSING
        changes=$(cd /usr/local; git fetch --quiet; git log master..origin/master)
        [ "$(echo $changes | sed '/^\s*$/d' | wc -l | awk '{print $1}')" -gt 0 ] && return $STATUS_OUTDATED
        return $STATUS_OK
        ;;
      install)
        bake 'ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"'
        ;;
      upgrade)
        bake brew update
        ;;
      *) return 1 ;;
    esac
  else
    case $action in
      status)
        baking_platform_is "Darwin" || return $STATUS_UNSUPPORTED_PLATFORM
        needs_exec "brew" || return $STATUS_FAILED_PRECONDITION
        bake brew list | grep -E "^$name$" > /dev/null
        [ "$?" -gt 0 ] && return $STATUS_MISSING
        bake brew outdated | awk '{print $1}' | grep -E "^$name$" > /dev/null
        [ "$?" -eq 0 ] && return $STATUS_OUTDATED
        return 0 ;;
      install) bake brew install $name ;;
      upgrade) bake brew upgrade $name ;;
      *) return 1 ;;
    esac
  fi
}
ok brew
ok brew git

# include dotfiles.sh
type_directory () {
  action=$1
  dir=$2
  shift 2
  case "$action" in
    desc)
      echo "asserts presence of a directory"
      echo "* directories ~/.ssh"
      ;;
    status)
      [ ! -e $dir ] && return $STATUS_MISSING
      [ -d $dir ] && return $STATUS_OK
      echo "target exists as non-directory"
      return $STATUS_CONFLICT_CLOBBER
      ;;
    install) bake mkdir -p $dir ;;
    *) return 1 ;;
  esac
}
ok directory $HOME/code/mattly
destination $HOME/code/mattly
type_github () {
  action=$1
  repo=$2
  shift 2
  case $action in
    desc)
      echo "front-end for git type, uses github urls"
      echo "* ok github mattly/dotfiles"
      ;;
    compile) include_assertion git $BORK_SOURCE_DIR/types/git.sh ;;
    *) . $BORK_SOURCE_DIR/types/git.sh $action "https://github.com/$(echo $repo).git" $* ;;
  esac
}
type_git () {
  action=$1
  git_url=$2
  shift 2
  git_name=$(basename $git_url .git)
  git_dir="$git_name"
  git_branch="master"
  case $action in
    desc)
      echo "asserts presence and state of a git repository"
      echo "* git git@github.com:mattly/bork"
      ;;
    status)
      needs_exec "git" || return $STATUS_FAILED_PRECONDITION
      bake [ ! -d $git_dir ] && return $STATUS_MISSING
      git_dir_contents=$(str_item_count "$(bake ls -A $git_dir)")
      [ "$git_dir_contents" -eq 0 ] && return $STATUS_MISSING
      bake cd $git_dir
      git_fetch="$(bake git fetch 2>&1)"
      git_fetch_status=$?
      if [ $git_fetch_status -gt 0 ]; then
        echo "destination directory $git_dir exists, not a git repository (exit status $git_fetch_status)"
        return $STATUS_CONFLICT_CLOBBER
      elif str_matches "$git_fetch" '"^fatal"'; then 
        echo "destination directory exists, not a git repository"
        echo "$git_fetch"
        return $STATUS_CONFLICT_CLOBBER
      fi
      git_stat=$(bake git status -uno -b --porcelain)
      git_first_line=$(echo "$git_stat" | head -n 1)
      git_divergence=$(str_get_field "$git_first_line" 3)
      if str_matches "$git_divergence" 'ahead'; then
        echo "local git repository is ahead of remote"
        return $STATUS_CONFLICT_UPGRADE
      fi
      if str_matches "$git_stat" "^\\s?\\w"; then
        echo "local git repository has uncommitted changes"
        return $STATUS_CONFLICT_UPGRADE
      fi
      str_matches "$(str_get_field "$git_first_line" 2)" "$git_branch"
      if [ "$?" -ne 0 ]; then
        echo "local git repository is on incorrect branch"
        return $STATUS_MISMATCH_UPGRADE
      fi
      if str_matches "$git_divergence" 'behind'; then return $STATUS_OUTDATED; fi
      return $STATUS_OK ;;
    install)
      bake mkdir -p $git_dir
      bake git clone $git_url $git_dir
      ;;
    upgrade)
      bake cd $git_dir
      bake git reset --hard
      bake git pull
      bake git checkout $git_branch
      bake git log HEAD@{2}..
      printf "\n"
      ;;
    *) return 1 ;;
  esac
}
ok github mattly/dotfiles

destination $HOME
for config in $HOME/code/mattly/dotfiles/configs/*; do
type_symlink () {
  action=$1
  target=$2
  source=$3
  case "$action" in
    desc)
      echo "assert presence and target of a symlink"
      echo "* symlink .vimrc ~/code/dotfiles/configs/vimrc"
      ;;
    status)
      if bake [ -h $target ]; then
        existing_source=$(bake readlink $target)
        if [ "$existing_source" != $source ]; then
          echo "received source for existing symlink: $existing_source"
          echo "expected source for symlink: $source"
          return $STATUS_MISMATCH_CLOBBER
        else
          return $STATUS_OK
        fi
      elif bake [ -e $target ]; then
        echo "not a symlink: $target"
        return $STATUS_CONFLICT_CLOBBER
      else
        return $STATUS_MISSING
      fi ;;
    install|upgrade)
      bake ln -s $source $target ;;
    *) return 1;;
  esac
}
ok symlink "$HOME/.$(basename $config)" $config
done
# ---


# basics
ok brew readline
ok brew bcrypt
ok brew openssl

# git tools
ok brew hub
ok brew tig

# environment
ok brew fish
if did_install; then
echo "changing shell to fish, you will need to enter your password"
sudo echo /usr/local/bin/fish >> /etc/shells
chsh -s /usr/local/bin/fish
fi

# include tmux.sh
ok brew tmux
ok brew reattach-to-user-namespace --wrap-pbpaste-and-pbcopy

ok directory $HOME/.tmux
destination $HOME/.tmux

ok github bruno-/tmux_goto_session
ok github bruno-/tmux_battery_osx
# ---
# include vim.sh
ok brew vim

# TODO: keep track of 'any' changes

[ -z $code ] && code=$HOME/code/mattly
destination $code/dotfiles/configs/vim/bundle

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
ok github junegunn/limelight.vim

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
# ---

# etc tools
ok brew the_silver_searcher
ok brew par
ok brew curl
ok brew jq
ok brew nmap
ok brew dnsmasq
ok brew mtr
ok brew graphviz
type_pip () {
  action=$1
  name=$2
  shift 2
  case $action in
    desc)
      echo "asserts presence of packages installed via pip"
      echo "* pip pygments"
      ;;
    status)
      needs_exec "pip" || return $STATUS_FAILED_PRECONDITION
      pkgs=$(bake pip list)
      if ! str_matches "$pkgs" "^$name"; then
        return $STATUS_MISSING
      fi
      return 0 ;;
    install)
      bake pip install "$name"
      ;;
  esac
}
ok pip httpie
ok pip virtualenv

ok brew direnv

ok brew apple-gcc42

ok brew ansible

# include osx.sh
# TODO: perhaps pull inspiration from https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# auto-expand save, print dialogs
type_defaults () {
  action=$1
  domain=$2
  key=$3
  desired_type=$4
  desired_val=$5
  case $action in
    desc)
      echo "asserts settings for OS X's 'defaults' system"
      echo "> defaults domain key type value"
      echo "* defaults com.apple.dock autohide bool true"
      ;;
    status)
      needs_exec "defaults" || return $STATUS_FAILED_PRECONDITION
      current_val=$(bake defaults read $domain $key)
      [ "$?" -eq 1 ] && return $STATUS_MISSING
      current_type=$(str_get_field "$(bake defaults read-type $domain $key)" 3)
      conflict=
      if [ "$current_type" = "boolean" ]; then
        current_type="bool"
        case "$current_val" in
          0) current_val="false" ;;
          1|YES) current_val="true" ;;
        esac
      fi
      if [ "$desired_type" != $current_type ]; then
        conflict=1
        echo "expected type: $desired_type"
        echo "received type: $current_type"
      fi
      if [ "$current_val" != $desired_val ]; then
        conflict=1
        echo "expected value: $desired_val"
        echo "received value: $current_val"
      fi
      [ -n "$conflict" ] && return $STATUS_MISMATCH_UPGRADE
      return 0 ;;
    install|upgrade)
      bake defaults write $domain $key "-$desired_type" $desired_val
      ;;
    *) return 1 ;;
  esac
}
ok defaults NSGlobalDomain NSNavPanelExpandedStateForSaveMode bool true
ok defaults NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 bool true
ok defaults NSGlobalDomain PMPrintingExpandedStateForPrint bool true
ok defaults NSGlobalDomain PMPrintingExpandedStateForPrint2 bool true

# default to save to disk, not iCloud
ok defaults NSGlobalDomain NSDocumentSaveNewDocumentsToCloud bool false

# disable gatekeeper
ok defaults com.apple.LaunchServices LSQuarantine bool false

# speed up the UI
ok defaults NSGlobalDomain NSAutomaticWindowAnimationsEnabled bool false
ok defaults NSGlobalDomain NSWindowResizeTime string .001
# fix the UI
ok defaults NSGlobalDomain AppleEnableMenuBarTransparency bool false
# show all extensions
ok defaults NSGlobalDomain AppleShowAllExtensions bool true
# help viewer to regular window
ok defaults com.apple.helpviewer DevMode bool true

# disable auto spelling correction
ok defaults NSGlobalDomain NSAutomaticSpellingCorrectionEnabled bool false

ok defaults com.apple.desktopservices DSDontWriteNetworkStores bool true
ok defaults com.apple.frameworks.diskimages skip-verify bool true
ok defaults com.apple.frameworks.diskimages skip-verify-remote bool true
ok defaults com.apple.frameworks.diskimages skip-verify-locked bool true

# don't prompt time machine on new disks
ok defaults com.apple.TimeMachine DoNotOfferNewDisksForBackup bool true

# --- dock
ok defaults com.apple.dock autohide bool true
ok defaults com.apple.dock static-only bool true
ok defaults com.apple.dock workspaces-swoosh-animation-off bool true
ok defaults com.apple.dashboard mcx-disabled bool true
ok defaults com.apple.dock tilesize integer 36
# dock show/hide
ok defaults com.apple.dock autohide-delay float 0
ok defaults com.apple.dock autohide-time-modifier float 0
# don't re-order spaces in mission control
ok defaults com.apple.dock mru-spaces bool false
# top-left corner: start screen saver
ok defaults com.apple.dock wvous-tl-corner integer 5
ok defaults com.apple.dock wvous-tl-modifier integer 0
# Put it on the left
ok defaults com.apple.dock orientation string left
# clear the dock
# ok rm ~/Library/Application Support/Dock/*.db

# DIE DASHBOARD DIE
ok defaults com.apple.dashboard mcx-disabled bool true

# TODO: if changed...
# killall Dock

ok defaults com.apple.Finder FXPreferredViewStyle string clmv
ok defaults com.apple.finder FXEnableExtensionChangeWarning bool false
# ok defaults com.apple.finder EmptyTrashSecurely bool true
# show ~/Library
# chflags nohidden ~/Library
# TODO: if changed...
# killall Finder

# require password immediately on sleep or screensaver
ok defaults com.apple.screensaver askForPassword integer 1
ok defaults com.apple.screensaver askForPasswordDelay integer 0



# ---
# include apps.sh
type_cask () {
  action=$1
  name=$2
  shift 2
  case $action in
    desc)
      echo "asserts presenece of apps installed via caskroom.io on Mac OS X"
      echo "* cask app-name"
      ;;
    status)
      baking_platform_is "Darwin" || return $STATUS_UNSUPPORTED_PLATFORM
      needs_exec "brew" || return $STATUS_FAILED_PRECONDITION
      bake brew cask || return $STATUS_FAILED_PRECONDITION
      list=$(bake brew cask list)
      echo "$list" | grep -E "^$name$" > /dev/null
      [ "$?" -gt 0 ] && return $STATUS_MISSING
      return 0 ;;
    install) bake brew cask install $name ;;
    *) return 1 ;;
  esac
}
ok cask alfred
ok cask crashplan
ok cask dropbox
ok cask google-drive
ok cask little-snitch
ok cask the-unarchiver

# ok cask daisydisk # via appstore
ok cask onepassword

#ok cask fantastical
ok cask google-chrome
ok cask google-hangouts
ok cask kindle
# ok cask pocket
ok cask vlc

ok cask adobe-creative-cloud
ok cask adobe-photoshop-lightroom
# ok cask search colorchooser
ok cask colorpicker-developer
ok cask gifrocket
ok cask fontprep
# ok cask pixelmator
# ok cask sketch
# ok cask sketchbook-pro
# ok cask xscope

# ok cask albeton-live
ok cask fission
ok cask cycling74-max

# ok cask calca
ok cask marked

ok cask atom
# ok cask dash
# ok cask duo
ok cask iterm2
ok cask vagrant
ok cask virtualbox
# ---
# include sketch.sh
sketch_dir="$HOME/Library/Containers/com.bohemiancoding.sketch3/Data/Library/Application Support/com.bohemiancoding.sketch3/"
ok directory $sketch_dir

destination push $sketch_dir
ok github timuric/Content-generator-sketch-plugin

destination pop
# ---
