function __bobthefish_prompt_aws_vault_profile -S -d 'Show AWS Vault profile'
    [ "$theme_display_aws_vault_profile" = 'yes' ]
    or return

    [ -n "$AWS_VAULT" -a -n "$AWS_SESSION_EXPIRATION" ]
    or return

    set -l profile $AWS_VAULT

    set -l now (date --utc +%s)
    set -l expiry (date -d "$AWS_SESSION_EXPIRATION" +%s)
    set -l diff_mins (math "floor(( $expiry - $now ) / 60)")

    set -l diff_time $diff_mins"m"
    [ $diff_mins -le 0 ]
    and set -l diff_time "0m"
    [ $diff_mins -ge 60 ]
    and set -l diff_time (math "floor($diff_mins / 60)")"h"(math "$diff_mins % 60")"m"

    set -l segment $profile " (" $diff_time ")"
    set -l status_color $color_aws_vault
    [ $diff_mins -le 0 ]
    and set -l status_color $color_aws_vault_expired

    __bobthefish_start_segment $status_color
    echo -ns $segment " "
end
