function __bobthefish_k8s_namespace -S -d 'Get the current k8s namespace'
    kubectl config view --minify --output "jsonpath={..namespace}"
end
