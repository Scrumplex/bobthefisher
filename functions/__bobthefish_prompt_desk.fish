function __bobthefish_prompt_desk -S -d 'Display current desk environment'
    [ "$theme_display_desk" = 'no' -o -z "$DESK_ENV" ]
    and return

    __bobthefish_start_segment $color_desk
    echo -ns $desk_glyph ' ' (basename  -a -s ".fish" "$DESK_ENV") ' '
    set_color normal
end
