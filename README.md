# Lockra1n v2.1 Beta 1 is now out!
Lockra1n v2.1 Beta 1 has some important changes since the the 2.0 Beta 3. Some notable ones are:

Added iPhone X iOS 16 Mounting issue fix: Lockra1n had trouble when mounting the user data partition of the device (/mnt2) when in SSH ramdisk mode. This has been addressed in version 2.1 by utilizing the Palera1n ramdisk instead of SSHRD_Script, which contains fixed r/w permissions.

Normal Mode Bypass: This is a feature I was quite excited about releasing. You can now choose your bypass mode when unlocking your devices. 
The Normal mode bypass is probably quicker, because it only requires a jailbreak. The software will guide you through the process carefully.
If the Normal mode bypass fails though, use the ramdisk mode bypass. It is probably more stable, and the ramdisk method is known to work better. It is up to you which option to use. Please try out the Normal mode bypass though because I'm looking for feedback on how it worked for others. If the Normal mode bypass was successful OR failed, message me on X (Twitter) @AlwaysAppleFTD or Instagram @finn.desilva with the information. 

Updated UI: This is a smaller feature of Lockra1n v2.1. The tool's UI now has been redesigned to accommodate the new features and buttons.
Enjoy!

PLEASE NOTE: This app may not be perfect. Please don’t get upset of there are bugs, just report it to me and I will do my best to issue a fix. While I have done excessive testing on my devices, the software is probably not finalized yet. 
Kindly report any bugs to me as I aim to make the software the best it can be. 
To contact me, you can message me on X (Twitter) @AlwaysAppleFTD, Instagram @finn.desilva or email alwaysappleftd@icloud.com. Thank you for your participation in this new software!

# How to Download Lockra1n

Visit the Lockra1n page on my website at: https://alwaysappleftd.com/software/Lockra1n.html for details.

Once on the site, click the latest top blue download button in the How to Download Lockra1n section of the page to open the file link. 
The tool will start downloading. Make sure you allow downloads from my site if it's your first time downloading!

If you are downloading the previous beta, an external link to the file sharing platform will be opened.
From there, once the site opens, click the blue download button on MediaFire to start the download.
I recommend using the latest version though because features are ONLY added (never removed) and the software's stability is improved with every update. If you really need the old version though, go ahead. I wouldn't prevent you.

NOTE: If you see a message that the app cannot be opened because it's from an unidentified developer, just right-click on the app file and select "Open." This will bypass the unidentified developer message and open the app.

If the app still won’t open, follow these steps:

Open a blank Terminal window. You can find the Terminal app in the Other folder in your Launchpad.
Type, in lowercase, xattr -cr (without quotes), then drag and drop the Lockra1n application you downloaded into the Terminal window.
Press Enter to run the command.
These steps should allow the app to open. If you encounter any further launching issues, please contact me.

# How to Use Lockra1n

Open the app you downloaded from here.

If you see the "Untrusted Developer" message, follow the steps above to resolve it.
For any other launching issues, please contact me.
1. Click the "Prepare Lockra1n" button to ensure everything is installed and ready for using Lockra1n.

2. Click the "Search for Device" button. This will pair your device with the computer. Make sure to hit "Trust" on the device if prompted!

3. Click the "Generate Activation Files" button. It will check the registration and generate activation tickets for your device.

If you are not registered, the tool will prompt you to do so. You can visit the free registration page here: https://alwaysappleftd.com/software/Lockra1n/register_device.php
If you encounter an error like "Failed to generate tickets!", DO NOT ATTEMPT to activate! This could brick your device, requiring a restore in most cases to fix.

4. Click either the "Bypass Device (Ramdisk)" or the "Bypass Device (Normal mode)" button. As mentioned earlier, the ramdisk mode bypass is probably more reliable, but please do try out the Normal mode bypass function. I'd love to hear if it worked or not.

To enter DFU Mode on your device, the method varies depending on your device model.
I recommend Googling "How to Enter DFU Mode on " and then your device model.
For example, "How to Enter DFU Mode on iPhone 8". 


The tool will mount the device's filesystem, inject the tickets, apply some filesystem modifications, and reboot your device. After your device turns back on, you will be on the Home Screen!

Also note that the "Re-Lock device (unhide baseband, ramdisk)" and the "Re-Lock device (unhide baseband, normal mode)" buttons will not remove the activation tickets. It just un-hides the baseband so the device returns to the Setup screen. To remove the tickets from the device, just do a clean restore in iTunes (older macOS versions), Finder, or 3uTools. DO NOT "Update" or "Retain User's Data"! This can in some cases brick the device, forcing a restore. It's also just a waste of time.

Once everything is done, your device is bypassed untethered!

Enjoy bypassing your devices using this software!
As mentioned above, report any bugs you encounter back to me.

Thank you for your participation in this new software!

