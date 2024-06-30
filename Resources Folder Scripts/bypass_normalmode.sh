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
./iproxy 2222:44 > /dev/null 2>&1 &

sleep 2

# Mount read/write filesystem on the device
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mount -o rw,union,update /'

# Upload activation tickets
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "dd of=/var/root/activation_record.plist" < Device_Activation/activation_record.plist
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "dd of=/var/root/IC-Info.sisv" < Device_Activation/FairPlay/iTunes_Control/iTunes/IC-Info.sisv

# Unlock read/write on var/root dir
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chflags -R nouchg /var/root'

# Prepare mnt2 locations for activation tickets
#./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'rm -rf /mnt2/root/activation_record.plist /mnt2/root/IC-Info.sisv &>/var/root/log'

# Move activation_record.plist and Info.sisv to different locations
#./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mv -f /mnt1/activation_record.plist /mnt2/root/'
#./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mv -f /mnt1/IC-Info.sisv /mnt2/root/'

# Delete existing FairPlay and prepare for the new one
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'rm -rf /var/mobile/Library/FairPlay'
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'rm -rf $(find /var/containers/Data/System/ -iname \*Launch\*)';

# ./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 echo $(cat guidFairPlay);

# Delete GUID FairPlay files and add the new ones
# ./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'grep -Rh fairplayd /var/containers/Data/System &>/var/root/g.txt; cat /var/root/g.txt | grep "Binary file " | sed "s/Binary file //g" | sed "s/\/.com.apple.mobile_container_manager.metadata.plist matches//g"' &>guidFairPlay;
# ./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'grep -Rh fairplayd /var/containers/Data/System &>/var/root/g.txt; cat /var/root/g.txt &>guidFairPlay;
# ./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'rm -rf '$(cat guidFairPlay)'/Documents/*';

# Make GUID FairPlay folders for new files
# ./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mkdir -p '$(cat guidFairPlay)'/Documents/Library/FairPlay/iTunes_Control/iTunes';
# ./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mkdir -p '$(cat guidFairPlay)'/Documents/Media/iTunes_Control/iTunes';

# Make sidv file
# ./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cp -rp /var/root/IC-Info.sisv /mnt2/root/IC-Info.sidv';
# ./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mv -f /var/root/IC-Info.sisv '$(cat guidFairPlay)'/Documents/Library/FairPlay/iTunes_Control/iTunes/';
# ./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mv -f /var/root/IC-Info.sidv '$(cat guidFairPlay)'/Documents/Media/iTunes_Control/iTunes/';
# # permissions GUID files
# ./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chmod -R 00755 '$(cat guidFairPlay)'/Documents/Library/';
# ./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chmod 00664 '$(cat guidFairPlay)'/Documents/Library/FairPlay/iTunes_Control/iTunes/IC-Info.sisv';
# ./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chmod -R 00755 '$(cat guidFairPlay)'/Documents/Media/';
# ./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chmod 00664 '$(cat guidFairPlay)'/Documents/Media/iTunes_Control/iTunes/IC-Info.sidv';

# Add the IC-Info.sisv
# ./sshpass -p 'alpine' scp -P 2222 -p ./Device_Activation/FairPlay/iTunes_Control/iTunes/IC-Info.sisv root@localhost:"/var/root/";

#./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 '/bin/mv -f /var/root/IC-Info.sisv /mnt2/root/';

# Clean the /var/mobile/Media/iTunes_Control/iTunes/ directory
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'rm -rf /var/mobile/Media/iTunes_Control/iTunes/';

# Add the .sisv and .sidv file
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cp -rp /var/root/IC-Info.sisv /var/root/IC-Info.sidv';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mkdir -p -m 755 /var/mobile/Library/FairPlay/iTunes_Control/iTunes/';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mkdir -p -m 755 /var/mobile/Media/iTunes_Control/iTunes/';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mv -f /var/root/IC-Info.sisv /var/mobile/Library/FairPlay/iTunes_Control/iTunes/';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mv -f /var/root/IC-Info.sidv /var/mobile/Media/iTunes_Control/iTunes/';
# permissions FairPlay files
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chown -R mobile:mobile /var/mobile/Library/FairPlay';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chown -R mobile:mobile /var/mobile/Media/iTunes_Control';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chmod 0644 /var/mobile/Library/FairPlay/iTunes_Control/iTunes/IC-Info.sisv';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chmod 0644 /var/mobile/Media/iTunes_Control/iTunes/IC-Info.sidv';








./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /private/var/containers/Data/System/*/Library/internal/../ && chflags -R nouchg activation_records';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /private/var/containers/Data/System/*/Library/internal/../ && rm -rf activation_records'
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /private/var/containers/Data/System/*/Library/internal/../ && mkdir -p activation_records'
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /private/var/containers/Data/System/*/Library/activation_records && mv -f /var/root/activation_record.plist ./'
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /private/var/containers/Data/System/*/Library/activation_records/.. && chmod 755 activation_records' 
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /private/var/containers/Data/System/*/Library/activation_records/.. && chmod 0664 activation_records/activation_record.plist' 

sleep 2

