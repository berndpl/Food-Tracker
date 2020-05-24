//
//  TrackerKitTests.swift
//  TrackerKitTests
//
//  Created by Bernd Plontsch on 11.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import XCTest
import TrackerKit

class TrackerKitTests: XCTestCase {

    var viewModel:ViewModel! = ViewModel { (_) in
        // print("Callback called")
    }
    
    override func setUp() {
        super.setUp()
        //let state:State =
//        let viewModel:ViewModel = ViewModel { (_) in
//            // print("Callback called")
//        }
        //viewModel.state = state
    }

    func testItemsInitial() throws {
        XCTAssertEqual(viewModel.state.items.count, 0)
        XCTAssertEqual(viewModel.numberOfSections(), 0)
    }

    func drinkPreset()->Preset {
        return viewModel.state.presets[0] as Preset
    }

    func mealPreset()->Preset {
        return viewModel.state.presets[1] as Preset
    }

    func sweetsPreset()->Preset {
        return viewModel.state.presets[2] as Preset
    }
    
    func testItemsAdded() throws {
        
        viewModel.didTap(preset: drinkPreset())
        XCTAssertEqual(viewModel.state.items.count, 1)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        viewModel.didTap(preset: mealPreset())
        viewModel.didTap(preset: sweetsPreset())
        XCTAssertEqual(viewModel.state.items.count, 3)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
    }

    func testItemsAddedOverTime() throws {
        // ADD
        let today = Date()
        let yesterday = Date().yesterday()
        let twoWeeksAgo = Date().daysFromNow(days: -14)
        print("today \(today)")
        print("yesterday \(yesterday)")
        print("twoWeeksAgao \(twoWeeksAgo)")
        viewModel.didTap(preset: mealPreset(), date: today)
        XCTAssertEqual(viewModel.state.items.count, 1)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        viewModel.didTap(preset: drinkPreset(), date: yesterday)
        viewModel.didTap(preset: drinkPreset(), date: twoWeeksAgo)
        viewModel.didTap(preset: drinkPreset(), date: twoWeeksAgo)
        XCTAssertEqual(viewModel.state.items.count, 4)
        XCTAssertEqual(viewModel.numberOfSections(), 2)
        //print("items as sections \(viewModel.state.itemsAsSections())")
        
        // DELETE
        let lastItem = viewModel.state.items.last!
        let firstItem = viewModel.state.items.first!
        print("Delete LAST \(lastItem)")
        viewModel.didTapDelete(item: lastItem)
        XCTAssertEqual(viewModel.state.items.count, 3)
        XCTAssertEqual(viewModel.numberOfSections(), 2)
        print("- After Delete Sections \(viewModel.state.itemsAsSections())")
        print("Delete FIRST \(firstItem)")
        viewModel.didTapDelete(item: firstItem)
        XCTAssertEqual(viewModel.state.items.count, 2)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        print("- After Delete Sections \(viewModel.state.itemsAsSections())")
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension Date {

    var isToday:Bool {
        return Calendar.current.isDateInToday(self)
    }
    var isYesterday:Bool {
        return Calendar.current.isDateInYesterday(self)
    }

    func daysFromNow(days:Int)->Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func yesterday()->Date {
        return daysFromNow(days: -1)
    }

}
