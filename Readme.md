# These are my dotfiles

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


# Using the Magic Trackpad in Windows

https://www.labnol.org/software/apple-magic-trackpad-with-windows/14158/

1. Download [this patch](https://support.apple.com/kb/DL979?locale=en_US) from the Apple website but don’t run it yet. It’s an executable file but it won’t run on your Windows Desktop since it is intended only for users who are running Windows inside a Mac desktop using Boot Camp.

2. Download a copy of 7-zip and extract the contents of the exe file that you’ve downloaded in the previous step

3. This will create a new file called “BootCampUpdate32.msp” – extract the contents of this file as well using 7-zip again.

4. You’ll now have several sub-folders that are named like BootCamp3135*. One of these folders will have a file called “Binary.AppleWirelessTrackpad_Bin” – just add a .exe extension to this file and then double-click to run it.

This will install the Apple Wireless Trackpad driver on your Windows machine without requiring Boot Camp and you should now be able to pair the Magic Trackpad with the PC.

The Trackpad device driver is available for Windows XP, Vista and Windows 7 computers. As some readers pointed out, the same approach can be used to get your Magic Mouse work with Windows.