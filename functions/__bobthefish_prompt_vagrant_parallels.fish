function __bobthefish_prompt_vagrant_parallels -S -d 'Display Parallels Vagrant status'
    set -l vagrant_status
    set -l vm_status (prlctl list $id -o status 2>/dev/null | command tail -1)

    switch "$vm_status"
        case 'running'
            set vagrant_status "$vagrant_status$vagrant_running_glyph"
        case 'stopped'
            set vagrant_status "$vagrant_status$vagrant_poweroff_glyph"
        case 'paused'
            set vagrant_status "$vagrant_status$vagrant_saved_glyph"
        case 'suspended'
            set vagrant_status "$vagrant_status$vagrant_saved_glyph"
        case 'stopping'
            set vagrant_status "$vagrant_status$vagrant_stopping_glyph"
        case ''
            set vagrant_status "$vagrant_status$vagrant_unknown_glyph"
    end

    [ -z "$vagrant_status" ]
    and return

    __bobthefish_start_segment $color_vagrant
    echo -ns $vagrant_status ' '
end
