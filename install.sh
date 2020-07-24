#!/bin/bash

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

sleep 2
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
