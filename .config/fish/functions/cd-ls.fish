function cd-ls
builtin cd $argv; and if test (ls -lh | wc -l) -lt 20; ls -lh; end
end
