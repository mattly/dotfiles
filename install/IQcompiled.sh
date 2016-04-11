#!/usr/bin/env bash
getDir () {
  fname=$1
  while [ -h "$fname" ]; do
    dir=$(cd -P "$(dirname "$fname")" && pwd)
    fname=$(readlink $fname)
    [[ $fname != /* ]] && fname="$dir/$fname"
  done
  echo "$(cd "$(dirname $fname)" && pwd -P)"
}
# used by loader to find core/ and stdlib/
BORK_SOURCE_DIR="$(cd $(getDir ${BASH_SOURCE[0]})/.. && pwd -P)"
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
          echo "$tmp" | grep -E '=' > /dev/null
          if [ "$?" -eq 0 ]; then
            param=${tmp%%=*}    # everything before =
            val=${tmp##*=}      # everything after =
          else
            param=$tmp
            val="true"
          fi
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
    print)
      index=0
      while [ "$index" -lt $length ]; do
        eval "echo \"\${$varname[$index]}\""
        (( index++ ))
      done
      ;;
    *) return 1 ;;
  esac
}
bake () { eval "$*"; }
has_curl () {
    needs_exec "curl"
}
http_head_cmd () {
    url=$1
    shift 1
    has_curl
    if [ "$?" -eq 0 ]; then
        echo "curl -sI \"$url\""
    else
        echo "curl not found; wget support not implemented yet"
        return 1
    fi
}
http_header () {
    header=$1
    headers=$2
    echo "$headers" | grep "$header" | tr -s ' ' | cut -d' ' -f2
}
http_get_cmd () {
    url=$1
    target=$2
    has_curl
    if [ "$?" -eq 0 ]; then
        echo "curl -so \"$target\" \"$url\" &> /dev/null"
    else
        echo "curl not found; wget support not implemented yet"
        return 1
    fi
}
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
satisfying () { [ "$operation" == "satisfy" ]; }
permission_cmd () {
  case $1 in
    Linux) echo "stat --printf '%a'" ;;
    Darwin) echo "stat -f '%Lp'" ;;
    *) return 1 ;;
  esac
}
STATUS_OK=0
STATUS_FAILED=1
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
    $STATUS_FAILED) echo "failed" ;;
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
bork_any_updated=0
did_install () { [ "$bork_performed_install" -eq 1 ] && return 0 || return 1; }
did_upgrade () { [ "$bork_performed_upgrade" -eq 1 ] && return 0 || return 1; }
did_update () {
  if did_install; then return 0
  elif did_upgrade; then return 0
  else return 1
  fi
}
did_error () { [ "$bork_performed_error" -gt 0 ] && return 0 || return 1; }
any_updated () { [ "$bork_any_updated" -gt 0 ] && return 0 || return 1; }
_changes_reset () {
  bork_performed_install=0
  bork_performed_upgrade=0
  bork_performed_error=0
  last_change_type=
}
_changes_complete () {
  status=$1
  action=$2
  if [ "$status" -gt 0 ]; then bork_performed_error=1
  elif [ "$action" = "install" ]; then bork_performed_install=1
  elif [ "$action" = "upgrade" ]; then bork_performed_upgrade=1
  fi
  if did_update; then bork_any_updated=1 ;fi
  [ "$status" -gt 0 ] && echo "* failure"
}
destination () {
  echo "deprecation warning: 'destination' utility will be removed in a future version - use 'cd' instead" 1>&2
  cd $1
}
bag init include_directories
bag push include_directories "$BORK_SCRIPT_DIR"
include () {
    incl_script="$(bag read include_directories)/$1"
    if [ -e $incl_script ]; then
        target_dir=$(dirname $incl_script)
        bag push include_directories "$target_dir"
        case $operation in
            compile) compile_file "$incl_script" ;;
            *) . $incl_script ;;
        esac
        bag pop include_directories
    else
        echo "include: $incl_script: No such file" 1>&2
        exit 1
    fi
    return 0
}
_source_runner () {
  if is_compiled; then echo "$1"
  else echo ". $1"
  fi
}
_bork_check_failed=0
check_failed () { [ "$_bork_check_failed" -gt 0 ] && return 0 || return 1; }
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
  _bork_check_failed=0
  _changes_reset
  fn=$(_lookup_type $assertion)
  if [ -z "$fn" ]; then
    echo "not found: $assertion" 1>&2
    return 1
  fi
  argstr=$*
  quoted_argstr=
  while [ -n "$1" ]; do
    quoted_argstr=$(echo "$quoted_argstr \"$1\"")
    shift
  done
  case $operation in
    echo) echo "$fn $argstr" ;;
    status)
      _checking "checking" $assertion $argstr
      output=$(eval "$(_source_runner $fn) status $quoted_argstr")
      status=$?
      _checked "$(_status_for $status): $assertion $argstr"
      [ "$status" -eq 1 ] && _bork_check_failed=1
      [ "$status" -ne 0 ] && [ -n "$output" ] && echo "$output"
      return $status ;;
    satisfy)
      _checking "checking" $assertion $argstr
      status_output=$(eval "$(_source_runner $fn) status $quoted_argstr")
      status=$?
      _checked "$(_status_for $status): $assertion $argstr"
      case $status in
        0) : ;;
        1)
          _bork_check_failed=1
          echo "$status_output"
          ;;
        10)
          eval "$(_source_runner $fn) install $quoted_argstr"
          _changes_complete $? 'install'
          ;;
        11|12|13)
          echo "$status_output"
          eval "$(_source_runner $fn) upgrade $quoted_argstr"
          _changes_complete $? 'upgrade'
          ;;
        20)
          echo "$status_output"
          _conflict_approve $assertion $argstr
          if [ "$?" -eq 0 ]; then
            echo "Resolving conflict..."
            eval "$(_source_runner $fn) upgrade $quoted_argstr"
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
        echo "verifying $last_change_type: $assertion $argstr"
        output=$(eval "$(_source_runner $fn) status $quoted_argstr")
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
computer_name="Lightbringer"
echo "Please enter your administrator password:"
sudo -v
type_check () {
  action=$1
  shift 1
  case $action in
    desc)
      echo "runs a given command.  OK if returns 0, FAILED otherwise."
      echo '* check evalstr'
      echo '> check "[ -d $HOME/.ssh/id_rsa ]"'
      echo '> if check_failed; then ...'
      ;;
    status)
      eval "$*"
      [ "$?" -gt 0 ] && return $STATUS_FAILED || return $STATUS_OK
      ;;
  esac
}
ok check "sudo fdsetup status | grep 'On'"
if check_failed; then
echo "Filevault is not setup. Please enable filevault before continuing."
open -a System Preferences.app
exit 1
fi
type_scutil () {
  action=$1
  type=$2
  name=$3
  shift 3
  case $action in
    desc)
      echo "Verifies OS X machine name with scutil"
      echo "> scutil ComputerName bork"
      ;;
    status)
      needs_exec "scutil" || return $STATUS_FAILED_PRECONDITION
      current_val=$(bake scutil --get $type)
      if [ "$current_val" != $name ]; then
        echo "expected: $name"
        echo "received: $current_val"
        return $STATUS_MISMATCH_UPGRADE
      fi
      return $STATUS_OK
      ;;
    upgrade)
      bake scutil --set $type $name
      ;;
  esac
}
ok scutil ComputerName $computer_name
ok scutil HostName $computer_name
ok scutil LocalHostName $computer_name

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
      [ ! -e "$dir" ] && return $STATUS_MISSING
      [ -d "$dir" ] && return $STATUS_OK
      echo "target exists as non-directory"
      return $STATUS_CONFLICT_CLOBBER
      ;;
    install) bake mkdir -p $dir ;;
    *) return 1 ;;
  esac
}
ok directory "$HOME/.ssh"
ok check "[ -e $HOME/.ssh/*.pub ]"
if check_failed && satisfying; then
ssh-keygen -t rsa
fi

type_brew () {
  action=$1
  name=$2
  shift 2
  from=$(arguments get from $*)
  if [ -z "$name" ]; then
    case $action in
      desc)
        echo "asserts presence of packages installed via homebrew on mac os x"
        echo "* brew                  (installs homebrew)"
        echo "* brew package-name     (instals package)"
        echo "--from=caskroom/cask    (source repository)"
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
        bake 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
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
      install)
        if [ -z "$from" ]; then
          bake brew install $name
        else
          bake brew install $from/$name
        fi
        ;;
      upgrade) bake brew upgrade $name ;;
      *) return 1 ;;
    esac
  fi
}
ok brew
ok brew git

ok directory "$HOME/code/mattly"
cd $HOME/code/mattly
type_github () {
  if [ -z "$git_call" ]; then
    git_call=". $BORK_SOURCE_DIR/types/git.sh"
    is_compiled && git_call="git"
  fi
  action=$1
  repo=$2
  shift 2
  case $action in
    desc)
      echo "front-end for git type, uses github urls"
      echo "passes arguments to git type"
      echo "> ok github mattly/bork"
      echo "> ok github ~/code/bork mattly/bork"
      echo "--ssh                    (clones via ssh instead of https)"
      ;;
    compile)
      include_assertion git $BORK_SOURCE_DIR/types/git.sh
      ;;
    status|install|upgrade)
      next=$1
      target_dir=
      if [ -n "$next" ] && [ ${next:0:1} != '-' ]; then
        target_dir="$repo"
        repo=$1
        shift
      fi
      args="$*"
      if [ -n  "$(arguments get ssh $*)" ]; then
        url="git@github.com:$(echo $repo).git"
        args=$(echo "$args" | sed -E 's|--ssh||')
      else
        url="https://github.com/$(echo $repo).git"
      fi
      eval "$git_call $action $target_dir $url $args"
      ;;
    *) return 1 ;;
  esac
}
type_git () {
  action=$1
  git_url=$2
  shift 2
  next=$1
  if [ -n "$next" ] && [ ${next:0:1} != '-' ]; then
    target_dir=$git_url
    git_url=$1
    shift
  else
    git_name=$(basename $git_url .git)
    target_dir="$git_name"
  fi
  branch=$(arguments get branch $*)
  if [[ ! -z $branch ]]; then
    git_branch=$branch
  else
    git_branch="master"
  fi
  case $action in
    desc)
      echo "asserts presence and state of a git repository"
      echo "> git git@github.com:mattly/bork"
      echo "> git ~/code/bork git@github.com:mattly/bork"
      echo "--ref=gh-pages                (specify branch, tag, or ref)"
      ;;
    status)
      needs_exec "git" || return $STATUS_FAILED_PRECONDITION
      bake [ ! -d $target_dir ] && return $STATUS_MISSING
      target_dir_contents=$(str_item_count "$(bake ls -A $target_dir)")
      [ "$target_dir_contents" -eq 0 ] && return $STATUS_MISSING
      bake cd $target_dir
      git_fetch="$(bake git fetch 2>&1)"
      git_fetch_status=$?
      if [ $git_fetch_status -gt 0 ]; then
        echo "destination directory $target_dir exists, not a git repository (exit status $git_fetch_status)"
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
      bake mkdir -p $target_dir
      bake git clone -b $git_branch $git_url $target_dir
      ;;
    upgrade)
      bake cd $target_dir
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
cd ~
for config in $HOME/code/mattly/dotfiles/configs/*; do
type_symlink () {
  action=$1
  target=$2
  source=$3
  case "$action" in
    desc)
      echo "assert presence and target of a symlink"
      echo "> symlink .vimrc ~/code/dotfiles/configs/vimrc"
      ;;
    status)
      bake [ ! -e "$target" ] && return $STATUS_MISSING
      if bake [ ! -h "$target" ]; then
        echo "not a symlink: $target"
        return $STATUS_CONFLICT_CLOBBER
      else
        existing_source=$(bake readlink \"$target\")
        if [ "$existing_source" != "$source" ]; then
          echo "received source for existing symlink: $existing_source"
          echo "expected source for symlink: $source"
          return $STATUS_MISMATCH_UPGRADE
        fi
      fi
      return $STATUS_OK
      ;;
    install|upgrade)
      bake ln -sf "$source" "$target" ;;
    *) return 1;;
  esac
}
ok symlink ".$(basename $config)" $config
done

ok brew tig

ok brew fish
type_shells () {
  action=$1
  shell=$2
  shift 2
  case $action in
      status)
          bake cat /etc/shells | grep "$shell"
          [ "$?" -gt 0 ] && return $STATUS_MISSING
          return $STATUS_OK
      ;;
      install|upgrade)
          sudo echo "$shell" >> /etc/shells
      ;;
      *) return 1 ;;
  esac
}
ok shells /usr/local/bin/fish
did_install && chsh -s /usr/local/bin/fish

ok brew curl
ok brew editorconfig
ok brew jq
ok brew the_silver_searcher

type_brew-tap () {
  action=$1
  name=$2
  shift 2
  pin=$(arguments get pin $*)
  case $action in
      desc)
          echo "asserts a homebrew forumla repository has been tapped"
          echo "> brew-tap homebrew/games    (taps homebrew/games)"
          echo "--pin                        (pins the formula repository)"
      ;;
      status)
          baking_platform_is "Darwin" || return $STATUS_UNSUPPORTED_PLATFORM
          needs_exec "brew" || return $STATUS_FAILED_PRECONDITION
          list=$(bake brew tap)
          echo "$list" | grep -E "$name$" > /dev/null
          [ "$?" -gt 0 ] && return $STATUS_MISSING
          pinlist=$(bake brew tap --list-pinned)
          echo "$pinlist" | grep -E "$name$" > /dev/null
          pinstatus=$?
          if [ -n "$pin" ]; then
              [ "$pinstatus" -gt 0 ] && return $STATUS_PARTIAL
          else
              [ "$pinstatus" -eq 0 ] && return $STATUS_PARTIAL
          fi
          return $STATUS_OK ;;
      install)
          bake brew tap $name
          if [ -n "$pin" ]; then
              bake brew tap-pin $name
          fi
          ;;
      upgrade)
          if [ -n "$pin" ]; then
              bake brew tap-pin $name
          else
              bake brew tap-unpin $name
          fi
          ;;
      *) return 1 ;;
  esac
}
ok brew-tap caskroom/cask
ok brew brew-cask

type_cask () {
  action=$1
  name=$2
  shift 2
  appdir=$(arguments get appdir $*)
  case $action in
    desc)
      echo "asserts presenece of apps installed via caskroom.io on Mac OS X"
      echo "* cask app-name         (installs cask)"
      echo "--appdir=/Applications  (changes symlink path)"
      ;;
    status)
      baking_platform_is "Darwin" || return $STATUS_UNSUPPORTED_PLATFORM
      needs_exec "brew" || return $STATUS_FAILED_PRECONDITION
      bake brew cask > /dev/null
      [ "$?" -gt 0 ] && return $STATUS_FAILED_PRECONDITION
      list=$(bake brew cask list)
      echo "$list" | grep -E "^$name$" > /dev/null
      [ "$?" -gt 0 ] && return $STATUS_MISSING
      info=$(bake brew cask info $name)
      echo "$info" | grep 'Not installed' > /dev/null
      [ "$?" -eq 0 ] && return $STATUS_OUTDATED
      return 0 ;;
    install)
      if [ -n "$appdir"  ]; then
        bake brew cask install $name --appdir=$appdir
      else
        bake brew cask install $name
      fi
      ;;
    upgrade)
      bake rm -rf "/opt/homebrew-cask/Caskroom/$name"
      if [ -n "$appdir" ]; then
        bake brew cask install $name --appdir=$appdir --force
      else
        bake brew cask install $name --force
      fi
      ;;
    *) return 1 ;;
  esac
}
ok cask 1password
ok cask dropbox
ok cask google-chrome-beta
ok cask google-drive
ok cask the-unarchiver

ok brew-tap argon/mas
ok brew mas

type_mas () {
  action=$1
  appid=$2
  shift 2
  case $action in
      desc)
          echo "asserts a Mac app is installed and up-to-date from the App Store"
          echo " via the 'mas' utility https://github.com/argon/mas"
          echo "app id is required, can be obtained from 'mas' utility, name is optional"
          echo "!WARNING! 'mas' will currently perform *all* pending upgrades when upgrading any app"
          echo "> mas 497799835 Xcode    (installs/upgrades Xcode)"
          ;;
      status)
          baking_platform_is "Darwin" || return $STATUS_UNSUPPORTED_PLATFORM
          needs_exec "mas" || return $STATUS_FAILED_PRECONDITION
          bake mas list | grep -E "^$appid" > /dev/null
          [ "$?" -gt 0 ] && return $STATUS_MISSING
          bake mas outdated | grep -E "^$appid" > /dev/null
          [ "$?" -eq 0 ] && return $STATUS_OUTDATED
          return $STATUS_OK
          ;;
      install) bake mas install $appid ;;
      upgrade) bake mas upgrade ;;
      *) return 1 ;;
  esac
}
ok mas 477670270 2Do
ok mas 687450044 Blind
ok mas 458034879 Dash
ok mas 777886035 Duo
ok cask emacs-mac
ok cask fantastical
ok cask iterm2
ok mas 540348655 Monosnap
ok cask paw
ok cask screenflow
ok mas 507257563 Sip
ok mas 803453959 Slack
ok mas 497799835 Xcode

# TODO: perhaps pull inspiration from https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# auto-expand save, print dialogs
type_defaults () {
  action=$1
  domain=$2
  key=$3
  desired_type=$4
  [ "$desired_type" = "int" ] && desired_type="integer"
  shift 4
  if [ ${desired_type:0:4} = "dict" ]; then
    desired_val=$*
  else
    desired_val=$1
  fi
  case $action in
    desc)
      echo "asserts settings for OS X's 'defaults' system"
      echo "* defaults domain key type value"
      echo "> defaults com.apple.dock autohide bool true"
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
      if [ "$current_type" = "dictionary" ]; then
        current_type="dict"
        bag init temp_defaults_value
        bag push temp_defaults_value "{"
        while [ -n "$1" ]; do
          key=$1
          shift
          next="$1"
          [ ${next:0:1} = '-' ] && shift
          value=$1
          shift
          bash push temp_defaults_value "  $key = $value"
        done
        bag push temp_defaults_value "}"
        desired_val=$(bag print temp_defaults_value)
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
      return $STATUS_OK
      ;;
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
# ok defaults com.apple.LaunchServices LSQuarantine bool false

# speed up the UI
ok defaults NSGlobalDomain NSAutomaticWindowAnimationsEnabled bool false
ok defaults NSGlobalDomain NSWindowResizeTime string .001

# fix the UI
ok defaults NSGlobalDomain AppleEnableMenuBarTransparency bool false
ok defaults NSGlobalDomain NSTableViewDefaultSizeMode integer 2

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
ok defaults com.apple.dock tilesize float 42
# dock show/hide
ok defaults com.apple.dock autohide-delay float 0
ok defaults com.apple.dock autohide-time-modifier float 0
# don't re-order spaces in mission control
ok defaults com.apple.dock mru-spaces bool false
# top-left corner: start screen saver
ok defaults com.apple.dock wvous-tl-corner integer 5
ok defaults com.apple.dock wvous-tl-modifier integer 0
# Put it on the left
ok defaults com.apple.dock orientation string bottom
# clear the dock
# ok rm ~/Library/Application Support/Dock/*.db

# DIE DASHBOARD DIE
ok defaults com.apple.dashboard mcx-disabled bool true

# TODO: if changed...
# killall Dock

ok defaults com.apple.Finder FXPreferredViewStyle string Nlsv
ok defaults com.apple.finder FXEnableExtensionChangeWarning bool false
# ok defaults com.apple.finder EmptyTrashSecurely bool true
# show ~/Library
# chflags nohidden ~/Library
# TODO: if changed...
# killall Finder

# require password immediately on sleep or screensaver
ok defaults com.apple.screensaver askForPassword bool true
ok defaults com.apple.screensaver askForPasswordDelay integer 0


# show ascii-control characters using caret notation in text views
ok defaults NSGlobalDomain NSTextShowsControlCharacters bool true
