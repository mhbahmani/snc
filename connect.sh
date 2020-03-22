login_page_url=https://net2.sharif.edu/login
ssids="ssids.txt"
username_password="username_password.txt"

if test -z $1; then

	nmcli radio wifi on
	sleep 2
	nmcli device wifi rescan

	if test -f $username_password; then
		username=$(awk '/username/ {split($1,a,":"); print a[2]}' $username_password)
		encrypted_password=$(awk '/password/ {split($1,a,":"); print a[2]}' $username_password)
		password=$(echo $encrypted_password | openssl enc -aes-128-cbc -iter 29 -a -d -salt -pass pass:asdffdsa)
	else
		echo "please first set your net2 username and password using init command"
		exit
	fi

	if test ! -f $ssids; then
		echo "There is no modem id in your list. Add one with add_modem command"
		exit
	fi

	while read ssid; do
		nmcli device wifi connect $ssid > /dev/null 2>&1
		connection=$(ping -q -w 5 -c 1 $login_page_url > /dev/null 2>&1 && echo 0 || echo 1)
		if [ $connection -eq 0 ]; then
			echo Successfully connected
			curl -Ls -d "username=$username&password=$password" -X POST $login_page_url
			break
		fi
		done < $ssids

elif test $1 == "newmodem"; then
	if [ -z $2 ]; then
		echo "please type modem ssid"
	else
		new_ssids=($@)
		for (( i=1; i<=($#-1); i++ ))
		do  
   			echo "${new_ssids[$i]}" >> $ssids
		done
	fi

elif test $1 == "init"; then
	if [ -z $3 ]; then 
		echo "please type both username and password"
	else
		encrypted_password=$(echo $3 | openssl enc -aes-128-cbc -iter 29 -a -salt -pass pass:asdffdsa)
		echo -e "username:$2\npassword:$encrypted_password" > $username_password
	fi
fi

