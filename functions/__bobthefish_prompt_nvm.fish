function __bobthefish_prompt_nvm -S -d 'Display current node version through NVM'
    [ "$theme_display_nvm" = 'yes' -a -n "$NVM_DIR" ]
    or return

    set -l node_version (nvm current 2> /dev/null)

    [ -z $node_version -o "$node_version" = 'none' -o "$node_version" = 'system' ]
    and return

    __bobthefish_start_segment $color_nvm
    echo -ns $node_glyph $node_version ' '
    set_color normal
end
