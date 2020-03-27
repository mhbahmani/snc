#!/bin/bash

git clone https://github.com/mhbahmani/snc
cd snc

destination=/usr/local/bin/snc
if  [ -f $destination ] || [ -d $destination ]; then
    echo
    echo "a file or directory named snc already exists in $destination."
    echo "remove it and try insallation again."
    echo
    exit 1
fi

sudo cp snc $destination
sudo chmod +x $destination
cd ..
rm -rf snc

echo
echo "snc successfully installed."
echo "enjoy!"
echo
snc --help
