# Defined in /tmp/fish.opVdU6/correct_dogs_fed.fish @ line 2
function correct_dogs_fed
	set date $argv[1]
if test -z "$MQTT_PASS"
    read -i -P "mqtt pass: " MQTT_PASS
end
mosquitto_pub -h mqtt.developingwisdom.org -t iot/sensors/dog-food -m "{\"last_fed\": \"$date\"}" -p 8883 --capath /etc/ssl/certs/ -u "wisdomwolf" -P $MQTT_PASS
end
