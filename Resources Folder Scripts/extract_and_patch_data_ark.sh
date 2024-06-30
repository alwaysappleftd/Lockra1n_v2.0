rm -rf ~/.ssh/known_hosts

# Change current directory to working directory
cd "$(dirname "$0")"

# Remove old patch folder
rm -rf patch

mkdir -p patch

# Kill iproxy in case its running.
killall iproxy

./iproxy 2222:44 > /dev/null 2>&1 &

# Mount the device filesystem
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p 2222 "root@localhost" 'mount -o rw,union,update /'

# Define where data_ark is located
DataArk=$(./sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 2222 find /var/containers/Data/System/ -name data_ark.plist)

# Copy data_ark to Mac
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "dd if=$DataArk" | dd of=patch/data_ark.plist
 #./sshpass -p 'alpine' scp -P 2222 -p root@localhost:"/var/containers/Data/System/*/Library/internal/data_ark.plist" ./patch/data_ark.plist
 
# Make copy of data_ark
 cp -rp ./patch/data_ark.plist ./patch/modified_data_ark.plist

 plutil -extract '-BuildVersion' xml1 -o - ./patch/data_ark.plist  | grep -o '<string>.*</string>' | sed -E 's/<\/?string>//g' &> ./patch/buildversion
 build_ver_file_path="./patch/buildversion"
 file_contents=$(<"$build_ver_file_path")
 spit_build=$(echo "$file_contents" | tr -d '
')

 # Make changes to modified_data_ark.plist
 plutil -replace -ActivationState -string Activated ./patch/modified_data_ark.plist
 plutil -replace -BrickState -bool 0 ./patch/modified_data_ark.plist
 plutil -replace -BuildVersion -string "$spit_build" ./patch/modified_data_ark.plist
 plutil -replace -LastActivated -string "$spit_build" ./patch/modified_data_ark.plist

# Upload new data_ark
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "dd of=$DataArk" < patch/modified_data_ark.plist

# Hide baseband (only if necessary)
#./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /usr/local/standalone/firmware/ && mv -f Baseband Baseband2';

#./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /private/preboot/*/usr/local/standalone/firmware/ && mv -f Baseband Baseband2'

# Reboot device
#./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'launchctl reboot userspace'

# Kill iproxy
killall iproxy
echo 'Done!'
