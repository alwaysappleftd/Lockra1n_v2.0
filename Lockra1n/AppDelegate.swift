import Cocoa
import UserNotifications

@main
class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Set the notification center delegate to self.
        UNUserNotificationCenter.current().delegate = self

        // Request notification permissions from the user.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    // Ensure we run UI updates on the main thread.
                    print("Notification permission granted.")
                }
            }
        }
    }
    
    // This delegate method is called when a notification is about to be presented.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .badge]) // .banner should make it appear as a sliding notification
    }


    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func helpMenuButtonPressed(_ sender: Any) {
        if let url = URL(string: "https://alwaysappleftd.com/software/Lockra1n.html") {
            NSWorkspace.shared.open(url)
        }
    }
    
    @IBAction func bugReportButtonPressed(_ sender: Any) {
        if let url = URL(string: "mailto:alwaysappleftd@icloud.com?subject=Issue%20with%20Lockra1n") {
            NSWorkspace.shared.open(url)
        } else {
            print("Could not create URL.")
        }
    }
    

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
