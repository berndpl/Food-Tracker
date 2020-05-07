//
//  Item.swift
//  Tracker Kit
//
//  Created by Bernd Plontsch on 06.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import Foundation

public enum ItemCategory:Int, Codable, CustomStringConvertible, Hashable {
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

public struct Item:Codable, CustomDebugStringConvertible {
    public let itemCategory:ItemCategory
    public let createDate:Date
    public let id:UUID
    
    init(itemCategory: ItemCategory,
        date: Date) {
        self.itemCategory = itemCategory
        self.createDate = date
        self.id = UUID()
    }
    
    public var debugDescription: String {
        return "\(createDate) \(itemCategory)"
    }
}
