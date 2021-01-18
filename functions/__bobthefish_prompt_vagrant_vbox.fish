function __bobthefish_prompt_vagrant_vbox -S -a id -d 'Display VirtualBox Vagrant status'
    set -l vagrant_status
    set -l vm_status (VBoxManage showvminfo --machinereadable $id 2>/dev/null | command grep 'VMState=' | tr -d '"' | cut -d '=' -f 2)

    switch "$vm_status"
        case 'running'
            set vagrant_status "$vagrant_status$vagrant_running_glyph"
        case 'poweroff'
            set vagrant_status "$vagrant_status$vagrant_poweroff_glyph"
        case 'aborted'
            set vagrant_status "$vagrant_status$vagrant_aborted_glyph"
        case 'saved'
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
