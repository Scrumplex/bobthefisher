function __bobthefish_pretty_parent -S -a child_dir -d 'Print a parent directory, shortened to fit the prompt'
    set -q fish_prompt_pwd_dir_length
    or set -l fish_prompt_pwd_dir_length 1

    # Replace $HOME with ~
    set -l real_home ~
    set -l parent_dir (string replace -r '^'(string escape --style=regex "$real_home")'($|/)' '~$1' (dirname $child_dir))

    if [ -z "$parent_dir" ]
        echo -n /
        return
    end

    # Must check whether `$parent_dir = /` if using native dirname
    if [ "$parent_dir" = "/" ]
        set -le parent_dir
    end

    if [ $fish_prompt_pwd_dir_length -eq 0 ]
        echo -n "$parent_dir/"
        return
    end

    string replace -ar '(\.?[^/]{'"$fish_prompt_pwd_dir_length"'})[^/]*/' '$1/' "$parent_dir/"
end
