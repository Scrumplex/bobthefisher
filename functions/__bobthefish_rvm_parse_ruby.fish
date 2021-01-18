function __bobthefish_rvm_parse_ruby -S -a ruby_string -a scope -d 'Parse RVM Ruby string'
    # Function arguments:
    # - 'ruby-2.2.3@rails', 'jruby-1.7.19'...
    # - 'default' or 'current'
    set -l IFS @
    echo "$ruby_string" | read __ruby __rvm_{$scope}_ruby_gemset __
    set IFS -
    echo "$__ruby" | read __rvm_{$scope}_ruby_interpreter __rvm_{$scope}_ruby_version __
    set -e __ruby
    set -e __
end
