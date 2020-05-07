//
//  State.swift
//  Tracker Kit
//
//  Created by Bernd Plontsch on 06.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import Foundation

public struct State:Codable, CustomDebugStringConvertible {
    public var items:[Item]!
    
    public var debugDescription:String {
        return "[State] Items \(items.count)"
    }
    
    public func countLabel(itemCategory:ItemCategory)->String {
        let countedItem = items.filter { (item:Item) -> Bool in
            return item.itemCategory == itemCategory
        }.count
        return ("\(countedItem)")
    }
    
}
