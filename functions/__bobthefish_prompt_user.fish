function __bobthefish_prompt_user -S -d 'Display current user and hostname'
    [ "$theme_display_user" = 'yes' -o \( "$theme_display_user" != 'no' -a -n "$SSH_CLIENT" \) -o \( -n "$default_user" -a "$USER" != "$default_user" \) ]
    and set -l display_user

    [ "$theme_display_sudo_user" = 'yes' -a -n "$SUDO_USER" ]
    and set -l display_sudo_user

    [ "$theme_display_hostname" = 'yes' -o \( "$theme_display_hostname" != 'no' -a -n "$SSH_CLIENT" \) ]
    and set -l display_hostname

    if set -q display_user
        __bobthefish_start_segment $color_username
        echo -ns (whoami)
    end

    if set -q display_sudo_user
        if set -q display_user
            echo -ns ' '
        else
            __bobthefish_start_segment $color_username
        end
        echo -ns "($SUDO_USER)"
    end

    if set -q display_hostname
        if set -q display_user
            or set -q display_sudo_user
            # reset colors without starting a new segment...
            # (so we can have a bold username and non-bold hostname)
            set_color normal
            set_color -b $color_hostname[1] $color_hostname[2..-1]
            echo -ns '@' (prompt_hostname)
        else
            __bobthefish_start_segment $color_hostname
            echo -ns (prompt_hostname)
        end
    end

    set -q display_user
    or set -q display_sudo_user
    or set -q display_hostname
    and echo -ns ' '
end
