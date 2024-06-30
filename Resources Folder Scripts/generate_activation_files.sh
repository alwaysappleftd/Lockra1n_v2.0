url="http://alwaysappleftd.com"

# Always Apple FTD Activation Tickets Generation Script [NOT USED IN THIS APP]

# Change directory to the current directory
cd "$(dirname "$0")"

# Delete old Activation Files
rm -rf ./Device_Activation/
sleep 1

timeout=5

check_internet_connection() {
    if curl --output /dev/null --silent --head --max-time $timeout "$url"; then
        echo "Connected to the Internet"
    else
        echo "No internet connection!"
        osascript -e 'display dialog "Check your internet connection and try again!" with title "Lockra1n"'
        exit
    fi
}

check_internet_connection

sp="$(system_profiler SPUSBDataType 2> /dev/null)"

apples=$(printf '%s' "$sp" | grep -B1 'Vendor ID: 0x05ac' | grep 'Product ID:' | cut -dx -f2 | cut -d' ' -f1)
reversed_apples=$(echo "$apples" | awk '{for(i=NF;i>=1;i--) print $i}')

device_count=0
device_mode="none"

update_device_mode() {
    case "$1" in
        12a8|12aa|12ab)
            device_mode="normal"
            device_count=$((device_count+1))
            ;;
        1281)
            device_mode="recovery"
            device_count=$((device_count+1))
            ;;
        1227)
            device_mode="dfu"
            device_count=$((device_count+1))
            ;;
        1222)
            device_mode="diag"
            device_count=$((device_count+1))
            ;;
        1338)
            device_mode="checkra1n_stage2"
            device_count=$((device_count+1))
            ;;
        4141)
            device_mode="pongo"
            device_count=$((device_count+1))
            ;;
    esac
}

for apple in $reversed_apples; do
    update_device_mode "$apple"
done

if [ "$device_count" -ge 2 ]; then
    echo "[-] Please attach only one device" > /dev/tty
    osascript -e 'display dialog "Please attach only one device!" with title "Lockra1n"'
    kill -30 0
    exit 1
fi

usbserials=$(printf '%s' "$sp" | grep 'Serial Number' | cut -d: -f2 | sed 's/ //')

if grep -qE '(ramdisk tool|SSHRD_Script) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) [0-9]{1,2} [0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2}' <<< "$usbserials"; then
    device_mode="ramdisk"
fi

case "$device_mode" in
    normal)

        echo Done! Device detected.

        ;;

    *)
          #osascript -e 'display dialog "No device in normal mode connected!" with title "Lockra1n"'

        #exit
        ;;
esac

DeviceInfo() {
  /usr/local/bin/ideviceinfo | grep -w "$1" | awk '{printf $NF}'
}

if [ "$(DeviceInfo ActivationState)" = "Unactivated" ]; then
    echo "Device is unactivated. Continuing..."
else
    osascript -e 'display alert "ERROR: This device is already activated!" message "This could mean that the device \nhas been bypassed already, or \nit is a normal activated device.\n\nLockra1n does not provide any \nopen menu unlocking functions."'
    exit
fi

mkdir -p ./Device_Activation/

echo "HUGE THANK YOU Hackt1vator for your Activation Tickets generation server!"

curl -k "https://hackt1vator.com/Hackt1vatorUntethered/generate.php?sn=$(DeviceInfo SerialNumber)&ucid=$(DeviceInfo UniqueChipID)&udid=$(DeviceInfo UniqueDeviceID)" --output ./Device_Activation/activation_record.plist
fi

#curl -s "https://icactivate.000webhostapp.com/bypass/generate.php?uniqueDiviceID=$(DeviceInfo UniqueDeviceID)&Build=$(DeviceInfo BuildVersion)&model=$(DeviceInfo ModelNumber)&productType=$(DeviceInfo ProductType)&ios=$(DeviceInfo ProductVersion)&ucid=$(DeviceInfo UniqueChipID)&serialNumber=$(DeviceInfo SerialNumber)" --output ./Device_Activation/activation_record.plist

mkdir -p ./Device_Activation/FairPlay/
mkdir -p ./Device_Activation/FairPlay/iTunes_Control/
mkdir -p ./Device_Activation/FairPlay/iTunes_Control/iTunes/

bash ./convert.sh ./Device_Activation/activation_record.plist ./Device_Activation/FairPlay/iTunes_Control/iTunes/

echo "Almost done"

file_path="./Device_Activation/activation_record.plist"

file_size=$(stat -f%z "$file_path")

file_size_kb=$((file_size / 1024))

if (( file_size_kb > 3 )); then
    echo "File size matches the requirement."

else
    echo "File size is not more than 4KB."
    osascript -e 'display notification "An error occurred when generating activation files." with title "Lockra1n"'
    osascript -e 'display dialog "Failed to generate activation tickets!" with title "Lockra1n"'
    osascript -e 'display notification "DO NOT CONTINUE! Otherwise, your device will likely get bricked." with title "Lockra1n"'
    rm -rf ./Device_Activation
    exit
fi

echo "Finished creating activation files!"
echo "Done."
#osascript -e 'display dialog "Activation files successfully generated!" with title "Lockra1n"'
