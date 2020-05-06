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
            callback(state)
        }
    }
    
    public init(callback: @escaping (State) -> Void) {
        self.callback = callback
    }
    
    public func hi()->String {
        return "hi"
    }
    
}

func allItems()->[Item] {
    let allItems:[Item] = [
        Item(title:"🥤", date:Date()),
        Item(title:"🥪", date:Date())]
    return allItems
}
