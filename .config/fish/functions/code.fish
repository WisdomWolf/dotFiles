# Defined in /tmp/fish.AGphYl/code.fish @ line 2
function code
    if test (command -s code-oss)
        code-oss $argv
    else if test (command -s code)
        command code $argv
    else
        echo "Code doesn't appear to be installed"
    end
end
