#!/usr/bin/env bash

echo "Connect a device in DFU mode. "
echo "You can connect in Recovery or Normal mode, but it takes way longer to jailbreak that way."
echo ""
read -p "Once device is connected, press Enter..."

echo "Jailbreaking iOS 15.0 to 16.5"
sleep 2

#xattr the palera1n executable
xattr -cr palera1n-macos-universal-6
#start palera1n executable
./palera1n-macos-universal-6

#Wait 60 seconds for the device to have enough time to boot...
sleep 36
echo "Thanks to @palera1n for the jailbreak."
exit 1

