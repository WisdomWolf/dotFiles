function dir_colors
	eval (dircolors -c $argv[1] | sed 's/>&\/dev\/null$//')
end
