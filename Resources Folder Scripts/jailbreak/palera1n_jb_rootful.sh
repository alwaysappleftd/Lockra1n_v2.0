
#!/usr/bin/env bash

# Made by @mrcreator1 @pwn2owned
clear
#stop asking me if i want to save the darn key
rm -rf ~/.ssh/known_hosts

# Change the current working directory
cd "`dirname "$0"`"

sleep 1
echo "--------------------------------------------------------"
echo "Jailbreaking iOS 15.X-16.5..."
sleep 2

# start palera1n-c pongo shell first
./palera1n-macos-universal_bakepal -p

sleep 5

osascript -e 'tell app "System Events" to display dialog "Please disconnect and reconnect device!!! Then click Ok to continue Jailbreak..."'

sleep 2

# upload ssh ramdisk files
./palera1n-macos-universal_bakepal -cf

osascript -e 'tell app "System Events" to display dialog "Please Enter DFU mode now! Then click OK to continue Jailbreak..."'

# start palera1n-c pongo shell first
./palera1n-macos-universal_bakepal -p

sleep 10

# upload ssh ramdisk files
./palera1n-macos-universal_bakepal -f

#sleep 5
#for good measure...
#./palera1n-macos-universal_bakepal -r ./PongoOS/build/ramdisk.dmg -V
# wait 60 seconds for the device to have enough time to boot...

sleep 5

exit 1





















# Made by @mrcreator1 @pwn2owned
