function __bobthefish_git_branch -S -d 'Get the current git branch (or commitish)'
    set -l branch (command git symbolic-ref HEAD 2>/dev/null | string replace -r '^refs/heads/' '')
    and begin
        [ -n "$theme_git_default_branches" ]
        or set -l theme_git_default_branches master main

        [ "$theme_display_git_master_branch" != 'yes' -a "$theme_display_git_default_branch" != 'yes' ]
        and contains $branch $theme_git_default_branches
        and echo $branch_glyph
        and return

        # truncate the middle of the branch name, but only if it's 25+ characters
        set -l truncname $branch
        [ "$theme_use_abbreviated_branch_name" = 'yes' ]
        and set truncname (string replace -r '^(.{17}).{3,}(.{5})$' "\$1…\$2" $branch)

        echo $branch_glyph $truncname
        and return
    end

    set -l tag (command git describe --tags --exact-match 2>/dev/null)
    and echo "$tag_glyph $tag"
    and return

    set -l branch (command git show-ref --head -s --abbrev | head -n1 2>/dev/null)
    echo "$detached_glyph $branch"
end
