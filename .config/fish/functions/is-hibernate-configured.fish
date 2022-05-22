function is-hibernate-configured
if test -L /usr/lib/systemd/system/systemd-suspend.service
echo "symlink in place"
else
echo "system won't hibernate"
end
end
