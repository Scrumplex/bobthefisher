function __bobthefish_prompt_hg -S -a hg_root_dir -a real_pwd -d 'Display the actual hg state'
    set -l dirty (command hg stat; or echo -n '*')

    set -l flags "$dirty"
    [ "$flags" ]
    and set flags ""

    set -l flag_colors $color_repo
    if [ "$dirty" ]
        set flag_colors $color_repo_dirty
    end

    __bobthefish_path_segment $hg_root_dir

    __bobthefish_start_segment $flag_colors
    echo -ns $hg_glyph ' '

    __bobthefish_start_segment $flag_colors
    echo -ns (__bobthefish_hg_branch) $flags ' '
    set_color normal

    set -l project_pwd (__bobthefish_project_pwd $hg_root_dir $real_pwd)
    if [ "$project_pwd" ]
        if [ -w "$real_pwd" ]
            __bobthefish_start_segment $color_path
        else
            __bobthefish_start_segment $color_path_nowrite
        end

        echo -ns $project_pwd ' '
    end
end
