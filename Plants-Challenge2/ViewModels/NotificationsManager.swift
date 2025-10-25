//
//  NotificationsManager.swift
//  Plants-Challenge2
//
//  Created by Abeer Jeilani Osman  on 02/05/1447 AH.
//

import Foundation
import UserNotifications

final class NotificationsManager: NSObject {

    static let shared = NotificationsManager()
    private override init() { super.init() }
    private let center = UNUserNotificationCenter.current()

    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async { completion(granted) }
        }
    }

    
    func setDelegate(_ delegate: UNUserNotificationCenterDelegate) {
        center.delegate = delegate
    }

    func scheduleReminderNotification(reminder: PlantReminderList, date: Date) {
        guard let id = reminder.id.uuidString as String? else { return }
        
        cancelNotification(identifier: id)

        let content = UNMutableNotificationContent()
        content.title = "\(reminder.name) needs water 💧"
        content.body = "Time to water your \(reminder.name) in the \(reminder.room)."
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        center.add(request) { error in
            if let e = error { print("Schedule error:", e.localizedDescription) }
        }
    }

    func scheduleNoRemindersDaily(hour: Int = 7, minute: Int = 0) {
        let id = "no_reminders_daily"
        cancelNotification(identifier: id)

        let content = UNMutableNotificationContent()
        content.title = "Add your plants 🌱"
        content.body = "You don't have any reminders yet — add a plant reminder so we can help you care for them."
        content.sound = .default

        var comps = DateComponents()
        comps.hour = hour
        comps.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)

        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        center.add(request) { error in if let e = error { print(e.localizedDescription) } }
    }

    func cancelNotification(identifier: String) {
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
    }

    func cancelAllReminderNotifications() {
        center.removeAllPendingNotificationRequests()
    }

   
    func syncNotifications(with reminders: [PlantReminderList]) {
        
        center.removeAllPendingNotificationRequests()

        if reminders.isEmpty {
            scheduleNoRemindersDaily()
            return
        }

        // For each reminder, schedule if it has nextDue
        for r in reminders {
            if let next = r.nextDate {
                scheduleReminderNotification(reminder: r, date: next)
            } else {
                // compute a reasonable nextDue if missing - schedule in X days at 9 AM
                let next = RemindersDateHelper.nextDueDate(for: r, from: Date())
                scheduleReminderNotification(reminder: r, date: next)
            }
        }
    }
}

