function bak-restore --description 'Restore backup made with make-bak'
	for arg in $argv
mv $arg{.bak,}
end
end
