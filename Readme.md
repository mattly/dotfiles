# Because Fork You

Don't fork anyone's dotfiles.  Curate your own.  Document what things do,
why you prefer them to work that way, and help others learn from your
choices.  By using other people's configs wholesale, you're 
[cargo-culting], copying the actions of others without understanding why.  
Maybe it gets you some nifty thing that will help you get started, but if 
want to truly master your tools, you have to make these choices 
deliberately, not because someone else said so.

[cargo-culting]: https://en.wikipedia.org/wiki/Cargo_cult_programming

## Items of Interest

### vimrc

I spend a lot of time in vim. Having switched to it from Textmate,
I expected a certain way of working that I attempted to emulate through
plugins, a sort of proto-janus. Then I realized that way lied madness, and
learned the vim way. So I have a 'command-t' type thing with 'ctrlp' but
it works a bit differently, but makes sense when coming from the vim way:
thinking about _everything_ in terms of actions and objects. "split
Readme.txt", "delete word", "visual select inner indent".

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

I've become a huge believer in creating new git commands to semantically
map to certain operations.  Of note:

- **`amend`**: `commit --amend` a long time ago I accidently performed
    a `commit -amend` instead of the desired action, and to my surprise
    and horror it actually did something, I'm still not sure exactly what,
    but it took an hour to undo.  Thus began the list you are reading.
- **`addp`**: `add --patch` I would rename this to simply 'add' if I could
- **`axe <term>`**: `log -S<term>` performs a search of your git history for *term*
- **`cleanup`**: remove all local branches that have been merged into HEAD
- **`cleanup-remotes`**: remove all remote branches that have been merged into
    HEAD.
- **`delete <remotename> <branchname>`**: Deletes *branch* from *remote*
- **`fold`**:`merge --no-ff` takes some branches and merges them in,
    keeping their full branch and commit history.
- **`goto <refspec>`**: `reset --hard <refspec>` performs a reset-hard to
    the given refspec
- **`label`**: `tag -a` creates an annotated tag, suitable for versioning
    or the like
- **`staged`**: `diff --cached` shows a diff of what's in the current commit
- **`tag-release`**: Creates an unannotated tag named
    `release/YYYY/MM/DD/HHMM`.  For when you need to do this by hand.
- **`track <remote refspec>`**: `checkout -t <remote refspec>` checks out
    a remote branch as a local branch and sets tracking.
- **`undo`**: `reset --soft HEAD^` Revert a commit, but leave its contents
    as staged.
- **`unstage <path>`**: `reset HEAD -- <path>` removes `path` from the
    index
- **`update-remotes`**: `remote update --prune` performs a fetch/prune
    against all remotes.

Aliases such as "amend", "addp", "stat", "tag-release", and "unstage" are
shorthands for common operations that I've fucked up in the past, sometimes with
frustrating results.

### fish

After years of using a cargo-culted zsh config, I gave up on it and went
over to the vastly simplified Friendly Interactive Shell, aka **fish**.
It's got a simplified scripting language, has sane defaults, and nice
autocompletion features.  There's not much remarkable to see in the config
file, because [configurability is the root of all evil][fish-evil], and
after years of managing a complex zsh config I didn't understand half of,
that seems pretty remarkable to me.

[fish-evil]: http://fishshell.com/docs/current/design.html#conf

## Install

I am migrating the automated install of this to [bork][] and if you'd like
to see the Borkfiles they're in the `install` directory.  Eventually there
will be a compiled borkfile when I get around to writing that feature of
Bork, and then a copy-pastable command to install everything at once.

[bork]: https://github.com/mattly/bork
