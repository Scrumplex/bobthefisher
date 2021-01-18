function __bobthefish_prompt_virtualfish -S -d "Display current Python virtual environment (only for virtualfish, virtualenv's activate.fish changes prompt by itself) or conda environment."
    [ "$theme_display_virtualenv" = 'no' -o -z "$VIRTUAL_ENV" -a -z "$CONDA_DEFAULT_ENV" ]
    and return

    set -l version_glyph (__bobthefish_virtualenv_python_version)

    if [ "$version_glyph" ]
        __bobthefish_start_segment $color_virtualfish
        echo -ns $virtualenv_glyph $version_glyph ' '
    end

    if [ "$VIRTUAL_ENV" ]
        echo -ns (basename "$VIRTUAL_ENV") ' '
    else if [ "$CONDA_DEFAULT_ENV" ]
        echo -ns (basename "$CONDA_DEFAULT_ENV") ' '
    end
end
