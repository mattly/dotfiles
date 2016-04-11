
ok directory $HOME/code/mattly
cd $HOME/code/mattly
ok github mattly/dotfiles

cd ~
for config in $HOME/code/mattly/dotfiles/configs/*; do
  ok symlink ".$(basename $config)" $config
done
