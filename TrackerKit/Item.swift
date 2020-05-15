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
    public var title:String
    public var calories:Double
    public var colorLiteral:String
    public var createDate:Date
    public let id:UUID = UUID()
    
    public var caloriesLabel:String {
        return Measurement(value: calories, unit: UnitEnergy.calories).description
    }
    
    public var healthSampleIdentifier:UUID?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    public static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(title:String, calories:Double, colorLiteral:String, date: Date) {
        self.title = title
        self.calories = calories
        self.colorLiteral = colorLiteral
        self.createDate = date
    }
    
    public var debugDescription: String {
        return "\(createDate) \(title) \(calories)"
    }
}
