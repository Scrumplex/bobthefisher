function __bobthefish_hg_project_dir -S -a real_pwd -d 'Print the current hg project base directory'
    [ "$theme_display_hg" = 'yes' ]
    or return

    set -q theme_vcs_ignore_paths
    and [ (__bobthefish_ignore_vcs_dir $real_pwd) ]
    and return

    set -l d $real_pwd
    while not [ -z "$d" ]
        if [ -e $d/.hg ]
            command hg root --cwd "$d" 2>/dev/null
            return
        end

        [ "$d" = '/' ]
        and return

        set d (dirname $d)
    end
end
