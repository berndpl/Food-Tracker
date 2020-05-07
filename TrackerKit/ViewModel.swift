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
            callback(state)
        }
    }
    
    public init(callback: @escaping (State) -> Void) {
        self.callback = callback
    }
    
    public func didDismissEntry() {
        //shouldRestore()
    }
    
    public func didTap(itemCategory:ItemCategory) {
        let newItem = Item(itemCategory: itemCategory, date: Date())
        print("Add \(newItem)")
        state.items.append(newItem)
        Storage.save(state: state)
        shouldRestore()
    }
    
    public func didTapDeleteAll() {
        let emptyState = State(items: [])
        Storage.save(state: emptyState)
        shouldRestore()
    }
    
    public func shouldRestore() {
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
