import Foundation

public enum ItemCategory:Int, Codable, CustomStringConvertible {
    
    case drink
    case sweets
    case meal
    
    public var description: String {
        switch self {
        case .drink: return "🥤"
        case .sweets: return "🍭"
        case .meal: return "🥪"
        }
    }
}

struct Item:Codable, Identifiable, Hashable {
    let itemCategory:ItemCategory
    var createDate:Date
    let id:UUID = UUID()
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    public static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Date {
    func daysFromNow(days:Int)->Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
}

let allItems:[Item] = [
    Item(date:Calendar.current.date(byAdding: -1, value: days, to: Date())!),
    Item(date:Calendar.current.date(byAdding: -3, value: days, to: Date())!)
]


let allItems:[Item] = [
    Item(itemCategory:.sweets, date:Date().daysFromNow(days: -3)),
    Item(itemCategory:.meal, date:Date().daysFromNow(days: -1)),
    Item(itemCategory:.sweets, date:Date().daysFromNow(days: -4)),
    Item(itemCategory:.meal, date:Date().daysFromNow(days: -1)),
    Item(itemCategory:.drink, date:Date()),
    Item(itemCategory:.sweets, date:Date().daysFromNow(days: -5)),]

let itemsToday = allItems.filter { Calendar.current.isDateInToday($0.createDate) }
itemsToday
let itemsYesterday = allItems.filter { $0.createDate > $0.createDate.daysFromNow(days: -1) }
itemsYesterday
//let itemsYesterday = itemsSortedByDate.filter { $0.createDate < $0.createDate.daysFromNow(days: -1) }
//let earlierItems = itemsSortedByDate.filter { $0.createDate < $0.createDate.daysFromNow(days: -2) }
