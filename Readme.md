# Because Fork You

Don't fork anyone's dotfiles. Curate your own. Document what things do, why you
prefer them to work that way, and let others learn from your choices.

## Items of Interest

### vimrc

I spend a lot of time in vim. Having switched to it from Textmate, I expected
a certain way of working that I attempted to emulate through plugins, a sort of
proto-janus. Then I realized that way lied madness, and learned the vim way. So
I have a 'command-t' type thing with 'ctrlp' but it works a bit differently, but
makes sense when coming from the vim way.

Hint: the vim way regards thinking about _everything_ in terms of actions and
objects. "split Readme.txt", "delete word", "visual select inner indent".

I use vim in macvim, the terminal, and under tmux. The config has gradually
grown to accommodate the tmux use-case, as it emphasizes home-row keyboard
shortcuts and less reliance on CMD-OPT-ARROW type keys.

I've attempted to organize the file according to what certain directives,
functions, etc, serve. Breaking these out into multiple files would have been
madness, so each section is indented two characters in order to allow easy
folding by indent level. I love folding by indent level.

Note that to use vim in tmux with clipboard support for OS X you need:

    brew install reattach-to-user-name --wrap-pbpaste-and-pbcopy

This will allow you to use the "system clipboard" from vim and other apps under
tmux. You then need a vim with clipboard support, which OS X's vim doesn't have:

    brew install https://raw.github.com/Homebrew/homebrew-dupes/master/vim.rb

### gitconfig

Or particular note here is the aliases section. I've become a huge believer in
creating new git commands to semantically map to certain operations.

- "fold" takes some branches and merges them in, keeping their full branch and
  commit history.
- "goto" performs a reset-hard to the given refspec
- "label" creates a particular type of tag
- "staged" shows a diff of what's in the current commit
- "track" checks out a remote branch as a local branch and sets tracking
- "update-remotes" performs a fetch/prune against all remotes

Aliases such as "amend", "addp", "stat", "tag-release", and "unstage" are
shorthands for common operations that I've fucked up in the past, sometimes with
frustrating results.

### fish

After years of using a cargo-culted zsh config, I gave up on it and went over to
the vastly simplified Friendly Interactive Shell, aka **fish**. It's got
a simplified scripting language, has sane defaults, and nice autocompletion
features.

## Install

`bash < <(curl -s https://raw.github.com/mattly/dotfiles/master/install/bs)`

You should only be doing that if you are me. If you are not me, go make your
wn, and let me know if there's something I can learn from you.
