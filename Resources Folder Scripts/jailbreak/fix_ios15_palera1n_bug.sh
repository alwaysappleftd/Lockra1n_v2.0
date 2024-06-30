#!/usr/bin/env bash

cd "`dirname "$0"`"

./palera1n-macos-universal_bakepal -p
sleep 5

osascript -e 'tell app "System Events" to display dialog "Please disconnect and reconnect the device to the computer. Then click OK to finish Jailbreak..."'

./palera1n-macos-universal_bakepal -r ./PongoOS/build/ramdisk.dmg -V

echo "Jailbreak done!"