//
//  RemindersDateHelper.swift
//  Plants-Challenge2
//
//  Created by Abeer Jeilani Osman  on 02/05/1447 AH.
//

import Foundation

struct RemindersDateHelper {
    /// Map wateringDays enum to days interval (approx). Tweak to your app logic.
    static func daysInterval(for watering: WateringDays) -> Int {
        switch watering {
        case .everyDay: return 1
        case .every2Days: return 2
        case .every3Days: return 3
        case .OnceAWeek: return 7
        case .every10Days: return 10
        case .every2Weeks: return 14
        }
    }

    static func nextDueDate(for reminder: PlantReminderList, from: Date = Date(), hour: Int = 7, minute: Int = 0) -> Date {
        let days = daysInterval(for: reminder.wateringDays)
        let base = Calendar.current.startOfDay(for: from)
        let nextDay = Calendar.current.date(byAdding: .day, value: days, to: base) ?? from
        var comps = Calendar.current.dateComponents([.year, .month, .day], from: nextDay)
        comps.hour = hour
        comps.minute = minute
        return Calendar.current.date(from: comps) ?? Date().addingTimeInterval(TimeInterval(days * 24 * 60 * 60))
    }
}

