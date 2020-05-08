import UIKit

func upcomingLunchDate()->Date {
    let date = Date()
    let calendar = Calendar.current
    let tomorrow = calendar.date(byAdding: .day, value: 1, to: date)!
    let tomorrowLunchTime:Date = calendar.date(bySetting: .hour, value: 12, of: tomorrow)!
    return tomorrowLunchTime
}

let date = upcomingLunchDate()
