function __bobthefish_prompt_k8s_context -S -d 'Show current Kubernetes context'
    [ "$theme_display_k8s_context" = 'yes' ]
    or return

    set -l context (__bobthefish_k8s_context)
    or return

    [ "$theme_display_k8s_namespace" = 'yes' ]
    and set -l namespace (__bobthefish_k8s_namespace)

    [ -z $context -o "$context" = 'default' ]
    and [ -z $namespace -o "$namespace" = 'default' ]
    and return

    set -l segment $k8s_glyph " " $context
    [ -n "$namespace" ]
    and set segment $segment ":" $namespace

    __bobthefish_start_segment $color_k8s
    echo -ns $segment " "
end
