function docker-create-web
	for x in $argv[3..-3]
set volumes $volumes "-v $x"
end
docker create --name $argv[1] \
-e "VIRTUAL_HOST=$argv[2]" \
-e "LETSENCRYPT_HOST=$argv[2]" \
-e "LETSENCRYPT_EMAIL=wisdomwolf@gmail.com" \
$volumes \
--restart=$argv[-2] \
$argv[-1]
end
