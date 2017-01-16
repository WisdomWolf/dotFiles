function myip --description 'Get external IP'
	set -l myip=(elinks -dump http://checkip.dyndns.org:8245/)
echo "$myip"
end
