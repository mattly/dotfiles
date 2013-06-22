#!/bin/bash

manifest=$(cat install/brews)

# homebrew
# brew update
brews_wanted=$(echo "$manifest" | grep -e '^brew\s\+' | awk '{print $2}')
brews_have=$(brew list)
brews_outdated=$(brew outdated | awk '{print $1}')


includes () {
  present=$(echo "$1" | grep -e "$2" > /dev/null)
  return $present
}

replace () {
  echo $(echo "$1" | sed -e 's/'"$2"'/'"$3"'/')
}

get_field () {
  echo $(echo "$1" | awk '{print $'"$2"'}')
}

get_directory () {
  echo $(eval "echo $1")
}

cat install/Borkfile |
while read line; do
  source=$(get_field "$line" 1)
  id=$(get_field "$line" 2)
  case $source in
    "#"|"") ;; #noop
    "brew")
      if includes "$brews_have" $id ; then
        if includes "$brews_outdated" $id ; then
          cmd="brew update $id"
        fi
      else
        cmd=$(replace "$line" '^brew' 'brew install')
      fi
      $cmd
      ;;
    "hub")
      repo=$(get_field "$line" 2)
      dir=$(get_field "$line" 3)
      dir=$(get_directory $dir)
      if [ ! -d $dir ]; then
        echo mkdir -p $dir
        cmd="git clone --bare https://github.com/$(echo $repo).git $dir"
      else
        cmd="cd $dir && git pull"
      fi
      $cmd
      ;;
    "rbenv")
      version=$(get_field "$line" 2)
      if ! includes "$(rbenv versions --bare )" $version; then
        rbenv install $version
      fi ;;
    "nodenv")
      version=$(get_field "$line" 2)
      if ! includes "$(nodenv versions --bare )" $version; then
        nodenv install $version
      fi
      ;;
    "sh")
      cmd=$(replace "$line" '^sh' '')
      $cmd
      ;;
    *)
      echo "WARN unknown directive: $line";;
  esac
done
