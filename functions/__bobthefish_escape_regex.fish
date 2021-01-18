# Note that for fish < 3.0 this falls back to unescaped, rather than trying to do something clever /shrug
# After we drop support for older fishies, we can inline this without the fallback.
function __bobthefish_escape_regex -a str -d 'A backwards-compatible `string escape --style=regex` implementation'
    string escape --style=regex "$str" 2>/dev/null
    or echo "$str"
end
