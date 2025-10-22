//
//  PlantsViewModel.swift
//  Plants-Challenge2
//
//  Created by Abeer Jeilani Osman  on 30/04/1447 AH.
//

import SwiftUI
import Combine


@MainActor
class PlantsViewModel: ObservableObject {

    @Published var reminders: [PlantReminderList] = []
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

    func addReminder(_ reminder: PlantReminderList) {
        reminders.append(reminder)
    }

    func removeReminder(at offsets: IndexSet) {
        reminders.remove(atOffsets: offsets)
    }

    func clearReminders() {
        reminders.removeAll()
    }
}
