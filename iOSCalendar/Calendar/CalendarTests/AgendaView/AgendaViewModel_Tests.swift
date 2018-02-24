//
//  AgendaViewModel_Tests.swift
//  CalendarTests
//
//  Created by Vinodh Govind Swamy on 2/19/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import XCTest
@testable import Calendar

class AgendaViewModel_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateDaysForRange23Months() {
        let agendaModel = AgendaViewModel()
        
        // Creates a date range from 23 months from feb -17 to Dec - 18
        let dateRange = DateRange(start: dateFeb142018().dateByAdding(months: -12),
                                  months: 23,
                                  years: 0)
        let days = agendaModel.createDaysFor(dateRange:dateRange)
        XCTAssertEqual(days.count, 699)
    }
    
    func testCreateDaysForRange48Months() {
        let agendaModel = AgendaViewModel()
        
        // Creates a date range from 23 months from feb -17 to Dec - 18
        let dateRange = DateRange(start: dateJan262020().dateByAdding(months: 0),
                                  months: 48,
                                  years: 0)
        let days = agendaModel.createDaysFor(dateRange:dateRange)
        XCTAssertEqual(days.count, 1461)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func dateJan262020() -> Date {
        var date = Date()
        // create date 26th Jan
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 1
        components.day = 26
        components.year = 2020
        date = Calendar.current.date(from: components)!
        return date
    }
    
    func dateFeb142018() -> Date {
        var date = Date()
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 2
        components.day = 14
        components.year = 2018
        date = Calendar.current.date(from: components)!
        return date
    }
}
