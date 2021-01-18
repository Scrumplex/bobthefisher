function __bobthefish_prompt_vagrant -S -d 'Display Vagrant status'
    [ "$theme_display_vagrant" = 'yes' -a -f Vagrantfile ]
    or return

    # .vagrant/machines/$machine/$provider/id
    for file in .vagrant/machines/*/*/id
        read -l id <"$file"

        if [ -n "$id" ]
            switch "$file"
                case '*/virtualbox/id'
                    __bobthefish_prompt_vagrant_vbox $id
                case '*/vmware_fusion/id'
                    __bobthefish_prompt_vagrant_vmware $id
                case '*/parallels/id'
                    __bobthefish_prompt_vagrant_parallels $id
            end
        end
    end
end
