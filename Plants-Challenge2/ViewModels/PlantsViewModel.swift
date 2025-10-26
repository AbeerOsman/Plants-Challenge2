//
//  PlantsViewModel.swift
//  Plants-Challenge2
//
//  Created by Abeer Jeilani Osman  on 30/04/1447 AH.
//

import SwiftUI
import Combine
import Foundation

@MainActor
class PlantsViewModel: ObservableObject {
    @Published var reminders: [PlantReminderList] = [] {
        didSet { remindersChanged() }
    }
    @Published var showSetReminderSheet: Bool = false
    
    var hasReminders: Bool {
        !reminders.isEmpty
    }

    var countReminders: Double {
        Double(reminders.count)
    }
    
    

    func toggleReminderSheet() {
        showSetReminderSheet.toggle()
    }

    init() {
        // If app launches, sync existing reminders to notifications
        NotificationsManager.shared.requestAuthorization { granted in
            if granted {
                NotificationsManager.shared.syncNotifications(with: self.reminders)
            }
        }
    }

    func addReminder(_ reminder: PlantReminderList) {
        var r = reminder
        // set nextDate using helper
        r.nextDate = RemindersDateHelper.nextDueDate(for: r, from: Date())
        reminders.append(r)
        // schedule notification for that reminder
        NotificationsManager.shared.scheduleReminderNotification(reminder: r, date: r.nextDate!)
    }

    func removeReminder(at index: Int) {
        guard reminders.indices.contains(index) else { return }
        let id = reminders[index].id.uuidString
        reminders.remove(at: index)
        NotificationsManager.shared.cancelNotification(identifier: id)
    }
    
    func clearReminders() {
            reminders.removeAll()
        }

    func remindersChanged() {
        // If empty, schedule daily "no reminders" ping, else cancel it
        if reminders.isEmpty {
            NotificationsManager.shared.scheduleNoRemindersDaily()
        } else {
            // Resync all (remove stale pending and schedule new ones)
            NotificationsManager.shared.syncNotifications(with: reminders)
        }
    }

    // call when user checks a reminder (meaning user completed the watering)
    func userCheckedReminder(id: UUID) {
        guard let idx = reminders.firstIndex(where: { $0.id == id }) else { return }

        // mark checked
        reminders[idx].ischecked.toggle()

        if reminders[idx].ischecked {
            // cancel pending notification for this reminder (they did it early)
            NotificationsManager.shared.cancelNotification(identifier: reminders[idx].id.uuidString)

            // compute next due date and update model + schedule again
            let next = RemindersDateHelper.nextDueDate(for: reminders[idx], from: Date())
            reminders[idx].nextDate = next
            // Use a short delay for UI consistency if needed
            NotificationsManager.shared.scheduleReminderNotification(reminder: reminders[idx], date: next)
        }
    }

    // call to edit/save changes (from EditReminderViewModel)
    func updateReminder(_ reminder: PlantReminderList) {
        if let i = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[i] = reminder
            // reschedule
            if let next = reminder.nextDate {
                NotificationsManager.shared.scheduleReminderNotification(reminder: reminder, date: next)
            } else {
                let next = RemindersDateHelper.nextDueDate(for: reminder)
                reminders[i].nextDate = next
                NotificationsManager.shared.scheduleReminderNotification(reminder: reminders[i], date: next)
            }
        }
    }
}
