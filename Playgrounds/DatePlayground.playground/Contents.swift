import UIKit

func upcomingLunchDate()->Date {
    let date = Date()
    let calendar = Calendar.current
    let tomorrow = calendar.date(byAdding: .day, value: 1, to: date)!
    let tomorrowLunchTime:Date = calendar.date(bySetting: .hour, value: 12, of: tomorrow)!
    return tomorrowLunchTime
}

let date = upcomingLunchDate()

let now = Date()

let dateNow = Date()
let isDateNow = Calendar.current.isDateInToday(dateNow)
let isDateYesterday:Bool = (dateNow > dateNow.daysFromNow(days: -1))
let isDateEarlier:Bool = (dateNow > dateNow.daysFromNow(days: -2))

let dateYesterday = Date().daysFromNow(days: -1)
let isDateYesterdayToday = Calendar.current.isDateInToday(dateYesterday)
let isDateYesterdayYesterday:Bool = (dateYesterday > dateYesterday.daysFromNow(days: -1)) && dateYesterday < dateYesterday.daysFromNow(days: 1)
let isDateYesterdayEarlier:Bool = (dateYesterday > dateYesterday.daysFromNow(days: -2) && dateYesterday < dateYesterday.daysFromNow(days: 0))

let dateEarlier = Date().daysFromNow(days: -5)
let isDateEarlierToday = Calendar.current.isDateInToday(dateEarlier)
let isDateEarlierYesterday:Bool = (dateEarlier > dateEarlier.daysFromNow(days: -1) && dateEarlier < dateEarlier.daysFromNow(days: 0))
let isDateEarlierEarlier:Bool = (dateEarlier > dateEarlier.daysFromNow(days: -2))

let isNow = Calendar.current.isDateInToday(now)

let yesterday = now.daysFromNow(days: -1)
let isYesterday = Calendar.current.isDateInToday(yesterday)
let isThisYesterday:Bool = (yesterday > yesterday.daysFromNow(days: -1))


extension Date {

    var isToday:Bool {
        return Calendar.current.isDateInToday(self)
    }
    var isYesterday:Bool {
        return Calendar.current.isDateInYesterday(self)
    }

    func daysFromNow(days:Int)->Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func yesterday()->Date {
        return daysFromNow(days: -1)
    }

}
