#!/usr/bin/env bash

#echo "iOS version was found."
echo "Starting Restore..."
sleep 2
echo "Killing iproxy incase it's running..."
killall iproxy

sleep 1

file_content=$(cat ipsw.txt)

executable="libs/idevicerestore"
argument="-e $file_content"

# Run the executable with the appended argument
"$executable" $argument 