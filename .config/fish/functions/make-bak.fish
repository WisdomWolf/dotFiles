function make-bak --description 'Backup file(s) by appending .bak to name'
	for arg in $argv
mv $arg{,.bak}
end
end
