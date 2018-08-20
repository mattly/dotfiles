# These are my dotfiles

## doom.d

I had a highly-tweaked vim config for many years. Then I started working in a
non-scripting language, and I gave [spacemacs][] a try, and ended up using that
for quite a while. Unfortunately its development pace hasn't scaled well with
the project's popularity, and I tried [Atom][] for a while. I like it, but Atom
has some rather problematic core bugs that make it unusable on my employer's
network, so I'm back to Emacs. This time around, I decided to give Henrik
Lissner's [doom-emacs][] a try, and quite like it. My private module is here.

[spacemacs]: https://github.com/syl20bnr/spacemacs/
[magit]: http://magit.vc/
[atom]: https://atom.io
[doom-emacs]: https://github.com/hlissner/doom-emacs

## fish

After years of using zsh with a cargo-culted configuration, I gave up on it and
switched to the [Friendly Interactive Shell][fish], aka **fish**. It has a
simplified scripting language, has sane defaults, and straightforward
auto-complete features. There's not much to see in the config file, because
[fish doesn't believe in configurability][fish-evil].  I'm using [oh my fish][] to
manage most of the config.

[fish]: http://fishshell.com/
[fish-evil]: http://fishshell.com/docs/current/design.html#conf
[oh my fish]: https://github.com/oh-my-fish/oh-my-fish

## gitconfig

Before I started using Magit, I got to know the git command line pretty well,
and got really into creating custom aliases. Here are a few:

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



## Install

- on mac: `bash -c "$(curl -fsSL https://github.com/mattly/dotfiles/blob/master/install/mac_bootstrap)"`

  This gets you homebrew, a pub key to put on GitHub, git, this repository
  cloned, the config files symlinked, .emacs.d, and fish as the default shell.

  From there, `brew bundle` the desired files in `install/`
