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
    public var presets:[Preset]!
    
    public var debugDescription:String {
        return "[State] Items \(items.count)"
    }   
    
    func itemsToday()->Int {
        let itemsToday = items.filter { (item:Item) -> Bool in
            return item.createDate.isToday
        }.count
        return itemsToday
    }
    
    public func itemsAsSections()->[[Item]] {
        var sections = [[Item]]()
        
        let itemsToday = items.filter { (item:Item) -> Bool in
            return item.createDate.isToday
        }
        if itemsToday.count > 0 {
            sections.append(itemsToday)
        }
        
        let itemsNotToday = items.filter { (item:Item) -> Bool in
            return !item.createDate.isToday
        }
        if itemsNotToday.count > 0 {
            sections.append(itemsNotToday)
        }
        
        return sections
    }
    
    public func count(title:String)->Int {
        let countedItem = items.filter { (item:Item) -> Bool in
            let isMatchingCategory = item.title == title
            return isMatchingCategory && item.createDate.isToday
        }.count
        return countedItem
    }

    public func countLabel(title:String)->String {
        let counted = count(title: title)
        return counted == 0 ? "" : "\(counted)"
    }
    
    public func countLabelisHidden(title:String)->Bool {
        return count(title: title) > 0 ? false : true
    }
    
}
