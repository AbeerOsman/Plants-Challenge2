//
//  TodayReminderViewModel.swift
//  Plants-Challenge2
//
//  Created by Abeer Jeilani Osman  on 30/04/1447 AH.
//

import SwiftUI
import Combine

@MainActor
class TodayReminderViewModel: ObservableObject {
    
    @Published var reminders: [PlantReminderList] = []
    @Published var editingIndex: Int? = nil

    var countOfCheck: Double {
        Double(reminders.filter { $0.ischecked }.count)
    }

    var countReminders: Double {
        Double(reminders.count)
    }

    var allDone: Bool {
        countOfCheck == countReminders && !reminders.isEmpty
    }

    func toggleCheck(for reminder: PlantReminderList) {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index].ischecked.toggle()
        }
    }

    func deleteReminder(at index: Int) {
        guard reminders.indices.contains(index) else { return }
        reminders.remove(at: index)
    }

    func deleteReminder(at offsets: IndexSet) {
        reminders.remove(atOffsets: offsets)
    }

    func startEditing(at index: Int) {
        editingIndex = index
    }

    func stopEditing() {
        editingIndex = nil
    }

    func reminderBinding(for index: Int) -> Binding<PlantReminderList>? {
        guard reminders.indices.contains(index) else { return nil }
        return Binding(
            get: { self.reminders[index] },
            set: { self.reminders[index] = $0 }
        )
    }

    func showEditBinding() -> Binding<Bool> {
        Binding(
            get: { self.editingIndex != nil },
            set: { newValue in
                if !newValue { self.editingIndex = nil }
            }
        )
    }
}
