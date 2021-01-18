# Requires jorgebucaran/humantime.fish

function __bobthefish_cmd_duration -S -d 'Show command duration'
    [ "$theme_display_cmd_duration" = "no" ]
    and return

    [ -z "$CMD_DURATION" -o "$CMD_DURATION" -lt 100 ]
    and return

    if [ "$CMD_DURATION" -ge 60000 ]
        set_color $fish_color_error
    end
    if not type -q humantime
        echo $CMD_DURATION "ms"
    else
        humantime $CMD_DURATION
    end

    set_color $fish_color_normal
    set_color $fish_color_autosuggestion

    [ "$theme_display_date" = "no" ]
    or echo -ns ' ' $__bobthefish_left_arrow_glyph
end