./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'find /private/var/containers/Data/System -iname internal' | sed "s/\/internal//g" &>guid;
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chflags -R nouchg '$(cat guid)'/activation_records';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chmod -R 00666 '$(cat guid)'/activation_records';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'chown -R mobile '$(cat guid)'/activation_records';


sleep 1



# Pull hidden data_ark.plist
# ./sshpass -p 'alpine' scp -P 2222 -p root@localhost:"/private/var/containers/Data/System/*/Library/internal/data_ark.plist" ./patch/;

# Make a copy of data_ark.plist
# #cp -rp ./patch/data_ark.plist ./patch/original_data_ark.plist
# cp -rp ./patch/data_ark.plist ./patch/modded_data_ark.plist

# Read and save the Build Version of data_ark.plist to buildversion
# plutil -extract '-BuildVersion' xml1 -o - ./patch/data_ark.plist  | grep -o '<string>.*</string>' | sed -E 's/<\/?string>//g' &> ./patch/buildversion
# build_ver_file_path="./patch/buildversion"
# file_contents=$(<"$build_ver_file_path")
# spit_build=$(echo "$file_contents" | tr -d '\n')

# Replace needed values to correct values
# plutil -replace -ActivationState -string Activated ./patch/modded_data_ark.plist
# plutil -replace -BrickState -bool 0 ./patch/modded_data_ark.plist
# plutil -replace -BuildVersion -string "$spit_build" ./patch/modded_data_ark.plist
# plutil -replace -LastActivated -string "$spit_build" ./patch/modded_data_ark.plist

# Copy and push back updated data_ark.plist
# cp -rp ./patch/modded_data_ark.plist ./patch/new_data_ark.plist
# ./sshpass -p 'alpine' scp -P 2222 -p ./patch/new_data_ark.plist root@localhost:"/var/containers/Data/System/*/Library/internal/data_ark.plist";

# Prepare skip setup process

echo "Unlock Permissions on setup steps file..."
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p 2222 "root@localhost" 'chflags nouchg /private/var/mobile/Library/Preferences/com.apple.purplebuddy.plist'
echo "Unlocked Permissions 2 on skip setup file done!"

echo "Deleting com.apple.purplebuddy.plist..."
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p 2222 "root@localhost" 'rm -rf /private/var/mobile/Library/Preferences/com.apple.purplebuddy.plist'
echo "Deleted /private/var/mobile/Library/Preferences/com.apple.purplebuddy.plist"

echo "Pushing file to skip setup"
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "dd of=/private/var/mobile/Library/Preferences/com.apple.purplebuddy.plist" < patch/com.apple.purplebuddy.plist
echo "Pushed setup skip file!"

echo "Change first permissions on setup file"
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p 2222 "root@localhost" 'chmod 755 /private/var/mobile/Library/Preferences/com.apple.purplebuddy.plist'
echo "Permissions on skip setup file done!"

echo "Change second part of permissions on setup file"
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p 2222 "root@localhost" 'chflags uchg /private/var/mobile/Library/Preferences/com.apple.purplebuddy.plist'
echo "Second permissions 2 on skip setup file done!"




echo ""
echo ""
echo "Notice: If this next command fails, that most likely means you already hid the Baseband."
echo "This is fine and the bypass will still work."

# Hide device Baseband

# Using Palera1n SSH instead of ramdisk so different method

# cd /private/preboot/*/usr/local/standalone/firmware/
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mount -uw /private/preboot';
# Hide device Baseband
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /private/preboot/*/usr/local/standalone/firmware/ && mv -f Baseband Baseband2';

# Baseband for iOS 14 and below
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /usr/local/standalone/firmware/ && mv -f Baseband Baseband2';

# Unhide Baseband only if needed
#./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /private/preboot/*/usr/local/standalone/firmware/ && mv -f Baseband2 Baseband';

# OPTIONAL: Use this code if you don't want to hide baseband!
# It will not provide a direct signal bypass, but this is how some tools get signal!
# If you have PHP code that can generate the correct ActivationTicket Key for the commcenter, then for iOS 12 to 14 you could potentially activate GSM devices.

#GSM/MEID FOR SIGNAL
#echo "Unlocking file..."
#sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p 2222 "root@localhost" 'chflags nouchg /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist'
#echo "Unlocked file!"

#echo "Deleting file..."
#sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p 2222 "root@localhost" 'rm -r /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist'
#echo "Deleted file!"

#echo "Pushing file..."
#./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "dd of=/var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist" < patch/com.apple.commcenter.device_specific_nobackup.plist
#echo "File pushed!"

#echo "Perm file..."
#sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p 2222 "root@localhost" 'chmod 755 /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist'
#echo "Permed file!"

#echo "Locking file..."
#sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p 2222 "root@localhost" 'chflags uchg /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist'
#echo "Locked file!"

sleep 3

# Reboot the connected device

# Additional UI Cache cleaning (probably not needed but why not)
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'uicache --all'
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'launchctl reboot userspace'


# Kill iproxy
kill %1 > /dev/null 2>&1
echo ""
echo 'Bypass Script Ran!'
echo ""
sleep 1

