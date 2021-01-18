function __bobthefish_prompt_vagrant_vmware -S -a id -d 'Display VMWare Vagrant status'
    set -l vagrant_status
    if [ (pgrep -f "$id") ]
        set vagrant_status "$vagrant_status$vagrant_running_glyph"
    else
        set vagrant_status "$vagrant_status$vagrant_poweroff_glyph"
    end

    [ -z "$vagrant_status" ]
    and return

    __bobthefish_start_segment $color_vagrant
    echo -ns $vagrant_status ' '
end
