function is-hibernate-configured
if test -L /usr/lib/systemd/system/systemd-suspend.service
echo "symlink in place"
else
echo "system won't hibernate. Run `link-hibernate-service` to fix"
end
end
