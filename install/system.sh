echo "Please enter your administrator password:"
sudo -v

ok check "sudo fdesetup status | grep 'On'"
if check_failed; then
  echo "Filevault is not setup.  Please enable filevault before continuing."
  exit 1
fi
ok scutil ComputerName lluvia
ok scutil HostName lluvia
ok scutil LocalHostName lluvia

ok directory "$HOME/.ssh"
ok check "[ -e $HOME/.ssh/*.pub ]"
if check_failed && satisfying; then
  ssh-keygen -t rsa
fi
