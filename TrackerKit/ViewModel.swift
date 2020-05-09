//
//  ViewModel.swift
//  Tracker Kit
//
//  Created by Bernd Plontsch on 06.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import Foundation

public class ViewModel:NSObject {
    var callback: ((State) -> Void)
    
    public var state: State = State(items: allItems()) {
        didSet {
            print("Callback!")
            //callback(state)
        }
    }
    
    public init(callback: @escaping (State) -> Void) {
        self.callback = callback
    }
    
    public func didTap(itemCategory:ItemCategory, shouldUpdate:Bool=false) {
        let newItem = Item(itemCategory: itemCategory, date: Date())
        print("Add \(newItem)")
        state.items.append(newItem)
        Storage.save(state: state)
        shouldReload()
        if shouldUpdate {
            callback(state)
        }
    }
    
    public func didTapDeleteItem(section:Int, item:Int) {
        let itemToRemove = selectedItem(section:section, item:item)
        print("Delete Item \(itemToRemove)")
        print("BEFORE \(state.items.count)")
        state.items.removeAll(where: {$0.id == itemToRemove.id})
        print("AFTER \(state.items.count)")
        Storage.save(state: state)
    }
    
    public func didChangeDate(selectedItem:Item, date:Date) {
        print("Change \(selectedItem) Date \(date)")
        //state.items.filter{ $0.id == selectedItem.id }.first?.createDate = date
    }
    
    
    public func selectedItem(section:Int, item:Int)->Item {
        let item = state.itemSections()[section][item]
        return item
    }
    
    public func didTapDeleteAll() {
        let emptyState = State(items: [])
        Storage.save(state: emptyState)
        shouldReload()
        callback(state)
    }
    
    public func todayWidgetDidLoad() {
        shouldReload()
        callback(state)
    }
    
    public func shouldReload() {
           if let savedState = Storage.load() {
               state = savedState
               print("Loaded State \(state)")
           } else {
               state = initialState()
               print("Initial State \(state)")
           }
    }
    
    func initialState()->State {
        let initialState = State(items: [])
        return initialState
    }
    
}

func allItems()->[Item] {
    let allItems:[Item] = [
        Item(itemCategory:.drink, date:Date()),
        Item(itemCategory:.meal, date:Date())]
    return allItems
}
