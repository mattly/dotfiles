Don't fork anyone's dotfiles.  Curate your own. 

Document your settings, what they do and why you chose them, and help
others learn how they can work better.  When you copy someone else's
preferences without taking the time to understand the reasoning behind
them, you're practicing [cargo cult programming][cargo] and worse, being
lazy.  This practice might help in the short term, but if you want to
master your tools, you need to understand how they work and the reasoning
behind the usage patterns you chose.

[cargo]: https://en.wikipedia.org/wiki/Cargo_cult_programming

## Items of Interest

### vimrc

I spend a lot of time in vim.  I now do most of my writing in it in
addition to code.  When I started using vim, I used the macvim GUI
version, and I wanted to emulate Textmate.  These days, I use it in the
terminal under tmux and prefer the vim way of doing things.  The plugin
selection and custom mappings changed to accommodate these uses.

The mappings, for example, shifted away from chording, the cursor keys, or
anything using CMD or OPT in preference for home-row or leader mappings.

I manage the plugins with a utility I wrote, [bork][].  The file
`install/vim.sh` lists the plugins.

The main `vimrc` file sources each file in `vim/settings` which includes
any custom functions, mappings, et cetera.

For writing, I use a fish function *vimstar* that loads a separate
config file to set certain options.

Note that to use vim in tmux with clipboard support for OS X you need:

    brew install reattach-to-user-name --wrap-pbpaste-and-pbcopy

This will allow you to use the "system clipboard" from vim and other
programs under tmux. You then need a vim with clipboard support, which OS
X's vim doesn't ship with:

    brew install https://raw.github.com/Homebrew/homebrew-dupes/master/vim.rb

### gitconfig

I like to create new git commands to semantically map to common 
operations.  Some of them, in detail:

- **`amend`**: `commit --amend` after an accidental `commit -amend` and
  instead of `--amend` that took an hour to undo, I started this list.
- **`addp`**: `add --patch`
- **`axe <term>`**: `log -S<term>` searches your git history for *term*
- **`cleanup`**: removes all local branches merged into HEAD
- **`cleanup-remotes`**: removes all remote branches merged into HEAD.
- **`delete <remotename> <branchname>`**: Deletes *branch* from *remote*
- **`fold`**:`merge --no-ff` takes some branches and merges them in,
  keeping their full branch and commit history.
- **`goto <refspec>`**: `reset --hard <refspec>` hard resets to the given
  refspec
- **`label`**: `tag -a` creates an annotated tag, for versioning or such
- **`staged`**: `diff --cached` displays the contents of the index
- **`tag-release`**: Creates an unannotated tag named
  `release/YYYY/MM/DD/HHMM`.  Preferably, your build tools do this
  instead.
- **`track <remote refspec>`**: `checkout -t <remote refspec>` checks out
  a remote branch as a local branch and sets tracking.
- **`undo`**: `reset --soft HEAD^` Revert a commit, but leave its contents
  as staged.
- **`unstage <path>`**: `reset HEAD -- <path>` removes `path` from the
  index
- **`update-remotes`**: `remote update --prune` for each remote, fetches
  and prunes.

### fish

After years of using zsh with a cargo-culted configuration, I gave up on
it and switched to the Friendly Interactive Shell, aka **fish**.  It has
a simplified scripting language, has sane defaults, and straightforward
auto-complete features.  There's not much to see in the config file,
because [fish doesn't believe in configurability][fish-evil].

[fish-evil]: http://fishshell.com/docs/current/design.html#conf

## Install

I am in the process of  migrating the automated install of this to
[bork][] and their configurations are in the install directory.
Eventually there will be a compiled borkfile when I get around to writing
that feature of Bork, and then a command to copy & paste and run, letting
the computer work while you get coffee.

[bork]: https://github.com/mattly/bork

