function fish_prompt -d "Write out the prompt"
  set -l exit_status $status

  printf "\n"

  set_color cyan
  printf '(@ '
  set_color green
  printf (hostname | cut -d . -f 1)
  printf ' '
  printf (whoami)
  printf ' '
  set_color normal
  printf (prompt_pwd)
  set_color cyan
  printf ')'

  set -l git_in_worktree (git rev-parse --is-inside-work-tree ^/dev/null)
  if test $status -eq 0
    set_color cyan
    printf '\n(± '

    set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
    if test -n $branch
      set_color normal
      printf "$branch"
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

    # set -l remote_name (git config branch.$branch.remote)

    # set -l merge_name ""
    # if test -n $remote_name
    #   set merge_name_long (git config branch.$branch.merge)
    #   set merge_name (echo $merge_name_long | cut -c 12-)
    # else
    #   set remote_name "origin"
    #   set merge_name_long "refs/heads/$branch"
    #   set merge_name $branch
    # end
    # if [ $remote_name = '.' ]
    #   set remote_ref $merge_name
    # else
    #   set remote_ref "refs/remotes/$remote_name/$merge_name"
    # end
    # set -l rev_git (eval "git rev-list --left-right $remote_ref...HEAD" ^/dev/null)
    # if test $status != "0"
    #   set rev_git (eval "git rev-list --left-right $merge_name...HEAD" ^/dev/null)
    # end
    # for i in $rev_git
    #   if echo $i | grep '>' >/dev/null
    #     set isAhead $isAhead ">"
    #   end
    # end
    # set -l remote_diff (count $rev_git)
    # set -l ahead (count $isAhead)
    # set -l behind (math $remote_diff - $ahead)
    # if [ (math $ahead + $behind) != 0 ]
    #   set_color cyan
    #   printf " {"

    #   if test $ahead -gt 0
    #     set_color -o purple
    #     printf "▶︎ "
    #     set_color normal
    #     printf $ahead
    #   end

    #   if test $behind -gt 0
    #     if test $ahead -gt 0; printf " "; end
    #     set_color -o blue
    #     printf "◀︎ "
    #     set_color normal
    #     printf $behind
    #   end

    #   set_color cyan
    #   printf "}"
    # end

    set -l changedFiles (git diff --name-status | cut -c 1-2)
    set -l stagedFiles (git diff --staged --name-status | cut -c 1-2)
    set -l changed (math (count $changedFiles) - (count (echo $changedFiles | grep "U")))
    set -l conflicted (count (echo $stagedFiles | grep "U"))
    set -l staged (math (count $stagedFiles) - $conflicted)
    set -l untracked (count (git ls-files --others --exclude-standard))

    if [ (math $changed + $conflicted + $staged + $untracked) != 0 ]
      set_color cyan
      printf " {"

      set -l join 0
      if test $staged -gt 0
        set join 1
        set_color green
        printf "✭ "
        set_color normal
        printf $staged
      end

      if test $conflicted -gt 0
        if test $join -gt 0; printf " "; end
        set join 1
        set_color -o red
        printf '✕ '
        set_color normal
        printf $conflicted
      end

      if test $changed -gt 0
        if test $join -gt 0; printf " "; end
        set join 1
        set_color -o purple
        printf "✱ "
        set_color normal
        printf $changed
      end

      if test $untracked -gt 0
        if test $join -gt 0; printf " "; end
        set_color -o yellow
        printf "⦰ "
        set_color normal
        printf $untracked
      end

      set_color cyan
      printf "}"
    end

    set_color cyan
    printf ')'
  end

  #     switch (echo $git_status[2] | awk ' { print $4 } ')
  #       case 'ahead'
  #         set -l number (echo $git_status[2] | awk ' { print $8 } ')
  #         set_color -o yellow
  #         printf "▲"
  #         set_color normal
  #         printf " $number"
  #       case 'diverged'
  #         set_color -o purple
  #         printf "✱"
  #       case 'behind'
  #         set_color -o green
  #         printf "▼"
  #       case 'up-to-date'
  #         # noop, probably dirty
  #       case '*'
  #         printf ':%s:' (echo $git_status[2] | awk ' { print $4 } ' )
  #     end

  if test $exit_status -gt 0
    set_color cyan
    printf ' (✕ '
    set_color -o red
    printf $exit_status
    set_color normal # resets the -o brightness
    set_color cyan
    printf ')'
  end

  printf '%s ' (set_color normal)
end

