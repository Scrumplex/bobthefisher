function __bobthefish_pwd -d 'Get a normalized $PWD'
    builtin pwd -P 2>/dev/null
end
