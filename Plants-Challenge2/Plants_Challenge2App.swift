//
//  Plants_Challenge2App.swift
//  Plants-Challenge2
//
//  Created by Abeer Jeilani Osman  on 25/04/1447 AH.
//

//import SwiftUI
//
//@main
//struct Plants_Challenge2App: App {
//    var body: some Scene {
//        WindowGroup {
//            PlantsView(countReminders: .constant(0))
//        }
//    }
//}

import SwiftUI
import UserNotifications

@main
struct Plants_Challenge2App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            PlantsView(countReminders: .constant(0))
                .onAppear {
                    NotificationsManager.shared.requestAuthorization { granted in
                        if granted {
                            // optionally set delegate to AppDelegate (below)
                        } else {
                            print("Notifications not granted")
                        }
                    }
                }
        }
    }
}

// Optional: AppDelegate to conform to UNUserNotificationCenterDelegate
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    // Show notification while app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound]) // shows banner while app is active
    }
}

