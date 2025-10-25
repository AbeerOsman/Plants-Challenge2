import SwiftUI
import Combine

@MainActor
class SetReminderViewModel: ObservableObject {

    @Published var plantName: String = ""
    @Published var roomSelection: String = Rooms.Bedroom.rawValue
    @Published var lightSelection: String = Lights.FullSun.rawValue
    @Published var wateringDaysSelection: WateringDays = .everyDay
    @Published var waterSelection: WaterAmount = .verysmall
    @Published var countReminders: Double = 0.0

    // Create reminder
    func createReminder() -> PlantReminderList {
        let newReminder = PlantReminderList(
            name: plantName,
            room: roomSelection,
            light: lightSelection,
            wateringDays: wateringDaysSelection,
            water: waterSelection
        )
        countReminders += 1
        return newReminder
    }

    func resetFields() {
        plantName = ""
        roomSelection = Rooms.Bedroom.rawValue
        lightSelection = Lights.FullSun.rawValue
        wateringDaysSelection = .everyDay
        waterSelection = .verysmall
    }
}
