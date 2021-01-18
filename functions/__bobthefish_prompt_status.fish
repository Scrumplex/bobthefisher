function __bobthefish_prompt_status -S -a last_status -d 'Display flags for a non-zero exit status, private mode, root user, and background jobs'
    set -l nonzero
    set -l superuser
    set -l bg_jobs

    # Last exit was nonzero
    [ $last_status -ne 0 ]
    and set nonzero 1

    # If superuser (uid == 0)
    #
    # Note that iff the current user is root and '/' is not writeable by root this
    # will be wrong. But I can't think of a single reason that would happen, and
    # it is literally 99.5% faster to check it this way, so that's a tradeoff I'm
    # willing to make.
    [ -w / -o -w /private/ ]
    and [ (id -u) -eq 0 ]
    and set superuser 1

    # Jobs display
    if set -q AUTOJUMP_SOURCED
        # Autojump special case: check if there are jobs besides the `autojump`
        # job, since that one is (briefly) backgrounded every time we `cd`
        set bg_jobs (jobs -c | string match -v --regex '(Command|autojump)' | wc -l)
        [ "$bg_jobs" -eq 0 ]
        and set bg_jobs # clear it out so it doesn't show when `0`
    else
        if [ "$theme_display_jobs_verbose" = 'yes' ]
            set bg_jobs (jobs -p | wc -l)
            [ "$bg_jobs" -eq 0 ]
            and set bg_jobs # clear it out so it doesn't show when `0`
        else
            # `jobs -p` is faster if we redirect to /dev/null, because it exits
            # after the first match. We'll use that unless the user wants to
            # display the actual job count
            jobs -p >/dev/null
            and set bg_jobs 1
        end
    end

    if [ "$nonzero" -o "$fish_private_mode" -o "$superuser" -o "$bg_jobs" ]
        __bobthefish_start_segment $color_initial_segment_exit
        if [ "$nonzero" ]
            set_color normal
            set_color -b $color_initial_segment_exit
            if [ "$theme_show_exit_status" = 'yes' ]
                echo -ns $last_status ' '
            else
                echo -n $nonzero_exit_glyph
            end
        end

        if [ "$fish_private_mode" ]
            set_color normal
            set_color -b $color_initial_segment_private
            echo -n $private_glyph
        end

        if [ "$superuser" ]
            set_color normal
            if [ -z "$FAKEROOTKEY" ]
                set_color -b $color_initial_segment_su
            else
                set_color -b $color_initial_segment_exit
            end

            echo -n $superuser_glyph
        end

        if [ "$bg_jobs" ]
            set_color normal
            set_color -b $color_initial_segment_jobs
            if [ "$theme_display_jobs_verbose" = 'yes' ]
                echo -ns $bg_job_glyph $bg_jobs ' '
            else
                echo -n $bg_job_glyph
            end
        end
    end
end
