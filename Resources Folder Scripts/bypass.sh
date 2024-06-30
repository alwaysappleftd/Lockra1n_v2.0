#!/usr/bin/env bash

sleep 1

# Delete known_hosts so we don't run into SSH key issue
rm -rf ~/.ssh/known_hosts

# Change to the current directory
cd "`dirname "$0"`"

sleep 1

# Kill iproxy incase it's running
killall iproxy

# Start iproxy on port 22
./iproxy 2222:22 > /dev/null 2>&1 &

sleep 2

# Mount read/write filesystem on the device
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mount_filesystems'

# Upload activation tickets
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "dd of=/mnt1/activation_record.plist" < Device_Activation/activation_record.plist
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "dd of=/mnt1/IC-Info.sisv" < Device_Activation/FairPlay/iTunes_Control/iTunes/IC-Info.sisv

# Mount read/write on mnt2/root dir
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chflags -R nouchg /mnt2/root'

# Prepare mnt2 locations for activation tickets
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'rm -rf /mnt2/root/activation_record.plist /mnt2/root/IC-Info.sisv &>/mnt1/log'

# Move activation_record.plist and Info.sisv to different locations
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mv -f /mnt1/activation_record.plist /mnt2/root/'
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mv -f /mnt1/IC-Info.sisv /mnt2/root/'

# Delete existing FairPlay and prepare for the new one
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'rm -rf /mnt2/mobile/Library/FairPlay'
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'rm -rf $(find /mnt2/containers/Data/System/ -iname \*Launch\*)';

# ./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 echo $(cat GUID_FairPlay);

# Delete GUID FairPlay files and add the new ones
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'grep -Rh fairplayd /mnt2/containers/Data/System &>/mnt1/g.txt; cat /mnt1/g.txt | grep "Binary file " | sed "s/Binary file //g" | sed "s/\/.com.apple.mobile_container_manager.metadata.plist matches//g"' &>GUID_FairPlay;
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'rm -rf '$(cat GUID_FairPlay)'/Documents/*';

# Make GUID FairPlay folders for new files
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mkdir -p '$(cat GUID_FairPlay)'/Documents/Library/FairPlay/iTunes_Control/iTunes';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mkdir -p '$(cat GUID_FairPlay)'/Documents/Media/iTunes_Control/iTunes';

# Make sidv file
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cp -rp /mnt2/root/IC-Info.sisv /mnt2/root/IC-Info.sidv';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mv -f /mnt2/root/IC-Info.sisv '$(cat GUID_FairPlay)'/Documents/Library/FairPlay/iTunes_Control/iTunes/';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mv -f /mnt2/root/IC-Info.sidv '$(cat GUID_FairPlay)'/Documents/Media/iTunes_Control/iTunes/';

# Set permissions on GUID files
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chmod -R 00755 '$(cat GUID_FairPlay)'/Documents/Library/';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chmod 00664 '$(cat GUID_FairPlay)'/Documents/Library/FairPlay/iTunes_Control/iTunes/IC-Info.sisv';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chmod -R 00755 '$(cat GUID_FairPlay)'/Documents/Media/';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chmod 00664 '$(cat GUID_FairPlay)'/Documents/Media/iTunes_Control/iTunes/IC-Info.sidv';

# Add the IC-Info.sisv
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "dd of=/mnt1/IC-Info.sisv" < Device_Activation/FairPlay/iTunes_Control/iTunes/IC-Info.sisv

./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 '/bin/mv -f /mnt1/IC-Info.sisv /mnt2/root/';

# Clean the /mnt2/mobile/Media/iTunes_Control/iTunes/ directory
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'rm -rf /mnt2/mobile/Media/iTunes_Control/iTunes/';

# Add the .sisv and .sidv file
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cp -rp /mnt2/root/IC-Info.sisv /mnt2/root/IC-Info.sidv';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 '/bin/mkdir -p -m 755 /mnt2/mobile/Library/FairPlay/iTunes_Control/iTunes/';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 '/bin/mkdir -p -m 755 /mnt2/mobile/Media/iTunes_Control/iTunes/';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 '/bin/mv -f /mnt2/root/IC-Info.sisv /mnt2/mobile/Library/FairPlay/iTunes_Control/iTunes/';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 '/bin/mv -f /mnt2/root/IC-Info.sidv /mnt2/mobile/Media/iTunes_Control/iTunes/';

# Set permissions for FairPlay files
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 '/usr/sbin/chown -R mobile:mobile /mnt2/mobile/Library/FairPlay';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 '/usr/sbin/chown -R mobile:mobile /mnt2/mobile/Media/iTunes_Control';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chmod 0644 /mnt2/mobile/Library/FairPlay/iTunes_Control/iTunes/IC-Info.sisv';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chmod 0644 /mnt2/mobile/Media/iTunes_Control/iTunes/IC-Info.sidv';








