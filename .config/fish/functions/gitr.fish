function gitr --description 'git commit with random message'
	set message (eval whatthecommit)
    gitc "$message --whatthecommit"
end
