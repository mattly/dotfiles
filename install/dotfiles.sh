ok directory $HOME/code/mattly
destination $HOME/code/mattly
ok github mattly/dotfiles

destination $HOME
for config in $HOME/code/mattly/dotfiles/configs/*; do
  ok symlink "$HOME/.$(basename $config)" $config
done

