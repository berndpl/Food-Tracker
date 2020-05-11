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
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testItemsInitial() throws {
        XCTAssertEqual(viewModel.state.items.count, 0)
        XCTAssertEqual(viewModel.state.numberOfSections(), 0)
    }

    func testItemsAdded() throws {
        viewModel.didTap(itemCategory: .drink)
        XCTAssertEqual(viewModel.state.items.count, 1)
        XCTAssertEqual(viewModel.state.numberOfSections(), 1)
        viewModel.didTap(itemCategory: .meal)
        viewModel.didTap(itemCategory: .sweets)
        XCTAssertEqual(viewModel.state.items.count, 3)
        XCTAssertEqual(viewModel.state.numberOfSections(), 1)
    }

    func testItemsAddedOverTime() throws {
        let today = Date()
        let yesterday = Date().yesterday()
        let twoWeeksAgo = Date().daysFromNow(days: -14)
        print("today \(today)")
        print("yesterday \(yesterday)")
        print("twoWeeksAgao \(twoWeeksAgo)")
        viewModel.didTap(itemCategory: .drink, date: today)
        XCTAssertEqual(viewModel.state.items.count, 1)
        XCTAssertEqual(viewModel.state.numberOfSections(), 1)
        viewModel.didTap(itemCategory: .drink, date: yesterday)
        viewModel.didTap(itemCategory: .drink, date: twoWeeksAgo)
        viewModel.didTap(itemCategory: .sweets, date: twoWeeksAgo)
        XCTAssertEqual(viewModel.state.items.count, 3)
        XCTAssertEqual(viewModel.state.numberOfSections(), 3)
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
