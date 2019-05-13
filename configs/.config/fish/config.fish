set -g theme_display_ruby no
set -g theme_display_virtualenv no
set -g theme_display_rust no
set -g theme_display_nvm no


set -g fish_color_command magenta --bold
set -g fish_color_quote yellow
set -g fish_color_redirection green
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_param cyan
set -g fish_color_comment yellow
set -g fish_color_match normal --background yellow
set -g fish_color_search_match normal --background yellow
set -g fish_color_operator bryellow
set -g fish_color_escape bryellow
set -g fish_color_cwd green
set -g fish_color_cwd_root brgreen
set -g fish_color_autosuggestion brgreen
set -g fish_color_user brgreen
set -g fish_color_host normal
set -g fish_color_cancel normal --bold
set -g fish_color_valid_path normal --underline

test -e {$HOME}/.iterm2_shell_integration.fish
and source {$HOME}/.iterm2_shell_integration.fish

alias ping='prettyping --nolegend'
set -x PATH ~/projects/dotfiles/bin $PATH

set -x GOPATH ~/projects
