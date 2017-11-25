# Defined in - @ line 1
function get-dir-sizes
	du -d1 -h . 2>&1 | sed '/Permission denied/d;' | sort -hr
end
