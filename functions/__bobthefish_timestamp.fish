function __bobthefish_timestamp -S -d 'Show the current timestamp'
    [ "$theme_display_date" = "no" ]
    and return

    set -q theme_date_format
    or set -l theme_date_format "+%c"

    echo -n ' '
    set -q theme_date_timezone
        and env TZ="$theme_date_timezone" date $theme_date_format
        or date $theme_date_format
end
