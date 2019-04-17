import UIKit
import UserNotifications    // MARK: 01. import

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // MARK: 02. request to user
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else { return }

            // MARK: 03. register to APNs
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        return true
    }
}

// MARK: - Callback for Remote Notification
extension AppDelegate {
    // MARK: 04-1. succeeded to register to APNs
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Data -> Token string
        let tokenBytes = deviceToken.map { (byte: UInt8) in String(format: "%02.2hhx", byte) }
        print("Device token: \(tokenBytes.joined())")
    }

    // MARK: failed to register to APNs
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register to APNs: \(error)")
    }
}
