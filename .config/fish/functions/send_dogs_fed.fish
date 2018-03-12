function send_dogs_fed
	if test -z "$MQTT_PASS"
read -i -P "mqtt pass: " MQTT_PASS
end
mosquitto_pub -h developingwisdom.org -t dog-monitor/dog-food -m "Open" -u "wisdomwolf" -P $MQTT_PASS
end
