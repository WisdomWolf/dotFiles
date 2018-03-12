# Defined in - @ line 2
function ld --description 'list directories only'
	if count $argv >0
        set dirs $argv
    else
        set dirs */
    end
    unbuffer ls -d $dirs --color=auto
end
