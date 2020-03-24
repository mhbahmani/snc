login_page_url=https://net2.sharif.edu/login
favorite_ssids_file="ssids.txt"
username_password_file="username_password.txt"

load_username_password(){
        if test -f $username_password_file;
        then
                username=$(awk '/username/ {split($1,a,":"); print a[2]}' $username_password_file)
                encrypted_password=$(awk '/password/ {split($1,a,":"); print a[2]}' $username_password_file)
                password=$(echo $encrypted_password | openssl enc -aes-128-cbc -iter 29 -a -d -salt -pass pass:asdffdsa)
        else
                echo "Please first set your net2 username and password using init command."
		echo "See \'--help\' or \'-h\'"
                exit
        fi
}

load_favorite_ssids(){
        if test -f $favorite_ssids_file;
        then
                online_favorite_ssids=$(nmcli device wifi list | grep -wi -f $favorite_ssids_file | cut -d '*' -f 2 | awk '{print $1}')
                ssids=($online_favorite_ssids)
        else
                echo "There is no modem id in your list. Add one with newmodem command."
                echo "See \'--help\' or \'-h\'"
		exit
        fi
}

try_connecting_to_modems(){
	for ssid in "${ssids[@]}"
        do      
                nmcli device wifi connect $ssid > /dev/null 2>&1
                connection=$(ping -q -w 5 -c 1 $login_page_url > /dev/null 2>&1 && echo 0 || echo 1)
                if [ $connection -eq 0 ];
                then    
                        echo Successfully connected to $ssid
                        curl -Ls -d "username=$username&password=$password" -X POST $login_page_url
                        exit
                fi
        done
	echo "Connecting failed, try again."
}

connect(){
	nmcli radio wifi on
	sleep 2
	nmcli device wifi rescan

	load_username_password

	load_favorite_ssids

	try_connecting_to_modems
}

add_modem(){
	if [ -z $1 ];
	then
		echo "Please type modem ssid"
		echo "See \'--help\' or \'-h\'"
	else
		new_ssids=($@)
		echo $#
		for (( i=1; i<=($#-1); i++ ))
		do
   			echo "${new_ssids[$i]}" >> $favorite_ssids_file
		done
	fi
}

initialize(){
	if [ -z $1 ];
	then
		read -p "sharif-id username:" username
		read -s -p "sharif-id password:" password
		echo
	elif [ -z $1 ];
	then
		echo "$1 assumed as your net2 username"
		username=$1
		read -s -p "sharif-id password:" password
	fi

	encrypted_password=$(echo $password | openssl enc -aes-128-cbc -iter 29 -a -salt -pass pass:asdffdsa)
	echo -e "username:$username\npassword:$encrypted_password" > $username_password_file
}

show_favorite_modems(){
	cat $favorite_ssids_file
}

case $1 in
        connect | c)
		connect
		;;
        init | i)
		initialize $2 $3 
                ;;
        newmodem | n)
                add_modem $@
                ;;
	show | s)
		show_favorite_modems
		;;
	--help | -h)
		#TODO: add a help
                echo "help"
                ;;  
esac

