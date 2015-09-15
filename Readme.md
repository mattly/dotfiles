I used to have some really details configs for vim and zsh. Then I started
using [fish][], [spacemacs][] and [magit][] and really don't have a very customized
environment anymore. And I'm happier with this.  So, find what thou wilt.

[spacemacs]: https://github.com/syl20bnr/spacemacs/
[fish]: http://fishshell.com/
[magit]: http://magit.vc/

## Items of Interest

### spacemacs

The beauty of my dot-spacemacs file isn't anything in the file, rather what's
not in the file and rather is a part of [spacemacs][] itself, through the power
of spacemacs's config-layer system.

### fish

After years of using zsh with a cargo-culted configuration, I gave up on it and
switched to the [Friendly Interactive Shell][fish], aka **fish**. It has a
simplified scripting language, has sane defaults, and straightforward
auto-complete features. There's not much to see in the config file, because
[fish doesn't believe in configurability][fish-evil].

[fish-evil]: http://fishshell.com/docs/current/design.html#conf

### gitconfig

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

I am in the process of migrating the automated install of this to [bork][] and their configurations are in the install directory. Eventually there will be a compiled borkfile when I get around to writing that feature of Bork, and then a command to copy & paste and run, letting the computer work while you get coffee.

[bork]: https://github.com/mattly/bork
