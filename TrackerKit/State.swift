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
        return countedItem == 0 ? "" : "\(countedItem)"
    }
    
        public func itemSections()->[[Item]] {
            var sections:[[Item]] = []            

            let itemsSortedByDate = items.sorted { (itemA, itemB) -> Bool in
                return itemA.createDate.compare(itemB.createDate) == .orderedDescending
            }
            
            let itemsToday = itemsSortedByDate.filter { Calendar.current.isDateInToday($0.createDate) }
            if itemsToday.count > 0 {
                sections.append(itemsToday)
            }
            
            let itemsYesterday = itemsSortedByDate.filter { Calendar.current.isDateInYesterday($0.createDate) }
            if itemsYesterday.count > 0 {
                sections.append(itemsYesterday)
            }
            
            let earlierItems = itemsSortedByDate.filter { !Calendar.current.isDateInYesterday($0.createDate) && !Calendar.current.isDateInToday($0.createDate) }
            if earlierItems.count > 0 {
                sections.append(earlierItems)
            }
            
            //sections.append(itemsSortedByDate)
            
            return sections
        }
    
}
