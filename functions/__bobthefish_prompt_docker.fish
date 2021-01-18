function __bobthefish_prompt_docker -S -d 'Display Docker machine name'
    [ "$theme_display_docker_machine" = 'no' -o -z "$DOCKER_MACHINE_NAME" ]
    and return

    __bobthefish_start_segment $color_vagrant
    echo -ns $DOCKER_MACHINE_NAME ' '
end
