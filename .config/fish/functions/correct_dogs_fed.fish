# Defined in /tmp/fish.nmnZ4g/correct_dogs_fed.fish @ line 2
function correct_dogs_fed
	if test (count $argv) -gt 0
        set date $argv[1]
    else
        echo 'setting date to default'
        set date (TZ='America/New_York' date "+%m/%d/%y %I:%M%p")
    end
    if test -z "$MQTT_PASS"
        read -i -P "mqtt pass: " MQTT_PASS
    end
    echo "correcting last fed to $date"
    mosquitto_pub -h mqtt.developingwisdom.org -t iot/sensors/dog-food -m "{\"last_fed\": \"$date\"}" -p 8883 --capath /etc/ssl/certs/ -u "wisdomwolf" -P $MQTT_PASS
end
