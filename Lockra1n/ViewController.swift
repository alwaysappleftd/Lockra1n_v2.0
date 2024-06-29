//
//  ViewController.swift
//  Lockra1n
//
//  Created by Always Apple FTD on 4/19/24.
//

import Cocoa
import SwiftUI
import AppKit
import UniformTypeIdentifiers
import Foundation
import UserNotifications
import AppKit
import SystemConfiguration

class AlertManager {
    // Instead of using @Published, manually notify observers of changes
    private var isShowingPromptForiOSVersion: Bool = false {
        didSet {
            // Notify observers manually
            NotificationCenter.default.post(name: .isShowingPromptForiOSVersionChanged, object: nil)
        }
    }

    var iOSVersionPrompt: String?

    func promptForiOSVersion(completion: @escaping (String?) -> Void) {
        isShowingPromptForiOSVersion = true

        // Add your prompt implementation here
        // For example, simulate user input using NSAlert
        let alert = NSAlert()
        alert.messageText = "Please enter your device iOS Version here!\nThis can be a rough guess, it doesn't have to be exact."
        let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 300, height: 24))
        textField.placeholderString = "Enter device iOS Version"
        alert.accessoryView = textField
        alert.addButton(withTitle: "OK")
        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            let input = textField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
            completion(input.isEmpty ? nil : input)
        } else {
            completion(nil)
        }
    }
    
    @IBAction func helpMenuBtnPressed(_ sender: NSMenuItem) {
        if let url = URL(string: "https://alwaysappleftd.com/software/Lockra1n.html") {
            NSWorkspace.shared.open(url)
        }
    }
    
    @IBAction func bugReportButtonPressed(_ sender: NSMenuItem) {
        if let url = URL(string: "mailto:alwaysappleftd@icloud.com?subject=Issue%20with%20Lockra1n") {
            NSWorkspace.shared.open(url)
        } else {
            print("Could not create URL.")
        }
    }
    
    
}

extension Notification.Name {
    static let isShowingPromptForiOSVersionChanged = Notification.Name("isShowingPromptForiOSVersionChanged")
}

class ViewController: NSViewController {
    
    // @ObservedObject private var alertManager = AlertManager() // Instantiate AlertManager
    
    @IBOutlet weak var welcomeText: NSTextField!
    
    @IBOutlet weak var infoText1: NSTextField!
    
    @IBOutlet weak var startSteps1: NSTextField!
    
    @IBOutlet weak var prepareLockra1nRef: NSButton!
    
    @IBOutlet weak var searchDeviceRef: NSButton!
    
    @IBOutlet weak var genActRef: NSButton!
    
    @IBOutlet weak var bypassDeviceRef: NSButton!
    
    @IBOutlet weak var bypassDeviceNormalMode: NSButton!
    
    @IBOutlet weak var relockDeviceRef: NSButton!
    
    @IBOutlet weak var relockDeviceNormalModeRef: NSButton!
    
    @IBOutlet weak var moreOptionsText: NSTextField!
    
    @IBOutlet weak var manageRecoveryRef: NSButton!
    
    @IBOutlet weak var exitRecModeRef: NSButton!
    
    @IBOutlet weak var enterPwnDFURef: NSButton!
    
    @IBOutlet weak var restoreDeviceRef: NSButton!
    
    @IBOutlet weak var getDeviceInfoRef: NSButton!
    
    @IBOutlet weak var helpButtonRef: NSButton!
    
    @IBOutlet weak var creditsButtonRef: NSButton!
    
    @IBOutlet weak var followMeTextRef: NSTextField!
    
    @IBOutlet weak var youtubeButtonRef: NSButton!
    
    @IBOutlet weak var twitterButtonRef: NSButton!
    
    @IBOutlet weak var instagramButtonRef: NSButton!
    
    @IBOutlet weak var creditsMainText: NSTextField!
    
    @IBOutlet weak var creditsText1: NSTextField!
    
    @IBOutlet weak var nathanDevText: NSTextField!
    
    @IBOutlet weak var mrcreatorDevText1: NSTextField!
    
    @IBOutlet weak var mrcreatorDevText2: NSTextField!
    
    @IBOutlet weak var libimobiledeviceText: NSTextField!
    
    @IBOutlet weak var creditsText2: NSTextField!
    
    @IBOutlet weak var doneCreditsButton: NSButton!
    
    @IBOutlet weak var notifyButton: NSButton!
    
    @IBAction func prepareLockra1nButtonPressed(_ sender: NSButton) {
        // Make an Alert pop-up
        let alert = NSAlert()
        alert.messageText = "Prepare Lockra1n?"
        alert.informativeText = "It may take a few minutes to complete. You only need to do this once. If you have done this already, just click cancel."
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        
        let response = alert.runModal()
        // If the 'OK' button was pressed, then execute the 'test.sh' script
        if response == .alertFirstButtonReturn {
            guard let resourcesPath = Bundle.main.resourcePath else {
                print("Failed to find the main bundle's resource path")
                return
            }
            
            let scriptPath = "\(resourcesPath)/prepare_lockra1n.sh"
            
            let process = Process()
            process.executableURL = URL(fileURLWithPath: "/bin/sh")
            process.arguments = [scriptPath]
            
            do {
                try process.run()
                process.waitUntilExit()
            } catch {
                // If failed, then print the error
                print("Failed to run script: \(error)")
            }
        }
        
        if response == .alertSecondButtonReturn {
            return
        }
        
        let alert2 = NSAlert()
        alert2.messageText = "Done!"
        alert2.informativeText = "Lockra1n is now set up and ready to use."
        alert2.addButton(withTitle: "OK")
        //alert2.addButton(withTitle: "Cancel")
        
        alert2.runModal()
    }
    
    
    @IBAction func searchForDeviceButtonPressed(_ sender: NSButton) {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return
        }
        
        //scheduleLocalNotification(NotificationTitle: "Test!", NotificationSubtitle: "The following is a test of all values:", NotificationMessage: "It actually worked!")
        
        let alert1 = NSAlert()
        alert1.messageText = "Seaching for a connected device"
        alert1.informativeText = "This may take a few seconds..."
        alert1.addButton(withTitle: "OK")
        //alert2.addButton(withTitle: "Cancel")
        
        alert1.runModal()
        
        let output1 = runTerminalCommand("\(resourcesPath)/idevicepair unpair")
        print(output1)
        
        let output2 = runTerminalCommand("\(resourcesPath)/idevicepair pair")
        print(output2)
        
        let alert2 = NSAlert()
        alert2.messageText = "Lockra1n is asking for you to press trust on your device."
        alert2.informativeText = "If you see the prompt to Trust this computer, then please do so then click OK.\nIf you don't see a trust prompt, then you're good to go.\nONLY click OK when that's done."
        alert2.addButton(withTitle: "OK")
        
        alert2.runModal()
        
        let output3 = runTerminalCommand("\(resourcesPath)/ideviceinfo > \(resourcesPath)/work/deviceinfo.txt 2>&1")
        print(output3)
        sleep(2)
        
        // DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/deviceinfo.txt")
        do {
            let fileData = try String(contentsOf: fileURL, encoding: .utf8)
            //print("File Data: \(fileData)") // Debug: Check what is being read
            
            if fileData.contains("ERROR:") {
                let checkDeviceState = self.iRecoveryInfo("MODE")
                // let findDeviceModelRecovery = self.iRecoveryInfo("PRODUCT")
                
                if checkDeviceState == "Recovery" {
                    let deviceModel = self.iRecoveryInfo("NAME")
                    self.genActRef.isEnabled = false
                    self.relockDeviceRef.isEnabled = false
                    self.relockDeviceNormalModeRef.isEnabled = false
                    self.bypassDeviceRef.isEnabled = false
                    self.bypassDeviceNormalMode.isEnabled = false
                    print("Found device in Recovery Mode!")
                    self.showAlert(message: "Device is in Recovery Mode!", informativeText: "You must be in Normal Mode to continue. Press OK to restart the device out of Recovery Mode, then click the 'Search for Device' button again to check registration and generate activation tickets!")
                    let output1 = runTerminalCommand("\(resourcesPath)/futurerestore_194 --exit-recovery")
                    print(output1)
                    
                    sleep(2)
                    
                    let alert3 = NSAlert()
                    alert3.messageText = "Done!"
                    alert3.informativeText = "Device should now be rebooting into Normal mode. Once you reach the Hello screen, click 'Search for Device' again to continue."
                    alert3.addButton(withTitle: "OK")
                    
                    alert3.runModal()
                    return
                } else if checkDeviceState == "DFU" {
                    self.genActRef.isEnabled = false
                    self.relockDeviceRef.isEnabled = false
                    self.relockDeviceNormalModeRef.isEnabled = false
                    self.bypassDeviceRef.isEnabled = false
                    self.bypassDeviceNormalMode.isEnabled = false
                    print("Found device in DFU Mode!")
                    self.showAlert(message: "Device is in DFU Mode!", informativeText: "You must be in Normal Mode to continue. Restart the device out of DFU Mode manually, then click the 'Search for Device' button again to check registration and generate activation tickets!")
                    return
                } else {
                    self.genActRef.isEnabled = false
                    self.relockDeviceRef.isEnabled = false
                    self.relockDeviceNormalModeRef.isEnabled = false
                    self.bypassDeviceRef.isEnabled = false
                    self.bypassDeviceNormalMode.isEnabled = false
                    let alert3 = NSAlert()
                    alert3.messageText = "No device was found!"
                    alert3.informativeText = "Try disconnecting and reconnecting your device.\nIf that fails as well, try using a different USB cable, and ensure that if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter."
                    alert3.addButton(withTitle: "OK")
                    alert3.runModal()
                }
            } else {
                    let filePath = "\(resourcesPath)/work/deviceinfo.txt"
                    // let fileURL = URL(fileURLWithPath: filePath)
                    if let iosVersion = extractData(from: fileData, start: "ProductVersion: ", end: "ProductionSOC:") {
                        let versionComponents = iosVersion.split(separator: ".").map(String.init)
                        var major = 0
                        var minor = 0
                        
                        if versionComponents.count > 0 {
                            major = Int(versionComponents[0]) ?? 0
                        }
                        if versionComponents.count > 1 {
                            minor = Int(versionComponents[1]) ?? 0
                        }
                        
                        // Use only major and minor for comparison and further processing
                        let versionNumber = Double("\(major).\(minor)") ?? 0.0
                        
                        if versionNumber >= 12.0 {
                            // Use the user's input
                            print("Device iOS Version: \(iosVersion)")
                            self.processDeviceData(from: fileURL)
                        } else {
                            // Default to 12.0
                            let defaultVersion = "12.0"
                            self.genActRef.isEnabled = false
                            self.relockDeviceRef.isEnabled = false
                            self.relockDeviceNormalModeRef.isEnabled = false
                            print("ERROR: iOS Version not supported!")
                            showAlert(message: "ERROR: Your device's iOS version is not supported!", informativeText: "Lockra1n supports checkm8-compatible devices running iOS 12.0 - 16.X.X")
                            return
                        }
                        
                    } else {
                        print("Fatal: No iOS version found. Exiting...")
                        // showAlert(message: "ERROR: No iOS Version was entered!", informativeText: "You must enter the iOS Version of your device to continue.\n\nIf you don't know the exact version, you can put a rough guess like 13.0 or 15.0.")
                        return
                    }
                }
        } catch {
            print("An error occurred while reading the file: \(error)")
        }
    }
    
    func iRecoveryInfo(_ Info: String) -> String {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return ""
        }
        
        // Run irecovery in query mode, without any additional arguments.
        let irecoverycmd = "\(resourcesPath)/irecovery -q 2>&1"
        let cmdoutput = runTerminalCommand(irecoverycmd)

        // Check if there is any output; if not, assume no device is connected.
        if cmdoutput.isEmpty {
            return "ERROR: No device found!"
        }

        // Process the output to extract the specific information.
        let lines = cmdoutput.components(separatedBy: .newlines)
        for line in lines {
            if line.contains(Info) {
                let components = line.components(separatedBy: ":").map { $0.trimmingCharacters(in: .whitespaces) }
                if components.count >= 2 {
                    return components[1]
                }
            }
        }

        return "Information not found."
    }
    
    func DeviceInfo(_ info: String) -> String {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return ""
        }

        let ideviceinfocmd = "\(resourcesPath)/ideviceinfo"
        let cmdoutput = runTerminalCommand(ideviceinfocmd)

        if cmdoutput.isEmpty {
            return "ERROR: No device found!"
        }

        let lines = cmdoutput.components(separatedBy: .newlines)
        for line in lines {
            if line.starts(with: "\(info):") { // Change made here to ensure it exactly matches the line start
                let components = line.components(separatedBy: ":").map { $0.trimmingCharacters(in: .whitespaces) }
                if components.count >= 2 {
                    return components[1]
                }
            }
        }

        return "Information not found."
    }
    
    func processDeviceData(from fileURL: URL) {
        do {
            let fileData = try String(contentsOf: fileURL, encoding: .utf8)
            
            if fileData.contains("ERROR:") {
                print("ERROR: No device found!")
                showAlert(message: "No device was found!", informativeText: "Try disconnecting and reconnecting your device.")
            } else {
                let udid = extractData(from: fileData, start: "UniqueDeviceID: ", end: "UseRaptorCerts:")
                let iosVersion = extractData(from: fileData, start: "ProductVersion: ", end: "ProductionSOC:")
                
                if let udid = udid, udid.count > 38 {
                    print("Found UDID: \(udid)")
                    if let iosVersion = iosVersion {
                        //print("Device iOS Version: \(iosVersion)")
                        self.genActRef.isEnabled = true
                        self.relockDeviceRef.isEnabled = true
                        self.relockDeviceNormalModeRef.isEnabled = true
                        showAlert(message: "Found iDevice on iOS \(iosVersion)", informativeText: "You can now generate your activation tickets!")
                    } else {
                        //print("Failed to extract iOS version")
                    }
                    
                } else {
                    print("Couldn't find your device")
                    showAlert(message: "No device was found!", informativeText: "Try disconnecting and reconnecting your device.\nIf that fails as well, try using a different USB cable, and ensure that if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
                }
            }
        } catch {
            print("An error occurred while reading the file: \(error)")
        }
    }
    
    func extractData(from text: String, start: String, end: String) -> String? {
        var regexPattern: String
        if end.isEmpty {
            // If no end marker is provided, grab everything till the end of the line.
            regexPattern = "\(start)(.*)"
        } else {
            // Use the original pattern when the end marker is provided.
            regexPattern = "\(start)(.*?)\(end)"
        }

        do {
            let regex = try NSRegularExpression(pattern: regexPattern, options: .dotMatchesLineSeparators)
            let results = regex.matches(in: text, options: [], range: NSRange(text.startIndex..., in: text))
            
            if let match = results.first, let range = Range(match.range(at: 1), in: text) {
                return String(text[range]).trimmingCharacters(in: .whitespacesAndNewlines)  // Trim whitespace/newlines from the result
            }
        } catch {
            print("Regex error: \(error)")
        }
        return nil
    }
    
    func processDeviceDataV2(from fileURL: URL) {
        do {
            let fileData = try String(contentsOf: fileURL, encoding: .utf8)
            //print("File Data: \(fileData)") // Debug: Check what is being read
            
            let startSerial = "SerialNumber: "
            let end = "\n"
            
            // Find the starting position of the first fake Serial Number in fileData
            if let firstPos = fileData.range(of: startSerial) {
                let secondStartIndex = fileData.index(firstPos.upperBound, offsetBy: 0)
                
                // If the annoying fake first serial number is found, find the starting position of the real second Serial Number
                if let secondPos = fileData.range(of: startSerial, range: secondStartIndex..<fileData.endIndex) {
                    let realStartIndex = fileData.index(secondPos.upperBound, offsetBy: 0)
                    let endRange = fileData.range(of: end, range: realStartIndex..<fileData.endIndex)
                    
                    // If the second Serial Number is found, extract it
                    if let endPos = endRange {
                        let serialNumber = fileData[realStartIndex..<endPos.lowerBound].trimmingCharacters(in: .whitespacesAndNewlines)
                        print("Looking for serial number...")
                        // Simulate processing delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            //print("Device Serial Number:", serialNumber)
                            // Following extraction functions should be included within the do block
                            let udid = self.extractDataV2(from: fileData, start: "UniqueDeviceID: ", end: "UseRaptorCerts:")
                            let iosVersion = self.extractDataV2(from: fileData, start: "ProductVersion: ", end: "ProductionSOC:")
                            let deviceName = self.extractDataV2(from: fileData, start: "DeviceName: ", end: "DieID:")
                            let modelNumber = self.extractDataV2(from: fileData, start: "ModelNumber: ", end: "NonVolatileRAM:")
                            let activationState = self.extractDataV2(from: fileData, start: "ActivationState: ", end: "BasebandKeyHashInformation:")
                            let passwordProtected = self.extractDataV2(from: fileData, start: "PasswordProtected: ", end: "ProductName:")
                            let productType = self.extractDataV2(from: fileData, start: "ProductType: ", end: "ProductVersion:")
                            //let serialNumber = extractDataV2(from: fileData, start: "SerialNumber: ", end: "SoftwareBehavior:")
                            //let phoneNumber = extractDataV2(from: fileData, start: "PhoneNumber: ", end: "PkHash:")
                            //let activationStateAcknowledged = extractDataV2(from: fileData, start: "ActivationStateAcknowledged: ", end: "BasebandActivationTicketVersion:")
                            
                            // Use the extracted values to create a detailed message
                            if let udid = udid, let iosVersion = iosVersion, let deviceName = deviceName {
                                self.showAlert(message: "Found iDevice with values:\nSerial Number: \(serialNumber),\nUDID: \(udid),\niOS Version: \(iosVersion),\nDevice Name: \(deviceName),\nModel Number: \(modelNumber ?? "N/A"),\nActivation State: \(activationState ?? "N/A"),\nPassword Protected: \(passwordProtected ?? "N/A"),\nProduct Type: \(productType ?? "N/A")", informativeText: "You can use this information for almost anything that requires device info, including Lockra1n registration!")
                            } else {
                                self.showAlert(message: "Failed to extract device details", informativeText: "Could not find all required device information.")
                            }
                        }
                    } else {
                        print("Second Serial Number not found in the file.")
                    }
                } else {
                    print("Second Serial Number not found in the file.")
                }
            } else {
                print("First Serial Number not found in the file.")
                showAlert(message: "No device was found!", informativeText: "Try disconnecting and reconnecting your device.\nIf that fails as well, try using a different USB cable, and ensure that if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
            }
            
        } catch {
            print("An error occurred while reading the file: \(error)")
        }
    }
    
    func extractDataV2(from text: String, start: String, end: String) -> String? {
        // Find the start index
        if let startRange = text.range(of: start) {
            let afterStartIndex = text.index(startRange.upperBound, offsetBy: 0)
            
            // Find the end index from the start index forward
            if let endRange = text.range(of: end, range: afterStartIndex..<text.endIndex) {
                let extractedData = text[afterStartIndex..<endRange.lowerBound]
                return extractedData.trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                print("End marker '\(end)' not found after start marker.")
            }
        } else {
            print("Start marker '\(start)' not found.")
        }
        return nil
    }
    
    
    func processDeviceDataNoPopUp(from fileURL: URL) -> Bool {
        do {
            let fileData = try String(contentsOf: fileURL, encoding: .utf8)
            
            if fileData.contains("ERROR:") {
                print("ERROR: No device found!")
                showAlert(message: "No device was found!", informativeText: "Try disconnecting and reconnecting your device.\nIf that fails as well, try using a different USB cable, and ensure that if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
                return false  // Indicate failure
            } else {
                let udid = extractData(from: fileData, start: "UniqueDeviceID: ", end: "UseRaptorCerts:")
                let iosVersion = extractData(from: fileData, start: "ProductVersion: ", end: "ProductionSOC:")
                
                if let udid = udid, udid.count > 38 {
                    print("Found UDID: \(udid)")
                    if let iosVersion = iosVersion {
                        print("Device found! iOS Version: \(iosVersion)")
                        return true  // Indicate success
                    } else {
                        print("Failed to extract iOS version")
                        return false  // Failed to extract iOS version
                    }
                } else {
                    print("Couldn't find your device")
                    showAlert(message: "No device was found!", informativeText: "Try disconnecting and reconnecting your device.\nIf that fails as well, try using a different USB cable, and ensure that if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
                    return false  // No valid UDID found
                }
            }
        } catch {
            print("An error occurred while reading the file: \(error)")
            return false  // Indicate failure on exception
        }

        // Jusy for safety: Ideally this should never be reached unless there's a logical flaw in the flow above
        return false
    }
    
    func processDeviceDataNoErrorPopUp(from fileURL: URL) -> Bool {
        do {
            let fileData = try String(contentsOf: fileURL, encoding: .utf8)
            
            if fileData.contains("ERROR:") {
                //print("ERROR: No Normal Mode device found!")
                //showAlert(message: "No device was found!", informativeText: "Try disconnecting and reconnecting your device.\nIf that fails as well, try using a different USB cable, and ensure that if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
                return false  // Indicate failure
            } else {
                let udid = extractData(from: fileData, start: "UniqueDeviceID: ", end: "UseRaptorCerts:")
                let iosVersion = extractData(from: fileData, start: "ProductVersion: ", end: "ProductionSOC:")
                
                if let udid = udid, udid.count > 38 {
                    print("Found UDID: \(udid)")
                    if let iosVersion = iosVersion {
                        print("Device found! iOS Version: \(iosVersion)")
                        return true  // Indicate success
                    } else {
                        print("Failed to extract iOS version")
                        return false  // Failed to extract iOS version
                    }
                } else {
                    //print("ERROR: No Normal Mode device found!")
                    //showAlert(message: "No device was found!", informativeText: "Try disconnecting and reconnecting your device.\nIf that fails as well, try using a different USB cable, and ensure that if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
                    return false  // No valid UDID found
                }
            }
        } catch {
            print("An error occurred while reading the file: \(error)")
            return false  // Indicate failure on exception
        }

        // Jusy for safety: Ideally this should never be reached unless there's a logical flaw in the flow above
        return false
    }
    
    
    func detectDFUDevice() {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return
        }
        
        let checkDeviceConnected = self.iRecoveryInfo("ERROR")
        
        if checkDeviceConnected == "Unable to connect to device" {
            print("No device found!")
            showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
            return
        }
        
        let checkDeviceState = self.iRecoveryInfo("MODE")
        let findDeviceModelRecovery = self.iRecoveryInfo("PRODUCT")
        
        // let output1 = runTerminalCommand("\(resourcesPath)/irecovery -q > \(resourcesPath)/work/dfu.txt 2>&1")
        // print(output1)
        
        //        let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
        //        do {
        //            let fileData = try String(contentsOf: fileURL, encoding: .utf8)
        //            //print("File Data: \(fileData)") // Debug: Check what is being read
        //
        //            if fileData.contains("ERROR:") {
        //                print("ERROR: No device found!")
        //                showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
        //            } else {
        //                let deviceModel = extractData(from: fileData, start: "NAME: ", end: "\n")  // Assuming each data ends with a newline
        //                let deviceMode = extractData(from: fileData, start: "MODE: ", end: "\n")  // Assuming PRODUCT follows a newline after MODE
        //
        //                if let mode = deviceMode {
        //                    if mode == "Recovery" {
        //                        print("Found device in Recovery Mode!")
        //                        self.showAlert(message: "Device is in Recovery Mode!", informativeText: "You must be in DFU Mode to continue. Try entering DFU Mode again, and be sure the device's screen is black before continuing. Then press the 'Bypass Device!' button again to try again.")
        //                        return
        //                    } else if mode == "DFU" {
        //                        print("DFU Mode device found!")
        //                        guard let resourcesPath = Bundle.main.resourcePath else {
        //                            print("Failed to find the main bundle's resource path")
        //                            return
        //                        }
        //                        //self.showAskiOSVersionAlert()
        //                        // Further custom logic for handling DFU mode
        //                    } else {
        //                        print("Device is neither in Recovery nor DFU Mode.")
        //                        showAlert(message: "Device status unclear!", informativeText: "The device status could not be determined accurately.")
        //                        return
        //                    }
        //                } else {
        //                    print("Failed to determine device mode")
        //                    showAlert(message: "Device information error!", informativeText: "Could not extract device mode information.")
        //                    return
        //                }
        //            }
        //        } catch {
        //            print("An error occurred while reading the file: \(error)")
        //            return
        //        }
        
        if checkDeviceState == "Recovery" {
            let deviceModel = self.iRecoveryInfo("NAME")
            print("Found device in Recovery Mode!")
            self.showAlert(message: "Device is in Recovery Mode!", informativeText: "You must be in DFU Mode to continue. Try entering DFU Mode again, and be sure the device's screen is black before continuing. Then press the 'Bypass Device!' button again to try again.")
            return
        } else if checkDeviceState == "DFU" {
            print("DFU Mode device found!")
            // Change isDFUDetected to true to prevent further DFU detections
            // self.detectDFUDeviceNoPopUpV2()
            guard let resourcesPath = Bundle.main.resourcePath else {
                print("Failed to find the main bundle's resource path")
                return
            }
        }
        
        if findDeviceModelRecovery == "iPhone6,1" || findDeviceModelRecovery == "iPad4,1" || findDeviceModelRecovery == "iPad4,2" || findDeviceModelRecovery == "iPad4,3" || findDeviceModelRecovery == "iPad4,4" || findDeviceModelRecovery == "iPad4,5" || findDeviceModelRecovery == "iPad4,6" || findDeviceModelRecovery == "PRODUCT: iPad4,7" || findDeviceModelRecovery == "iPad4,8" || findDeviceModelRecovery == "iPad4,9" {
            print("A7 device detected!")
            
            self.showAskiOSVersionAlert2()
        } else {
            print("A8 or higher device detected!")
            let success = self.showAskiOSVersionAlert()  // Get success or failure
            
            if !success {
                return  // Stop further processing because processDeviceDataNoPopUp failed
            }
        }
    }
    
    func detectDFUDeviceNoPopUpV2() {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return
        }

        let checkDeviceConnected = self.iRecoveryInfo("ERROR")
        let checkDeviceState = self.iRecoveryInfo("MODE")
        let findDeviceModelRecovery = self.iRecoveryInfo("PRODUCT")
        
        if checkDeviceConnected == "Unable to connect to device" {
            print("No device found!")
            showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
            return
        }

        if checkDeviceState == "Recovery" {
            print("Found device in Recovery Mode!")
            self.showAlert(message: "Device is in Recovery Mode!", informativeText: "You must be in DFU Mode to continue. Try entering DFU Mode again, and be sure the device's screen is black before continuing. Then press the 'Bypass Device!' button again to try again.")
            return
        } else if checkDeviceState == "DFU" {
            
            print("DFU Mode device found!")
            guard let resourcesPath = Bundle.main.resourcePath else {
                print("Failed to find the main bundle's resource path")
                return
            }
        }
        
            if findDeviceModelRecovery == "iPhone6,1" || findDeviceModelRecovery == "iPad4,1" || findDeviceModelRecovery == "iPad4,2" || findDeviceModelRecovery == "iPad4,3" || findDeviceModelRecovery == "iPad4,4" || findDeviceModelRecovery == "iPad4,5" || findDeviceModelRecovery == "iPad4,6" || findDeviceModelRecovery == "PRODUCT: iPad4,7" || findDeviceModelRecovery == "iPad4,8" || findDeviceModelRecovery == "iPad4,9" {
                print("A7 device detected!")
                //let output1 = runTerminalCommand("\(resourcesPath)/irecovery -q > \(resourcesPath)/work/dfu.txt 2>&1")
                //print(output1)
                sleep(2)
                //let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
                // self.processDeviceDataNotNormalV2(from: fileURL)
                let success = self.showAskiOSVersionAlert2()  // Get success or failure
                
                if !success {
                    return  // Stop further processing because processDeviceDataNoPopUp failed
                }
            } else {
                print("A8 or higher device detected!")
                //            let output1 = runTerminalCommand("\(resourcesPath)/irecovery -q > \(resourcesPath)/work/dfu.txt 2>&1")
                //            print(output1)
                //            sleep(2)
                //            let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
                // self.processDeviceDataNotNormalV2(from: fileURL)
                let success = self.showAskiOSVersionAlert()  // Get success or failure
                
                if !success {
                    return  // Stop further processing because processDeviceDataNoPopUp failed
                }
            }
    
//        let output1 = runTerminalCommand("\(resourcesPath)/irecovery -q > \(resourcesPath)/work/dfu.txt 2>&1")
//        print(output1)
//
//        let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
//        do {
//            let fileData = try String(contentsOf: fileURL, encoding: .utf8)
//            //print("File Data: \(fileData)") // Debug: Check what is being read
//
//            if fileData.contains("ERROR:") {
//                print("ERROR: No device found!")
//                showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
//            } else {
//                let deviceModel = extractData(from: fileData, start: "NAME: ", end: "\n")  // Assuming each data ends with a newline
//                let deviceMode = extractData(from: fileData, start: "MODE: ", end: "\n")  // Assuming PRODUCT follows a newline after MODE
//
//                if let mode = deviceMode {
//                    if mode == "Recovery" {
//                        print("Found device in Recovery Mode!")
//                        showAlert(message: "Please enter DFU Mode now!", informativeText: "If you need instructions on how to enter DFU Mode, please Google 'How to enter DFU mode on \(deviceModel ?? "")'. Then find an online tutorial or website post.")
//                        self.detectDFUDeviceNoPopUpV2()
//                    } else if mode == "DFU" {
//                        print("DFU Mode device found!")
//                        guard let resourcesPath = Bundle.main.resourcePath else {
//                            print("Failed to find the main bundle's resource path")
//                            return
//                        }
//                        //self.showAskiOSVersionAlert()
//                        // Further custom logic for handling DFU mode
//                    } else {
//                        print("Device is neither in Recovery nor DFU Mode.")
//                        showAlert(message: "Device status unclear!", informativeText: "The device status could not be determined accurately.")
//                        return
//                    }
//                } else {
//                    print("Failed to determine device mode")
//                    showAlert(message: "Device information error!", informativeText: "Could not extract device mode information.")
//                    return
//                }
//            }
//        } catch {
//            print("An error occurred while reading the file: \(error)")
//            return
//        }
    }
    
    func detectDFUDeviceNoPopUpV3() {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return
        }
        
        let checkDeviceConnected = self.iRecoveryInfo("ERROR")
        
        if checkDeviceConnected == "Unable to connect to device" {
            print("No device found!")
            showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
            return
        }
        
        let checkDeviceState = self.iRecoveryInfo("MODE")
        let findDeviceModelRecovery = self.iRecoveryInfo("PRODUCT")
        
        if checkDeviceState == "Recovery" {
            print("Found device in Recovery Mode!")
            self.showAlert(message: "Device is in Recovery Mode!", informativeText: "You must be in DFU Mode to continue. Try entering DFU Mode again, and be sure the device's screen is black before continuing. Then press the 'Bypass Device!' button again to try again.")
            return
        } else if checkDeviceState == "DFU" {
            
            print("DFU Mode device found!")
            guard let resourcesPath = Bundle.main.resourcePath else {
                print("Failed to find the main bundle's resource path")
                return
            }
        }
        
        if findDeviceModelRecovery == "iPhone6,1" || findDeviceModelRecovery == "iPad4,1" || findDeviceModelRecovery == "iPad4,2" || findDeviceModelRecovery == "iPad4,3" || findDeviceModelRecovery == "iPad4,4" || findDeviceModelRecovery == "iPad4,5" || findDeviceModelRecovery == "iPad4,6" || findDeviceModelRecovery == "PRODUCT: iPad4,7" || findDeviceModelRecovery == "iPad4,8" || findDeviceModelRecovery == "iPad4,9" {
            print("A7 device detected!")
            // let output1 = runTerminalCommand("\(resourcesPath)/irecovery -q > \(resourcesPath)/work/dfu.txt 2>&1")
            // print(output1)
            sleep(2)
            // let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
            // self.processDeviceDataNotNormalV2(from: fileURL)
            // let success = self.showAskiOSVersionAlert2ReLock()  // Get success or failure
            let success = self.showAskiOSVersionAlert2()  // Get success or failure
            
            if !success {
                return  // Stop further processing because processDeviceDataNoPopUp failed
            }
            // self.showAskiOSVersionAlert2ReLock()
            // if !success {
            // return  // Stop further processing because processDeviceDataNoPopUp failed
            // }
        } else if findDeviceModelRecovery == "iPhone10,6" || findDeviceModelRecovery == "iPhone10,3" {
            
            let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/deviceinfo.txt")
            do {
                let fileData = try String(contentsOf: fileURL, encoding: .utf8)
                
                if let iosVersion = extractData(from: fileData, start: "ProductVersion: ", end: "ProductionSOC:")?.trimmingCharacters(in: .whitespacesAndNewlines), !iosVersion.isEmpty {
                    let versionComponents = iosVersion.split(separator: ".").map(String.init)
                    var major = 0
                    var minor = 0
                    
                    if versionComponents.count > 0 {
                        major = Int(versionComponents[0]) ?? 0
                    }
                    if versionComponents.count > 1 {
                        minor = Int(versionComponents[1]) ?? 0
                    }
                    
                    let versionNumber = Double("\(major).\(minor)") ?? 0.0
                    
                    if versionNumber >= 12.0 {
                        print("iOS Version entered: \(iosVersion)\n")  // Correctly unwrapped
                        print("iPhone X Detected!")
                        
                        let output1 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script_pale && chmod +x * && xattr -cr * && chmod +x Darwin/* && xattr -cr Darwin/*")
                        print(output1)
                        
                        sleep(1)
                        print("Booting Palera1n Ramdisk...")
                        sleep(1)
                        
                        let output2 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script_pale/ && ./sshrd.sh boot > log.txt")
                        print(output2)
                        
                        sleep(8)
                        print("Palera1n Ramdisk should now be booted!")
                        
                        // sleep(2)
                        print("Starting bypass script...")
                        sleep(3)
                        let scriptPath = "\(resourcesPath)/bypass.sh"
                        let process = Process()
                        process.executableURL = URL(fileURLWithPath: "/bin/sh")
                        process.arguments = [scriptPath]
                        do {
                            try process.run()
                            process.waitUntilExit()
                        } catch {
                            // If failed, then print the error
                            print("Failed to run script: \(error)")
                        }
                        sleep(3)
                        print("✓ iCloud bypass complete! ✓")
                        showAlert(message: "iCloud Bypass Done!", informativeText: "Enjoy your bypassed device!\n\nPS. If you got some of your devices working thanks to this tool, send me a DM on X (@AlwaysAppleFTD) or on Instagram (@finn.desilva) :)")
                    } else {
                        print("ERROR: iOS Version not supported!")
                        print("iOS Version entered: \(iosVersion)")  // Correctly unwrapped
                        showAlert(message: "ERROR: The iOS version you entered is not supported!", informativeText: "Lockra1n supports checkm8-compatible devices running iOS 12.0 - 16.7.8")
                        return
                    }
                } else {
                    print("No iOS version in text file.")
                    print("Asking user what iOS version device is running...")
                    if let iosVersion = promptForiOSVersion() {
                        let versionComponents = iosVersion.split(separator: ".").map(String.init)
                        var major = 0
                        var minor = 0
                        
                        if versionComponents.count > 0 {
                            major = Int(versionComponents[0]) ?? 0
                        }
                        if versionComponents.count > 1 {
                            minor = Int(versionComponents[1]) ?? 0
                        }
                        
                        // Use only major and minor for comparison and further processing
                        let versionNumber = Double("\(major).\(minor)") ?? 0.0
                        
                        if versionNumber >= 12.0 {
                            // Use the user's input
                            print("iOS Version entered: \(iosVersion)")
                            print("iPhone X Detected!")
                            
                            let output1 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script_pale && chmod +x * && xattr -cr * && chmod +x Darwin/* && xattr -cr Darwin/*")
                            print(output1)
                            
                            sleep(1)
                            print("Booting Ramdisk...")
                            sleep(1)
                            
                            let output2 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script_pale && ./sshrd.sh boot > log.txt")
                            print(output2)
                            
                            sleep(8)
                            
                            print("Ramdisk should now be booted.")
                            sleep(2)
                            print("Starting bypass script...")
                            sleep(3)
                            let scriptPath = "\(resourcesPath)/bypass.sh"
                            let process = Process()
                            process.executableURL = URL(fileURLWithPath: "/bin/sh")
                            process.arguments = [scriptPath]
                            do {
                                try process.run()
                                process.waitUntilExit()
                            } catch {
                                // If failed, then print the error
                                print("Failed to run script: \(error)")
                            }
                            sleep(3)
                            print("✓ iCloud bypass complete! ✓")
                            showAlert(message: "iCloud Bypass Done!", informativeText: "Enjoy your bypassed device!\n\nPS. If you got some of your devices working thanks to this tool, send me a DM on X (@AlwaysAppleFTD) or on Instagram (@finn.desilva) :)")
                            // print("No iOS version in text file or failed to fetch iOS version.")
                            // print("iOS Version entered: \(iosVersion)")  // Correctly unwrapped
                            // showAlert(message: "ERROR: No iOS Version was found!", informativeText: "This is most likely a Swift related problem. Please contact me on X @AlwaysAppleFTD or on Instagram @finn.desilva and I will help you.\n\nAlso, please remember that your feedback on this tool is important! The more users report bugs, the sooner I can fix them.")
                        } else {
                            // Default to 12.0
                            let defaultVersion = "12.0"
                            print("ERROR: iOS Version not supported!")
                            showAlert(message: "ERROR: The iOS version you entered is not supported!", informativeText: "Lockra1n supports checkm8-compatible devices running iOS 12.0 - 16.7.8")
                            return
                        }
                        
                        // showAlert(message: "Ramdisk has been created!", informativeText: "Press OK to boot your device into SSH Ramdisk mode.")
                        
                    } else {
                        // Handle the case where no iOS version was entered
                        print("No iOS version entered.")
                        showAlert(message: "ERROR: No iOS Version was entered!", informativeText: "You must enter the iOS Version of your device to continue.\n\nIf you don't know the exact version, you can put a rough guess like 13.0 or 15.0.")
                        return
                    }
                    return
                }
            } catch {
                print("An error occurred while reading the file: \(error)")
                return
            }
            
        } else {
            print("A8 or higher device detected!")
            // let success = self.showAskiOSVersionAlertReLock()  // Get success or failure
            // self.showAskiOSVersionAlertReLock()
            let success = self.showAskiOSVersionAlert()  // Get success or failure
            
            if !success {
                return  // Stop further processing because processDeviceDataNoPopUp failed
            }
        }
    }
    
    func detectDFUDeviceNoPopUpReLock() {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return
        }

        let checkDeviceConnected = self.iRecoveryInfo("ERROR")
        
        if checkDeviceConnected == "Unable to connect to device" {
            print("No device found!")
            showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
            return
        }
        
        let checkDeviceState = self.iRecoveryInfo("MODE")
        let findDeviceModelRecovery = self.iRecoveryInfo("PRODUCT")

        if checkDeviceState == "Recovery" {
            print("Found device in Recovery Mode!")
            self.showAlert(message: "Device is in Recovery Mode!", informativeText: "You must be in DFU Mode to continue. Try entering DFU Mode again, and be sure the device's screen is black before continuing. Then press the 'Re-Lock device (un-hide baseband)' button again to try again.")
            return
        } else if checkDeviceState == "DFU" {
            
            print("DFU Mode device found!")
            guard let resourcesPath = Bundle.main.resourcePath else {
                print("Failed to find the main bundle's resource path")
                return
            }
        }
        
        if findDeviceModelRecovery == "iPhone6,1" || findDeviceModelRecovery == "iPad4,1" || findDeviceModelRecovery == "iPad4,2" || findDeviceModelRecovery == "iPad4,3" || findDeviceModelRecovery == "iPad4,4" || findDeviceModelRecovery == "iPad4,5" || findDeviceModelRecovery == "iPad4,6" || findDeviceModelRecovery == "PRODUCT: iPad4,7" || findDeviceModelRecovery == "iPad4,8" || findDeviceModelRecovery == "iPad4,9" {
            print("A7 device detected!")
            //let output1 = runTerminalCommand("\(resourcesPath)/irecovery -q > \(resourcesPath)/work/dfu.txt 2>&1")
            //print(output1)
            sleep(2)
            //let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
            // self.processDeviceDataNotNormalV2(from: fileURL)
            // let success = self.showAskiOSVersionAlert2ReLock()  // Get success or failure
            self.showAskiOSVersionAlert2ReLock()
            // if !success {
            // return  // Stop further processing because processDeviceDataNoPopUp failed
            // }
        } else if findDeviceModelRecovery == "iPhone10,6" || findDeviceModelRecovery == "iPhone10,3" {
            
            let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/deviceinfo.txt")
            do {
                let fileData = try String(contentsOf: fileURL, encoding: .utf8)
                
                if let iosVersion = extractData(from: fileData, start: "ProductVersion: ", end: "ProductionSOC:")?.trimmingCharacters(in: .whitespacesAndNewlines), !iosVersion.isEmpty {
                    let versionComponents = iosVersion.split(separator: ".").map(String.init)
                    var major = 0
                    var minor = 0
                    
                    if versionComponents.count > 0 {
                        major = Int(versionComponents[0]) ?? 0
                    }
                    if versionComponents.count > 1 {
                        minor = Int(versionComponents[1]) ?? 0
                    }
                    
                    let versionNumber = Double("\(major).\(minor)") ?? 0.0
                    
                    if versionNumber >= 12.0 {
                        print("iOS Version entered: \(iosVersion)\n")  // Correctly unwrapped
                        print("iPhone X Detected!")
                        
                        let output1 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script_pale && chmod +x * && xattr -cr * && chmod +x Darwin/* && xattr -cr Darwin/*")
                        print(output1)
                        
                        sleep(1)
                        print("Booting Palera1n Ramdisk...")
                        sleep(1)
                        
                        let output2 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script_pale/ && ./sshrd.sh boot > log.txt")
                        print(output2)
                        
                        sleep(8)
                        print("Palera1n Ramdisk should now be booted!")
                        
                        // sleep(2)
                        print("Starting re-lock script...")
                        sleep(3)
                        let scriptPath = "\(resourcesPath)/unhide_baseband.sh"
                        let process = Process()
                        process.executableURL = URL(fileURLWithPath: "/bin/sh")
                        process.arguments = [scriptPath]
                        do {
                            try process.run()
                            process.waitUntilExit()
                        } catch {
                            // If failed, then print the error
                            print("Failed to run script: \(error)")
                        }
                        sleep(3)
                        print("✓ iCloud bypass complete! ✓")
                        showAlert(message: "iCloud Bypass Done!", informativeText: "Enjoy your bypassed device!\n\nPS. If you got some of your devices working thanks to this tool, send me a DM on X (@AlwaysAppleFTD) or on Instagram (@finn.desilva) :)")
                    } else {
                        print("ERROR: iOS Version not supported!")
                        print("iOS Version entered: \(iosVersion)")  // Correctly unwrapped
                        showAlert(message: "ERROR: The iOS version you entered is not supported!", informativeText: "Lockra1n supports checkm8-compatible devices running iOS 12.0 - 16.7.8")
                        return
                    }
                } else {
                    print("No iOS version in text file.")
                    print("Asking user what iOS version device is running...")
                    if let iosVersion = promptForiOSVersion() {
                        let versionComponents = iosVersion.split(separator: ".").map(String.init)
                        var major = 0
                        var minor = 0
                        
                        if versionComponents.count > 0 {
                            major = Int(versionComponents[0]) ?? 0
                        }
                        if versionComponents.count > 1 {
                            minor = Int(versionComponents[1]) ?? 0
                        }
                        
                        // Use only major and minor for comparison and further processing
                        let versionNumber = Double("\(major).\(minor)") ?? 0.0
                        
                        if versionNumber >= 12.0 {
                            // Use the user's input
                            print("iOS Version entered: \(iosVersion)")
                            print("iPhone X Detected!")
                            
                            let output1 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script_pale && chmod +x * && xattr -cr * && chmod +x Darwin/* && xattr -cr Darwin/*")
                            print(output1)
                            
                            sleep(1)
                            print("Booting Ramdisk...")
                            sleep(1)
                            
                            let output2 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script_pale && ./sshrd.sh boot > log.txt")
                            print(output2)
                            
                            sleep(8)
                            
                            print("Ramdisk should now be booted.")
                            sleep(2)
                            print("Starting re-lock script...")
                            sleep(3)
                            let scriptPath = "\(resourcesPath)/unhide_baseband.sh"
                            let process = Process()
                            process.executableURL = URL(fileURLWithPath: "/bin/sh")
                            process.arguments = [scriptPath]
                            do {
                                try process.run()
                                process.waitUntilExit()
                            } catch {
                                // If failed, then print the error
                                print("Failed to run script: \(error)")
                            }
                            sleep(3)
                            print("✓ iCloud bypass complete! ✓")
                            showAlert(message: "iCloud Bypass Done!", informativeText: "Enjoy your bypassed device!\n\nPS. If you got some of your devices working thanks to this tool, send me a DM on X (@AlwaysAppleFTD) or on Instagram (@finn.desilva) :)")
                            // print("No iOS version in text file or failed to fetch iOS version.")
                            // print("iOS Version entered: \(iosVersion)")  // Correctly unwrapped
                            // showAlert(message: "ERROR: No iOS Version was found!", informativeText: "This is most likely a Swift related problem. Please contact me on X @AlwaysAppleFTD or on Instagram @finn.desilva and I will help you.\n\nAlso, please remember that your feedback on this tool is important! The more users report bugs, the sooner I can fix them.")
                        } else {
                            // Default to 12.0
                            let defaultVersion = "12.0"
                            print("ERROR: iOS Version not supported!")
                            showAlert(message: "ERROR: The iOS version you entered is not supported!", informativeText: "Lockra1n supports checkm8-compatible devices running iOS 12.0 - 16.7.8")
                            return
                        }
                        
                        // showAlert(message: "Ramdisk has been created!", informativeText: "Press OK to boot your device into SSH Ramdisk mode.")
                        
                    } else {
                        // Handle the case where no iOS version was entered
                        print("No iOS version entered.")
                        showAlert(message: "ERROR: No iOS Version was entered!", informativeText: "You must enter the iOS Version of your device to continue.\n\nIf you don't know the exact version, you can put a rough guess like 13.0 or 15.0.")
                        return
                    }
                    return
                }
            } catch {
                print("An error occurred while reading the file: \(error)")
                return
            }
            } else {
                print("A8 or higher device detected!")
                //let success = self.showAskiOSVersionAlertReLock()  // Get success or failure
                self.showAskiOSVersionAlertReLock()
                // if !success {
                    // return  // Stop further processing because processDeviceDataNoPopUp failed
                // }
            }
    }
    
    func onlyDetectDFUDeviceReLock() {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return
        }

        let checkDeviceConnected = self.iRecoveryInfo("ERROR")
        
        if checkDeviceConnected == "Unable to connect to device" {
            print("No device found!")
            showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
            return
        }
        
        let checkDeviceState = self.iRecoveryInfo("MODE")
        let findDeviceModelRecovery = self.iRecoveryInfo("PRODUCT")

        if checkDeviceState == "Recovery" {
            print("Found device in Recovery Mode!")
            self.showAlert(message: "Device is in Recovery Mode!", informativeText: "You must be in DFU Mode to continue. Try entering DFU Mode again, and be sure the device's screen is black before continuing. Then press the 'Re-Lock device (un-hide baseband)' button again to try again.")
            return
        } else if checkDeviceState == "DFU" {
            
            print("DFU Mode device found!")
            guard let resourcesPath = Bundle.main.resourcePath else {
                print("Failed to find the main bundle's resource path")
                return
            }
        }
    }
    
    func detectDFUDeviceNoPopUpV2Restore() {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return
        }

        let checkDeviceConnected = self.iRecoveryInfo("ERROR")
        
        if checkDeviceConnected == "Unable to connect to device" {
            print("No device found!")
            showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
            return
        }
        
        let checkDeviceState = self.iRecoveryInfo("MODE")
        let findDeviceModelRecovery = self.iRecoveryInfo("PRODUCT")
        
        if checkDeviceState == "Recovery" {
                let deviceModel = self.iRecoveryInfo("NAME")
                print("Found device in Recovery Mode!")
                self.showAlert(message: "Device is in Recovery Mode!", informativeText: "You must be in DFU Mode to continue. Try entering DFU Mode again, and be sure the device's screen is black before continuing. Then press the 'Bypass Device!' button again to try again.")
            return
        } else if checkDeviceState == "DFU" {
            print("DFU Mode device found!")
            // Change isDFUDetected to true to prevent further DFU detections
            // self.detectDFUDeviceNoPopUpV2()
            guard let resourcesPath = Bundle.main.resourcePath else {
                print("Failed to find the main bundle's resource path")
                return
            }
        }
        
            if findDeviceModelRecovery == "iPhone6,1" || findDeviceModelRecovery == "iPad4,1" || findDeviceModelRecovery == "iPad4,2" || findDeviceModelRecovery == "iPad4,3" || findDeviceModelRecovery == "iPad4,4" || findDeviceModelRecovery == "iPad4,5" || findDeviceModelRecovery == "iPad4,6" || findDeviceModelRecovery == "PRODUCT: iPad4,7" || findDeviceModelRecovery == "iPad4,8" || findDeviceModelRecovery == "iPad4,9" {
                print("A7 device detected!")
                sleep(2)
                self.showA7PwnDFU()
                runTerminalCommand("cd \(resourcesPath) && ./startrestore.sh > work/restorelog.txt 2>&1")
                sleep(3)
                let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/restorelog.txt")
                do {
                    let fileData = try String(contentsOf: fileURL, encoding: .utf8)
                    
                    if fileData.contains("ERROR: Could not make sure this firmware is suitable for the current device. Refusing to continue.") {
                        print("ERROR: Selected IPSW may not be compatible.")
                        showAlert(message: "An error occurred:", informativeText: "The firmware file you selected may not be compatible with the connected device.")
                        return
                    } else if fileData.contains("ERROR: Unable to extract BuildManifest from ") {
                        print("ERROR: Firmware file may be corrupt.")
                        showAlert(message: "An error occurred:", informativeText: "The firmware file you selected may be corrupt or damaged. Try re-downloading the corresponding IPSW file that is currently signed for your device from https://ipsw.me")
                    } else if fileData.contains("ERROR: Unable to get SHSH blobs for this device") {
                        print("ERROR: Firmware is not being signed!")
                        showAlert(message: "An error occurred:", informativeText: "The firmware file you selected is not currently signed! Try re-downloading the corresponding signed IPSW file for your device from https://ipsw.me")
                        return
                    } else {
                        print("Restore was attempted!")
                        showAlert(message: "Success!", informativeText: "The software has attempted to restore your device. This was only successful if your device turned on to the Apple logo, and the restore bar went all the way across and rebooted. If not, read the restorelog.txt file in this app's Resources folder to learn more about what failed. Then, contact me with the error and I will configure Lockra1n to handle this error message.\n\nAlso, please remember that your feedback on this tool is important! The more users report bugs, the sooner I can fix them.")
                        return
                    }
                } catch {
                    print("An error occurred while reading the file: \(error)")
                    return
                }
            } else {
                print("A8 or higher device detected!")
                sleep(2)
                // self.showA7PwnDFU()
                let output1 = runTerminalCommand("\(resourcesPath)/gaster pwn")
                print(output1)
                
                let output2 = runTerminalCommand("cd \(resourcesPath) && ./startrestore.sh > work/restorelog.txt 2>&1")
                print(output2)
                
                sleep(3)
                let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/restorelog.txt")
                do {
                    let fileData = try String(contentsOf: fileURL, encoding: .utf8)
                    
                    if fileData.contains("ERROR: Could not make sure this firmware is suitable for the current device. Refusing to continue.") {
                        print("ERROR: Selected IPSW may not be compatible.")
                        showAlert(message: "An error occurred:", informativeText: "The firmware file you selected may not be compatible with the connected device.")
                        return
                    } else if fileData.contains("ERROR: Unable to extract BuildManifest from ") {
                        print("ERROR: Firmware file may be corrupt.")
                        showAlert(message: "An error occurred:", informativeText: "The firmware file you selected may be corrupt or damaged. Try re-downloading the corresponding IPSW file that is currently signed for your device from https://ipsw.me")
                    } else if fileData.contains("ERROR: Unable to get SHSH blobs for this device") {
                        print("ERROR: Firmware is not being signed!")
                        showAlert(message: "An error occurred:", informativeText: "The firmware file you selected is not currently signed! Try re-downloading the corresponding signed IPSW file for your device from https://ipsw.me")
                        return
                    } else {
                        print("Restore was attempted!")
                        showAlert(message: "Success!", informativeText: "The software has attempted to restore your device. This was only successful if your device turned on to the Apple logo, and the restore bar went all the way across and rebooted. If not, read the restorelog.txt file in this app's Resources folder to learn more about what failed. Then, contact me with the error and I will configure Lockra1n to handle this error message.\n\nAlso, please remember that your feedback on this tool is important! The more users report bugs, the sooner I can fix them.")
                        return
                    }
                } catch {
                    print("An error occurred while reading the file: \(error)")
                    return
                }
            }
        return
    }
    
    func processDeviceDataNotNormalV2(from fileURL: URL) {
        do {
            let fileData = try String(contentsOf: fileURL, encoding: .utf8)
            
            if fileData.contains("ERROR:") {
                print("ERROR: No device found!")
                showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
            } else {
                let deviceModel = extractData(from: fileData, start: "NAME: ", end: "\n")  // Assuming each data ends with a newline
                let deviceMode = extractData(from: fileData, start: "MODE: ", end: "\n")  // Assuming PRODUCT follows a newline after MODE

                if let mode = deviceMode {
                    if mode == "Recovery" {
                        print("Found device in Recovery Mode!")
                        showAlert(message: "Please enter DFU Mode now!", informativeText: "If you need instructions on how to enter DFU Mode, please Google 'How to enter DFU mode on \(deviceModel ?? "")'. Then find an online tutorial or website post.")
                        self.detectDFUDeviceNoPopUpV2()
                    } else if mode == "DFU" {
                        print("DFU Mode device found!")
                        guard let resourcesPath = Bundle.main.resourcePath else {
                            print("Failed to find the main bundle's resource path")
                            return
                        }
                        //self.showAskiOSVersionAlert()
                        // Further custom logic for handling DFU mode
                    } else {
                        print("Device is neither in Recovery nor DFU Mode.")
                        showAlert(message: "Device status unclear!", informativeText: "The device status could not be determined accurately.")
                        return
                    }
                } else {
                    print("Failed to determine device mode")
                    showAlert(message: "Device information error!", informativeText: "Could not extract device mode information.")
                    return
                }
            }
        } catch {
            print("An error occurred while reading the file: \(error)")
            showAlert(message: "Read error!", informativeText: "An error occurred while trying to read the device information file.")
        }
    }
    
    
    func detectDFUDeviceNoPopUp() -> Bool {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return false
        }
        
        let checkDeviceConnected = self.iRecoveryInfo("ERROR")
        
        if checkDeviceConnected == "Unable to connect to device" {
            print("No device found!")
            showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
            return false
        }
        
        let checkDeviceState = self.iRecoveryInfo("MODE")
        let findDeviceModelRecovery = self.iRecoveryInfo("PRODUCT")
        
        if checkDeviceState == "Recovery" {
                let deviceModel = self.iRecoveryInfo("NAME")
                print("Found device in Recovery Mode!")
                self.showAlert(message: "Device is in Recovery Mode!", informativeText: "You must be in DFU Mode to continue. Try entering DFU Mode again, and be sure the device's screen is black before continuing. Then press the 'Bypass Device!' button again to try again.")
            return false
        } else if checkDeviceState == "DFU" {
            print("DFU Mode device found!")
            print("All checks passed.")
            // Change isDFUDetected to true to prevent further DFU detections
            // self.detectDFUDeviceNoPopUpV2()
            guard let resourcesPath = Bundle.main.resourcePath else {
                print("Failed to find the main bundle's resource path")
                return false
            }
            return true
        }
        // Jusy for safety: Ideally this should never be reached unless there's a logical flaw in the flow above
        return false
    }
    
    func detectDFUDeviceNoPopUpA7(from fileURL: URL) -> Bool {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return false
        }
        
        let output1 = runTerminalCommand("\(resourcesPath)/irecovery -q > \(resourcesPath)/work/dfu.txt 2>&1")
        print(output1)
        
        let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
        do {
            let fileData = try String(contentsOf: fileURL, encoding: .utf8)
            //print("File Data: \(fileData)") // Debug: Check what is being read
            
            // print(fileData)
            if fileData.contains("ERROR:") {
                print("No device found!")
                let alert3 = NSAlert()
                alert3.messageText = "No device was found!"
                alert3.informativeText = "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter."
                alert3.addButton(withTitle: "OK")
                alert3.runModal()
                return false  // Indicate failure
            } else if fileData.contains("Recovery") {
                print("Found device in Recovery Mode!")
                showAlert(message: "Please enter DFU Mode now!", informativeText: "If you need instructions on how to enter DFU Mode, please Google 'How to enter DFU mode on ' and then your device model. Example might be 'How to enter DFU mode on iPhone 8'. Then find an online tutorial or website post.")
                // let fileURL2 = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
                self.detectDFUDeviceNoPopUp()
                return false  // Indicate failure
            } else {
                print("All checks passed.")
                self.showAskiOSVersionAlert2()
                return true  // Indicate success
            }
        } catch {
            print("An error occurred while reading the file: \(error)")
            return false  // Indicate failure on exception
        }
        // Jusy for safety: Ideally this should never be reached unless there's a logical flaw in the flow above
        return false
    }
    
    func detectDFUDeviceNoPopUpA8(from fileURL: URL) -> Bool {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return false
        }
        
        let output1 = runTerminalCommand("\(resourcesPath)/irecovery -q > \(resourcesPath)/work/dfu.txt 2>&1")
        print(output1)
        
        let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
        do {
            let fileData = try String(contentsOf: fileURL, encoding: .utf8)
            //print("File Data: \(fileData)") // Debug: Check what is being read
            
            // print(fileData)
            if fileData.contains("ERROR:") {
                print("No device found!")
                let alert3 = NSAlert()
                alert3.messageText = "No device was found!"
                alert3.informativeText = "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter."
                alert3.addButton(withTitle: "OK")
                alert3.runModal()
                return false  // Indicate failure
            } else if fileData.contains("Recovery") {
                print("Found device in Recovery Mode!")
                showAlert(message: "Please enter DFU Mode now!", informativeText: "If you need instructions on how to enter DFU Mode, please Google 'How to enter DFU mode on ' and then your device model. Example might be 'How to enter DFU mode on iPhone 8'. Then find an online tutorial or website post.")
                // let fileURL2 = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
                self.detectDFUDeviceNoPopUp()
                return false  // Indicate failure
            } else {
                print("All checks passed.")
                let success = self.showAskiOSVersionAlert()  // Get success or failure
                
                if !success {
                    return false  // Stop further processing because processDeviceDataNoPopUp failed
                }
                // return true  // Indicate success
            }
        } catch {
            print("An error occurred while reading the file: \(error)")
            return false  // Indicate failure on exception
        }
        // Jusy for safety: Ideally this should never be reached unless there's a logical flaw in the flow above
        return false
    }
    
    func processDeviceDataNotNormal(from fileURL: URL) {
        do {
            let fileData = try String(contentsOf: fileURL, encoding: .utf8)
            
            if fileData.contains("ERROR:") {
                print("ERROR: No device found!")
                showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
            } else {
                let deviceModel = extractData(from: fileData, start: "NAME: ", end: "\n")  // Assuming each data ends with a newline
                let deviceMode = extractData(from: fileData, start: "MODE: ", end: "\n")  // Assuming PRODUCT follows a newline after MODE

                if let mode = deviceMode {
                    if mode == "Recovery" {
                        print("Found device in Recovery Mode!")
                        showAlert(message: "Please enter DFU Mode now!", informativeText: "If you need instructions on how to enter DFU Mode, please Google 'How to enter DFU mode on \(deviceModel ?? "")'. Then find an online tutorial or website post.")
                        self.detectDFUDevice()
                    } else if mode == "DFU" {
                        print("DFU Mode device found!")
                        guard let resourcesPath = Bundle.main.resourcePath else {
                            print("Failed to find the main bundle's resource path")
                            return
                        }
                        //self.showAskiOSVersionAlert()
                        // Further custom logic for handling DFU mode
                    } else {
                        print("Device is neither in Recovery nor DFU Mode.")
                        showAlert(message: "Device status unclear!", informativeText: "The device status could not be determined accurately.")
                        return
                    }
                } else {
                    print("Failed to determine device mode")
                    showAlert(message: "Device information error!", informativeText: "Could not extract device mode information.")
                    return
                }
            }
        } catch {
            print("An error occurred while reading the file: \(error)")
            showAlert(message: "Read error!", informativeText: "An error occurred while trying to read the device information file.")
        }
    }

    
    class FileChecker {
        static func checkPython2Installation() -> Bool {
            let path = "/usr/local/bin/python2"
            return FileManager.default.fileExists(atPath: path)
        }
    }

    class FileChecker2 {
        static func checkLibUSBInstallation() -> Bool {
            let path = "/usr/local/lib/libusb-1.0.dylib"
            return FileManager.default.fileExists(atPath: path)
        }
    }
    
    private func showAskiOSVersionAlert() -> Bool {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return false
        }
        
        let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/deviceinfo.txt")
        do {
            let fileData = try String(contentsOf: fileURL, encoding: .utf8)

            if let iosVersion = extractData(from: fileData, start: "ProductVersion: ", end: "ProductionSOC:")?.trimmingCharacters(in: .whitespacesAndNewlines), !iosVersion.isEmpty {
                let versionComponents = iosVersion.split(separator: ".").map(String.init)
                var major = 0
                var minor = 0

                if versionComponents.count > 0 {
                    major = Int(versionComponents[0]) ?? 0
                }
                if versionComponents.count > 1 {
                    minor = Int(versionComponents[1]) ?? 0
                }
                
                let versionNumber = Double("\(major).\(minor)") ?? 0.0

                if versionNumber >= 12.0 {
                    print("iOS Version entered: \(iosVersion)")  // Correctly unwrapped
                    
                    let output1 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && chmod +x * && xattr -cr * && chmod +x Darwin/* && xattr -cr Darwin/*")
                    print(output1)
                    
                    let output2 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && ./sshrd.sh \(iosVersion) > log.txt")
                    print(output2)
                    
                    showAlert(message: "Ramdisk has been created!", informativeText: "Press OK to boot your device into SSH Ramdisk mode.")
                    
                    sleep(1)
                    print("Booting Ramdisk...")
                    sleep(1)
                    
                    let output3 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && ./sshrd.sh boot > log.txt")
                    print(output3)
                    
                    sleep(5)
                    
                    print("Ramdisk should now be booted.")
                    sleep(2)
                    print("Starting bypass script...")
                    sleep(3)
                    let scriptPath = "\(resourcesPath)/bypass.sh"
                    let process = Process()
                    process.executableURL = URL(fileURLWithPath: "/bin/sh")
                    process.arguments = [scriptPath]
                    do {
                        try process.run()
                        process.waitUntilExit()
                    } catch {
                        // If failed, then print the error
                        print("Failed to run script: \(error)")
                    }
                    sleep(3)
                    print("✓ iCloud bypass complete! ✓")
                    showAlert(message: "iCloud Bypass Done!", informativeText: "Enjoy your bypassed device!\n\nPS. If you got some of your devices working thanks to this tool, send me a DM on X (@AlwaysAppleFTD) or on Instagram (@finn.desilva) :)")
                } else {
                    print("ERROR: iOS Version not supported!")
                    print("iOS Version entered: \(iosVersion)")  // Correctly unwrapped
                    showAlert(message: "ERROR: The iOS version you entered is not supported!", informativeText: "Lockra1n supports checkm8-compatible devices running iOS 12.0 - 16.7.8")
                    return false
                }
            } else {
                print("No iOS version in text file.")
                print("Asking user what iOS version device is running...")
                if let iosVersion = promptForiOSVersion() {
                    let versionComponents = iosVersion.split(separator: ".").map(String.init)
                    var major = 0
                    var minor = 0
                    
                    if versionComponents.count > 0 {
                        major = Int(versionComponents[0]) ?? 0
                    }
                    if versionComponents.count > 1 {
                        minor = Int(versionComponents[1]) ?? 0
                    }
                    
                    // Use only major and minor for comparison and further processing
                    let versionNumber = Double("\(major).\(minor)") ?? 0.0
                    
                    if versionNumber >= 12.0 {
                        // Use the user's input
                        print("iOS Version entered: \(iosVersion)")
                        
                        let output1 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && chmod +x * && xattr -cr * && chmod +x Darwin/* && xattr -cr Darwin/*")
                        print(output1)
                        
                        let output2 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && ./sshrd.sh \(iosVersion) > log.txt")
                        print(output2)
                        
                        showAlert(message: "Ramdisk has been created!", informativeText: "Press OK to boot your device into SSH Ramdisk mode.")
                        
                        sleep(1)
                        print("Booting Ramdisk...")
                        sleep(1)
                        
                        let output3 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && ./sshrd.sh boot > log.txt")
                        print(output3)
                        
                        sleep(3)
                        
                        print("Ramdisk should now be booted.")
                        sleep(2)
                        print("Starting bypass script...")
                        sleep(3)
                        let scriptPath = "\(resourcesPath)/bypass.sh"
                        let process = Process()
                        process.executableURL = URL(fileURLWithPath: "/bin/sh")
                        process.arguments = [scriptPath]
                        do {
                            try process.run()
                            process.waitUntilExit()
                        } catch {
                            // If failed, then print the error
                            print("Failed to run script: \(error)")
                        }
                        sleep(3)
                        print("✓ iCloud bypass complete! ✓")
                        showAlert(message: "iCloud Bypass Done!", informativeText: "Enjoy your bypassed device!\n\nPS. If you got some of your devices working thanks to this tool, send me a DM on X (@AlwaysAppleFTD) or on Instagram (@finn.desilva) :)")
                // print("No iOS version in text file or failed to fetch iOS version.")
                // print("iOS Version entered: \(iosVersion)")  // Correctly unwrapped
                // showAlert(message: "ERROR: No iOS Version was found!", informativeText: "This is most likely a Swift related problem. Please contact me on X @AlwaysAppleFTD or on Instagram @finn.desilva and I will help you.\n\nAlso, please remember that your feedback on this tool is important! The more users report bugs, the sooner I can fix them.")
                    } else {
                        // Default to 12.0
                        let defaultVersion = "12.0"
                        print("ERROR: iOS Version not supported!")
                        showAlert(message: "ERROR: The iOS version you entered is not supported!", informativeText: "Lockra1n supports checkm8-compatible devices running iOS 12.0 - 16.7.8")
                        return false
                    }
                    
                    //showAlert(message: "Ramdisk has been created!", informativeText: "Press OK to boot your device into SSH Ramdisk mode.")
                    
                } else {
                    // Handle the case where no iOS version was entered
                    print("No iOS version entered.")
                    showAlert(message: "ERROR: No iOS Version was entered!", informativeText: "You must enter the iOS Version of your device to continue.\n\nIf you don't know the exact version, you can put a rough guess like 13.0 or 15.0.")
                    return false
                }
                return false
            }
        } catch {
            print("An error occurred while reading the file: \(error)")
            return false
        }
        
        // Jusy for safety: Ideally this should never be reached unless there's a logical flaw in the flow above
        return false
    }
    
    private func showAskiOSVersionAlert2() -> Bool {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return false
        }
        
        self.showAlert(message: "We will stick to 12.0 for this ramdisk.", informativeText: "Because your device is an A7 device, and A7 devices only go up to iOS 12, the ramdisk iOS version will be set to 12.0. No override is needed, because the minimum supported iOS version for Lockra1n is 12.0. If your device is lower then 12.0, then your iOS version is not supported. You can most likely just boot a ramdisk and rename Setup.app to Setup.bak or anything and the device will boot up bypassed. Note that on iOS 10 or later, you will need to erase without updating before preforming the bypass. Message me on social media with your device and iOS version and I can guide you through the process.")
        
        if !FileChecker.checkPython2Installation() {
            self.showAlert(message: "Python2 is not installed and is required!", informativeText: "Please install it now by pressing OK then running through the installer that opens. Once you have completed the installer, click OK on the next pop-up.")
            runTerminalCommand("open \(resourcesPath)/Python/python2.pkg")
            self.showAlert(message: "Please press OK once you have completed the Python installation.", informativeText: "")
        }
        
        if !FileChecker2.checkLibUSBInstallation() {
            self.showAlert(message: "libusb is not installed and is required!", informativeText: "It will now install when you press OK. Then the app will continue running through the Ramdisk creation process. ")
            //let mvlibusbcmd = runTerminalCommand("mv \(quotedResourcesPath)/libusb ~/libusb")
            //print(mvlibusbcmd)
            
            let cplibusbcmd = runTerminalCommand("cp -R \(resourcesPath)/libusb/libusb-1.0.dylib /usr/local/lib")
            print(cplibusbcmd)
            
            sleep(2)
        }
        
        print("Passed!")
        sleep(5)
        
        let output1 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && chmod +x * && xattr -cr * && chmod +x Darwin/* && xattr -cr Darwin/*")
        print(output1)
        
        let output2 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && ./sshrd.sh 12.0 > log.txt")
        print(output2)
        
        showAlert(message: "Ramdisk has been created!", informativeText: "Press OK to boot your device into SSH Ramdisk mode.")
        
        sleep(1)
        print("Booting Ramdisk...")
        sleep(1)
        
        let output3 = runTerminalCommand("cd \(resourcesPath)/ipwndfu_public && chmod +x * && xattr -cr *")
        print(output3)
        
        let output4 = runTerminalCommand("cd \(resourcesPath)/ipwndfu_public && /usr/local/bin/python ./ipwndfu -p > pwndfu.txt 2>&1")
        print(output4)
        
        let pathToPwnDFUStatus = "\(resourcesPath)/ipwndfu_public/pwndfu.txt" // Correctly using resourcesPath directly because for some reason quotedResourcesPath doesn't work for this situation.
        
        do {
            let pwndfuStatusData = try String(contentsOfFile: pathToPwnDFUStatus, encoding: .utf8)
            
            if pwndfuStatusData.contains("ERROR: No Apple device in DFU Mode 0x1227 detected after 5.00 second timeout. Exiting.") {
                print("ERROR: ipwndfu failed to detect your device!")
                print("This may also mean that your device rebooted by accident.")
                showAlert(message: "ERROR: ipwndfu has failed to detect your device!", informativeText: "Please make sure the device's screen is black and you have entered DFU mode correctly.\n\nAdditionally, if the device is showing the Apple logo, then it means it accidentally rebooted out of DFU mode. To fix this, re-enter DFU mode any try creating the ramdisk again.")
                return false
            } else {
                //  Handle if the device entered PwnDFU successfully
                print("Success! Your device should now be in PwnDFU mode.")
            }
        } catch {
            print("Error reading file: \(error)")
        }
        
        sleep(3)
        
        let output5 = runTerminalCommand("cd \(resourcesPath)/ipwndfu_public && /usr/local/bin/python2 rmsigchks.py > unsignedfiles.txt 2>&1")
        print(output5)
        
        let pathToSigChecksStatus = "\(resourcesPath)/ipwndfu_public/pwndfu.txt" // Correctly using resourcesPath directly because for some reason quotedResourcesPath doesn't work for this situation.
        
        do {
            let sigChecksStatusData = try String(contentsOfFile: pathToSigChecksStatus, encoding: .utf8)
            
            if sigChecksStatusData.contains("Input/Output Error") {
                print("Notice: A temporary error has ocurred. We will try to fix this now...")
                print("Re-running rmsigchks.py")
                sleep(2)
                let rmsigchkscmd = runTerminalCommand("cd \(resourcesPath)/ipwndfu_public && /usr/local/bin/python2 rmsigchks.py > unsignedfiles.txt 2>&1")
                print(rmsigchkscmd)
                print("Lockra1n has attempted to fix the Input/Output Error!")
                print("If successful, the text file in the ipwndfu_public folder should say 'Patches have already been applied. Exiting.'.")
                print("if it fails to boot the ramdisk, please check all log files in the 'work' folder in the Resources folder, and also the log files in 'ipwndfu_public' in the Resources folder.")
                sleep(2)
                // return false
            } else {
                //  Handle if the device entered PwnDFU successfully
                print("Success! Your device should now have Signature Checks removed.")
            }
        } catch {
            print("Error reading file: \(error)")
        }
        
        let output6 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && ./sshrd.sh boot > log.txt")
        print(output6)
        
        sleep(3)
        
        print("If there is no text on the screen right now, then booting the ramdisk failed!")
        print("Reboot out of DFU Mode by pressing and holding Home + Power buttons together until you see the Apple Logo, then try again.")
        print("It may take a few tries to succeed.")
        sleep(3)
        
        print("Ramdisk should now be booted.")
        sleep(2)
        print("Starting bypass script...")
        sleep(3)
        let scriptPath = "\(resourcesPath)/bypass.sh"
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/sh")
        process.arguments = [scriptPath]
        do {
            try process.run()
            process.waitUntilExit()
        } catch {
            // If failed, then print the error
            print("Failed to run script: \(error)")
        }
        sleep(3)
        print("✓ iCloud bypass complete! ✓")
        showAlert(message: "iCloud Bypass Done!", informativeText: "Enjoy your bypassed device!\n\nPS. If you got some of your devices working thanks to this tool, send me a DM on X (@AlwaysAppleFTD) or on Instagram (@finn.desilva) :)")

        //self.showAlert(message: "Ramdisk is Booted!", informativeText: "If there is no verbose text on the screen, then your device's iOS version is incompatible with this tool.\nEven if there only a logo, DO NOT continue!\n\nThis rarely happens though.")
        return false
    }
    
    func showA7PwnDFU() {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return
        }
        
        // self.showAlert(message: "We will stick to 12.0 for this ramdisk.", informativeText: "Because your device is an A7 device, and A7 devices only go up to iOS 12, the ramdisk iOS version will be set to 12.0. No override is needed, because even if your device is lower then 12.0, the ramdisk will boot fine due to old iOS's being interchangeable.")
        
        if !FileChecker.checkPython2Installation() {
            self.showAlert(message: "Python2 is not installed and is required!", informativeText: "Please install it now by pressing OK then running through the installer that opens. Once you have completed the installer, click OK on the next pop-up.")
            runTerminalCommand("open \(resourcesPath)/Python/python2.pkg")
            self.showAlert(message: "Please press OK once you have completed the Python installation.", informativeText: "")
        }
        
        if !FileChecker2.checkLibUSBInstallation() {
            self.showAlert(message: "libusb is not installed and is required!", informativeText: "It will now install when you press OK. Then the app will continue running through the Ramdisk creation process. ")
            //let mvlibusbcmd = runTerminalCommand("mv \(quotedResourcesPath)/libusb ~/libusb")
            //print(mvlibusbcmd)
            
            let cplibusbcmd = runTerminalCommand("cp -R \(resourcesPath)/libusb/libusb-1.0.dylib /usr/local/lib")
            print(cplibusbcmd)
            
            sleep(2)
        }
        
        print("Passed!")
        sleep(5)
        
        let output1 = runTerminalCommand("cd \(resourcesPath)/ipwndfu_public && chmod +x * && xattr -cr *")
        print(output1)
        
        let output2 = runTerminalCommand("cd \(resourcesPath)/ipwndfu_public && /usr/local/bin/python2 ./ipwndfu -p > pwndfu.txt")
        print(output2)
        
        let pathToPwnDFUStatus = "\(resourcesPath)/ipwndfu_public/pwndfu.txt" // Correctly using resourcesPath directly because for some reason quotedResourcesPath doesn't work for this situation.
        
        do {
            let pwndfuStatusData = try String(contentsOfFile: pathToPwnDFUStatus, encoding: .utf8)
            
            if pwndfuStatusData.contains("ERROR: No Apple device in DFU Mode 0x1227 detected after 5.00 second timeout. Exiting.") {
                print("ERROR: ipwndfu failed to detect your device!")
                print("This may also mean that your device rebooted by accident.")
                showAlert(message: "ERROR: ipwndfu has failed to detect your device!", informativeText: "Please make sure the device's screen is black and you have entered DFU mode correctly.\n\nAdditionally, if the device is showing the Apple logo, then it means it accidentally rebooted out of DFU mode. To fix this, re-enter DFU mode any try creating the ramdisk again.")
                return
            } else {
                //  Handle if the device entered PwnDFU successfully
                print("Success! Your device should now be in PwnDFU mode.")
            }
        } catch {
            print("Error reading file: \(error)")
        }
        
        let output3 = runTerminalCommand("cd \(resourcesPath)/ipwndfu_public && /usr/local/bin/python rmsigchks.py > unsignedfiles.txt")
        print(output3)
        
        print("✓ Your A7 device should now be in pwned DFU mode with signature checks removed! ✓")
        // showAlert(message: "Done!", informativeText: "Your A7 device should now be in pwned DFU mode with signature checks removed!")
    }
    
    private func showAskiOSVersionAlertReLock() {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return
        }
        
        let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/deviceinfo.txt")
        do {
            let fileData = try String(contentsOf: fileURL, encoding: .utf8)

            if let iosVersion = extractData(from: fileData, start: "ProductVersion: ", end: "ProductionSOC:")?.trimmingCharacters(in: .whitespacesAndNewlines), !iosVersion.isEmpty {
                let versionComponents = iosVersion.split(separator: ".").map(String.init)
                var major = 0
                var minor = 0
                
                if versionComponents.count > 0 {
                    major = Int(versionComponents[0]) ?? 0
                }
                if versionComponents.count > 1 {
                    minor = Int(versionComponents[1]) ?? 0
                }
                
                let versionNumber = Double("\(major).\(minor)") ?? 0.0
                
                if versionNumber >= 12.0 {
                    print("iOS Version entered: \(iosVersion)")  // Correctly unwrapped
                    
                    let output1 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && chmod +x * && xattr -cr * && chmod +x Darwin/* && xattr -cr Darwin/*")
                    print(output1)
                    
                    let output2 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && ./sshrd.sh \(iosVersion) > log.txt")
                    print(output2)
                    
                    showAlert(message: "Ramdisk has been created!", informativeText: "Press OK to boot your device into SSH Ramdisk mode.")
                    
                    sleep(1)
                    print("Booting Ramdisk...")
                    sleep(1)
                    
                    let output3 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && ./sshrd.sh boot > log.txt")
                    print(output3)
                    
                    sleep(5)
                    
                    print("Ramdisk should now be booted.")
                    sleep(2)
                    print("Starting re-lock script...")
                    sleep(3)
                    let scriptPath = "\(resourcesPath)/unhide_baseband.sh"
                    let process = Process()
                    process.executableURL = URL(fileURLWithPath: "/bin/sh")
                    process.arguments = [scriptPath]
                    do {
                        try process.run()
                        process.waitUntilExit()
                    } catch {
                        // If failed, then print the error
                        print("Failed to run script: \(error)")
                    }
                    sleep(3)
                    print("✓ Device Re-lock complete! ✓")
                    showAlert(message: "Device Re-lock Done!", informativeText: "Your device will now boot up to the setup screen!\n\nPS. If you got some of your devices working thanks to this tool, send me a DM on X (@AlwaysAppleFTD) or on Instagram (@finn.desilva) :)")
                } else {
                    print("ERROR: iOS Version not supported!")
                    print("iOS Version entered: \(iosVersion)")  // Correctly unwrapped
                    showAlert(message: "ERROR: The iOS version you entered is not supported!", informativeText: "Lockra1n supports checkm8-compatible devices running iOS 12.0 - 16.7.8")
                    return
                }
            } else {
                print("No iOS version in text file.")
                print("Asking user what iOS version device is running...")
                if let iosVersion = promptForiOSVersion() {
                    let versionComponents = iosVersion.split(separator: ".").map(String.init)
                    var major = 0
                    var minor = 0
                    
                    if versionComponents.count > 0 {
                        major = Int(versionComponents[0]) ?? 0
                    }
                    if versionComponents.count > 1 {
                        minor = Int(versionComponents[1]) ?? 0
                    }
                    
                    // Use only major and minor for comparison and further processing
                    let versionNumber = Double("\(major).\(minor)") ?? 0.0
                    
                    if versionNumber >= 12.0 {
                        // Use the user's input
                        print("iOS Version entered: \(iosVersion)")
                        
                        let output1 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && chmod +x * && xattr -cr * && chmod +x Darwin/* && xattr -cr Darwin/*")
                        print(output1)
                        
                        let output2 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && ./sshrd.sh \(iosVersion) > log.txt")
                        print(output2)
                        
                        showAlert(message: "Ramdisk has been created!", informativeText: "Press OK to boot your device into SSH Ramdisk mode.")
                        
                        sleep(1)
                        print("Booting Ramdisk...")
                        sleep(1)
                        
                        let output3 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && ./sshrd.sh boot > log.txt")
                        print(output3)
                        
                        sleep(3)
                        
                        print("Ramdisk should now be booted.")
                        sleep(2)
                        print("Starting re-lock script...")
                        sleep(3)
                        let scriptPath = "\(resourcesPath)/unhide_baseband.sh"
                        let process = Process()
                        process.executableURL = URL(fileURLWithPath: "/bin/sh")
                        process.arguments = [scriptPath]
                        do {
                            try process.run()
                            process.waitUntilExit()
                        } catch {
                            // If failed, then print the error
                            print("Failed to run script: \(error)")
                        }
                        sleep(3)
                        print("✓ Device Re-lock complete! ✓")
                        showAlert(message: "Device Re-lock Done!", informativeText: "Your device will now boot up to the setup screen!\n\nPS. If you got some of your devices working thanks to this tool, send me a DM on X (@AlwaysAppleFTD) or on Instagram (@finn.desilva) :)")
                // print("No iOS version in text file or failed to fetch iOS version.")
                // print("iOS Version entered: \(iosVersion)")  // Correctly unwrapped
                // showAlert(message: "ERROR: No iOS Version was found!", informativeText: "This is most likely a Swift related problem. Please contact me on X @AlwaysAppleFTD or on Instagram @finn.desilva and I will help you.\n\nAlso, please remember that your feedback on this tool is important! The more users report bugs, the sooner I can fix them.")
                    } else {
                        // Default to 12.0
                        let defaultVersion = "12.0"
                        print("ERROR: iOS Version not supported!")
                        showAlert(message: "ERROR: The iOS version you entered is not supported!", informativeText: "Lockra1n supports checkm8-compatible devices running iOS 12.0 - 16.7.8")
                        return
                    }
                    
                    //showAlert(message: "Ramdisk has been created!", informativeText: "Press OK to boot your device into SSH Ramdisk mode.")
                    
                } else {
                    // Handle the case where no iOS version was entered
                    print("No iOS version entered.")
                    showAlert(message: "ERROR: No iOS Version was entered!", informativeText: "You must enter the iOS Version of your device to continue.\n\nIf you don't know the exact version, you can put a rough guess like 13.0 or 15.0.")
                    return
                }
                return
            }
        } catch {
            print("An error occurred while reading the file: \(error)")
            return
        }
        
        // Jusy for safety: Ideally this should never be reached unless there's a logical flaw in the flow above
        return
    }
    
    private func showAskiOSVersionAlert2ReLock() {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return
        }
        
        self.showAlert(message: "We will stick to 12.0 for this ramdisk.", informativeText: "Because your device is an A7 device, and A7 devices only go up to iOS 12, the ramdisk iOS version will be set to 12.0. No override is needed, because even if your device is lower then 12.0, the ramdisk will boot fine due to old iOS's being interchangeable.")
        
        if !FileChecker.checkPython2Installation() {
            self.showAlert(message: "Python2 is not installed and is required!", informativeText: "Please install it now by pressing OK then running through the installer that opens. Once you have completed the installer, click OK on the next pop-up.")
            runTerminalCommand("open \(resourcesPath)/Python/python2.pkg")
            self.showAlert(message: "Please press OK once you have completed the Python installation.", informativeText: "")
        }
        
        if !FileChecker2.checkLibUSBInstallation() {
            self.showAlert(message: "libusb is not installed and is required!", informativeText: "It will now install when you press OK. Then the app will continue running through the Ramdisk creation process. ")
            //let mvlibusbcmd = runTerminalCommand("mv \(quotedResourcesPath)/libusb ~/libusb")
            //print(mvlibusbcmd)
            
            let cplibusbcmd = runTerminalCommand("cp -R \(resourcesPath)/libusb/libusb-1.0.dylib /usr/local/lib")
            print(cplibusbcmd)
            
            sleep(2)
        }
        
        print("Passed!")
        sleep(5)
        
        let output1 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && chmod +x * && xattr -cr * && chmod +x Darwin/* && xattr -cr Darwin/*")
        print(output1)
        
        let output2 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && ./sshrd.sh 12.0 > log.txt")
        print(output2)
        
        showAlert(message: "Ramdisk has been created!", informativeText: "Press OK to boot your device into SSH Ramdisk mode.")
        
        sleep(1)
        print("Booting Ramdisk...")
        sleep(1)
        
        let output3 = runTerminalCommand("cd \(resourcesPath)/ipwndfu_public && chmod +x * && xattr -cr *")
        print(output3)
        
        let output4 = runTerminalCommand("cd \(resourcesPath)/ipwndfu_public && /usr/local/bin/python ./ipwndfu -p > pwndfu.txt")
        print(output4)
        
        let pathToPwnDFUStatus = "\(resourcesPath)/ipwndfu_public/pwndfu.txt" // Correctly using resourcesPath directly because for some reason quotedResourcesPath doesn't work for this situation.
        
        do {
            let pwndfuStatusData = try String(contentsOfFile: pathToPwnDFUStatus, encoding: .utf8)
            
            if pwndfuStatusData.contains("ERROR: No Apple device in DFU Mode 0x1227 detected after 5.00 second timeout. Exiting.") {
                print("ERROR: ipwndfu failed to detect your device!")
                print("This may also mean that your device rebooted by accident.")
                showAlert(message: "ERROR: ipwndfu has failed to detect your device!", informativeText: "Please make sure the device's screen is black and you have entered DFU mode correctly.\n\nAdditionally, if the device is showing the Apple logo, then it means it accidentally rebooted out of DFU mode. To fix this, re-enter DFU mode any try creating the ramdisk again.")
                return
            } else {
                //  Handle if the device entered PwnDFU successfully
                print("Success! Your device should now be in PwnDFU mode.")
            }
        } catch {
            print("Error reading file: \(error)")
        }
        
        sleep(3)
        
        let output5 = runTerminalCommand("cd \(resourcesPath)/ipwndfu_public && /usr/local/bin/python rmsigchks.py > unsignedfiles.txt")
        print(output5)
        
        let output6 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script && ./sshrd.sh boot > log.txt")
        print(output6)
        
        sleep(3)
        
        print("Ramdisk should now be booted.")
        sleep(2)
        print("Starting re-lock script...")
        sleep(3)
        let scriptPath = "\(resourcesPath)/unhide_baseband.sh"
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/sh")
        process.arguments = [scriptPath]
        do {
            try process.run()
            process.waitUntilExit()
        } catch {
            // If failed, then print the error
            print("Failed to run script: \(error)")
        }
        sleep(3)
        print("✓ Device Re-lock complete! ✓")
        showAlert(message: "Device Re-lock Done!", informativeText: "Your device will now boot up to the setup screen!\n\nPS. If you got some of your devices working thanks to this tool, send me a DM on X (@AlwaysAppleFTD) or on Instagram (@finn.desilva) :)")

        //self.showAlert(message: "Ramdisk is Booted!", informativeText: "If there is no verbose text on the screen, then your device's iOS version is incompatible with this tool.\nEven if there only a logo, DO NOT continue!\n\nThis rarely happens though.")
    }
    
    private func promptForiOSVersionAndSave() {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return
        }
        
        if let customFileName = promptForiOSVersion(), !customFileName.isEmpty {
            // User entered a custom file name, write it to "savename.txt"
            let saveNameFilePath = "\(resourcesPath)/savename.txt"
            do {
                try customFileName.write(toFile: saveNameFilePath, atomically: true, encoding: .utf8)
                // Run the terminal command after saving the custom file name
                let output2 = runTerminalCommand("chmod 755 \(resourcesPath)/move2.sh && bash \(resourcesPath)/move2.sh")
                print(output2)
                
            } catch {
                print("Error writing custom file name: \(error)")
            }
        } else {
            // User left the field empty, handle this case here
            let output3 = runTerminalCommand("chmod 755 \(resourcesPath)/move.sh && bash \(resourcesPath)/move.sh")
            print(output3)
        }
        
    }
    
    private func iOSVersionData() -> String? {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return ""
        }
        
        let filePath = "\(resourcesPath)/work/deviceinfo.txt"
        
        let version = runTerminalCommand("\(resourcesPath)/ideviceinfo | grep -w 'ProductVersion' | awk '{print $NF}'").trimmingCharacters(in: .whitespacesAndNewlines)
//        do {
//            let fileData = try String(contentsOfFile: filePath, encoding: .utf8)
//        } catch {
//            print("Error reading file: \(error)")
//        }
        return ""
    }
    
    private func promptForiOSVersion() -> String? {
        let alert = NSAlert()
        alert.messageText = "Please enter your device iOS Version here!\nThis can be a rough guess, it doesn't have to be exact."
        
        let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 300, height: 24))
        textField.placeholderString = "Enter device iOS Version"
        
        // Add the text field to the alert
        alert.accessoryView = textField
        
        // Add only the OK button
        alert.addButton(withTitle: "OK")
        
        // Show the alert
        let response = alert.runModal()
        
        // If the user clicked "OK", check the input value
        if response == .alertFirstButtonReturn {
            let input = textField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
            return input.isEmpty ? nil : input
        } else {
            // This branch is unlikely to be executed since there's no Cancel button
            return nil
        }
    }
    
    func extractDataNoNormal(from text: String, start: String, end: String) -> String? {
        let regexPattern = "\(start)(.*?)\(end)"
        do {
            let regex = try NSRegularExpression(pattern: regexPattern, options: .dotMatchesLineSeparators)
            let results = regex.matches(in: text, options: [], range: NSRange(text.startIndex..., in: text))
            
            if let match = results.first, let range = Range(match.range(at: 1), in: text) {
                return String(text[range])
            }
        } catch {
            print("Regex error: \(error)")
        }
        return nil
    }
    
    @IBAction func generateActivationButtonPressed(_ sender: NSButton) {
        // Make an Alert pop-up
        let alert1 = NSAlert()
        alert1.messageText = "Generating activation files for your device."
        alert1.informativeText = "This may take a minute or so..."
        alert1.addButton(withTitle: "OK")
        alert1.addButton(withTitle: "Cancel")
        
        let response = alert1.runModal()
        // If the 'OK' button was pressed, then execute the 'test.sh' script
        if response == .alertFirstButtonReturn {
            guard let resourcesPath = Bundle.main.resourcePath else {
                print("Failed to find the main bundle's resource path")
                return
            }
            
            print("Generating activation files...")
            let output1 = runTerminalCommand("cd \(resourcesPath) && xattr -cr *")
            print(output1)
            
            let output2 = runTerminalCommand("cd \(resourcesPath) && chmod +x * && xattr -cr *")
            print(output2)
            
            let output3 = runTerminalCommand("\(resourcesPath)/ideviceinfo > \(resourcesPath)/work/deviceinfo.txt")
            print(output3)
            
            //DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/deviceinfo.txt")
            let success = self.processDeviceDataNoPopUp(from: fileURL)  // Get success or failure
            
            if !success {
                return  // Stop further processing because processDeviceDataNoPopUp failed
            }
            
            // If success, proceed with script execution
            let scriptPath = "\(resourcesPath)/check_device_registration.sh"
            
            let process = Process()
            process.executableURL = URL(fileURLWithPath: "/bin/sh")
            process.arguments = [scriptPath]
            
            do {
                try process.run()
                process.waitUntilExit()
            } catch {
                // If failed, then print the error
                print("Failed to run script: \(error)")
            }
            
            let activationState = runTerminalCommand("\(resourcesPath)/ideviceinfo | grep -w 'ActivationState' | awk '{print $NF}'").trimmingCharacters(in: .whitespacesAndNewlines)
            //print("\(activationState)")

            if activationState == "Unactivated" {
                print("Device is unactivated. Continuing...")
                
                sleep(1)
                
                runTerminalCommand("mkdir -p \(resourcesPath)/Device_Activation/")

                let serialNumber = runTerminalCommand("\(resourcesPath)/ideviceinfo | grep -w 'SerialNumber' | awk '{print $NF}'").trimmingCharacters(in: .whitespacesAndNewlines)
                runTerminalCommand("curl -s -k \"https://alwaysappleftd.com/software/Lockra1n/registration_check.php?serialNumber=\(serialNumber)\" --output \(resourcesPath)/Device_Activation/registration_status.txt")

                // Sleep may be needed depending on system performance and script requirements
                sleep(2)  // Ensure there is a delay for file I/O operations

                let registrationStatus = runTerminalCommand("cat \(resourcesPath)/Device_Activation/registration_status.txt")
                let regStatus = "Your device is not registered with Lockra1n!"

                if registrationStatus.contains(regStatus) {
                    print("Device is not registered with Lockra1n!")
                    print("User must be registered before continuing.")
                    self.bypassDeviceRef.isEnabled = false
                    self.bypassDeviceNormalMode.isEnabled = false
                    scheduleLocalNotification(NotificationTitle: "Registration Status", NotificationMessage: "Your device (\(serialNumber)) is not registered with Lockra1n! Please visit alwaysappleftd.com/software/Lockra1n.html for details and registration.")
                    sleep(1)
                    let alert3 = NSAlert()
                    alert3.messageText = "Registration Status:"
                    alert3.informativeText = "\(registrationStatus)"
                    alert3.addButton(withTitle: "Visit Registration Page")
                    alert3.addButton(withTitle: "OK")
                    
                    let response = alert3.runModal()
                    // If the user said to visit the registration, then open the page
                    if response == .alertFirstButtonReturn {
                        if let url = URL(string: "https://alwaysappleftd.com/software/Lockra1n/register_device.php") {
                            NSWorkspace.shared.open(url)
                        }
                    }
                    
                    if response == .alertSecondButtonReturn {
                        return
                    }
                    // showAlert(message: "Registration Status:", informativeText: "\(registrationStatus)")
                    sleep(2)  // Give user time to see the message
                    return
                } else {
                    print("Device is registered with Lockra1n!")
                    scheduleLocalNotification(NotificationTitle: "Registration Status", NotificationMessage: "Apple device \(serialNumber) is registered with Lockra1n! The tool is now generating your activation tickets...")
                    
                    let rmdevactfolder = runTerminalCommand("rm -rf \(resourcesPath)/Device_Activation")
                    print(rmdevactfolder)
                    sleep(1)
                    let output4 = runTerminalCommand("mkdir -p \(resourcesPath)/Device_Activation/")
                    print(output4)
                    let ucid = runTerminalCommand("\(resourcesPath)/ideviceinfo | grep -w 'UniqueChipID' | awk '{print $NF}'").trimmingCharacters(in: .whitespacesAndNewlines)
                    let udid = runTerminalCommand("\(resourcesPath)/ideviceinfo | grep -w 'UniqueDeviceID' | awk '{print $NF}'").trimmingCharacters(in: .whitespacesAndNewlines)
                    print("curl -k \"https://alwaysappleftd.com/bypass/generate.php?udid=\(udid)sn=\(serialNumber)&ucid=\(ucid)")
                    sleep(2)
                    let output5 = runTerminalCommand("curl -k \"https://alwaysappleftd.com/bypass/generate.php?udid=\(udid)&sn=\(serialNumber)&ucid=\(ucid)\" --output \(resourcesPath)/Device_Activation/activation_record.plist")
                    print(output5)
                    
                    // let output5 = runTerminalCommand("curl -s \"https://icactivate.000webhostapp.com/bypass/generate.php?uniqueDiviceID=\(udid)&Build=$(DeviceInfo BuildVersion)&model=$(DeviceInfo ModelNumber)&productType=$(DeviceInfo ProductType)&ios=$(DeviceInfo ProductVersion)&ucid=\(ucid)&serialNumber=\(serialNumber)\" --output \(resourcesPath)/Device_Activation/activation_record.plist")
                    
                    sleep(2)
                    
                    // Define file path
                    let fileManager = FileManager.default
                    let filePath = "\(resourcesPath)/Device_Activation/activation_record.plist"
                    
                    // Check file size
                    if let attributes = try? fileManager.attributesOfItem(atPath: filePath),
                       let fileSize = attributes[.size] as? UInt64 {
                        let fileSizeKB = fileSize / 1024
                        
                        if fileSizeKB > 3 {
                            print("File size matches the requirement.")
                            
                            let output6 = runTerminalCommand("mkdir -p \(resourcesPath)/Device_Activation/FairPlay/")
                            print(output6)
                            let output7 = runTerminalCommand("mkdir -p \(resourcesPath)/Device_Activation/FairPlay/iTunes_Control/")
                            print(output7)
                            let output8 = runTerminalCommand("mkdir -p \(resourcesPath)/Device_Activation/FairPlay/iTunes_Control/iTunes/")
                            print(output8)
                            
                            print("Almost done")
                            sleep(1)
                            
                            let output9 = runTerminalCommand("bash \(resourcesPath)/convert.sh \(resourcesPath)/Device_Activation/activation_record.plist \(resourcesPath)/Device_Activation/FairPlay/iTunes_Control/iTunes/")
                            print(output9)
                            
                            sleep(2)
                            
                            let mkdir1 = runTerminalCommand("mkdir -p \(resourcesPath)/Device_Activation/var/")
                            print(mkdir1)
                            let mkdir2 = runTerminalCommand("mkdir -p \(resourcesPath)/Device_Activation/var/wireless/")
                            print(mkdir2)
                            let mkdir3 = runTerminalCommand("mkdir -p \(resourcesPath)/Device_Activation/var/wireless/Library/")
                            print(mkdir3)
                            let mkdir4 = runTerminalCommand("mkdir -p \(resourcesPath)/Device_Activation/var/wireless/Library/Preferences/")
                            print(mkdir4)
                            
                            print("\(resourcesPath)/Device_Activation/var/wireless/Library/Preferences/")
                            
                            sleep(3)
                            
                            let output10 = runTerminalCommand("curl -k \"https://alwaysappleftd.com/bypass/Devices/activation_records/\(serialNumber)/commcenter.plist\" --output \(resourcesPath)/Device_Activation/var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist")
                            print(output10)
                            
                            print("Finished creating activation files!")
                            print("Done.")
                            scheduleLocalNotification(NotificationTitle: "Activation files successfully generated!", NotificationMessage: "You can now bypass your device!")
                            self.bypassDeviceRef.isEnabled = true
                            self.bypassDeviceNormalMode.isEnabled = true
                            
                        } else {
                            print("File size is not more than 3KB.")
                            scheduleLocalNotification(NotificationTitle: "Failed to generate activation tickets!", NotificationMessage: "An error occurred when generating activation files. DO NOT CONTINUE! Otherwise, your device will likely get bricked.")
                            let output11 = runTerminalCommand("rm -rf \(resourcesPath)/Device_Activation")
                            print(output11)
                            self.bypassDeviceRef.isEnabled = false
                            self.bypassDeviceNormalMode.isEnabled = false
                            return
                        }
                    } else {
                        print("Failed to get file attributes.")
                    }
                }
            } else {
                showAlert(message: "ERROR: This device is already activated!", informativeText: "This could mean that the device has been bypassed already, or it is a normally activated device.\n\nLockra1n does not provide any open menu unlocking functions.")
                return
            }
            
            let alert2 = NSAlert()
            alert2.messageText = "Activation Files have been successfully generated."
            alert2.informativeText = "Move on to bypassing the device!"
            alert2.addButton(withTitle: "OK")
            alert2.runModal()
        }
        
        if response == .alertSecondButtonReturn {
            return
        }
    }
    
    
    @IBAction func bypassDeviceButtonPressed(_ sender: NSButton) {
        // Make an Alert pop-up
        let alert1 = NSAlert()
        alert1.messageText = "Bypass Device?"
        alert1.informativeText = "Make sure that you have followed all the steps above before continuing..."
        alert1.addButton(withTitle: "Continue")
        alert1.addButton(withTitle: "Cancel")
        
        let response = alert1.runModal()
        
        if response == .alertFirstButtonReturn {
            guard let resourcesPath = Bundle.main.resourcePath else {
                print("Failed to find the main bundle's resource path")
                return
            }
            
            print("Searching for connected device...")
            
            let output1 = runTerminalCommand("cd \(resourcesPath) && chmod +x * && xattr -cr *")
            print(output1)
            
            let output2 = runTerminalCommand("\(resourcesPath)/ideviceinfo > \(resourcesPath)/work/deviceinfo.txt")
            print(output2)
            
            //DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/deviceinfo.txt")
            let success = self.processDeviceDataNoErrorPopUp(from: fileURL)  // Get success or failure
            
            if !success {
                //return  // Stop further processing because processDeviceDataNoPopUp failed
                print("ERROR: No normal mode device found!")
                print("Searching for Recovery or DFU Mode device...")
                sleep(2)
                
                //let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
                self.detectDFUDevice()
                return
            } //else {
                let filePath = "\(resourcesPath)/work/deviceinfo.txt"
                
                do {
                    let fileData = try String(contentsOfFile: filePath, encoding: .utf8)
                    let a7Devices = ["iPhone6,1", "iPad4,1", "iPad4,2", "iPad4,3", "iPad4,4", "iPad4,5", "iPad4,6", "iPad4,7", "iPad4,8", "iPad4,9"]
                    
                    if a7Devices.contains(where: fileData.contains) {
                        print("A7 device detected!")
                        // let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
                        // self.processDeviceDataNotNormal(from: fileURL)
                        // let deviceModel = extractData(from: fileData, start: "NAME: ", end: "\n")  // Assuming each data ends with a newline
                        showAlert(message: "Please enter DFU Mode now!", informativeText: "If you need instructions on how to enter DFU Mode, please Google 'How to enter DFU mode on ' and then your device model. Example might be 'How to enter DFU mode on iPhone 8'. Then find an online tutorial or website post.")
                        
//                        let output1 = runTerminalCommand("\(resourcesPath)/irecovery -q > \(resourcesPath)/work/dfu.txt 2>&1")
//                        print(output1)
//
                        // var success = false
                        
                        // let success2 = self.detectDFUDeviceNoPopUpA7(from: fileURL)
                        
                        self.detectDFUDeviceNoPopUpV3()
                        
                        // Get success or failure
                        // if !success2 {
                            // return  // Stop further processing because detectDFUDeviceNoPopUp failed
                        // }
                        // self.detectDFUDeviceNoPopUp(from: fileURL)
                        // } while !success
                        
//                        print("Showing showAskiOSVersionAlert2")
//                        self.showAskiOSVersionAlert2()
                    } else if fileData.contains("ERROR: No device found!") {
                        print("Something's not right. Your device was originally found, but appears to no longer be connected. Please try again.")
                        return
                        // showAlert(message: "ERROR: No device was detected!", informativeText: "This could mean that your device is not in DFU or Recovery mode, or isn't connected at all. Please connect a device in DFU mode to continue.")
                        // showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
                    } else {
                        // This else block correctly handles any other device processor.
                        print("A8 or higher device detected!")
                        // let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
                        
                        showAlert(message: "Please enter DFU Mode now!", informativeText: "If you need instructions on how to enter DFU Mode, please Google 'How to enter DFU mode on ' and then your device model. Example might be 'How to enter DFU mode on iPhone 8'. Then find an online tutorial or website post.")
                        
//                        let output1 = runTerminalCommand("\(resourcesPath)/irecovery -q > \(resourcesPath)/work/dfu.txt 2>&1")
//                        print(output1)
                        
                        // let success3 = self.detectDFUDeviceNoPopUpA8(from: fileURL)
                        
                        self.detectDFUDeviceNoPopUpV3()
                        
                        // Get success or failure
                        // if !success3 {
                            // showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
                            // return  // Stop further processing because detectDFUDeviceNoPopUp failed
                        // }
                        
//                        print("Showing showAskiOSVersionAlert")
//                        self.showAskiOSVersionAlert()
                    }
                } catch {
                    print("Error reading file: \(error)")
                }
            }
            
//            // If success, proceed with script execution
//            let scriptPath = "\(resourcesPath)/generate_activation_files.sh"
//
//            let process = Process()
//            process.executableURL = URL(fileURLWithPath: "/bin/sh")
//            process.arguments = [scriptPath]
//
//            do {
//                try process.run()
//                process.waitUntilExit()
//            } catch {
//                // If failed, then print the error
//                print("Failed to run script: \(error)")
//            }
       // }
        
        if response == .alertSecondButtonReturn {
            return
        }
    }
    
    @IBAction func bypassDeviceNormalModeButtonPressed(_ sender: NSButton) {
        // Make an Alert pop-up
        let alert1 = NSAlert()
        alert1.messageText = "Bypass Device?"
        alert1.informativeText = "Make sure that you have followed all the steps above before continuing..."
        alert1.addButton(withTitle: "Continue")
        alert1.addButton(withTitle: "Cancel")
        
        let response = alert1.runModal()
        
        if response == .alertFirstButtonReturn {
            guard let resourcesPath = Bundle.main.resourcePath else {
                print("Failed to find the main bundle's resource path")
                return
            }
            
            print("Searching for connected device...")
            
            let output1 = runTerminalCommand("cd \(resourcesPath) && chmod +x * && xattr -cr *")
            print(output1)
            
            let output2 = runTerminalCommand("\(resourcesPath)/ideviceinfo > \(resourcesPath)/work/deviceinfo.txt 2>&1")
            print(output2)
            
            let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/deviceinfo.txt")
            
            do {
                let fileData = try String(contentsOf: fileURL, encoding: .utf8)
                //print("File Data: \(fileData)") // Debug: Check what is being read
                
                if fileData.contains("ERROR:") {
                    print("ERROR: No normal mode device found!")
                    print("Searching for Recovery or DFU Mode device...")
                    sleep(1)
                    
                    let checkDeviceState = self.iRecoveryInfo("MODE")
                    // let findDeviceModelRecovery = self.iRecoveryInfo("PRODUCT")
                    
                    if checkDeviceState == "Recovery" {
                        let deviceModel = self.iRecoveryInfo("NAME")
                        print("Found device in Recovery Mode!")
                        self.showAlert(message: "Device is in Recovery Mode!", informativeText: "You must be in Normal Mode to continue. Press OK to restart the device out of Recovery Mode, then click the 'Bypass Device (Normal mode)' button again to start the bypass process!")
                        let output1 = runTerminalCommand("\(resourcesPath)/futurerestore_194 --exit-recovery")
                        print(output1)
                        
                        sleep(2)
                        
                        let alert3 = NSAlert()
                        alert3.messageText = "Done!"
                        alert3.informativeText = "Device should now be rebooting into Normal mode. Once you reach the Hello screen, click 'Bypass Device (Normal mode)' again to continue."
                        alert3.addButton(withTitle: "OK")
                        
                        alert3.runModal()
                        return
                    } else if checkDeviceState == "DFU" {
                        print("Found device in DFU Mode!")
                        self.showAlert(message: "Device is in DFU Mode!", informativeText: "You must be in Normal Mode to continue. Restart the device out of DFU Mode manually, then click the 'Bypass Device (Normal Mode)' button again to start the process.")
                        return
                    } else {
                        let alert3 = NSAlert()
                        alert3.messageText = "No device was found!"
                        alert3.informativeText = "Try disconnecting and reconnecting your device.\nIf that fails as well, try using a different USB cable, and ensure that if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter."
                        alert3.addButton(withTitle: "OK")
                        alert3.runModal()
                    }
                    
                } else {
                    
                }
                
            } catch {
                print("An error occurred while reading the file: \(error)")
            }
            
            let filePath = "\(resourcesPath)/work/deviceinfo.txt"
            
            do {
                let fileData = try String(contentsOfFile: filePath, encoding: .utf8)
                let a7Devices = ["iPhone6,1", "iPad4,1", "iPad4,2", "iPad4,3", "iPad4,4", "iPad4,5", "iPad4,6", "iPad4,7", "iPad4,8", "iPad4,9"]
                
                if a7Devices.contains(where: fileData.contains) {
                    print("A7 device detected!")
                    // let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
                    // self.processDeviceDataNotNormal(from: fileURL)
                    // let deviceModel = extractData(from: fileData, start: "NAME: ", end: "\n")  // Assuming each data ends with a newline
                    // showAlert(message: "Please enter DFU Mode now!", informativeText: "If you need instructions on how to enter DFU Mode, please Google 'How to enter DFU mode on ' and then your device model. Example might be 'How to enter DFU mode on iPhone 8'. Then find an online tutorial or website post.")
                    
                    print("Checking iOS Version...")
                    
                    // let checkiOSVersion = self.DeviceInfo("ProductVersion")
                    if let iosVersion = extractData(from: fileData, start: "ProductVersion: ", end: "ProductionSOC:") {
                        let versionComponents = iosVersion.split(separator: ".").map(String.init)
                        var major = 0
                        var minor = 0
                        
                        if versionComponents.count > 0 {
                            major = Int(versionComponents[0]) ?? 0
                        }
                        if versionComponents.count > 1 {
                            minor = Int(versionComponents[1]) ?? 0
                        }
                        
                        // Use only major and minor for comparison and further processing
                        let versionNumber = Double("\(major).\(minor)") ?? 0.0
                        
                        if versionNumber >= 12.0 {
                            if versionNumber < 15.0 {
                                // Use the user's input
                                // print("Device iOS Version: \(checkiOSVersion)")
                                print("Device is between iOS 12 and 14...")
                                print("Device iOS Version: \(iosVersion)")
                                
                                let alert1 = NSAlert()
                                alert1.messageText = "Jailbreak your device"
                                // alert1.informativeText = "You will need to enter DFU mode, so look up how to for your model now if you don't know how to."
                                alert1.informativeText = "You will need to jailbreak your device using Checkra1n to continue. Also, you will need to enter DFU mode, so you can follow the instructions in the jailbreak app."
                                alert1.addButton(withTitle: "Open Checkra1n (Built in to this app)")
                                alert1.addButton(withTitle: "Already Done Jailbreak")
                                alert1.addButton(withTitle: "Cancel")
                                let response = alert1.runModal()
                                if response == .alertFirstButtonReturn {
                                    // self.AutomaticallySSHConnection()
                                    // self.backupPasscodeFiles()
                                    //let alert2 = NSAlert()
                                    //alert2.messageText = "Please enter DFU Mode on your device!"
                                    //alert2.informativeText = "Once done, click OK to continue with jailbreak."
                                    //alert2.addButton(withTitle: "OK")
                                    // alert2.addButton(withTitle: "Cancel")
                                    //alert2.runModal()
                                    
                                    //print("Running checkra1n executable...")
                                    //sleep(2)
                                    
                                    guard let resourcesPath = Bundle.main.resourcePath else {
                                        print("Failed to find the main bundle's resource path")
                                        return
                                    }
                                    
                                    let command1 = "chmod +x \(resourcesPath)/checkra1n.app/Contents/MacOS/checkra1n"
                                    let command2 = "xattr -cr \(resourcesPath)/checkra1n.app"
                                    let command3 = "open \(resourcesPath)/checkra1n.app"
                                    
                                    let process1 = Process()
                                    process1.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process1.arguments = ["-c", command1]
                                    
                                    let process2 = Process()
                                    process2.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process2.arguments = ["-c", command2]
                                    
                                    let process3 = Process()
                                    process3.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process3.arguments = ["-c", command3]
                                    
                                    do {
                                        try process1.run()
                                        process1.waitUntilExit()
                                        
                                        try process2.run()
                                        process2.waitUntilExit()
                                        
                                        try process3.run()
                                        process3.waitUntilExit()
                                    } catch {
                                        print("Failed to run commands: \(error)")
                                    }
                                    
                                    sleep(1)
                                    
                                    let alert2 = NSAlert()
                                    alert2.messageText = "Did the jailbreak complete successfully and say 'All Done'?"
                                    // alert1.informativeText = "You will need to enter DFU mode, so look up how to for your model now if you don't know how to."
                                    alert2.informativeText = ""
                                    alert2.addButton(withTitle: "Yes")
                                    alert2.addButton(withTitle: "No")
                                    let response2 = alert2.runModal()
                                    if response2 == .alertFirstButtonReturn {
                                        // bypassDeviceButton.isEnabled = true
                                        // deactivateButton.isEnabled = true
                                        let alert4 = NSAlert()
                                        alert4.messageText = "Yay!"
                                        alert4.informativeText = "Lockra1n will now move on to bypassing your device!"
                                        alert4.addButton(withTitle: "OK")
                                        // alert2.addButton(withTitle: "Cancel")
                                        alert4.runModal()
                                    } else if response2 == .alertSecondButtonReturn {
                                        print("ERROR: You cannot continue without a jailbreak!")
                                        let alert3 = NSAlert()
                                        alert3.messageText = "Sorry! You cannot continue without a jailbreak!"
                                        alert1.informativeText = "Try jailbreaking again with checkra1n. If it still fails, make sure you are re-locking a device with iOS 12.0 - 14.5.1! For iOS 14.6 to 14.8.1, click the 'Options' button in the checkra1n app and check the 'Allow untested iOS/iPadOS/tvOS versions'. Additionally, for A11 devices, you may need to select 'Skip A11 BPR Check' to be able to continue with the jailbreak. Once done, go back and try re-locking again."
                                        alert3.addButton(withTitle: "OK")
                                        // alert2.addButton(withTitle: "Cancel")
                                        alert3.runModal()
                                        return
                                    }
                                    
                                } else if response == .alertSecondButtonReturn {
                                    // bypassDeviceButton.isEnabled = true
                                    // deactivateButton.isEnabled = true
                                    let alert5 = NSAlert()
                                    alert5.messageText = "Yay!"
                                    alert5.informativeText = "Lockra1n will now move on to bypassing your device!"
                                    alert5.addButton(withTitle: "OK")
                                    // alert2.addButton(withTitle: "Cancel")
                                    alert5.runModal()
                                } else if response == .alertThirdButtonReturn {
                                    return
                                }
                            } else {
                                print("Device is either iOS 15, 16 or 17...")
                                print("Device iOS Version: \(iosVersion)")
                                
                                let alert1 = NSAlert()
                                alert1.messageText = "Jailbreak your device"
                                // alert1.informativeText = "You will need to enter DFU mode, so look up how to for your model now if you don't know how to."
                                alert1.informativeText = "You will need to jailbreak your device using Palera1n to continue. Also, you will need to enter DFU mode. If you don't know how, just Google 'How to enter DFU Mode on ' and then your device model. Example might be 'How to enter DFU Mode on iPhone 8'."
                                alert1.addButton(withTitle: "I've Entered DFU Mode")
                                alert1.addButton(withTitle: "Already Done Jailbreak")
                                alert1.addButton(withTitle: "Cancel")
                                let response = alert1.runModal()
                                if response == .alertFirstButtonReturn {
                                    // self.AutomaticallySSHConnection()
                                    // self.backupPasscodeFiles()
                                    //let alert2 = NSAlert()
                                    //alert2.messageText = "Please enter DFU Mode on your device!"
                                    //alert2.informativeText = "Once done, click OK to continue with jailbreak."
                                    //alert2.addButton(withTitle: "OK")
                                    // alert2.addButton(withTitle: "Cancel")
                                    //alert2.runModal()
                                    
                                    //print("Running palera1n executable...")
                                    //sleep(2)
                                    
                                    guard let resourcesPath = Bundle.main.resourcePath else {
                                        print("Failed to find the main bundle's resource path")
                                        return
                                    }
                                    
                                    let command1 = "chmod +x \(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal"
                                    let command2 = "xattr -cr \(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal"
                                    let command3 = "\(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal -p"
                                    
                                    let process1 = Process()
                                    process1.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process1.arguments = ["-c", command1]
                                    
                                    let process2 = Process()
                                    process2.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process2.arguments = ["-c", command2]
                                    
                                    let process3 = Process()
                                    process3.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process3.arguments = ["-c", command3]
                                    
                                    do {
                                        try process1.run()
                                        process1.waitUntilExit()
                                        
                                        try process2.run()
                                        process2.waitUntilExit()
                                        
                                        try process3.run()
                                        process3.waitUntilExit()
                                    } catch {
                                        print("Failed to run commands: \(error)")
                                    }
                                    
                                    sleep(1)
                                    
                                    let alert2 = NSAlert()
                                    alert2.messageText = "Please unplug your device from the Mac, then re-plug it back in. Click Done once done."
                                    // alert1.informativeText = "You will need to enter DFU mode, so look up how to for your model now if you don't know how to."
                                    alert2.informativeText = ""
                                    alert2.addButton(withTitle: "Done")
                                    alert2.addButton(withTitle: "Cancel")
                                    let response2 = alert2.runModal()
                                    if response2 == .alertFirstButtonReturn {
                                        // bypassDeviceButton.isEnabled = true
                                        // deactivateButton.isEnabled = true
                                        
                                        let command1 = "\(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal -r \(resourcesPath)/PongoOS/build/ramdisk.dmg -V"
                                        
                                        let process1 = Process()
                                        process1.executableURL = URL(fileURLWithPath: "/bin/sh")
                                        process1.arguments = ["-c", command1]
                                        
                                        do {
                                            try process1.run()
                                            process1.waitUntilExit()
                                        } catch {
                                            print("Failed to run command: \(error)")
                                        }
                                        
                                        sleep(5)
                                        let alert4 = NSAlert()
                                        alert4.messageText = "Jailbreak Completed!"
                                        alert4.informativeText = "Your device should now be verbose booting to the Apple logo, then the Hello screen should show. Once done, click OK. Lockra1n will then move on to bypassing your device!"
                                        alert4.addButton(withTitle: "OK")
                                        // alert2.addButton(withTitle: "Cancel")
                                        alert4.runModal()
                                    } else if response2 == .alertSecondButtonReturn {
                                        // print("ERROR: You cannot continue without a jailbreak!")
                                        let alert3 = NSAlert()
                                        alert3.messageText = "Are you sure?"
                                        alert3.informativeText = "If you choose to Cancel, your device will hang on the Pongo shell until it is force restarted or the battery dies."
                                        alert3.addButton(withTitle: "Continue")
                                        alert3.addButton(withTitle: "Cancel Jailbreak")
                                        let response3 = alert3.runModal()
                                        if response3 == .alertFirstButtonReturn {
                                            let command1 = "\(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal -r \(resourcesPath)/PongoOS/build/ramdisk.dmg -V"
                                            
                                            let process1 = Process()
                                            process1.executableURL = URL(fileURLWithPath: "/bin/sh")
                                            process1.arguments = ["-c", command1]
                                            
                                            do {
                                                try process1.run()
                                                process1.waitUntilExit()
                                            } catch {
                                                print("Failed to run command: \(error)")
                                            }
                                            
                                            sleep(5)
                                            let alert4 = NSAlert()
                                            alert4.messageText = "Jailbreak Completed!"
                                            alert4.informativeText = "Your device should now be verbose booting to the Apple logo, then the Hello screen should show. Once done, click OK. Lockra1n will then move on to bypassing your device!"
                                            alert4.addButton(withTitle: "OK")
                                            // alert2.addButton(withTitle: "Cancel")
                                            alert4.runModal()
                                        } else if response3 == .alertSecondButtonReturn {
                                            return
                                        }
                                    }
                                } else if response == .alertSecondButtonReturn {
                                    // bypassDeviceButton.isEnabled = true
                                    // deactivateButton.isEnabled = true
                                    let alert5 = NSAlert()
                                    alert5.messageText = "Yay!"
                                    alert5.informativeText = "Lockra1n will now move on to bypassing your device!"
                                    alert5.addButton(withTitle: "OK")
                                    // alert2.addButton(withTitle: "Cancel")
                                    alert5.runModal()
                                } else if response == .alertThirdButtonReturn {
                                    return
                                }
                            }
                            let alert1 = NSAlert()
                            alert1.messageText = "One last check!"
                            alert1.informativeText = "Please ensure your device has full booted up (on the Hello screen or any setup screen) and is connected to the Mac. This is crutial for Lockra1n to work correctly. Click OK to confirm and move on to bypassing your device!"
                            alert1.addButton(withTitle: "OK")
                            // alert2.addButton(withTitle: "Cancel")
                            alert1.runModal()
                            
                            print("Starting bypass script...")
                            sleep(3)
                            let scriptPath = "\(resourcesPath)/bypass_normalmode.sh"
                            let process = Process()
                            process.executableURL = URL(fileURLWithPath: "/bin/sh")
                            process.arguments = [scriptPath]
                            do {
                                try process.run()
                                process.waitUntilExit()
                            } catch {
                                // If failed, then print the error
                                print("Failed to run script: \(error)")
                            }
                            sleep(3)
                            print("✓ iCloud bypass complete! ✓")
                            showAlert(message: "iCloud Bypass Done!", informativeText: "Enjoy your bypassed device!\n\nPS. If you got some of your devices working thanks to this tool, send me a DM on X (@AlwaysAppleFTD) or on Instagram (@finn.desilva) :)")
                        } else {
                                print("Device iOS Version: \(iosVersion)")
                                print("ERROR: iOS Version not supported!")
                                showAlert(message: "ERROR: The iOS version of the device is not supported!", informativeText: "Lockra1n supports checkm8-compatible devices running iOS 12.0 - 16.7.8")
                                return
                            }
                        }
                    
                    // self.detectDFUDeviceNoPopUpV3()
                    
                    // Get success or failure
                    // if !success2 {
                    // return  // Stop further processing because detectDFUDeviceNoPopUp failed
                    // }
                    // self.detectDFUDeviceNoPopUp(from: fileURL)
                    // } while !success
                    
                    //                        print("Showing showAskiOSVersionAlert2")
                    //                        self.showAskiOSVersionAlert2()
                } else if fileData.contains("ERROR: No device found!") {
                    print("Something's not right. Your device was originally found, but appears to no longer be connected. Please try again.")
                    return
                    // showAlert(message: "ERROR: No device was detected!", informativeText: "This could mean that your device is not in DFU or Recovery mode, or isn't connected at all. Please connect a device in DFU mode to continue.")
                    // showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
                } else {
                    // This else block correctly handles any other device processor.
                    print("A8 or higher device detected!")
                    
                    print("Checking iOS Version...")
                    
                    // let checkiOSVersion = self.DeviceInfo("ProductVersion")
                    if let iosVersion = extractData(from: fileData, start: "ProductVersion: ", end: "ProductionSOC:") {
                        let versionComponents = iosVersion.split(separator: ".").map(String.init)
                        var major = 0
                        var minor = 0
                        
                        if versionComponents.count > 0 {
                            major = Int(versionComponents[0]) ?? 0
                        }
                        if versionComponents.count > 1 {
                            minor = Int(versionComponents[1]) ?? 0
                        }
                        
                        // Use only major and minor for comparison and further processing
                        let versionNumber = Double("\(major).\(minor)") ?? 0.0
                        
                        if versionNumber >= 12.0 {
                            if versionNumber < 15.0 {
                                // Use the user's input
                                // print("Device iOS Version: \(checkiOSVersion)")
                                print("Device is between iOS 12 and 14...")
                                print("Device iOS Version: \(iosVersion)")
                                
                                let alert1 = NSAlert()
                                alert1.messageText = "Jailbreak your device"
                                // alert1.informativeText = "You will need to enter DFU mode, so look up how to for your model now if you don't know how to."
                                alert1.informativeText = "You will need to jailbreak your device using Checkra1n to continue. Also, you will need to enter DFU mode, so you can follow the instructions in the jailbreak app."
                                alert1.addButton(withTitle: "Open Checkra1n (Built in to this app)")
                                alert1.addButton(withTitle: "Already Done Jailbreak")
                                alert1.addButton(withTitle: "Cancel")
                                let response = alert1.runModal()
                                if response == .alertFirstButtonReturn {
                                    // self.AutomaticallySSHConnection()
                                    // self.backupPasscodeFiles()
                                    //let alert2 = NSAlert()
                                    //alert2.messageText = "Please enter DFU Mode on your device!"
                                    //alert2.informativeText = "Once done, click OK to continue with jailbreak."
                                    //alert2.addButton(withTitle: "OK")
                                    // alert2.addButton(withTitle: "Cancel")
                                    //alert2.runModal()
                                    
                                    //print("Running checkra1n executable...")
                                    //sleep(2)
                                    
                                    guard let resourcesPath = Bundle.main.resourcePath else {
                                        print("Failed to find the main bundle's resource path")
                                        return
                                    }
                                    
                                    let command1 = "chmod +x \(resourcesPath)/checkra1n.app/Contents/MacOS/checkra1n"
                                    let command2 = "xattr -cr \(resourcesPath)/checkra1n.app"
                                    let command3 = "open \(resourcesPath)/checkra1n.app"
                                    
                                    let process1 = Process()
                                    process1.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process1.arguments = ["-c", command1]
                                    
                                    let process2 = Process()
                                    process2.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process2.arguments = ["-c", command2]
                                    
                                    let process3 = Process()
                                    process3.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process3.arguments = ["-c", command3]
                                    
                                    do {
                                        try process1.run()
                                        process1.waitUntilExit()
                                        
                                        try process2.run()
                                        process2.waitUntilExit()
                                        
                                        try process3.run()
                                        process3.waitUntilExit()
                                    } catch {
                                        print("Failed to run commands: \(error)")
                                    }
                                    
                                    sleep(1)
                                    
                                    let alert2 = NSAlert()
                                    alert2.messageText = "Did the jailbreak complete successfully and say 'All Done'?"
                                    // alert1.informativeText = "You will need to enter DFU mode, so look up how to for your model now if you don't know how to."
                                    alert2.informativeText = ""
                                    alert2.addButton(withTitle: "Yes")
                                    alert2.addButton(withTitle: "No")
                                    let response2 = alert2.runModal()
                                    if response2 == .alertFirstButtonReturn {
                                        // bypassDeviceButton.isEnabled = true
                                        // deactivateButton.isEnabled = true
                                        let alert4 = NSAlert()
                                        alert4.messageText = "Yay!"
                                        alert4.informativeText = "Lockra1n will now move on to bypassing your device!"
                                        alert4.addButton(withTitle: "OK")
                                        // alert2.addButton(withTitle: "Cancel")
                                        alert4.runModal()
                                    } else if response2 == .alertSecondButtonReturn {
                                        print("ERROR: You cannot continue without a jailbreak!")
                                        let alert3 = NSAlert()
                                        alert3.messageText = "Sorry! You cannot continue without a jailbreak!"
                                        alert1.informativeText = "Try jailbreaking again with checkra1n. If it still fails, make sure you are bypassing with iOS 12.0 - 14.5.1! For iOS 14.6 to 14.8.1, click the 'Options' button in the checkra1n app and check the 'Allow untested iOS/iPadOS/tvOS versions'. Additionally, for A11 devices, you may need to select 'Skip A11 BPR Check' to be able to continue with the jailbreak. Once done, go back and try bypassing again."
                                        alert3.addButton(withTitle: "OK")
                                        // alert2.addButton(withTitle: "Cancel")
                                        alert3.runModal()
                                        return
                                    }
                                    
                                } else if response == .alertSecondButtonReturn {
                                    // bypassDeviceButton.isEnabled = true
                                    // deactivateButton.isEnabled = true
                                    let alert5 = NSAlert()
                                    alert5.messageText = "Yay!"
                                    alert5.informativeText = "Lockra1n will now move on to bypassing your device!"
                                    alert5.addButton(withTitle: "OK")
                                    // alert2.addButton(withTitle: "Cancel")
                                    alert5.runModal()
                                } else if response == .alertThirdButtonReturn {
                                    return
                                }
                            } else {
                                print("Device is either iOS 15, 16 or 17...")
                                print("Device iOS Version: \(iosVersion)")
                                
                                let alert1 = NSAlert()
                                alert1.messageText = "Jailbreak your device"
                                // alert1.informativeText = "You will need to enter DFU mode, so look up how to for your model now if you don't know how to."
                                alert1.informativeText = "You will need to jailbreak your device using Palera1n to continue. Also, you will need to enter DFU mode. If you don't know how, just Google 'How to enter DFU Mode on ' and then your device model. Example might be 'How to enter DFU Mode on iPhone 8'."
                                alert1.addButton(withTitle: "I've Entered DFU Mode")
                                alert1.addButton(withTitle: "Already Done Jailbreak")
                                alert1.addButton(withTitle: "Cancel")
                                let palera1nJBresponse = alert1.runModal()
                                if palera1nJBresponse == .alertFirstButtonReturn {
                                    // self.AutomaticallySSHConnection()
                                    // self.backupPasscodeFiles()
                                    //let alert2 = NSAlert()
                                    //alert2.messageText = "Please enter DFU Mode on your device!"
                                    //alert2.informativeText = "Once done, click OK to continue with jailbreak."
                                    //alert2.addButton(withTitle: "OK")
                                    // alert2.addButton(withTitle: "Cancel")
                                    //alert2.runModal()
                                    
                                    //print("Running palera1n executable...")
                                    //sleep(2)
                                    
                                    guard let resourcesPath = Bundle.main.resourcePath else {
                                        print("Failed to find the main bundle's resource path")
                                        return
                                    }
                                    
                                    let command1 = "chmod +x \(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal"
                                    let command2 = "xattr -cr \(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal"
                                    let command3 = "\(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal -p"
                                    
                                    let process1 = Process()
                                    process1.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process1.arguments = ["-c", command1]
                                    
                                    let process2 = Process()
                                    process2.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process2.arguments = ["-c", command2]
                                    
                                    let process3 = Process()
                                    process3.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process3.arguments = ["-c", command3]
                                    
                                    do {
                                        try process1.run()
                                        process1.waitUntilExit()
                                        
                                        try process2.run()
                                        process2.waitUntilExit()
                                        
                                        try process3.run()
                                        process3.waitUntilExit()
                                    } catch {
                                        print("Failed to run commands: \(error)")
                                    }
                                    
                                    sleep(1)
                                    
                                    let alert2 = NSAlert()
                                    alert2.messageText = "Please unplug your device from the Mac, then re-plug it back in. Click Done once done."
                                    // alert1.informativeText = "You will need to enter DFU mode, so look up how to for your model now if you don't know how to."
                                    alert2.informativeText = ""
                                    alert2.addButton(withTitle: "Done")
                                    alert2.addButton(withTitle: "Cancel")
                                    let response2 = alert2.runModal()
                                    if response2 == .alertFirstButtonReturn {
                                        // bypassDeviceButton.isEnabled = true
                                        // deactivateButton.isEnabled = true
                                        
                                        let command1 = "\(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal -r \(resourcesPath)/PongoOS/build/ramdisk.dmg -V"
                                        
                                        let process1 = Process()
                                        process1.executableURL = URL(fileURLWithPath: "/bin/sh")
                                        process1.arguments = ["-c", command1]
                                        
                                        do {
                                            try process1.run()
                                            process1.waitUntilExit()
                                        } catch {
                                            print("Failed to run command: \(error)")
                                        }
                                        
                                        sleep(5)
                                        let alert4 = NSAlert()
                                        alert4.messageText = "Jailbreak Completed!"
                                        alert4.informativeText = "Your device should now be verbose booting to the Apple logo, then the Hello screen should show. Once done, click OK. Lockra1n will then move on to bypassing your device!"
                                        alert4.addButton(withTitle: "OK")
                                        // alert2.addButton(withTitle: "Cancel")
                                        alert4.runModal()
                                    } else if response2 == .alertSecondButtonReturn {
                                        // print("ERROR: You cannot continue without a jailbreak!")
                                        let alert3 = NSAlert()
                                        alert3.messageText = "Are you sure?"
                                        alert3.informativeText = "If you choose to Cancel, your device will hang on the Pongo shell until it is force restarted or the battery dies."
                                        alert3.addButton(withTitle: "Continue")
                                        alert3.addButton(withTitle: "Cancel Jailbreak")
                                        let response3 = alert3.runModal()
                                        if response3 == .alertFirstButtonReturn {
                                            let command1 = "\(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal -r \(resourcesPath)/PongoOS/build/ramdisk.dmg -V"
                                            
                                            let process1 = Process()
                                            process1.executableURL = URL(fileURLWithPath: "/bin/sh")
                                            process1.arguments = ["-c", command1]
                                            
                                            do {
                                                try process1.run()
                                                process1.waitUntilExit()
                                            } catch {
                                                print("Failed to run command: \(error)")
                                            }
                                            
                                            sleep(5)
                                            let alert4 = NSAlert()
                                            alert4.messageText = "Jailbreak Completed!"
                                            alert4.informativeText = "Your device should now be verbose booting to the Apple logo, then the Hello screen should show. Once done, click OK. Lockra1n will then move on to bypassing your device!"
                                            alert4.addButton(withTitle: "OK")
                                            // alert2.addButton(withTitle: "Cancel")
                                            alert4.runModal()
                                        } else if response3 == .alertSecondButtonReturn {
                                            return
                                        }
                                    }
                                    
                                } else if palera1nJBresponse == .alertSecondButtonReturn {
                                    // bypassDeviceButton.isEnabled = true
                                    // deactivateButton.isEnabled = true
                                    let alert5 = NSAlert()
                                    alert5.messageText = "Yay!"
                                    alert5.informativeText = "Lockra1n will now move on to bypassing your device!"
                                    alert5.addButton(withTitle: "OK")
                                    // alert2.addButton(withTitle: "Cancel")
                                    alert5.runModal()
                                } else if palera1nJBresponse == .alertThirdButtonReturn {
                                    return
                                }
                            }
                            let alert1 = NSAlert()
                            alert1.messageText = "One last check!"
                            alert1.informativeText = "Please ensure your device has full booted up (on the Hello screen or any setup screen) and is connected to the Mac. This is crutial for Lockra1n to work correctly. Click OK to confirm and move on to bypassing your device!"
                            alert1.addButton(withTitle: "OK")
                            // alert2.addButton(withTitle: "Cancel")
                            alert1.runModal()
                            
                            print("Starting bypass script...")
                            sleep(3)
                            let scriptPath = "\(resourcesPath)/bypass_normalmode.sh"
                            let process = Process()
                            process.executableURL = URL(fileURLWithPath: "/bin/sh")
                            process.arguments = [scriptPath]
                            do {
                                try process.run()
                                process.waitUntilExit()
                            } catch {
                                // If failed, then print the error
                                print("Failed to run script: \(error)")
                            }
                            sleep(3)
                            print("✓ iCloud bypass complete! ✓")
                            showAlert(message: "iCloud Bypass Done!", informativeText: "Enjoy your bypassed device!\n\nPS. If you got some of your devices working thanks to this tool, send me a DM on X (@AlwaysAppleFTD) or on Instagram (@finn.desilva) :)")
                        } else {
                                print("Device iOS Version: \(iosVersion)")
                                print("ERROR: iOS Version not supported!")
                                showAlert(message: "ERROR: The iOS version of the device is not supported!", informativeText: "Lockra1n supports checkm8-compatible devices running iOS 12.0 - 16.7.8")
                                return
                            }
                        }
                }
            } catch {
                print("Error reading file: \(error)")
            }
        }
        
        //            // If success, proceed with script execution
        //            let scriptPath = "\(resourcesPath)/generate_activation_files.sh"
        //
        //            let process = Process()
        //            process.executableURL = URL(fileURLWithPath: "/bin/sh")
        //            process.arguments = [scriptPath]
        //
        //            do {
        //                try process.run()
        //                process.waitUntilExit()
        //            } catch {
        //                // If failed, then print the error
        //                print("Failed to run script: \(error)")
        //            }
        // }
        
        if response == .alertSecondButtonReturn {
            return
        }
    }
    
    
    
    @IBAction func relockDeviceButtonPressed(_ sender: NSButton) {
        // Make an Alert pop-up
        let alert1 = NSAlert()
        alert1.messageText = "Re-Lock Device?"
        alert1.informativeText = "This will undo the iCloud bypass. Your device will return to the Hello screen. Note that this does not remove the activation tickets, it just unhides the baseband so the device will return to the setup screen."
        alert1.addButton(withTitle: "Continue")
        alert1.addButton(withTitle: "Cancel")
        
        let response = alert1.runModal()
        
        if response == .alertFirstButtonReturn {
            guard let resourcesPath = Bundle.main.resourcePath else {
                print("Failed to find the main bundle's resource path")
                return
            }
            
            print("Searching for connected device...")
            
            let output1 = runTerminalCommand("cd \(resourcesPath) && chmod +x * && xattr -cr *")
            print(output1)
            
            let output2 = runTerminalCommand("\(resourcesPath)/ideviceinfo > \(resourcesPath)/work/relockinfo.txt")
            print(output2)
            
            //DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/relockinfo.txt")
            let success = self.processDeviceDataNoErrorPopUp(from: fileURL)  // Get success or failure
            
            if !success {
                //return  // Stop further processing because processDeviceDataNoPopUp failed
                print("ERROR: No normal mode device found!")
                print("Searching for Recovery or DFU Mode device...")
                sleep(2)
                
                // let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
                self.detectDFUDeviceNoPopUpReLock()
                return
            } // else {
                let filePath = "\(resourcesPath)/work/relockinfo.txt"
                // let checkDeviceState = self.iRecoveryInfo("MODE")
                // let findDeviceModelRecovery = self.iRecoveryInfo("PRODUCT")
                let findDeviceModelNormal = self.DeviceInfo("ProductType")
                
                do {
                    let fileData = try String(contentsOfFile: filePath, encoding: .utf8)
                    let a7Devices = ["iPhone6,1", "iPad4,1", "iPad4,2", "iPad4,3", "iPad4,4", "iPad4,5", "iPad4,6", "iPad4,7", "iPad4,8", "iPad4,9"]
                    
                    if a7Devices.contains(where: fileData.contains) {
                        print("A7 device detected!")
                        let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
                        // self.processDeviceDataNotNormal(from: fileURL)
                        // let deviceModel = extractData(from: fileData, start: "NAME: ", end: "\n")  // Assuming each data ends with a newline
                        showAlert(message: "Please enter DFU Mode now!", informativeText: "If you need instructions on how to enter DFU Mode, please Google 'How to enter DFU mode on ' and then your device model. Example might be 'How to enter DFU mode on iPhone 8'. Then find an online tutorial or website post.")
                        
                        // let output1 = runTerminalCommand("\(resourcesPath)/irecovery -q > \(resourcesPath)/work/dfu.txt 2>&1")
                        // print(output1)
                        
                        // var success = false
                        
                        let success2 = self.detectDFUDeviceNoPopUp()
                        
                        // Get success or failure
                        if !success2 {
                            // showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
                            return  // Stop further processing because detectDFUDeviceNoPopUp failed
                        }
                        // self.detectDFUDeviceNoPopUp(from: fileURL)
                        // } while !success
                        
                        // self.detectDFUDeviceNoPopUpV2()
                        // self.detectDFUDeviceNoPopUp()
                        
                        self.showAskiOSVersionAlert2ReLock()
                    } else if fileData.contains("ERROR: No device found!") {
                        print("Something's not right. Your device was originally found, but appears to no longer be connected. Please try again.")
                        return
                        // showAlert(message: "ERROR: No device was detected!", informativeText: "This could mean that your device is not in DFU or Recovery mode, or isn't connected at all. Please connect a device in DFU mode to continue.")
                        // showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
                    } else if findDeviceModelNormal == "iPhone10,6" || findDeviceModelNormal == "iPhone10,3" {
                        // let checkDeviceState = self.iRecoveryInfo("MODE")
                        // let findDeviceModelRecovery = self.iRecoveryInfo("PRODUCT")
                        showAlert(message: "Please enter DFU Mode now!", informativeText: "If you need instructions on how to enter DFU Mode, please Google 'How to enter DFU mode on ' and then your device model. Example might be 'How to enter DFU mode on iPhone 8'. Then find an online tutorial or website post.")
                        
                        let checkDeviceState = self.iRecoveryInfo("MODE")
                        
                        if checkDeviceState == "Recovery" {
                            let deviceModel = self.iRecoveryInfo("NAME")
                            print("Found device in Recovery Mode!")
                            self.showAlert(message: "Device is in Recovery Mode!", informativeText: "You must be in DFU Mode to continue. Press OK to exit Recovery mode, then try entering DFU Mode again. Be sure the device's screen is black before continuing. Then press the 'Re-Lock device (un-hide baseband, ramdisk)' button again to try again.")
                            let output1 = runTerminalCommand("\(resourcesPath)/futurerestore_194 --exit-recovery")
                            print(output1)
                            
                            sleep(2)
                            
                            let alert3 = NSAlert()
                            alert3.messageText = "Done!"
                            alert3.informativeText = "Device should now be rebooting into Normal mode. Once you reach the Hello screen, click the 'Re-Lock device (un-hide baseband, ramdisk)' again to continue."
                            alert3.addButton(withTitle: "OK")
                            
                            alert3.runModal()
                            return
                        } else if checkDeviceState == "DFU" {
                            print("DFU Mode device found!")
                            print("All checks passed.")
                        } else {
                            print("No device was found!")
                            showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
                            return
                        }
                        
                        
//                        let checkDeviceConnected = self.iRecoveryInfo("ERROR")
//                        print("testing...")
//                        if checkDeviceConnected == "Unable to connect to device" {
//                            print("No device found!")
//                            showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
//                            return
//                        }
//
//                        if checkDeviceState == "Recovery" {
//                                let deviceModel = self.iRecoveryInfo("NAME")
//                                print("Found device in Recovery Mode!")
//                                self.showAlert(message: "Device is in Recovery Mode!", informativeText: "You must be in DFU Mode to continue. Try entering DFU Mode again, and be sure the device's screen is black before continuing. Then press the 'Re-Lock device (un-hide baseband, ramdisk)' button again to try again.")
//                            return
//                        } else if checkDeviceState == "DFU" {
//                            print("DFU Mode device found!")
//                            print("All checks passed.")
//                            // Change isDFUDetected to true to prevent further DFU detections
//                            guard let resourcesPath = Bundle.main.resourcePath else {
//                                print("Failed to find the main bundle's resource path")
//                                return
//                            }
//                        }
                        
                           let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/deviceinfo.txt")
                           do {
                               let fileData = try String(contentsOf: fileURL, encoding: .utf8)
                               
                               if let iosVersion = extractData(from: fileData, start: "ProductVersion: ", end: "ProductionSOC:")?.trimmingCharacters(in: .whitespacesAndNewlines), !iosVersion.isEmpty {
                                   let versionComponents = iosVersion.split(separator: ".").map(String.init)
                                   var major = 0
                                   var minor = 0
                                   
                                   if versionComponents.count > 0 {
                                       major = Int(versionComponents[0]) ?? 0
                                   }
                                   if versionComponents.count > 1 {
                                       minor = Int(versionComponents[1]) ?? 0
                                   }
                                   
                                   let versionNumber = Double("\(major).\(minor)") ?? 0.0
                                   
                                   if versionNumber >= 12.0 {
                                       print("iOS Version entered: \(iosVersion)\n")  // Correctly unwrapped
                                       print("iPhone X Detected!")
                                       
                                       let output1 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script_pale && chmod +x * && xattr -cr * && chmod +x Darwin/* && xattr -cr Darwin/*")
                                       print(output1)
                                       
                                       sleep(1)
                                       print("Booting Palera1n Ramdisk...")
                                       sleep(1)
                                       
                                       let output2 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script_pale/ && ./sshrd.sh boot > log.txt")
                                       print(output2)
                                       
                                       sleep(8)
                                       print("Palera1n Ramdisk should now be booted!")
                                       
                                       // sleep(2)
                                       print("Starting re-lock script...")
                                       sleep(3)
                                       let scriptPath = "\(resourcesPath)/unhide_baseband.sh"
                                       let process = Process()
                                       process.executableURL = URL(fileURLWithPath: "/bin/sh")
                                       process.arguments = [scriptPath]
                                       do {
                                           try process.run()
                                           process.waitUntilExit()
                                       } catch {
                                           // If failed, then print the error
                                           print("Failed to run script: \(error)")
                                       }
                                       sleep(3)
                                       print("✓ iCloud bypass complete! ✓")
                                       showAlert(message: "Device Re-lock Done!", informativeText: "Your device will now reboot up to the setup screen!\n\nPS. If you got some of your devices working thanks to this tool, send me a DM on X (@AlwaysAppleFTD) or on Instagram (@finn.desilva) :)")
                                   } else {
                                       print("ERROR: iOS Version not supported!")
                                       print("iOS Version entered: \(iosVersion)")  // Correctly unwrapped
                                       showAlert(message: "ERROR: The iOS version you entered is not supported!", informativeText: "Lockra1n supports checkm8-compatible devices running iOS 12.0 - 16.7.8")
                                       return
                                   }
                               } else {
                                   print("No iOS version in text file.")
                                   print("Asking user what iOS version device is running...")
                                   if let iosVersion = promptForiOSVersion() {
                                       let versionComponents = iosVersion.split(separator: ".").map(String.init)
                                       var major = 0
                                       var minor = 0
                                       
                                       if versionComponents.count > 0 {
                                           major = Int(versionComponents[0]) ?? 0
                                       }
                                       if versionComponents.count > 1 {
                                           minor = Int(versionComponents[1]) ?? 0
                                       }
                                       
                                       // Use only major and minor for comparison and further processing
                                       let versionNumber = Double("\(major).\(minor)") ?? 0.0
                                       
                                       if versionNumber >= 12.0 {
                                           // Use the user's input
                                           print("iOS Version entered: \(iosVersion)")
                                           print("iPhone X Detected!")
                                           
                                           let output1 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script_pale && chmod +x * && xattr -cr * && chmod +x Darwin/* && xattr -cr Darwin/*")
                                           print(output1)
                                           
                                           sleep(1)
                                           print("Booting Ramdisk...")
                                           sleep(1)
                                           
                                           let output2 = runTerminalCommand("cd \(resourcesPath)/SSHRD_Script_pale && ./sshrd.sh boot > log.txt")
                                           print(output2)
                                           
                                           sleep(8)
                                           
                                           print("Ramdisk should now be booted.")
                                           sleep(2)
                                           print("Starting re-lock script...")
                                           sleep(3)
                                           let scriptPath = "\(resourcesPath)/unhide_baseband.sh"
                                           let process = Process()
                                           process.executableURL = URL(fileURLWithPath: "/bin/sh")
                                           process.arguments = [scriptPath]
                                           do {
                                               try process.run()
                                               process.waitUntilExit()
                                           } catch {
                                               // If failed, then print the error
                                               print("Failed to run script: \(error)")
                                           }
                                           sleep(3)
                                           print("✓ iCloud bypass complete! ✓")
                                           showAlert(message: "Device Re-lock Done!", informativeText: "Your device will now reboot up to the setup screen!\n\nPS. If you got some of your devices working thanks to this tool, send me a DM on X (@AlwaysAppleFTD) or on Instagram (@finn.desilva) :)")
                                           // print("No iOS version in text file or failed to fetch iOS version.")
                                           // print("iOS Version entered: \(iosVersion)")  // Correctly unwrapped
                                           // showAlert(message: "ERROR: No iOS Version was found!", informativeText: "This is most likely a Swift related problem. Please contact me on X @AlwaysAppleFTD or on Instagram @finn.desilva and I will help you.\n\nAlso, please remember that your feedback on this tool is important! The more users report bugs, the sooner I can fix them.")
                                       } else {
                                           // Default to 12.0
                                           let defaultVersion = "12.0"
                                           print("ERROR: iOS Version not supported!")
                                           showAlert(message: "ERROR: The iOS version you entered is not supported!", informativeText: "Lockra1n supports checkm8-compatible devices running iOS 12.0 - 16.7.8")
                                           return
                                       }
                                       
                                       // showAlert(message: "Ramdisk has been created!", informativeText: "Press OK to boot your device into SSH Ramdisk mode.")
                                       
                                   } else {
                                       // Handle the case where no iOS version was entered
                                       print("No iOS version entered.")
                                       showAlert(message: "ERROR: No iOS Version was entered!", informativeText: "You must enter the iOS Version of your device to continue.\n\nIf you don't know the exact version, you can put a rough guess like 13.0 or 15.0.")
                                       return
                                   }
                                   return
                               }
                           } catch {
                               print("An error occurred while reading the file: \(error)")
                               return
                           }
                           
                    } else {
                        // This else block correctly handles any other device processor.
                        print("A8 or higher device detected!")
                        let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
                        
                        showAlert(message: "Please enter DFU Mode now!", informativeText: "If you need instructions on how to enter DFU Mode, please Google 'How to enter DFU mode on ' and then your device model. Example might be 'How to enter DFU mode on iPhone 8'. Then find an online tutorial or website post.")
                        
                        // let output1 = runTerminalCommand("\(resourcesPath)/irecovery -q > \(resourcesPath)/work/dfu.txt 2>&1")
                       // print(output1)
                        
                        let success3 = self.detectDFUDeviceNoPopUp()
                        // onlyDetectDFUDeviceReLock
                        
                        // Get success or failure
                        if !success3 {
                            return  // Stop further processing because detectDFUDeviceNoPopUp failed
                        }
                        
                        self.showAskiOSVersionAlertReLock()
                    }
                } catch {
                    print("Error reading file: \(error)")
                }
            }
            
//            // If success, proceed with script execution
//            let scriptPath = "\(resourcesPath)/generate_activation_files.sh"
//
//            let process = Process()
//            process.executableURL = URL(fileURLWithPath: "/bin/sh")
//            process.arguments = [scriptPath]
//
//            do {
//                try process.run()
//                process.waitUntilExit()
//            } catch {
//                // If failed, then print the error
//                print("Failed to run script: \(error)")
//            }
       // }
        
        if response == .alertSecondButtonReturn {
            return
        }
    }
    
    @IBAction func relockDeviceNormalModeButton(_ sender: NSButton) {
        // Make an Alert pop-up
        let alert1 = NSAlert()
        alert1.messageText = "Re-Lock Device?"
        alert1.informativeText = "This will undo the iCloud bypass. Your device will return to the Hello screen. Note that this does not remove the activation tickets, it just unhides the baseband so the device will return to the setup screen."
        alert1.addButton(withTitle: "Continue")
        alert1.addButton(withTitle: "Cancel")
        
        let response = alert1.runModal()
        
        if response == .alertFirstButtonReturn {
            guard let resourcesPath = Bundle.main.resourcePath else {
                print("Failed to find the main bundle's resource path")
                return
            }
            
            print("Searching for connected device...")
            
            let output1 = runTerminalCommand("cd \(resourcesPath) && chmod +x * && xattr -cr *")
            print(output1)
            
            let output2 = runTerminalCommand("\(resourcesPath)/ideviceinfo > \(resourcesPath)/work/deviceinfo.txt 2>&1")
            print(output2)
            
            let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/deviceinfo.txt")
            
            do {
                let fileData = try String(contentsOf: fileURL, encoding: .utf8)
                //print("File Data: \(fileData)") // Debug: Check what is being read
                
                if fileData.contains("ERROR:") {
                    print("ERROR: No normal mode device found!")
                    print("Searching for Recovery or DFU Mode device...")
                    sleep(1)
                    
                    let checkDeviceState = self.iRecoveryInfo("MODE")
                    // let findDeviceModelRecovery = self.iRecoveryInfo("PRODUCT")
                    
                    if checkDeviceState == "Recovery" {
                        let deviceModel = self.iRecoveryInfo("NAME")
                        print("Found device in Recovery Mode!")
                        self.showAlert(message: "Device is in Recovery Mode!", informativeText: "You must be in Normal Mode to continue. Press OK to restart the device out of Recovery Mode, then click the 'Re-Lock device (un-hide baseband, normal mode)' button again to start the re-lock process.")
                        let output1 = runTerminalCommand("\(resourcesPath)/futurerestore_194 --exit-recovery")
                        print(output1)
                        
                        sleep(2)
                        
                        let alert3 = NSAlert()
                        alert3.messageText = "Done!"
                        alert3.informativeText = "Device should now be rebooting into Normal mode. Once you reach the Hello screen, click 'Re-Lock device (un-hide baseband, normal mode)' again to continue."
                        alert3.addButton(withTitle: "OK")
                        
                        alert3.runModal()
                        return
                    } else if checkDeviceState == "DFU" {
                        print("Found device in DFU Mode!")
                        self.showAlert(message: "Device is in DFU Mode!", informativeText: "You must be in Normal Mode to continue. Restart the device out of DFU Mode manually, then click the 'Re-Lock device (un-hide baseband, normal mode)' button again to start the process.")
                        return
                    } else {
                        let alert3 = NSAlert()
                        alert3.messageText = "No device was found!"
                        alert3.informativeText = "Try disconnecting and reconnecting your device.\nIf that fails as well, try using a different USB cable, and ensure that if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter."
                        alert3.addButton(withTitle: "OK")
                        alert3.runModal()
                    }
                    
                } else {
                    
                }
                
            } catch {
                print("An error occurred while reading the file: \(error)")
            }
            
            let filePath = "\(resourcesPath)/work/deviceinfo.txt"
            
            do {
                let fileData = try String(contentsOfFile: filePath, encoding: .utf8)
                let a7Devices = ["iPhone6,1", "iPad4,1", "iPad4,2", "iPad4,3", "iPad4,4", "iPad4,5", "iPad4,6", "iPad4,7", "iPad4,8", "iPad4,9"]
                
                if a7Devices.contains(where: fileData.contains) {
                    print("A7 device detected!")
                    // let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
                    // self.processDeviceDataNotNormal(from: fileURL)
                    // let deviceModel = extractData(from: fileData, start: "NAME: ", end: "\n")  // Assuming each data ends with a newline
                    // showAlert(message: "Please enter DFU Mode now!", informativeText: "If you need instructions on how to enter DFU Mode, please Google 'How to enter DFU mode on ' and then your device model. Example might be 'How to enter DFU mode on iPhone 8'. Then find an online tutorial or website post.")
                    
                    print("Checking iOS Version...")
                    
                    // let checkiOSVersion = self.DeviceInfo("ProductVersion")
                    if let iosVersion = extractData(from: fileData, start: "ProductVersion: ", end: "ProductionSOC:") {
                        let versionComponents = iosVersion.split(separator: ".").map(String.init)
                        var major = 0
                        var minor = 0
                        
                        if versionComponents.count > 0 {
                            major = Int(versionComponents[0]) ?? 0
                        }
                        if versionComponents.count > 1 {
                            minor = Int(versionComponents[1]) ?? 0
                        }
                        
                        // Use only major and minor for comparison and further processing
                        let versionNumber = Double("\(major).\(minor)") ?? 0.0
                        
                        if versionNumber >= 12.0 {
                            if versionNumber < 15.0 {
                                // Use the user's input
                                // print("Device iOS Version: \(checkiOSVersion)")
                                print("Device is between iOS 12 and 14...")
                                print("Device iOS Version: \(iosVersion)")
                                
                                let alert1 = NSAlert()
                                alert1.messageText = "Jailbreak your device"
                                // alert1.informativeText = "You will need to enter DFU mode, so look up how to for your model now if you don't know how to."
                                alert1.informativeText = "You will need to jailbreak your device using Checkra1n to continue. Also, you will need to enter DFU mode, so you can follow the instructions in the jailbreak app."
                                alert1.addButton(withTitle: "Open Checkra1n (Built in to this app)")
                                alert1.addButton(withTitle: "Already Done Jailbreak")
                                alert1.addButton(withTitle: "Cancel")
                                let response = alert1.runModal()
                                if response == .alertFirstButtonReturn {
                                    // self.AutomaticallySSHConnection()
                                    // self.backupPasscodeFiles()
                                    //let alert2 = NSAlert()
                                    //alert2.messageText = "Please enter DFU Mode on your device!"
                                    //alert2.informativeText = "Once done, click OK to continue with jailbreak."
                                    //alert2.addButton(withTitle: "OK")
                                    // alert2.addButton(withTitle: "Cancel")
                                    //alert2.runModal()
                                    
                                    //print("Running checkra1n executable...")
                                    //sleep(2)
                                    
                                    guard let resourcesPath = Bundle.main.resourcePath else {
                                        print("Failed to find the main bundle's resource path")
                                        return
                                    }
                                    
                                    let command1 = "chmod +x \(resourcesPath)/checkra1n.app/Contents/MacOS/checkra1n"
                                    let command2 = "xattr -cr \(resourcesPath)/checkra1n.app"
                                    let command3 = "open \(resourcesPath)/checkra1n.app"
                                    
                                    let process1 = Process()
                                    process1.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process1.arguments = ["-c", command1]
                                    
                                    let process2 = Process()
                                    process2.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process2.arguments = ["-c", command2]
                                    
                                    let process3 = Process()
                                    process3.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process3.arguments = ["-c", command3]
                                    
                                    do {
                                        try process1.run()
                                        process1.waitUntilExit()
                                        
                                        try process2.run()
                                        process2.waitUntilExit()
                                        
                                        try process3.run()
                                        process3.waitUntilExit()
                                    } catch {
                                        print("Failed to run commands: \(error)")
                                    }
                                    
                                    sleep(1)
                                    
                                    let alert2 = NSAlert()
                                    alert2.messageText = "Did the jailbreak complete successfully and say 'All Done'?"
                                    // alert1.informativeText = "You will need to enter DFU mode, so look up how to for your model now if you don't know how to."
                                    alert2.informativeText = ""
                                    alert2.addButton(withTitle: "Yes")
                                    alert2.addButton(withTitle: "No")
                                    let response2 = alert2.runModal()
                                    if response2 == .alertFirstButtonReturn {
                                        // bypassDeviceButton.isEnabled = true
                                        // deactivateButton.isEnabled = true
                                        let alert4 = NSAlert()
                                        alert4.messageText = "Yay!"
                                        alert4.informativeText = "Lockra1n will now move on to re-locking your device!"
                                        alert4.addButton(withTitle: "OK")
                                        // alert2.addButton(withTitle: "Cancel")
                                        alert4.runModal()
                                    } else if response2 == .alertSecondButtonReturn {
                                        print("ERROR: You cannot continue without a jailbreak!")
                                        let alert3 = NSAlert()
                                        alert3.messageText = "Sorry! You cannot continue without a jailbreak!"
                                        alert1.informativeText = "Try jailbreaking again with checkra1n. If it still fails, make sure you are re-locking a device with iOS 12.0 - 14.5.1! For iOS 14.6 to 14.8.1, click the 'Options' button in the checkra1n app and check the 'Allow untested iOS/iPadOS/tvOS versions'. Additionally, for A11 devices, you may need to select 'Skip A11 BPR Check' to be able to continue with the jailbreak. Once done, go back and try re-locking again."
                                        alert3.addButton(withTitle: "OK")
                                        // alert2.addButton(withTitle: "Cancel")
                                        alert3.runModal()
                                        return
                                    }
                                    
                                } else if response == .alertSecondButtonReturn {
                                    // bypassDeviceButton.isEnabled = true
                                    // deactivateButton.isEnabled = true
                                    let alert5 = NSAlert()
                                    alert5.messageText = "Yay!"
                                    alert5.informativeText = "Lockra1n will now move on to re-locking your device!"
                                    alert5.addButton(withTitle: "OK")
                                    // alert2.addButton(withTitle: "Cancel")
                                    alert5.runModal()
                                } else if response == .alertThirdButtonReturn {
                                    return
                                }
                            } else {
                                print("Device is either iOS 15, 16 or 17...")
                                print("Device iOS Version: \(iosVersion)")
                                
                                let alert1 = NSAlert()
                                alert1.messageText = "Jailbreak your device"
                                // alert1.informativeText = "You will need to enter DFU mode, so look up how to for your model now if you don't know how to."
                                alert1.informativeText = "You will need to jailbreak your device using Palera1n to continue. Also, you will need to enter DFU mode. If you don't know how, just Google 'How to enter DFU Mode on ' and then your device model. Example might be 'How to enter DFU Mode on iPhone 8'."
                                alert1.addButton(withTitle: "I've Entered DFU Mode")
                                alert1.addButton(withTitle: "Already Done Jailbreak")
                                alert1.addButton(withTitle: "Cancel")
                                let response = alert1.runModal()
                                if response == .alertFirstButtonReturn {
                                    // self.AutomaticallySSHConnection()
                                    // self.backupPasscodeFiles()
                                    //let alert2 = NSAlert()
                                    //alert2.messageText = "Please enter DFU Mode on your device!"
                                    //alert2.informativeText = "Once done, click OK to continue with jailbreak."
                                    //alert2.addButton(withTitle: "OK")
                                    // alert2.addButton(withTitle: "Cancel")
                                    //alert2.runModal()
                                    
                                    //print("Running palera1n executable...")
                                    //sleep(2)
                                    
                                    guard let resourcesPath = Bundle.main.resourcePath else {
                                        print("Failed to find the main bundle's resource path")
                                        return
                                    }
                                    
                                    let command1 = "chmod +x \(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal"
                                    let command2 = "xattr -cr \(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal"
                                    let command3 = "\(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal -p"
                                    
                                    let process1 = Process()
                                    process1.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process1.arguments = ["-c", command1]
                                    
                                    let process2 = Process()
                                    process2.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process2.arguments = ["-c", command2]
                                    
                                    let process3 = Process()
                                    process3.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process3.arguments = ["-c", command3]
                                    
                                    do {
                                        try process1.run()
                                        process1.waitUntilExit()
                                        
                                        try process2.run()
                                        process2.waitUntilExit()
                                        
                                        try process3.run()
                                        process3.waitUntilExit()
                                    } catch {
                                        print("Failed to run commands: \(error)")
                                    }
                                    
                                    sleep(1)
                                    
                                    let alert2 = NSAlert()
                                    alert2.messageText = "Please unplug your device from the Mac, then re-plug it back in. Click Done once done."
                                    // alert1.informativeText = "You will need to enter DFU mode, so look up how to for your model now if you don't know how to."
                                    alert2.informativeText = ""
                                    alert2.addButton(withTitle: "Done")
                                    alert2.addButton(withTitle: "Cancel")
                                    let response2 = alert2.runModal()
                                    if response2 == .alertFirstButtonReturn {
                                        // bypassDeviceButton.isEnabled = true
                                        // deactivateButton.isEnabled = true
                                        
                                        let command1 = "\(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal -r \(resourcesPath)/PongoOS/build/ramdisk.dmg -V"
                                        
                                        let process1 = Process()
                                        process1.executableURL = URL(fileURLWithPath: "/bin/sh")
                                        process1.arguments = ["-c", command1]
                                        
                                        do {
                                            try process1.run()
                                            process1.waitUntilExit()
                                        } catch {
                                            print("Failed to run command: \(error)")
                                        }
                                        
                                        sleep(5)
                                        let alert4 = NSAlert()
                                        alert4.messageText = "Jailbreak Completed!"
                                        alert4.informativeText = "Your device should now be verbose booting to the Apple logo, then the Hello screen should show. Once done, click OK. Lockra1n will then move on to re-locking your device!"
                                        alert4.addButton(withTitle: "OK")
                                        // alert2.addButton(withTitle: "Cancel")
                                        alert4.runModal()
                                    } else if response2 == .alertSecondButtonReturn {
                                        // print("ERROR: You cannot continue without a jailbreak!")
                                        let alert3 = NSAlert()
                                        alert3.messageText = "Are you sure?"
                                        alert3.informativeText = "If you choose to Cancel, your device will hang on the Pongo shell until it is force restarted or the battery dies."
                                        alert3.addButton(withTitle: "Continue Jailbreak")
                                        alert3.addButton(withTitle: "Cancel Jailbreak")
                                        let response3 = alert3.runModal()
                                        if response3 == .alertFirstButtonReturn {
                                            let command1 = "\(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal -r \(resourcesPath)/PongoOS/build/ramdisk.dmg -V"
                                            
                                            let process1 = Process()
                                            process1.executableURL = URL(fileURLWithPath: "/bin/sh")
                                            process1.arguments = ["-c", command1]
                                            
                                            do {
                                                try process1.run()
                                                process1.waitUntilExit()
                                            } catch {
                                                print("Failed to run command: \(error)")
                                            }
                                            
                                            sleep(5)
                                            let alert4 = NSAlert()
                                            alert4.messageText = "Jailbreak Completed!"
                                            alert4.informativeText = "Your device should now be verbose booting to the Apple logo, then the Hello screen should show. Once done, click OK. Lockra1n will then move on to re-locking your device!"
                                            alert4.addButton(withTitle: "OK")
                                            // alert2.addButton(withTitle: "Cancel")
                                            alert4.runModal()
                                        } else if response3 == .alertSecondButtonReturn {
                                            return
                                        }
                                    }
                                    
                                } else if response == .alertSecondButtonReturn {
                                    // bypassDeviceButton.isEnabled = true
                                    // deactivateButton.isEnabled = true
                                    let alert5 = NSAlert()
                                    alert5.messageText = "Yay!"
                                    alert5.informativeText = "Lockra1n will now move on to re-locking your device!"
                                    alert5.addButton(withTitle: "OK")
                                    // alert2.addButton(withTitle: "Cancel")
                                    alert5.runModal()
                                } else if response == .alertThirdButtonReturn {
                                    return
                                }
                            }
                            let alert1 = NSAlert()
                            alert1.messageText = "One last check!"
                            alert1.informativeText = "Please ensure your device has full booted up (on the Hello screen or any setup screen) and is connected to the Mac. This is crutial for Lockra1n to work correctly. Click OK to confirm and move on to re-locking your device!"
                            alert1.addButton(withTitle: "OK")
                            // alert2.addButton(withTitle: "Cancel")
                            alert1.runModal()
                            
                            print("Starting re-lock script...")
                            sleep(3)
                            let scriptPath = "\(resourcesPath)/unhide_baseband_normalmode.sh"
                            let process = Process()
                            process.executableURL = URL(fileURLWithPath: "/bin/sh")
                            process.arguments = [scriptPath]
                            do {
                                try process.run()
                                process.waitUntilExit()
                            } catch {
                                // If failed, then print the error
                                print("Failed to run script: \(error)")
                            }
                            sleep(3)
                            print("✓ Device Re-lock complete! ✓")
                            showAlert(message: "Device Re-lock Done!", informativeText: "Your device will now reboot up to the setup screen!\n\nPS. If you got some of your devices working thanks to this tool, send me a DM on X (@AlwaysAppleFTD) or on Instagram (@finn.desilva) :)")
                        } else {
                            print("Device iOS Version: \(iosVersion)")
                            print("ERROR: iOS Version not supported!")
                            showAlert(message: "ERROR: The iOS version of the device is not supported!", informativeText: "Lockra1n supports checkm8-compatible devices running iOS 12.0 - 16.7.8")
                            return
                        }
                    }
                    
                    // self.detectDFUDeviceNoPopUpV3()
                    
                    // Get success or failure
                    // if !success2 {
                    // return  // Stop further processing because detectDFUDeviceNoPopUp failed
                    // }
                    // self.detectDFUDeviceNoPopUp(from: fileURL)
                    // } while !success
                    
                    //                        print("Showing showAskiOSVersionAlert2")
                    //                        self.showAskiOSVersionAlert2()
                } else if fileData.contains("ERROR: No device found!") {
                    print("Something's not right. Your device was originally found, but appears to no longer be connected. Please try again.")
                    return
                    // showAlert(message: "ERROR: No device was detected!", informativeText: "This could mean that your device is not in DFU or Recovery mode, or isn't connected at all. Please connect a device in DFU mode to continue.")
                    // showAlert(message: "No device was found!", informativeText: "If your device is in DFU mode or Recovery, then try booting into Normal mode and bypassing again.\n\nIf your device is in Normal mode, then try pressing the 'Search for Device' button again to re-pair the device. Then try bypassing again.\n\nIf that fails as well, try using a different USB cable, and also make sure if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter.")
                } else {
                    // This else block correctly handles any other device processor.
                    print("A8 or higher device detected!")
                    
                    print("Checking iOS Version...")
                    
                    // let checkiOSVersion = self.DeviceInfo("ProductVersion")
                    if let iosVersion = extractData(from: fileData, start: "ProductVersion: ", end: "ProductionSOC:") {
                        let versionComponents = iosVersion.split(separator: ".").map(String.init)
                        var major = 0
                        var minor = 0
                        
                        if versionComponents.count > 0 {
                            major = Int(versionComponents[0]) ?? 0
                        }
                        if versionComponents.count > 1 {
                            minor = Int(versionComponents[1]) ?? 0
                        }
                        
                        // Use only major and minor for comparison and further processing
                        let versionNumber = Double("\(major).\(minor)") ?? 0.0
                        
                        if versionNumber >= 12.0 {
                            if versionNumber < 15.0 {
                                // Use the user's input
                                // print("Device iOS Version: \(checkiOSVersion)")
                                print("Device is between iOS 12 and 14...")
                                print("Device iOS Version: \(iosVersion)")
                                
                                let alert1 = NSAlert()
                                alert1.messageText = "Jailbreak your device"
                                // alert1.informativeText = "You will need to enter DFU mode, so look up how to for your model now if you don't know how to."
                                alert1.informativeText = "You will need to jailbreak your device using Checkra1n to continue. Also, you will need to enter DFU mode, so you can follow the instructions in the jailbreak app."
                                alert1.addButton(withTitle: "Open Checkra1n (Built in to this app)")
                                alert1.addButton(withTitle: "Already Done Jailbreak")
                                alert1.addButton(withTitle: "Cancel")
                                let response = alert1.runModal()
                                if response == .alertFirstButtonReturn {
                                    // self.AutomaticallySSHConnection()
                                    // self.backupPasscodeFiles()
                                    //let alert2 = NSAlert()
                                    //alert2.messageText = "Please enter DFU Mode on your device!"
                                    //alert2.informativeText = "Once done, click OK to continue with jailbreak."
                                    //alert2.addButton(withTitle: "OK")
                                    // alert2.addButton(withTitle: "Cancel")
                                    //alert2.runModal()
                                    
                                    //print("Running checkra1n executable...")
                                    //sleep(2)
                                    
                                    guard let resourcesPath = Bundle.main.resourcePath else {
                                        print("Failed to find the main bundle's resource path")
                                        return
                                    }
                                    
                                    let command1 = "chmod +x \(resourcesPath)/checkra1n.app/Contents/MacOS/checkra1n"
                                    let command2 = "xattr -cr \(resourcesPath)/checkra1n.app"
                                    let command3 = "open \(resourcesPath)/checkra1n.app"
                                    
                                    let process1 = Process()
                                    process1.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process1.arguments = ["-c", command1]
                                    
                                    let process2 = Process()
                                    process2.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process2.arguments = ["-c", command2]
                                    
                                    let process3 = Process()
                                    process3.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process3.arguments = ["-c", command3]
                                    
                                    do {
                                        try process1.run()
                                        process1.waitUntilExit()
                                        
                                        try process2.run()
                                        process2.waitUntilExit()
                                        
                                        try process3.run()
                                        process3.waitUntilExit()
                                    } catch {
                                        print("Failed to run commands: \(error)")
                                    }
                                    
                                    sleep(1)
                                    
                                    let alert2 = NSAlert()
                                    alert2.messageText = "Did the jailbreak complete successfully and say 'All Done'?"
                                    // alert1.informativeText = "You will need to enter DFU mode, so look up how to for your model now if you don't know how to."
                                    alert2.informativeText = ""
                                    alert2.addButton(withTitle: "Yes")
                                    alert2.addButton(withTitle: "No")
                                    let response2 = alert2.runModal()
                                    if response2 == .alertFirstButtonReturn {
                                        // bypassDeviceButton.isEnabled = true
                                        // deactivateButton.isEnabled = true
                                        let alert4 = NSAlert()
                                        alert4.messageText = "Yay!"
                                        alert4.informativeText = "Lockra1n will now move on to re-locking your device!"
                                        alert4.addButton(withTitle: "OK")
                                        // alert2.addButton(withTitle: "Cancel")
                                        alert4.runModal()
                                    } else if response2 == .alertSecondButtonReturn {
                                        print("ERROR: You cannot continue without a jailbreak!")
                                        let alert3 = NSAlert()
                                        alert3.messageText = "Sorry! You cannot continue without a jailbreak!"
                                        alert1.informativeText = "Try jailbreaking again with checkra1n. If it still fails, make sure you are re-locking a device with iOS 12.0 - 14.5.1! For iOS 14.6 to 14.8.1, click the 'Options' button in the checkra1n app and check the 'Allow untested iOS/iPadOS/tvOS versions'. Additionally, for A11 devices, you may need to select 'Skip A11 BPR Check' to be able to continue with the jailbreak. Once done, go back and try re-locking again."
                                        alert3.addButton(withTitle: "OK")
                                        // alert2.addButton(withTitle: "Cancel")
                                        alert3.runModal()
                                        return
                                    }
                                    
                                } else if response == .alertSecondButtonReturn {
                                    // bypassDeviceButton.isEnabled = true
                                    // deactivateButton.isEnabled = true
                                    let alert5 = NSAlert()
                                    alert5.messageText = "Yay!"
                                    alert5.informativeText = "Lockra1n will now move on to re-locking your device!"
                                    alert5.addButton(withTitle: "OK")
                                    // alert2.addButton(withTitle: "Cancel")
                                    alert5.runModal()
                                } else if response == .alertThirdButtonReturn {
                                    return
                                }
                            } else {
                                print("Device is either iOS 15, 16 or 17...")
                                print("Device iOS Version: \(iosVersion)")
                                
                                let alert1 = NSAlert()
                                alert1.messageText = "Jailbreak your device"
                                // alert1.informativeText = "You will need to enter DFU mode, so look up how to for your model now if you don't know how to."
                                alert1.informativeText = "You will need to jailbreak your device using Palera1n to continue. Also, you will need to enter DFU mode. If you don't know how, just Google 'How to enter DFU Mode on ' and then your device model. Example might be 'How to enter DFU Mode on iPhone 8'."
                                alert1.addButton(withTitle: "I've Entered DFU Mode")
                                alert1.addButton(withTitle: "Already Done Jailbreak")
                                alert1.addButton(withTitle: "Cancel")
                                let palera1nJBresponse = alert1.runModal()
                                if palera1nJBresponse == .alertFirstButtonReturn {
                                    // self.AutomaticallySSHConnection()
                                    // self.backupPasscodeFiles()
                                    //let alert2 = NSAlert()
                                    //alert2.messageText = "Please enter DFU Mode on your device!"
                                    //alert2.informativeText = "Once done, click OK to continue with jailbreak."
                                    //alert2.addButton(withTitle: "OK")
                                    // alert2.addButton(withTitle: "Cancel")
                                    //alert2.runModal()
                                    
                                    //print("Running palera1n executable...")
                                    //sleep(2)
                                    
                                    guard let resourcesPath = Bundle.main.resourcePath else {
                                        print("Failed to find the main bundle's resource path")
                                        return
                                    }
                                    
                                    let command1 = "chmod +x \(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal"
                                    let command2 = "xattr -cr \(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal"
                                    let command3 = "\(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal -p"
                                    
                                    let process1 = Process()
                                    process1.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process1.arguments = ["-c", command1]
                                    
                                    let process2 = Process()
                                    process2.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process2.arguments = ["-c", command2]
                                    
                                    let process3 = Process()
                                    process3.executableURL = URL(fileURLWithPath: "/bin/sh")
                                    process3.arguments = ["-c", command3]
                                    
                                    do {
                                        try process1.run()
                                        process1.waitUntilExit()
                                        
                                        try process2.run()
                                        process2.waitUntilExit()
                                        
                                        try process3.run()
                                        process3.waitUntilExit()
                                    } catch {
                                        print("Failed to run commands: \(error)")
                                    }
                                    
                                    sleep(1)
                                    
                                    let alert2 = NSAlert()
                                    alert2.messageText = "Please unplug your device from the Mac, then re-plug it back in. Click Done once done."
                                    // alert1.informativeText = "You will need to enter DFU mode, so look up how to for your model now if you don't know how to."
                                    alert2.informativeText = ""
                                    alert2.addButton(withTitle: "Done")
                                    alert2.addButton(withTitle: "Cancel")
                                    let response2 = alert2.runModal()
                                    if response2 == .alertFirstButtonReturn {
                                        // bypassDeviceButton.isEnabled = true
                                        // deactivateButton.isEnabled = true
                                        
                                        let command1 = "\(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal -r \(resourcesPath)/PongoOS/build/ramdisk.dmg -V"
                                        
                                        let process1 = Process()
                                        process1.executableURL = URL(fileURLWithPath: "/bin/sh")
                                        process1.arguments = ["-c", command1]
                                        
                                        do {
                                            try process1.run()
                                            process1.waitUntilExit()
                                        } catch {
                                            print("Failed to run command: \(error)")
                                        }
                                        
                                        sleep(5)
                                        let alert4 = NSAlert()
                                        alert4.messageText = "Jailbreak Completed!"
                                        alert4.informativeText = "Your device should now be verbose booting to the Apple logo, then the Hello screen should show. Once done, click OK. Lockra1n will then move on to re-locking your device!"
                                        alert4.addButton(withTitle: "OK")
                                        // alert2.addButton(withTitle: "Cancel")
                                        alert4.runModal()
                                    } else if response2 == .alertSecondButtonReturn {
                                        // print("ERROR: You cannot continue without a jailbreak!")
                                        let alert3 = NSAlert()
                                        alert3.messageText = "Are you sure?"
                                        alert3.informativeText = "If you choose to Cancel, your device will hang on the Pongo shell until it is force restarted or the battery dies."
                                        alert3.addButton(withTitle: "Continue")
                                        alert3.addButton(withTitle: "Cancel Jailbreak")
                                        let response3 = alert3.runModal()
                                        if response3 == .alertFirstButtonReturn {
                                            let command1 = "\(resourcesPath)/jailbreak/palera1n-macos-universal_bakepal -r \(resourcesPath)/PongoOS/build/ramdisk.dmg -V"
                                            
                                            let process1 = Process()
                                            process1.executableURL = URL(fileURLWithPath: "/bin/sh")
                                            process1.arguments = ["-c", command1]
                                            
                                            do {
                                                try process1.run()
                                                process1.waitUntilExit()
                                            } catch {
                                                print("Failed to run command: \(error)")
                                            }
                                            
                                            sleep(5)
                                            let alert4 = NSAlert()
                                            alert4.messageText = "Jailbreak Completed!"
                                            alert4.informativeText = "Your device should now be verbose booting to the Apple logo, then the Hello screen should show. Once done, click OK. Lockra1n will then move on to re-locking your device!"
                                            alert4.addButton(withTitle: "OK")
                                            // alert2.addButton(withTitle: "Cancel")
                                            alert4.runModal()
                                        } else if response3 == .alertSecondButtonReturn {
                                            return
                                        }
                                    }
                                    
                                } else if palera1nJBresponse == .alertSecondButtonReturn {
                                    // bypassDeviceButton.isEnabled = true
                                    // deactivateButton.isEnabled = true
                                    let alert5 = NSAlert()
                                    alert5.messageText = "Yay!"
                                    alert5.informativeText = "Lockra1n will now move on to re-locking your device!"
                                    alert5.addButton(withTitle: "OK")
                                    // alert2.addButton(withTitle: "Cancel")
                                    alert5.runModal()
                                } else if palera1nJBresponse == .alertThirdButtonReturn {
                                    return
                                }
                            }
                            let alert1 = NSAlert()
                            alert1.messageText = "One last check!"
                            alert1.informativeText = "Please ensure your device has full booted up (on the Hello screen or any setup screen) and is connected to the Mac. This is crutial for Lockra1n to work correctly. Click OK to confirm and move on to re-locking your device!"
                            alert1.addButton(withTitle: "OK")
                            // alert2.addButton(withTitle: "Cancel")
                            alert1.runModal()
                            
                            print("Starting re-lock script...")
                            sleep(3)
                            let scriptPath = "\(resourcesPath)/unhide_baseband_normalmode.sh"
                            let process = Process()
                            process.executableURL = URL(fileURLWithPath: "/bin/sh")
                            process.arguments = [scriptPath]
                            do {
                                try process.run()
                                process.waitUntilExit()
                            } catch {
                                // If failed, then print the error
                                print("Failed to run script: \(error)")
                            }
                            sleep(3)
                            print("✓ Device Re-lock complete! ✓")
                            showAlert(message: "Device Re-lock Done!", informativeText: "Your device will now reboot up to the setup screen!\n\nPS. If you got some of your devices working thanks to this tool, send me a DM on X (@AlwaysAppleFTD) or on Instagram (@finn.desilva) :)")
                        } else {
                            print("Device iOS Version: \(iosVersion)")
                            print("ERROR: iOS Version not supported!")
                            showAlert(message: "ERROR: The iOS version of the device is not supported!", informativeText: "Lockra1n supports checkm8-compatible devices running iOS 12.0 - 16.7.8")
                            return
                        }
                    }
                }
            } catch {
                print("Error reading file: \(error)")
            }
        }
        
        //            // If success, proceed with script execution
        //            let scriptPath = "\(resourcesPath)/generate_activation_files.sh"
        //
        //            let process = Process()
        //            process.executableURL = URL(fileURLWithPath: "/bin/sh")
        //            process.arguments = [scriptPath]
        //
        //            do {
        //                try process.run()
        //                process.waitUntilExit()
        //            } catch {
        //                // If failed, then print the error
        //                print("Failed to run script: \(error)")
        //            }
        // }
        
        if response == .alertSecondButtonReturn {
            return
        }
    }
    
    
    @IBAction func enterRecoveryButtonPressed(_ sender: NSButton) {
        
    }
    
    @IBAction func manageRecoveryButtonPressed(_ sender: NSButton) {
        let alert1 = NSAlert()
        alert1.messageText = "Manage Recovery Mode Options"
        alert1.informativeText = ""
        alert1.addButton(withTitle: "Enter Recovery Mode")
        alert1.addButton(withTitle: "Exit Recovery Mode")
        alert1.addButton(withTitle: "Cancel")
        
        let response = alert1.runModal()
        
        if response == .alertFirstButtonReturn {
            self.enterRecoveryMode()
        }
        
        if response == .alertSecondButtonReturn {
            self.exitRecoveryMode()
        }
        
        if response == .alertThirdButtonReturn {
            return
        }
    }
    
    
    func enterRecoveryMode() {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return
        }
        
        let alert1 = NSAlert()
        alert1.messageText = "Enter Recovery Mode?"
        alert1.informativeText = "If successful, your device will show a Connect to iTunes or Connect to Computer icon after it reboots."
        alert1.addButton(withTitle: "OK")
        alert1.addButton(withTitle: "Cancel")
        
        let response = alert1.runModal()
        
        if response == .alertFirstButtonReturn {
            guard let resourcesPath = Bundle.main.resourcePath else {
                print("Failed to find the main bundle's resource path")
                return
            }
            
            let output1 = runTerminalCommand("\(resourcesPath)/idevicepair unpair")
            print(output1)
            
            let output2 = runTerminalCommand("\(resourcesPath)/idevicepair pair")
            print(output2)
            
            let alert2 = NSAlert()
            alert2.messageText = "Lockra1n is asking for you to press trust on your device."
            alert2.informativeText = "If you see the prompt to Trust this computer, then please do so then click OK.\nIf you don't see a trust prompt, then you're good to go.\nONLY click OK when that's done."
            alert2.addButton(withTitle: "OK")
            
            alert2.runModal()
            
            let output3 = runTerminalCommand("\(resourcesPath)/enter_recovery.sh")
            print(output3)
            
            sleep(2)
            
            let alert3 = NSAlert()
            alert3.messageText = "Done!"
            alert3.informativeText = "Device should now be booting into Recovery Mode."
            alert3.addButton(withTitle: "OK")
            
            alert3.runModal()
        }
        
        if response == .alertSecondButtonReturn {
            return
        }
        
    }
    
    func exitRecoveryMode() {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return
        }
        
        let alert1 = NSAlert()
        alert1.messageText = "Exit Recovery Mode?"
        alert1.informativeText = "If successful, your device will reboot and boot back up into Normal mode."
        alert1.addButton(withTitle: "OK")
        alert1.addButton(withTitle: "Cancel")
        
        let response = alert1.runModal()
        
        if response == .alertFirstButtonReturn {
            guard let resourcesPath = Bundle.main.resourcePath else {
                print("Failed to find the main bundle's resource path")
                return
            }
            
            //let output1 = runTerminalCommand("\(resourcesPath)/tools/idevicepair unpair")
            //print(output1)
            
           // let output2 = runTerminalCommand("\(resourcesPath)/tools/idevicepair pair")
           // print(output2)
            
           // let alert2 = NSAlert()
           // alert2.messageText = "Lockra1n is asking for you to press trust on your device."
           // alert2.informativeText = "If you see the prompt to Trust this computer, then please do so then click OK.\nIf you don't see a trust prompt, then you're good to go.\nONLY click OK when that's done."
           // alert2.addButton(withTitle: "OK")
            
           // alert2.runModal()
            
            let output1 = runTerminalCommand("\(resourcesPath)/futurerestore_194 --exit-recovery")
            print(output1)
            
            sleep(2)
            
            let alert3 = NSAlert()
            alert3.messageText = "Done!"
            alert3.informativeText = "Device should now be rebooting into Normal mode."
            alert3.addButton(withTitle: "OK")
            
            alert3.runModal()
        }
        
        if response == .alertSecondButtonReturn {
            return
        }
        
    }
    
    @IBAction func enterPwnDFUButtonPressed(_ sender: NSButton) {
        // Make an Alert pop-up
        let alert1 = NSAlert()
        alert1.messageText = "This will enter PwnDFU Mode."
        alert1.informativeText = "Please put your device into DFU mode first, then click OK.\n\nIf you need instructions on how to enter DFU Mode, please Google 'How to enter DFU mode on ' then your device model, example might be 'How to enter DFU mode on iPhone 7'. Then find an online tutorial or website post."
        alert1.addButton(withTitle: "OK")
        alert1.addButton(withTitle: "Cancel")
        
        let response = alert1.runModal()
        // If the 'OK' button was pressed, then execute the 'test.sh' script
        if response == .alertFirstButtonReturn {
            guard let resourcesPath = Bundle.main.resourcePath else {
                print("Failed to find the main bundle's resource path")
                return
            }
            
            let output1 = runTerminalCommand("\(resourcesPath)/gaster pwn")
            print(output1)
        }
        
        if response == .alertSecondButtonReturn {
            return
        }
        
        let alert2 = NSAlert()
        alert2.messageText = "Done!"
        alert2.informativeText = "Device should now have entered PwnDFU Mode!"
        alert2.addButton(withTitle: "")
        //alert2.addButton(withTitle: "Cancel")
        
        alert2.runModal()
    }
    
    
    @IBAction func restoreDeviceButtonPressed(_ sender: NSButton) {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return
        }
        
            let panel = NSOpenPanel()
            panel.canChooseFiles = true
            panel.canChooseDirectories = false
            panel.allowsMultipleSelection = false
            panel.allowedFileTypes = ["ipsw"]
            
            if panel.runModal() == .OK, let url = panel.url {
                let filePath = url.path
                print("Writing IPSW directory to file:", filePath)
                    
                    let output4 = runTerminalCommand("rm -rf \(resourcesPath)/ipsw.txt")
                    print(output4)
                    
                    let output5 = runTerminalCommand("cp -R \(resourcesPath)/ipsw_blank.txt \(resourcesPath)/ipsw.txt")
                    print(output5)
                    
                    sleep(1)
                    
                    do {
                        try filePath.write(toFile: "\(resourcesPath)/ipsw.txt", atomically: true, encoding: .utf8)
                        
                        print("Searching for connected device...")
                        
                        let output1 = runTerminalCommand("cd \(resourcesPath) && chmod +x * && xattr -cr *")
                        print(output1)
                        
                        let output2 = runTerminalCommand("\(resourcesPath)/ideviceinfo > \(resourcesPath)/work/deviceinfo.txt 2>&1")
                        print(output2)
                        
                        //DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/deviceinfo.txt")
                        let success = self.processDeviceDataNoErrorPopUp(from: fileURL)  // Get success or failure
                        
                        if !success {
                            //return  // Stop further processing because processDeviceDataNoPopUp failed
                            print("ERROR: No normal mode device found!")
                            print("Searching for Recovery or DFU Mode device...")
                            sleep(2)
                            
                            detectDFUDeviceNoPopUpV2Restore()
                            
                            //let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
//                            let success = self.detectDFUDeviceNoPopUpV2Restore()  // Get success or failure
//
//                            if !success {
//                                return // Stop further processing because processDeviceDataNoPopUp failed
//                            }
                        }
                            let filePath = "\(resourcesPath)/work/deviceinfo.txt"
                            
                            do {
                                let fileData = try String(contentsOfFile: filePath, encoding: .utf8)
                                let a7Devices = ["iPhone6,1", "iPad4,1", "iPad4,2", "iPad4,3", "iPad4,4", "iPad4,5", "iPad4,6", "iPad4,7", "iPad4,8", "iPad4,9"]
                                
                                if a7Devices.contains(where: fileData.contains) {
                                    print("A7 device detected!")
                                    // let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/dfu.txt")
                                    // self.processDeviceDataNotNormal(from: fileURL)
                                    // let deviceModel = extractData(from: fileData, start: "NAME: ", end: "\n")  // Assuming each data ends with a newline
                                    showAlert(message: "Please enter DFU Mode now!", informativeText: "If you need instructions on how to enter DFU Mode, please Google 'How to enter DFU mode on ' and then your device model. Example might be 'How to enter DFU mode on iPhone 8'. Then find an online tutorial or website post.")
                                    
                                    self.detectDFUDeviceNoPopUpV2Restore()
                                    
                                } else if fileData.contains("ERROR: No device found!") {
                                    print("Something's not right. Your device was originally found, but appears to no longer be connected. Please try again.")
                                    return
                                    
                                } else {
                                    // This else block correctly handles any other device processor.
                                    print("A8 or higher device detected!")
                                    
                                    showAlert(message: "Please enter DFU Mode now!", informativeText: "If you need instructions on how to enter DFU Mode, please Google 'How to enter DFU mode on ' and then your device model. Example might be 'How to enter DFU mode on iPhone 8'. Then find an online tutorial or website post.")
                                    
                                    self.detectDFUDeviceNoPopUpV2Restore()
                                }
                            } catch {
                                print("Error reading file: \(error)")
                            }
                    } catch {
                        print("Error writing to file: \(error)")
                    }
            } else {
                    print("ERROR: No IPSW selected.")
                    // Handle the case where no folder is selected
                    let output3 = runTerminalCommand("rm -rf \(resourcesPath)/ipsw.txt")
                    print(output3)
            }
        }
    
    
    @IBAction func getDeviceInfoButtonPressed(_ sender: NSButton) {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            return
        }
        let alert1 = NSAlert()
        alert1.messageText = "Seaching for a connected device"
        alert1.informativeText = "This may take a few seconds..."
        alert1.addButton(withTitle: "OK")
        //alert2.addButton(withTitle: "Cancel")
        
        alert1.runModal()
        
        let output1 = runTerminalCommand("\(resourcesPath)/idevicepair unpair")
        print(output1)
        
        let output2 = runTerminalCommand("\(resourcesPath)/idevicepair pair")
        print(output2)
        
        let alert2 = NSAlert()
        alert2.messageText = "Lockra1n is asking for you to press trust on your device."
        alert2.informativeText = "If you see the prompt to Trust this computer, then please do so then click OK.\nIf you don't see a trust prompt, then you're good to go.\nONLY click OK when that's done."
        alert2.addButton(withTitle: "OK")
        
        alert2.runModal()
        
        let checkDeviceConnected = self.DeviceInfo("ERROR")
        
        if checkDeviceConnected.contains("No device found!") {
            let alert3 = NSAlert()
            alert3.messageText = "No device was found!"
            alert3.informativeText = "Try disconnecting and reconnecting your device.\nIf that fails as well, try using a different USB cable, and ensure that if your Mac has the new USB-C ports, you are using a USB-C to USB-A adapter."
            alert3.addButton(withTitle: "OK")
            alert3.runModal()
            return
        }
        
        let findDeviceModel = self.DeviceInfo("ProductType")
        print(findDeviceModel)
        
        let serialNumber = self.DeviceInfo("SerialNumber")
        print(serialNumber)
        
        let udid = self.DeviceInfo("UniqueDeviceID")
        let iosVersion = self.DeviceInfo("ProductVersion")
        let deviceName = self.DeviceInfo("DeviceName")
        let modelNumber = self.DeviceInfo("ModelNumber")
        let activationState = self.DeviceInfo("ActivationState")
        let passwordProtected = self.DeviceInfo("PasswordProtected")
        let productType = self.DeviceInfo("ProductType")
        //let serialNumber = extractDataV2(from: fileData, start: "SerialNumber: ", end: "SoftwareBehavior:")
        //let phoneNumber = extractDataV2(from: fileData, start: "PhoneNumber: ", end: "PkHash:")
        //let activationStateAcknowledged = extractDataV2(from: fileData, start: "ActivationStateAcknowledged: ", end: "BasebandActivationTicketVersion:")
        
        // Use the extracted values to create a detailed message
        //if let udid = udid, let iosVersion = iosVersion, let deviceName = deviceName {
            self.showAlert(message: "Found iDevice with values:\nSerial Number: \(serialNumber),\nUDID: \(udid),\niOS Version: \(iosVersion),\nDevice Name: \(deviceName),\nModel Number: \(modelNumber), \nActivation State: \(activationState), \nPassword Protected: \(passwordProtected), \nProduct Type: \(productType)", informativeText: "You can use this information for almost anything that requires device info, including Lockra1n registration!")
        //} else {
        
//        let output3 = runTerminalCommand("\(resourcesPath)/ideviceinfo > \(resourcesPath)/work/deviceinfo.txt")
//        print(output3)
//        sleep(2)
//
//        // DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//        let fileURL = URL(fileURLWithPath: "\(resourcesPath)/work/deviceinfo.txt")
//        do {
//            let fileData = try String(contentsOf: fileURL, encoding: .utf8)
//            //print("File Data: \(fileData)") // Debug: Check what is being read
//
//            } else {
//                let filePath = "\(resourcesPath)/work/deviceinfo.txt"
//                let fileURL = URL(fileURLWithPath: filePath)
//                self.processDeviceDataV2(from: fileURL)
//            }
//        } catch {
//            print("An error occurred while reading the file: \(error)")
//        }
//        // }
    }
    
    
    @IBAction func helpButtonPressed(_ sender: NSButton) {
        if let url = URL(string: "https://alwaysappleftd.com/software/Lockra1n.html") {
            NSWorkspace.shared.open(url)
        }
    }
    
    
    @IBAction func creditsButtonPressed(_ sender: NSButton) {
        self.showCreditsScreen()
    }
    
    
    @IBAction func youtubeButtonPressed(_ sender: NSButton) {
    if let url = URL(string: "https://youtube.com/@alwaysappleftd/videos?sub_confirmation=1") {
            NSWorkspace.shared.open(url)
        }
    }
    
    
    @IBAction func twitterButtonPressed(_ sender: NSButton) {
        if let url = URL(string: "https://twitter.com/intent/follow?screen_name=AlwaysAppleFTD") {
            NSWorkspace.shared.open(url)
        }
    }
    
    
    @IBAction func instagramButtonPressed(_ sender: NSButton) {
        if let url = URL(string: "https://instagram.com/finn.desilva") {
            NSWorkspace.shared.open(url)
        }
    }
    
    func openReportBug() {
        if let url = URL(string: "mailto:alwaysappleftd@icloud.com?subject=Issue%20with%20Lockra1n") {
            NSWorkspace.shared.open(url)
        } else {
            print("Could not create URL.")
        }
    }
    
    func sendVersionToServer() {
        if !isInternetAvailable() {
            print("Error: No internet connection!")
            DispatchQueue.main.async {
                self.showCriticalAlert(message: "No Internet Connection", informativeText: "An internet connection is required for Lockra1n to function. The software will exit.")
            }
            return
        }
        
        guard let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            print("Failed to get app version")
            return
        }

        let url = URL(string: "https://alwaysappleftd.com/software/Lockra1n/app_version.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "version=\(appVersion)"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }

            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
                DispatchQueue.main.async {
                    self.handleServerResponse(responseString)
                }
            }
        }
        task.resume()
    }

    func handleServerResponse(_ response: String) {
        if response.hasPrefix("critical_update_required") {
            let criticalMessage = response.replacingOccurrences(of: "critical_update_required: ", with: "")
            showCriticalAlert(message: "A critical Lockra1n error has occurred.", informativeText: criticalMessage)
        } else if response.hasPrefix("update_required") {
            let downloadURLPrefix = "download_url: "
            if let downloadURLRange = response.range(of: downloadURLPrefix) {
                let downloadURL = String(response[downloadURLRange.upperBound...])
                showUpdateAlert(message: "Update Available", informativeText: "A new version of Lockra1n is available. Please update to the latest version.", updateURLString: downloadURL)
            } else {
                showUpdateAlert(message: "Update Available", informativeText: "A new version of Lockra1n is available. Please update to the latest version.", updateURLString: "https://alwaysappleftd.com/software/Lockra1n.html")
            }
        }
    }
    
    
    @IBAction func sendNotification(_ sender: NSButton) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                // Notification is allowed
                let content = UNMutableNotificationContent()
                content.title = "Test Notification"
                content.body = "This is the body of the test notification."
                content.sound = UNNotificationSound.default // Play the default sound

                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)

                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                notificationCenter.add(request) { error in
                    if let error = error {
                        // Handle any errors
                        print("Error scheduling notification: \(error.localizedDescription)")
                    } else {
                        print("Notification scheduled successfully.")
                    }
                }
            } else {
                print("Notifications are not allowed for this application")
            }
        }
        // self.runAppleScript()
    }
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }) else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return isReachable && !needsConnection
    }
    
    @IBAction func doneCreditsButtonPressed(_ sender: NSButton) {
        self.creditsMainText.isHidden = true
        self.creditsText1.isHidden = true
        self.nathanDevText.isHidden = true
        self.mrcreatorDevText1.isHidden = true
        self.mrcreatorDevText2.isHidden = true
        self.libimobiledeviceText.isHidden = true
        self.creditsText2.isHidden = true
        self.doneCreditsButton.isHidden = true
        
        self.welcomeText.isHidden = false
        self.infoText1.isHidden = false
        self.startSteps1.isHidden = false
        self.prepareLockra1nRef.isHidden = false
        self.searchDeviceRef.isHidden = false
        self.genActRef.isHidden = false
        self.bypassDeviceRef.isHidden = false
        self.bypassDeviceNormalMode.isHidden = false
        self.relockDeviceRef.isHidden = false
        self.relockDeviceNormalModeRef.isHidden = false
        self.moreOptionsText.isHidden = false
        self.exitRecModeRef.isHidden = false
        //self.manageRecoveryRef.isHidden = false
        self.enterPwnDFURef.isHidden = false
        self.restoreDeviceRef.isHidden = false
        self.getDeviceInfoRef.isHidden = false
        self.helpButtonRef.isHidden = false
        self.creditsButtonRef.isHidden = false
        self.followMeTextRef.isHidden = false
        self.youtubeButtonRef.isHidden = false
        self.twitterButtonRef.isHidden = false
        self.instagramButtonRef.isHidden = false
        
    }
    
    
    func showCreditsScreen() {
        self.creditsMainText.isHidden = false
        self.creditsText1.isHidden = false
        self.nathanDevText.isHidden = false
        self.mrcreatorDevText1.isHidden = false
        self.mrcreatorDevText2.isHidden = false
        self.libimobiledeviceText.isHidden = false
        self.creditsText2.isHidden = false
        self.doneCreditsButton.isHidden = false
        
        self.welcomeText.isHidden = true
        self.infoText1.isHidden = true
        self.startSteps1.isHidden = true
        self.prepareLockra1nRef.isHidden = true
        self.searchDeviceRef.isHidden = true
        self.genActRef.isHidden = true
        self.bypassDeviceRef.isHidden = true
        self.bypassDeviceNormalMode.isHidden = true
        self.relockDeviceRef.isHidden = true
        self.relockDeviceNormalModeRef.isHidden = true
        self.moreOptionsText.isHidden = true
        self.exitRecModeRef.isHidden = true
        //self.manageRecoveryRef.isHidden = true
        self.enterPwnDFURef.isHidden = true
        self.restoreDeviceRef.isHidden = true
        self.getDeviceInfoRef.isHidden = true
        self.helpButtonRef.isHidden = true
        self.creditsButtonRef.isHidden = true
        self.followMeTextRef.isHidden = true
        self.youtubeButtonRef.isHidden = true
        self.twitterButtonRef.isHidden = true
        self.instagramButtonRef.isHidden = true
        
    }
    
    func checkDependencies(completion: @escaping (Bool) -> Void) {
        guard let resourcesPath = Bundle.main.resourcePath else {
            print("Failed to find the main bundle's resource path")
            completion(false)
            return
        }
        
        let paths = [
            "ideviceinfo",
            "idevicepair",
            "sshpass",
            "move",
            "move/libimobiledevice-1.0.6.dylib",
            "AppIcon.icns",
            "prepare_lockra1n.sh",
            "generate_activation_files.sh",
            "bypass.sh",
            "work"
        ]
        
        let descriptions = [
            "First file found...",
            "Second file found...",
            "Third file found...",
            "Fourth file found...",
            "Fifth file found...",
            "Sixth file found...",
            "Seventh file found...",
            "Eighth file found...",
            "Ninth file found...",
            "Tenth file found..."
        ]
        
        let errorDescriptions = [
            "An error occurred.\n\nOne or more of the required scripts/executables may be missing or damaged.",
            "An error occurred.\n\nOne or more of the required scripts/executables may be missing or damaged.",
            "An error occurred.\n\nOne or more of the required scripts/executables may be missing or damaged.",
            "An error occurred.\n\nOne or more of the required folders may be missing or damaged.",
            "An error occurred.\n\nOne or more of the required scripts/executables may be missing or damaged.",
            "An error occurred.\n\nThe AppIcon may be missing or inaccessible.",
            "An error occurred.\n\nOne or more of the required scripts may be missing or damaged.",
            "An error occurred.\n\nThe script to generate your activation tickets may be missing or damaged.",
            "An error occurred.\n\nThe bypass script may be missing or damaged.",
            "An error occurred.\n\nOne or more of the required folders may be missing or damaged."
        ]
        
        for (index, path) in paths.enumerated() {
            let fullPath = "\(resourcesPath)/\(path)"
            if !FileManager.default.fileExists(atPath: fullPath) {
                print("The file does not exist...")
                showAlertAsync(message: "Error", informativeText: errorDescriptions[index]) {
                    exit(1)
                }
                completion(false)
                return
            } else {
                print(descriptions[index])
            }
        }
        completion(true)
    }

    func showAlertAsync(message: String, informativeText: String, completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            let alert = NSAlert()
            alert.messageText = message
            alert.informativeText = informativeText
            alert.alertStyle = .warning
            alert.addButton(withTitle: "OK")
            if let window = NSApplication.shared.windows.first {
                alert.beginSheetModal(for: window) { _ in
                    completion()
                }
            } else {
                alert.runModal()
                completion()
            }
        }
    }

    func showDisclaimer() {
        // Make an Alert pop-up
        DispatchQueue.main.async {
            let alert = NSAlert()
            alert.messageText = "Welcome to Lockra1n!\nThis is a free untethered iCloud bypass tool for iOS 13.0 to 16.7.8.\n\nPlease read the disclaimer:"
            alert.informativeText = "Before you proceed further, I would like to emphasize and clarify the ethical principles surrounding the software you are about to utilize. This disclaimer is intended to ensure a responsible usage of the software developed. The software you are accessing is a product that can be used to bypass the iCloud lock on Apple devices, and is designed with the primary purpose of unlocking. It is crucial to understand that the developer behind this software disapproves of any form of stealing, illegal activities, or misuse of the software. By using this software, you agree not to engage in any unauthorized or unlawful activities, including the following: \n\n* Theft or unauthorized use of this software or it’s UI which was purely designed by me\n* Utilizing the software to participate in any illegal activities such as unlocking a stolen device.\n\nAs the developer of this software, I assume no liability for any improper or illegal use of the software by any third parties. I cannot be held responsible for any actions taken by users that violate the terms and conditions outlined in this disclaimer.\n\nBy continuing to use this software, you acknowledge and agree to abide by these guidelines, and you commit to using the software responsibly and legally. Thank you for your attention to this matter and for being a responsible user. Please remember that if this software bricks your device, I am 100% NOT RESPONSIBLE!\nBy agreeing to the disclaimer, you are agreeing that it won’t matter if your device gets stuck in a boot loop or gets bricked in any way, and you will not blame the software for breaking your device.\n\nThank you."
            alert.addButton(withTitle: "Agree")
            alert.addButton(withTitle: "Disagree")
            
            let response = alert.runModal()
            // If the Agree button was pressed, continue
            if response == .alertFirstButtonReturn {
                guard let resourcesPath = Bundle.main.resourcePath else {
                    print("Failed to find the main bundle's resource path")
                    return
                }
            }
            
            if response == .alertSecondButtonReturn {
                print("User didn't agree with disclaimer. Exiting the app...")
                exit(1)
            }
        }
    }
    
    @discardableResult
    func runTerminalCommand(_ command: String) -> String {
        print(command)  // Debugging

        let task = Process()
        let outPipe = Pipe()
        let errPipe = Pipe()

        task.standardOutput = outPipe
        task.standardError = errPipe
        task.arguments = ["-c", command]
        task.launchPath = "/bin/zsh"

        task.launch()
        task.waitUntilExit()

        if task.terminationStatus != 0 {
            print("Command failed with status: \(task.terminationStatus)")
        }

        let outData = outPipe.fileHandleForReading.readDataToEndOfFile()
        let errData = errPipe.fileHandleForReading.readDataToEndOfFile()

        let output = String(data: outData, encoding: .utf8) ?? ""
        let errorOutput = String(data: errData, encoding: .utf8) ?? ""

        if !output.isEmpty {
            return output
        } else if !errorOutput.isEmpty {
            return errorOutput
        } else {
            return "Command executed, but no output captured."
        }
    }
    
    func showAlert(message: String, informativeText: String) {
        let alert = NSAlert()
        alert.messageText = message
        alert.informativeText = informativeText
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    func showUpdateAlert(message: String, informativeText: String, updateURLString: String) {
        let alert = NSAlert()
        alert.messageText = message
        alert.informativeText = informativeText
        alert.addButton(withTitle: "Download Update")
        alert.addButton(withTitle: "No Thanks")
        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            if let url = URL(string: updateURLString) {
                NSWorkspace.shared.open(url)
            } else {
                print("Could not create URL.")
            }
        } else if response == .alertSecondButtonReturn {
            return
        }
    }

    func showCriticalAlert(message: String, informativeText: String) {
        let alert = NSAlert()
        alert.messageText = message
        alert.informativeText = informativeText
        alert.addButton(withTitle: "Done")
        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            exit(1)
        }
    }
    
    func scheduleLocalNotification(NotificationTitle: String, NotificationMessage: String) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = NotificationTitle
        //notificationContent.subtitle = NotificationSubtitle
        notificationContent.body = NotificationMessage
        notificationContent.sound = UNNotificationSound.default

        // Configure the trigger for a 5 seconds delay.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)

        // Create the request.
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)

        // Schedule the request with the system.
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                // Handle any errors.
                print("Error scheduling local notification: \(String(describing: error))")
            }
        }
    }
    
    enum DeviceState {
        case initial
        case recovery
        case dfu
        case foundA7Device
        case foundOtherDevice  // Renaming from foundA8Device for clarity
        case noDevice
    }

    var currentState = DeviceState.initial
    
    private func printAppDirectory() {
        let appDirectory = Bundle.main.bundlePath
        print("App is stored in: \(appDirectory)/Contents")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.printAppDirectory()
        
        self.creditsMainText.isHidden = true
        self.creditsText1.isHidden = true
        self.nathanDevText.isHidden = true
        self.mrcreatorDevText1.isHidden = true
        self.mrcreatorDevText2.isHidden = true
        self.libimobiledeviceText.isHidden = true
        self.creditsText2.isHidden = true
        self.doneCreditsButton.isHidden = true
        self.notifyButton.isHidden = true
        // Do any additional setup after loading the view.
        
        self.genActRef.isEnabled = false
        self.bypassDeviceRef.isEnabled = false
        self.bypassDeviceNormalMode.isEnabled = false
        self.relockDeviceRef.isEnabled = false
        self.relockDeviceNormalModeRef.isEnabled = false
        
        self.sendVersionToServer()
        
        self.checkDependencies { success in
            if success {
                self.showDisclaimer()
            }
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
}


