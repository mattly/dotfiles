autoload -U compinit zrecompile
compinit

for zshrc_snipplet in ~/.zsh/*.zsh; do
    source $zshrc_snipplet
done

