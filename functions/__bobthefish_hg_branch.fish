function __bobthefish_hg_branch -S -d 'Get the current hg branch'
    set -l branch (command hg branch 2>/dev/null)
    set -l book (command hg book | command grep \* | cut -d\  -f3)
    echo "$branch_glyph $branch @ $book"
end
