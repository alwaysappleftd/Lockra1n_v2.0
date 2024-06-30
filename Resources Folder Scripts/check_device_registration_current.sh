url="http://alwaysappleftd.com"

# Always Apple FTD Activation Device Registration Check Script

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
          echo "Something's not right. No device was detected, but it passed the Swift check."
          #osascript -e 'display dialog "No device in normal mode connected!" with title "Lockra1n"'

        exit
        ;;
esac

DeviceInfo() {
  /usr/local/bin/ideviceinfo | grep -w "$1" | awk '{printf $NF}'
}

if [ "$(DeviceInfo ActivationState)" = "Unactivated" ]; then
    echo "Device is unactivated. Continuing..."
else
    osascript -e 'display alert "ERROR: This device is already activated!" message "This could mean that the device \nhas been bypassed already, or \nit is a normally activated device.\n\nLockra1n does not provide any \nopen menu unlocking functions."'
    exit
fi

mkdir -p ./Device_Activation/

curl -s -k "https://alwaysappleftd.com/software/Lockra1n/registration_check.php?serialNumber=$(DeviceInfo SerialNumber)" --output ./Device_Activation/registration_status.txt
fi

#curl -s "https://icactivate.000webhostapp.com/bypass/generate.php?uniqueDiviceID=$(DeviceInfo UniqueDeviceID)&Build=$(DeviceInfo BuildVersion)&model=$(DeviceInfo ModelNumber)&productType=$(DeviceInfo ProductType)&ios=$(DeviceInfo ProductVersion)&ucid=$(DeviceInfo UniqueChipID)&serialNumber=$(DeviceInfo SerialNumber)" --output ./Device_Activation/activation_record.plist

sleep 2

filename="./Device_Activation/registration_status.txt"
reg_status="Your device is not registered with Lockra1n!"

if grep -q "$reg_status" "$filename"; then
    osascript -e 'display notification "'$(DeviceInfo SerialNumber)' is not registered with Lockra1n!" with title "Lockra1n"'
    sleep 2
    osascript -e 'display notification "Please visit alwaysappleftd.com/software/Lockra1n.html for details and registration." with title "Lockra1n"'
else
    echo ""
    echo "Your device is registered!"
    echo ""
    osascript -e 'display notification "Apple device '$(DeviceInfo SerialNumber)' is registered with Lockra1n!" with title "Lockra1n"'
fi


#mkdir -p ./Device_Activation/FairPlay/
#mkdir -p ./Device_Activation/FairPlay/iTunes_Control/
#mkdir -p ./Device_Activation/FairPlay/iTunes_Control/iTunes/

#bash ./convert.sh ./Device_Activation/activation_record.plist ./Device_Activation/FairPlay/#iTunes_Control/iTunes/


