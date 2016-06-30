function fish_prompt -d "Write out the prompt"
  set -l exit_status $status

  set_color cyan
  printf "\n✕ "
  if test $exit_status -gt 0
    set_color -o red
  else
    set_color -o green
  end
  printf $exit_status
  set_color normal # resets the -o brightness

  set_color cyan
  printf "\n☀︎ "
  set_color normal
  printf (date +"%T")

  set_color cyan
  printf "\n@ "
  set_color green
  printf (hostname | cut -d . -f 1)
  printf ' '
  printf (whoami)
  printf ' '
  set_color normal
  printf (prompt_pwd)

  set -l git_in_worktree (git rev-parse --is-inside-work-tree ^/dev/null)
  if test $status -eq 0
    set_color cyan
    printf '\n± '

    set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
    set -l rebasing (echo $branch | grep 'no branch')
    if test $status -gt 0
      set -l detached (echo $branch | grep 'detached')
      if test $status -eq 0
        set_color -o red
        printf $branch
        set_color normal
      else
        set_color -o yellow
        printf $branch
        set_color normal

        set remote_name (git config "branch.$branch.remote")
        if test $status -eq 0 # -a -n $remote_name
          set merge_name_long (git config branch.$branch.merge)
          set merge_name (echo $merge_name_long | cut -c 12-)
        else
          set remote_name "origin"
          set merge_name_long "refs/heads/$branch"
          set merge_name $branch
        end
        if test $remote_name -eq "."
          set remote_ref $merge_name
        else
          set remote_ref "refs/remotes/$remote_name/$merge_name"
        end
        set -l rev_git (eval "git rev-list --left-right $remote_ref...HEAD" ^/dev/null)
        if test $status -ne 0
          set rev_git (eval "git rev-list --left-right $merge_name...HEAD" ^/dev/null)
        end
        for i in $rev_git
          if echo $i | grep '>' >/dev/null
            set isAhead $isAhead ">"
          end
        end
        set -l remote_diff (count $rev_git)
        set -l ahead (count $isAhead)
        set -l behind (math $remote_diff - $ahead)
        if [ (math $ahead + $behind) != 0 ]
          set_color cyan
          printf " ⟳ "
          set_color normal
          printf $remote_name
          set_color cyan

          if test $ahead -gt 0
            set_color -o purple
            printf " + "
            set_color normal
            printf $ahead
          end

          if test $behind -gt 0
            if test $ahead -gt 0; printf " "; end
            set_color -o blue
            printf " - "
            set_color normal
            printf $behind
          end
        end
      end
    else if test -n $branch
      set_color normal
      set -l rebase (echo $branch | sed 's/no branch, \(.*\)/\1/')
      printf $rebase
    else
      set -l rev (git rev-parse --short HEAD | cut -c 2-)
      set_color cyan
      printf '('
      set_color -o yellow
      printf 'no-branch '
      if test -n $rev
        set_color normal
        printf $rev
      end
      set_color cyan
      printf ')'
    end


    set -l changedFiles (git diff --name-status | cut -c 1-2)
    set -l stagedFiles (git diff --staged --name-status | cut -c 1-2)
    set -l changed (math (count $changedFiles) - (count (echo $changedFiles | grep "U")))
    set -l conflicted (count (echo $stagedFiles | grep "U"))
    set -l staged (math (count $stagedFiles) - $conflicted)
    set -l untracked (count (git ls-files --others --exclude-standard))

    if test $staged -gt 0
      set join 1
      set_color green
      printf "✭ "
      set_color normal
      printf $staged
    end

    if [ (math $staged + $conflicted) != 0 ]
      printf " "
    end

    if test $conflicted -gt 0
      if test $join -gt 0; printf " "; end
      set join 1
      set_color -o red
      printf '✕ '
      set_color normal
      printf $conflicted
    end

    if [ (math $conflicted + $changed) != 0 ]
      printf " "
    end

    if test $changed -gt 0
      if test $join -gt 0; printf " "; end
      set join 1
      set_color -o purple
      printf "✱ "
      set_color normal
      printf $changed
    end

    if [ (math $changed + $untracked) != 0 ]
      printf " "
    end

    if test $untracked -gt 0
      if test $join -gt 0; printf " "; end
      set_color -o yellow
      printf "⦰ "
      set_color normal
      printf $untracked
    end
  end


  set_color -o yellow
  printf "\nλ "
  set_color normal
  # printf '%s ' (set_color normal)
end

