# Defined in - @ line 2
function ld --description 'list directories only'
	ls -d */ | sed 's|/||2' | column
end
