function mutt
    set window_name (tmux list-windows | grep '(active)$' | awk '{print $2}' | sed -E 's|\*$||')
    tmux rename-window "mutt"
    pushd ~/Desktop
    /usr/local/bin/mutt $argv
    popd
    tmux rename-window $window_name
end
