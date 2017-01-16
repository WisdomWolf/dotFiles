function mkcdr --description 'Make directory then move into it'
	mkdir -p -v $argv
cd $argv
end
