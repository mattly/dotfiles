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

test -e {$HOME}/.local.fish
    and source {$HOME}/.local.fish

test (which most)
    and set -x PAGER most

# prefer zed, fall back to vscode
test (which code)
    and set -x EDITOR code
test (which zed)
    and set -x EDITOR zed

# various cli utils

test (which bat)
    and alias cat="bat"

if test (which exa)
    set -l long "--long --header --classify --modified --time-style long-iso --git --color-scale"
    alias l="exa --classify --git-ignore "
    alias ll="exa $long --git-ignore "
    alias la="exa $long --all "
    alias lna="exa $long --all --sort=newest "
    alias ls="exa"
end

test (which prettyping)
    and alias ping='prettyping --nolegend'

test (which lazygit)
    and alias lg='lazygit'

set -x PATH ~/projects/dotfiles/bin $PATH

test -e ~/.local/bin
    and set -x PATH ~/.local/bin $PATH

test -e /opt/homebrew/bin
    and fish_add_path /opt/homebrew/bin

test (which brew)
    and set -x HOMEBREW_NO_AUTO_UPDATE no

test (which gpg)
    and set -x GPG_TTY (tty)

# language-specific stuff
# =========================================================

# --- bun
if test (which bun)
    set --export BUN_INSTALL "$HOME/.bun"
    set --export PATH $BUN_INSTALL/bin $PATH
end

# --- go
set -x GOPATH ~/projects/golang
set -x PATH $GOPATH/bin $PATH

# --- ruby
test -e /usr/local/opt/ruby/bin
    and set -x PATH /usr/local/opt/ruby/bin $PATH

test -e /usr/local/lib/ruby/gems/2.6.0/bin
    and set -x PATH /usr/local/lib/ruby/gems/2.6.0/bin $PATH


# --- rust
test -e ~/.cargo/bin
    and set -x PATH ~/.cargo/bin $PATH

# =========================================================

if test -n $WSL_DISTRO_NAME
  set -x XDG_CONFIG_HOME {$HOME}/.config
end

eval (starship init fish)
