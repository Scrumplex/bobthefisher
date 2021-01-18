function __bobthefish_prompt_rubies -S -d 'Display current Ruby information'
    [ "$theme_display_ruby" = 'no' ]
    and return

    set -l ruby_version
    if type -fq rvm-prompt
        set ruby_version (__bobthefish_rvm_info)
    else if type -fq rbenv
        set ruby_version (rbenv version-name)
        # Don't show global ruby version...
        set -q RBENV_ROOT
        or set -l RBENV_ROOT $HOME/.rbenv

        [ -e "$RBENV_ROOT/version" ]
        and read -l global_ruby_version <"$RBENV_ROOT/version"

        [ "$global_ruby_version" ]
        or set -l global_ruby_version system

        [ "$ruby_version" = "$global_ruby_version" ]
        and return
    else if type -q chruby # chruby is implemented as a function, so omitting the -f is intentional
        set ruby_version $RUBY_VERSION
    else if type -fq asdf
        set -l asdf_current_ruby (asdf current ruby 2>/dev/null)
        or return

        echo "$asdf_current_ruby" | read -l asdf_ruby_version asdf_provenance

        # If asdf changes their ruby version provenance format, update this to match
        [ (string trim -- "$asdf_provenance") = "(set by $HOME/.tool-versions)" ]
        and return

        set ruby_version $asdf_ruby_version
    end

    [ -z "$ruby_version" ]
    and return

    __bobthefish_start_segment $color_rvm
    echo -ns $ruby_glyph $ruby_version ' '
end
