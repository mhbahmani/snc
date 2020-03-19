nmcli radio wifi on
sleep 2
nmcli device wifi rescan

login_page_url=https://net2.sharif.edu/login
ssids="ssids.txt"

while read ssid; do
	nmcli device wifi connect $ssid
	connection=$(wget -q --spider --timeout=5 --tries=1 $login_page_url; echo $?)
	if [ $connection -eq 0 ]
	then
		echo Successfully connected
		curl -Ls -d "username=username&password=password" -X POST $login_page_url
		break
	fi
	done < $ssids

