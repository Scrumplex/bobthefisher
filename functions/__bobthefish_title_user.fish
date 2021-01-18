function __bobthefish_title_user -S -d 'Display actual user if different from $default_user'
    if [ "$theme_title_display_user" = 'yes' ]
        if [ "$USER" != "$default_user" -o -n "$SSH_CLIENT" ]
            set -l IFS .
            hostname | read -l hostname __
            echo -ns (whoami) '@' $hostname ' '
        end
    end
end
