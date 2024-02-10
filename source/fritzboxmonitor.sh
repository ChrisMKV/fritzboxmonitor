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

	#Submit reboot to Fritzbox API
 	curl http://$FRITZBOX_IP:49000/upnp/control/deviceconfig \
 	  --silent \
 	  --show-error \
 	  --max-time 5 \
 	  --anyauth \
 	  --insecure \
 	  --user "$FRITZBOX_USER:$FRITZBOX_PASSWORD" \
 	  --header 'Content-Type: text/xml; charset="utf-8"' \
 	  --header "SoapAction:urn:dslforum-org:service:DeviceConfig:1#Reboot" \
 	  --data "<?xml version='1.0' encoding='utf-8'?><s:Envelope s:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/' xmlns:s='http://schemas.xmlsoap.org/soap/envelope/'><s:Body><u:'Reboot' xmlns:u='urn:dslforum-org:service:DeviceConfig:1'></u:'Reboot'></s:Body></s:Envelope>"

fi