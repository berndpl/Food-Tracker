//
//  Item.swift
//  Tracker Kit
//
//  Created by Bernd Plontsch on 06.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import Foundation

public struct Item:Codable, CustomDebugStringConvertible {
    public let title:String
    public var createDate:Date
    
    init(title: String,
        date: Date) {
        self.title = title
        self.createDate = date
    }
    
    public var debugDescription: String {
        return "\(createDate) \(title)"
    }
}
