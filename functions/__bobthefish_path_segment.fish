function __bobthefish_path_segment -S -a segment_dir -d 'Display a shortened form of a directory'
    set -l segment_color $color_path
    set -l segment_basename_color $color_path_basename

    if not [ -w "$segment_dir" ]
        set segment_color $color_path_nowrite
        set segment_basename_color $color_path_nowrite_basename
    end

    __bobthefish_start_segment $segment_color

    set -l directory
    set -l parent

    switch "$segment_dir"
        case /
            set directory '/'
        case "$HOME"
            set directory '~'
        case '*'
            set parent (__bobthefish_pretty_parent "$segment_dir")
            set directory (basename "$segment_dir")
    end

    echo -n $parent
    set_color -b $segment_basename_color
    echo -ns $directory ' '
end