./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /mnt2/containers/Data/System/*/Library/internal/../ && chflags -R nouchg activation_records';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /mnt2/containers/Data/System/*/Library/internal/../ && rm -rf activation_records'
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /mnt2/containers/Data/System/*/Library/internal/../ && /bin/mkdir -p activation_records'
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /mnt2/containers/Data/System/*/Library/activation_records && /bin/mv -f /mnt2/root/activation_record.plist ./'
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /mnt2/containers/Data/System/*/Library/activation_records/.. && chmod 755 activation_records' 
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /mnt2/containers/Data/System/*/Library/activation_records/.. && chmod 0664 activation_records/activation_record.plist' 

sleep 2

./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'find /mnt2/containers/Data/System -iname internal' | sed "s/\/internal//g" &>GUID;
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chflags -R nouchg '$(cat GUID)'/activation_records';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chmod -R 00666 '$(cat GUID)'/activation_records';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 '/usr/sbin/chown -R mobile '$(cat GUID)'/activation_records';


sleep 1

# Pull hidden data_ark.plist
DataArk=$(./sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 2222 find /mnt2/containers/Data/System/ -name data_ark.plist)

./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "dd if=$DataArk" | dd of=patch/data_ark.plist

# Make a copy of data_ark.plist
cp -rp ./patch/data_ark.plist ./patch/modded_data_ark.plist

# Read and save the Build Version of data_ark.plist to buildversion
plutil -extract '-BuildVersion' xml1 -o - ./patch/data_ark.plist  | grep -o '<string>.*</string>' | sed -E 's/<\/?string>//g' &> ./patch/buildversion
build_ver_file_path="./patch/buildversion"
file_contents=$(<"$build_ver_file_path")
device_build=$(echo "$file_contents" | tr -d '\n')

# Replace needed values to correct values
plutil -replace -ActivationState -string Activated ./patch/modded_data_ark.plist
plutil -replace -BrickState -bool 0 ./patch/modded_data_ark.plist
plutil -replace -BuildVersion -string "$device_build" ./patch/modded_data_ark.plist
plutil -replace -LastActivated -string "$device_build" ./patch/modded_data_ark.plist

# Copy and push back updated data_ark.plist
mv ./patch/data_ark.plist ./patch/original_data_ark.plist
cp -rp ./patch/modded_data_ark.plist ./patch/data_ark.plist
DataArk=$(./sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 2222 find /mnt2/containers/Data/System/ -name data_ark.plist)
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "dd if=$DataArk" | dd of=patch/data_ark.plist

echo ""
echo ""
echo "Notice: If this next command fails, that most likely means you already hid the Baseband."
echo "This is fine and the bypass will still work."

# Hide device Baseband
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /mnt6/*/usr/local/standalone/firmware/ && mv -f Baseband Baseband2';

# Baseband for iOS 14 and below
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /usr/local/standalone/firmware/ && mv -f Baseband Baseband2';

# Unhide Baseband only if needed
#./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /mnt6/*/usr/local/standalone/firmware/ && mv -f Baseband2 Baseband';



# Prepare skip setup process

echo "Unlock Permissions on setup steps file..."
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p 2222 "root@localhost" 'chflags nouchg /mnt2/mobile/Library/Preferences/com.apple.purplebuddy.plist'
echo "Unlocked Permissions 2 on skip setup file done!"

echo "Deleting com.apple.purplebuddy.plist..."
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p 2222 "root@localhost" 'rm -rf /mnt2/mobile/Library/Preferences/com.apple.purplebuddy.plist'
echo "Deleted /private/var/mobile/Library/Preferences/com.apple.purplebuddy.plist"

echo "Pushing file to skip setup"
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "dd of=/mnt2/mobile/Library/Preferences/com.apple.purplebuddy.plist" < patch/com.apple.purplebuddy.plist
echo "Pushed setup skip file!"

echo "Change first permissions on setup file"
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p 2222 "root@localhost" 'chmod 755 /mnt2/mobile/Library/Preferences/com.apple.purplebuddy.plist'
echo "Permissions on skip setup file done!"

echo "Change second part of permissions on setup file"
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p 2222 "root@localhost" 'chflags uchg /mnt2/mobile/Library/Preferences/com.apple.purplebuddy.plist'
echo "Second permissions 2 on skip setup file done!"

# Reboot the connected device
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 '/sbin/reboot'

# Kill iproxy
kill %1 > /dev/null 2>&1
echo ""
echo 'Bypass Script Ran!'
echo ""
sleep 1
