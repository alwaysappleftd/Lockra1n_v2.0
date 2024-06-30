
#!/usr/bin/env bash

# Setup script created by Always Apple FTD

#make sure we don't run into the key/ssh issue...
rm -rf ~/.ssh/known_hosts

# Check if Homebrew is installed then install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null 2>&1
    echo ''
fi

# Check if sshpass is installed, install if we don't have it
#if test ! $(which sshpass); then
    #echo "Installing sshpass..."
    #brew install esolitos/ipa/sshpass > /dev/null 2>&1
    #echo ''
#fi

# Check if iproxy is installed, install if we don't have it
#if test ! $(which iproxy); then
    #echo "Installing iproxy..."
    #brew install libimobiledevice > /dev/null 2>&1
    #echo ''
#fi

# Change current directory to working directory
cd "$(dirname "$0")"

sleep 2

# Check if libxml2 is installed, and install libxml2 if not

xmllint_path="/usr/local/opt/libxml2/bin/xmllint"
if [ -f "$xmllint_path" ]; then
    $xmllint_path --version # Just an example to show xmllint works
else
    echo "Error: xmllint could not be found."
    echo "Installing it now..."
    sleep 2
    brew install libxml2
    if [ -f "$xmllint_path" ]; then
        $xmllint_path --version # Just an example to show xmllint works
    else
        echo "ERROR: Something went wrong! xmllint still could not be found."
	osascript -e 'display alert "ERROR: The software attempted to install xmllint, but it failed." message "The cause of this is not known, so \nmaybe try running the following \ncommand in Terminal: \n\nbrew install libxml2"'
	exit
    fi
fi

#chmod the executables for the bypass
chmod +x ideviceenterrecovery
chmod +x ideviceactivation
chmod +x ideviceinfo
chmod +x idevicepair
chmod +x idevicerestore
chmod +x iproxy
chmod +x ipwndfu2
chmod +x gaster
chmod +x sshpass
chmod +x irecovery
chmod +x *
chmod +x move/*

#xattr the executables for the bypass
xattr -cr ideviceenterrecovery
xattr -cr ideviceactivation
xattr -cr ideviceinfo
xattr -cr idevicepair
xattr -cr idevicerestore
xattr -cr iproxy
xattr -cr ipwndfu2
xattr -cr gaster
xattr -cr sshpass
xattr -cr irecovery
xattr -cr *
xattr -cr move/*
chmod +x move/*
chmod 755 move/*
#cd ..
chmod +x jailbreak/palera1n-macos-universal
chmod +x jailbreak/iOS16_palera1n
xattr -cr jailbreak/palera1n-macos-universal
xattr -cr jailbreak/iOS16_palera1n
#cd tools

#move the dependencies for ideviceactivation to /usr/local/lib
#assuming that you don't have them already...
#echo "It is possible that you'll see a message soon that says 'Override?' "
#echo "PLEASE press the y key to say yes if so."
#echo "If you don't, the bypass will not work properly."

#if [ ! -d "/usr/local/lib" ]; then
    # If lib dir doesn't exist, create the directory
    #mkdir -p "/usr/local/lib"
   # cp -R move/* /usr/local/lib
#else
    ## If lib exists, continue with the script
rm -rf /usr/local/lib/libcrypto.3.dylib
rm -rf /usr/local/lib/libideviceactivation-1.0.2.dylib
rm -rf /usr/local/lib/libimobiledevice-1.0.6.dylib
rm -rf /usr/local/lib/libimobiledevice-glue-1.0.0.dylib
rm -rf /usr/local/lib/libplist-2.0.3.dylib
rm -rf /usr/local/lib/libplist++-2.0.3.dylib
rm -rf /usr/local/lib/libssl.3.dylib
rm -rf /usr/local/lib/libusbmuxd-2.0.6.dylib
rm -rf /usr/local/lib/libcrypto.1.1.dylib
rm -rf /usr/local/lib/libusbmuxd.4.dylib
rm -rf /usr/local/lib/libplist-2.0.3.dylib
rm -rf /usr/local/lib/libplist.3.dylib
rm -rf /usr/local/lib/libssl.1.1.dylib
rm -rf /usr/local/bin/sshpass
rm -rf /usr/local/bin/ideviceenterrecovery
rm -rf /usr/local/bin/ideviceactivation
rm -rf /usr/local/bin/ideviceinfo
rm -rf /usr/local/bin/idevicepair
rm -rf /usr/local/bin/idevicerestore
rm -rf /usr/local/bin/iproxy
rm -rf /usr/local/bin/ipwndfu2
rm -rf /usr/local/bin/gaster
rm -rf /usr/local/bin/sshpass
rm -rf /usr/local/bin/irecovery

# Wait for 3 seconds
sleep 5

# Copy the contents from the 'move' directory to /usr/local/lib
cp -R move/* /usr/local/lib

cp -R libs/* /usr/local/bin

chmod 755 ssh.sh
chmod 755 bypass.sh
chmod 755 startrestore.sh
chmod 755 enter_recovery.sh
chmod 755 exitrecovery.sh
