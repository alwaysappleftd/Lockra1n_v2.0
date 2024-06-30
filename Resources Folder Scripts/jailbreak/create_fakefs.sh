#!/usr/bin/env bash

#echo "Connect a device in DFU mode. "
#echo "You can connect in Recovery or Normal mode, but it takes way longer to jailbreak that way."
#echo ""
#read -p "Once device is connected, press Enter..."

#Change the current working directory
cd "`dirname "$0"`"

echo "Jailbreaking iOS 15.0 to 15.8.2..."
sleep 2

#xattr the palera1n executable
xattr -cr palera1n-macos-universal
#start palera1n executable with shell
./palera1n-macos-universal -p

sleep 5

./palera1n-macos-universal -cf

#Wait 36 seconds for the device to boot up
sleep 36
echo "Thanks to @palera1n for the jailbreak."
exit 1

