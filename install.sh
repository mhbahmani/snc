#!/bin/bash

sudo apt install pv > /dev/null 2>&1
echo "installing snc ..." | pv -qL 20

git clone https://github.com/mhbahmani/snc > /dev/null 2>&1

cd snc

main_destination=/usr/local/bin/snc
sudo rm -rf $main_destination

sudo cp snc $main_destination
sudo chmod +x $main_destination

cd ..
sudo rm -rf snc

sudo mkdir -p $HOME/.local/share/snc
sudo touch $HOME/.local/share/snc/ssids.conf
sudo touch $HOME/.local/share/snc/username_password.conf

echo "snc successfully installed." | pv -qL 12
echo "enjoy!" | pv -qL 10
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
