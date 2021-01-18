function __bobthefish_rvm_info -S -d 'Current Ruby information from RVM'
    # look for rvm install path
    set -q rvm_path
    or set -l rvm_path ~/.rvm /usr/local/rvm

    # More `sed`/`grep`/`cut` magic...
    set -l __rvm_default_ruby (grep GEM_HOME $rvm_path/environments/default 2>/dev/null | sed -e"s/'//g" | sed -e's/.*\///')
    set -l __rvm_current_ruby (rvm-prompt i v g)

    [ "$__rvm_default_ruby" = "$__rvm_current_ruby" ]
    and return

    set -l __rvm_default_ruby_gemset
    set -l __rvm_default_ruby_interpreter
    set -l __rvm_default_ruby_version
    set -l __rvm_current_ruby_gemset
    set -l __rvm_current_ruby_interpreter
    set -l __rvm_current_ruby_version

    # Parse default and current Rubies to global variables
    __bobthefish_rvm_parse_ruby $__rvm_default_ruby default
    __bobthefish_rvm_parse_ruby $__rvm_current_ruby current
    # Show unobtrusive RVM prompt

    # If interpreter differs form default interpreter, show everything:
    if [ "$__rvm_default_ruby_interpreter" != "$__rvm_current_ruby_interpreter" ]
        if [ "$__rvm_current_ruby_gemset" = 'global' ]
            rvm-prompt i v
        else
            rvm-prompt i v g
        end
        # If version differs form default version
    else if [ "$__rvm_default_ruby_version" != "$__rvm_current_ruby_version" ]
        if [ "$__rvm_current_ruby_gemset" = 'global' ]
            rvm-prompt v
        else
            rvm-prompt v g
        end
        # If gemset differs form default or 'global' gemset, just show it
    else if [ "$__rvm_default_ruby_gemset" != "$__rvm_current_ruby_gemset" ]
        rvm-prompt g
    end
end
