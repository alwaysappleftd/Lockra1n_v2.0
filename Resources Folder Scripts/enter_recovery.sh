#!/usr/bin/env bash

# Change current directory to working directory
cd "$(dirname "$0")"

echo "Starting process..."

killall iproxy

#./idevicepair pair

# Write connected device info to file
./ideviceinfo > DeviceInfo1

# Find the UDID in the written file
DeviceUDID=$(grep 'UniqueDeviceID:' DeviceInfo1)
echo "$DeviceUDID"

# Fix UDID
FixedUDID=${DeviceUDID/UniqueDeviceID: /}

echo "Almost done..."
echo "Detected UDID: "$FixedUDID

# Now send device with the detected UDID into Recovery Mode!
./ideviceenterrecovery $FixedUDID
