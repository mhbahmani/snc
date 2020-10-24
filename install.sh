#!/bin/bash

declare -A osInfo;
osInfo[/etc/debian_version]="sudo apt-get install -y"
osInfo[/etc/alpine-release]="sudo apk --update add"
osInfo[/etc/centos-release]="sudo yum install -y"
osInfo[/etc/fedora-release]="sudo dnf install -y"

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        package_manager=${osInfo[$f]}
    fi
done

curl_inst=0
[ $(curl --version | grep -Eci 'release-date') = 0 ] && curl_inst=1

if [ $curl_inst = 1 ]; then
    if [ -z $package_manager ]; then
        echo "unknown linux distro".
        echo "try installing curl with your package manager"
        echo "then run the installation command again"
        echo "exiting."
        exit
    fi
    [ curl_intst = 1 ] && $package_manager curl
fi

main_destination=/usr/local/bin/snc
sudo rm -rf $main_destination 

snc=$(wget -q -O- https://raw.githubusercontent.com/mhbahmani/snc/master/snc)

sudo tee $main_destination << EOF > /dev/null
$snc 
EOF

sudo chmod +x $main_destination 

mkdir -p $HOME/.local/share/snc
touch $HOME/.local/share/snc/ssids.conf
touch $HOME/.local/share/snc/username_password.conf

echo "snc successfully installed."
echo "enjoy!"
echo

sleep 1
clear

echo "\`snc\` connects to sharif modems and log you in to net2"
echo 
echo "First, U have to set net2 username and password using [config | co] command."
echo "Then you should add your almost used modems to the list using [newmodem | n] command."
echo "Now, \`snc\` is ready to use."
echo "Use [connect | c] command and boom! you're connected to a modem with strongest signal and  logged in to ne2.sharif.edu!"
echo
echo "You can see commands list with [--help | -h]"
echo
