nmcli radio wifi on
sleep 2
nmcli device wifi rescan

login_page_url=https://net2.sharif.edu/login
ssids="ssids.txt"
username_password="username_password.txt"

if test -f $username_password; then
	username=$(awk '/username/ {split($1,a,"="); print a[2]}' $username_password)
	password=$(awk '/password/ {split($1,a,"="); print a[2]}' $username_password)
else
	echo "please first set your net2 username and password using init command"
	exit
fi

while read ssid; do
	nmcli device wifi connect $ssid
	connection=$(wget -q --spider --timeout=5 --tries=1 $login_page_url; echo $?)
	if [ $connection -eq 0 ]; then
		echo Successfully connected
		curl -Ls -d "username=$username&password=$password" -X POST $login_page_url
		break
	fi
	done < $ssids

#TODO: add a command to adding new ssid to wifi_ssids file
#TODO: add a command to initializing username_password.txt file
