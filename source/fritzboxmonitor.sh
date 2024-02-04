#!/bin/sh
# Expected environment variables: $FRITZBOX_IP, $FRITZBOX_USER, $FRITZBOX_PASSWORD

echo "Querying api.ipify.org for public IP address."
WebRequest=$(curl -m 10 -s "https://api.ipify.org")

IpRegex='([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])'
if [[ $WebRequest =~ $IpRegex ]]; then
	echo "Received valid IP '$WebRequest', internet appears to be working correctly."
	exit 0
else
	echo "Received invalid IP '$WebRequest', FritzBox may have lost internet!"
	echo "Rebooting FritzBox '$FRITZBOX_IP' with user '$FRITZBOX_USER'."
	location="/upnp/control/deviceconfig"
	uri="urn:dslforum-org:service:DeviceConfig:1"
	action='Reboot'
	curl -sS -k -m 5 --anyauth -u "$FRITZBOX_USER:$FRITZBOX_PASSWORD" http://$FRITZBOX_IP:49000$location -H 'Content-Type: text/xml; charset="utf-8"' -H "SoapAction:$uri#$action" -d "<?xml version='1.0' encoding='utf-8'?><s:Envelope s:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/' xmlns:s='http://schemas.xmlsoap.org/soap/envelope/'><s:Body><u:$action xmlns:u='$uri'></u:$action></s:Body></s:Envelope>"
fi