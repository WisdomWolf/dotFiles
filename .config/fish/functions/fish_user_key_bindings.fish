function fish_user_key_bindings
    ### sudope ###
    set -q sudope_sequence
    or set -l sudope_sequence \cs
    test (bind | grep -q '[[:space:]]sudope$')
    or set -l do_bind
    if test (bind $sudope_sequence ^/dev/null)
        echo "sudope: The requested sequence is already in use:" (bind $sudope_sequence | cut -d' ' -f2-)
    else if set -q do_bind
        bind $sudope_sequence sudope
    end
    ### sudope ###
end
