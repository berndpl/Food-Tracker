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
        let counted = count(itemCategory: itemCategory)
        return counted == 0 ? "" : "\(counted)"
    }
    
    public func count(itemCategory:ItemCategory)->Int {
        let countedItem = items.filter { (item:Item) -> Bool in
            let isMatchingCategory = item.itemCategory == itemCategory
            return isMatchingCategory && item.createDate.isToday
        }.count
        return countedItem
    }
    
    public func countLabelisHidden(itemCategory:ItemCategory)->Bool {
        return count(itemCategory: itemCategory) > 0 ? false : true
    }

    // MARK: - TableView
    
//    public func items()->[[Item]] {
//        var sections:[[Item]] = [[Item]]()
//
//        let itemsSortedByDate = items.sorted { (itemA, itemB) -> Bool in
//            return itemA.createDate.compare(itemB.createDate) == .orderedDescending
//        }
//
//        let itemsToday = itemsSortedByDate.filter { Calendar.current.isDateInToday($0.createDate) }
//        let itemsYesterday = itemsSortedByDate.filter { $0.createDate < $0.createDate.daysFromNow(days: -1) }
//        let earlierItems = itemsSortedByDate.filter { $0.createDate < $0.createDate.daysFromNow(days: -2) }
//
//        sections.append(itemsToday)
//        sections.append(itemsYesterday)
//        sections.append(earlierItems)
//
//        //listItems = ListItems(itemsToday, itemsYesterday, earlierItems)
//
//        //sections.append(itemsSortedByDate)
//
//        return sections
//    }
    
}
