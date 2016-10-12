#!/usr/bin/env bork

ok check "fdesetup status | grep 'On'"
if check_failed; then
    echo "Filevault is not setup. Please enable filevault before continuing."
    open "/System/Library/PreferencePanels/Security.prefpane"
    exit 1
fi

if [ -n "$COMPUTER_NAME" ]; then
    echo "Setting computer's name to $COMPUTER_NAME"
    ok scutil ComputerName $COMPUTER_NAME
    ok scutil HostName $COMPUTER_NAME
    ok scutil LocalHostName $COMPUTER_NAME
fi

ok directory "$HOME/.ssh"
ok check "[ -e $HOME/.ssh/*.pub ]"
if check_failed && satisfying; then
    echo "Generating SSH Key"
    ssh-keygen -t rsa
    echo "Please upload your new SSH key to GitHub before continuing"
    read -p "Press Return to continue" etc
fi

ok brew
ok brew git

ok directory "$HOME/projects"
ok github $HOME/projects/dotfiles mattly/dotfiles --ssh
cd ~
if [ -d "$HOME/projects/dotfiles/configs" ]; then
    for config in $HOME/projects/dotfiles/configs/*; do
        ok symlink ".$(basename $config)" $config
    done
fi

ok brew fish
register types/shells.sh
ok shells /usr/local/bin/fish
did_install && chsh -s /usr/local/bin/fish

ok github $HOME/projects/bork mattly/bork --ssh
ok brew-tap caskroom/cask
ok cask atom
