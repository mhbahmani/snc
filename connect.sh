login_page_url=https://net2.sharif.edu/login
favorite_ssids_file="ssids.txt"
username_password_file="username_password.txt"

if test "$1" = "connect" -o "$1" = "c"; then

	nmcli radio wifi on
	sleep 2
	nmcli device wifi rescan


	if test -f $username_password_file; then
		username=$(awk '/username/ {split($1,a,":"); print a[2]}' $username_password_file)
		encrypted_password=$(awk '/password/ {split($1,a,":"); print a[2]}' $username_password_file)
		password=$(echo $encrypted_password | openssl enc -aes-128-cbc -iter 29 -a -d -salt -pass pass:asdffdsa)
	else
		echo "please first set your net2 username and password using init command"
		exit
	fi

	if test -f $favorite_ssids_file; then
		online_favorite_ssids=$(nmcli device wifi list | grep -wi -f $favorite_ssids_file | cut -d '*' -f 2 | awk '{print $1}')
		ssids=($online_favorite_ssids)
	else
		echo "There is no modem id in your list. Add one with newmodem command"
		exit
	fi

	for ssid in "${ssids[@]}"
	do
		echo $ssid
		nmcli device wifi connect $ssid > /dev/null 2>&1
		connection=$(ping -q -w 5 -c 1 $login_page_url > /dev/null 2>&1 && echo 0 || echo 1)
		if [ $connection -eq 0 ]; then
			echo Successfully connected
			curl -Ls -d "username=$username&password=$password" -X POST $login_page_url
			break
		fi
	done

elif test  "$1" = "newmodem" -o "$1" = "n"; then
	if [ -z $2 ]; then
		echo "please type modem ssid"
	else
		new_ssids=($@)
		for (( i=1; i<=($#-1); i++ ))
		do  
   			echo "${new_ssids[$i]}" >> $favorite_ssids_file
		done
	fi

elif test "$1" = "init" -o "$1" = "i"; then
	if [ -z $2 ]; then
		read -p "sharif-id username:" username
		read -s -p "sharif-id password:" password
		echo
	elif [ -z $3 ]; then
		echo "$2 assumed as your net2 username"
		username=$2
		read -s -p "sharif-id password:" password
	fi

	encrypted_password=$(echo $password | openssl enc -aes-128-cbc -iter 29 -a -salt -pass pass:asdffdsa)
	echo -e "username:$username\npassword:$encrypted_password" > $username_password_file
fi

