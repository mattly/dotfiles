# Because Fork You

I'm not going to suggest you're an idiot and need to keep your dotfiles in git
and you should fork mine because obviously yours suck and mine rule. However,
these have evolved over many years to fit a way of working that's been very
productive for me, and I hope there's something here for you to learn.

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

### zshrc

This is mostly cargo culted, but it's evolved to fit my needs over seven years.
I don't pretend to be a shell master or know all the ins and outs of zsh, but
I do know what works for me and this is it. It's just a tool.

Of particular note is that if an ".env" file exists it will be sourced on login.
This file would be a good place to put anything machine-specific or private:

- $PATH declarations
- configs for your rbenv/rvm setup
- api tokens for shell utilities (mine contains $GITHUB_TOKEN among others)
- aliases:
    f.e. I alias vim to the specially built console client included in MacVim at
    /Applications/MacVim.app/Contents/MacOS/vim

There are some settings for `less` and the like in `zsh/55_zshenv`

### others

- I don't like GNU screen and I haven't taken to tmux because it's not installed
on most of the remote servers I need. My `screenrc` has evolved to fit the needs
of logging into remote servers to perform operations such as tailing logs,
compiling shit, and debugging live apps. I don't really use either on my
workstations, in favor of terminal tabs in iTerm.
- Use ack when you're searching source code. Use grep to search anything else.
- tig is a great git history visualizer. Not as good as the fork of gitx, but it
  does 90% of what I need it to do, and is pretty fast on large repositories.

## Getting Started

If you're cloning these down to use them, put them in your projects directory
and run `ruby install.rb`. This will symlink the files and directories herein to
your home folder.

You should only be doing that if you are me. If you are not me, go make your
own, and let me know if there's something I can learn from you.
