#!/usr/bin/env bash

# Always Apple FTD Show Baseband script (re-lock device)
# Normal Mode script version (ramdisk is different)

# Delete known_hosts file
rm -rf ~/.ssh/known_hosts

# Change to the current directory
cd "`dirname "$0"`"

sleep 1

# Kill iproxy incase it's running
killall iproxy

# Start iproxy on port 22
./iproxy 2222:44 > /dev/null 2>&1 &

sleep 1

# Mount filesystem as read/write on device
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mount -o rw,union,update /'

# UN-Hide the Baseband!
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'mount -uw /private/preboot';
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /private/preboot/*/usr/local/standalone/firmware/ && mv -f Baseband2 Baseband';

# Baseband for iOS 14 and below
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'cd /usr/local/standalone/firmware/ && mv -f Baseband2 Baseband';

# Reboot the device (/sbin/reboot)
./sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p2222 'launchctl reboot userspace'

# Kill iproxy
kill %1 > /dev/null 2>&1
echo ""
echo "Done!"
