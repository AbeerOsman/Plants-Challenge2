//
//  EditReminderViewModel.swift
//  Plants-Challenge2
//
//  Created by Abeer Jeilani Osman  on 30/04/1447 AH.
//

import SwiftUI
import Combine

@MainActor
class EditReminderViewModel: ObservableObject {
    
    // Local UI state for Pickers
    @Published var plantName: String = ""
    @Published var roomSelection: Rooms = .Bedroom
    @Published var lightSelection: Lights = .FullSun
    @Published var wateringDaysSelection: WateringDays = .everyDay
    @Published var waterSelection: WaterAmount = .large
    
    @Binding var reminder: PlantReminderList
    @Binding var reminders: [PlantReminderList]
    @Published var showingAlert = false

    init(reminder: Binding<PlantReminderList>, reminders: Binding<[PlantReminderList]>) {
        self._reminder = reminder
        self._reminders = reminders
    }

    func saveChanges() {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index] = reminder
        }
    }

    func deleteReminder() {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders.remove(at: index)
        }
    }
    
    func loadReminderData(
        plantName: Binding<String>,
        room: Binding<Rooms>,
        light: Binding<Lights>,
        days: Binding<WateringDays>,
        water: Binding<WaterAmount>
    ) {
        plantName.wrappedValue = reminder.name
        room.wrappedValue = Rooms(rawValue: reminder.room) ?? .Bedroom
        light.wrappedValue = Lights(rawValue: reminder.light) ?? .FullSun
        days.wrappedValue = reminder.wateringDays
        water.wrappedValue = reminder.water
    }

    func saveEdits(
        plantName: String,
        room: Rooms,
        light: Lights,
        days: WateringDays,
        water: WaterAmount
    ) {
        reminder.name = plantName
        reminder.room = room.rawValue
        reminder.light = light.rawValue
        reminder.wateringDays = days
        reminder.water = water
        saveChanges()
    }



}
