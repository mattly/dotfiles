function mutt
    tmux rename-window "mutt"
    bash --login -c "cd ~/Desktop; /usr/local/bin/mutt $argv";
    tmux rename-window (echo $PWD | sed -e "s|$HOME|~|")
end
