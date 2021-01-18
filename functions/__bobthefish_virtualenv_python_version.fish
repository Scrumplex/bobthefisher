function __bobthefish_virtualenv_python_version -S -d 'Get current Python version'
    switch (python --version 2>&1 | tr '\n' ' ')
        case 'Python 2*PyPy*'
            echo $pypy_glyph
        case 'Python 3*PyPy*'
            echo -s $pypy_glyph $superscript_glyph[3]
        case 'Python 2*'
            echo $superscript_glyph[2]
        case 'Python 3*'
            echo $superscript_glyph[3]
    end
end
