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
    
    public var state: State = State(items: [], presets: defaultPresets())
    
    public init(callback: @escaping (State) -> Void) {
        self.callback = callback
    }
    
    public func didTap(preset:Preset, shouldUpdate:Bool=true, date:Date=Date()) {
        addItem(preset: preset)
        Storage.save(state: state)
        //shouldReload()
        if shouldUpdate {
            callback(state)
        }
    }
    
    func addItem(preset: Preset) {
        print("ADD")
        let newItem = Item(title: preset.title, calories: preset.calories, colorLiteral: preset.colorLiteral, date: Date())
        print("Before \(state.items.count)")
        state.items.insert(newItem, at: 0)
        print("After \(state.items.count)")
    }
    
    public func didTapDelete(item:Item) {
        print("DELETE BEFORE \(state.items.count)")
        state.items.removeAll(where: {$0.id == item.id})
        
        print("DELETE AFTER \(state.items.count)")
        Storage.save(state: state)
        callback(state)
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
        var newState = state.items
        for (index, _) in newState!.enumerated() {
            if newState?[index].id == selectedItem.id {
                newState?[index].createDate = date
            }
        }
        state.items = newState
        Storage.save(state: state)
        callback(state)
    }
    
    func addHealthSampleUUID(healthSampleIdentifier:UUID, itemToUpdate:Item) {
        var newState = state.items
        for (index, _) in newState!.enumerated() {
            if newState?[index].id == itemToUpdate.id {
                newState?[index].healthSampleIdentifier = healthSampleIdentifier
            }
        }
        state.items = newState
        Storage.save(state: state)
    }
    
    public func selectedItem(section:Int, item:Int)->Item {
        let item = state.items[item]
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
    
    public func didUpdatePreset(preset:Preset, title:String, calories:Double) {
        var updatedPresets = state.presets
        for (index, _) in state.presets!.enumerated() {
            if updatedPresets?[index].id == preset.id {
                updatedPresets?[index].title = title
                updatedPresets?[index].calories = calories
            }
        }
        state.presets = updatedPresets
        Storage.save(state: state)
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
        let initialState = State(items: [], presets: defaultPresets())
        return initialState
    }
    
}

func allItems()->[Item] {
    let presets = defaultPresets()
    let allItems:[Item] = [
        Item(title: presets[0].title, calories: presets[0].calories, colorLiteral: presets[0].colorLiteral, date: Date()),
        Item(title: presets[1].title, calories: presets[1].calories, colorLiteral: presets[1].colorLiteral, date:Date())]
    return allItems
}

func defaultPresets()->[Preset] {
    let presets:[Preset] = [
        Preset(title: "🍪", calories: 230.0, colorLiteral: "systemPink"),
        Preset(title: "🥪", calories: 560.0, colorLiteral: "systemYellow"),
        Preset(title: "🥤", calories: 140.0, colorLiteral: "systemPurple")
    ]
    return presets
}
