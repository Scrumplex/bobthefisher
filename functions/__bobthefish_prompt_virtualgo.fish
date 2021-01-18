function __bobthefish_prompt_virtualgo -S -d 'Display current Go virtual environment'
    [ "$theme_display_virtualgo" = 'no' -o -z "$VIRTUALGO" ]
    and return

    __bobthefish_start_segment $color_virtualgo
    echo -ns $go_glyph ' ' (basename "$VIRTUALGO") ' '
    set_color normal
end
