function __bobthefish_k8s_context -S -d 'Get the current k8s context'
    set -l config_paths "$HOME/.kube/config"
    [ -n "$KUBECONFIG" ]
    and set config_paths (string split ':' "$KUBECONFIG") $config_paths

    for file in $config_paths
        [ -f "$file" ]
        or continue

        while read -l key val
            if [ "$key" = 'current-context:' ]
                set -l context (string trim -c '"\' ' -- $val)
                [ -z "$context" ]
                and return 1

                echo $context
                return
            end
        end <$file
    end

    return 1
end
