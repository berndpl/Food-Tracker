//
//  Item.swift
//  Tracker Kit
//
//  Created by Bernd Plontsch on 06.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import Foundation

public enum ItemCategory:Int, Codable, CustomStringConvertible {
    
    case drink
    case sweets
    case meal
    
    public var description: String {
        switch self {
        case .drink: return "🥤"
        case .sweets: return "🍪"
        case .meal: return "🥪"
        }
    }
}

public struct Item:Codable, CustomDebugStringConvertible, Identifiable, Hashable {
    public let itemCategory:ItemCategory
    public var createDate:Date
    public let id:UUID = UUID()
    public var calories:Double {
        switch itemCategory {
        case .drink:
            return 140.0
        case .sweets:
            return 230.0
        case .meal:
            return 560.0
        }
    }
    public var healthSampleIdentifier:UUID?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    public static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(itemCategory: ItemCategory,
        date: Date) {
        self.itemCategory = itemCategory
        self.createDate = date
    }
    
    public var debugDescription: String {
        return "\(createDate) \(itemCategory)"
    }
}
