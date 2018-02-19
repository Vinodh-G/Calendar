//
//  CalendarDayCellViewModel_Tests.swift
//  CalendarTests
//
//  Created by Vinodh Govind Swamy on 2/19/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import XCTest
@testable import Calendar

class CalendarDayCellViewModel_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCalendarDayCellViewModelDate() {
        
        // create date 26th Jan
        var components =  DateComponents()
        components.month = 1
        components.day = 26
        components.year = 2018
        let date = Calendar.current.date(from: components)!
        
        let dayViewModel = CalendarDayCellViewModel(inDate: date)
        XCTAssertEqual(dayViewModel.date, date)
    }
    
    func testCalendarDayCellViewModelDayString() {
        
        // create date 26th Jan
        var components =  DateComponents()
        components.month = 1
        components.day = 26
        components.year = 2018
        let date = Calendar.current.date(from: components)!
        
        let dayViewModel = CalendarDayCellViewModel(inDate: date)
        XCTAssertEqual(dayViewModel.dayString, "26")
    }
    
    func testCalendarDayCellViewModelDayStringFeb29() {
        
        var components =  DateComponents()
        components.month = 2
        components.day = 29
        components.year = 1988
        let date = Calendar.current.date(from: components)!
        
        let dayViewModel = CalendarDayCellViewModel(inDate: date)
        XCTAssertEqual(dayViewModel.dayString, "29")
    }
}
