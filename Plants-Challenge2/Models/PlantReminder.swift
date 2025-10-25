//
//  SetReminderModel.swift
//  Plants-Challenge2
//
//  Created by Abeer Jeilani Osman  on 30/04/1447 AH.
//

import Foundation

enum Rooms: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    case Bedroom
    case LivingRoom
    case Kitchen
    case Balcony
    case Bathroom
}

enum Lights: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    case FullSun
    case PartialSun
    case LowLight
}

enum WateringDays: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    case everyDay = "Every day"
    case every2Days = "Every 2 days"
    case every3Days = "Every 3 days"
    case OnceAWeek = "Once a week"
    case every10Days = "Every 10 days"
    case every2Weeks = "Every 2 weeks"
}

enum WaterAmount: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    case verysmall = "20-50 ml"
    case small = "50-100 ml"
    case medium = "100-200 ml"
    case large = "200-300 ml"
}

struct PlantReminderList: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var room: String
    var light: String
    var wateringDays: WateringDays
    var water: WaterAmount
    var ischecked: Bool = false
    var nextDate: Date? = nil
}
