//
//  CalendarViewModel_Tests.swift
//  CalendarTests
//
//  Created by Vinodh Govind Swamy on 2/19/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import XCTest
@testable import Calendar

class CalendarViewModel_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCalendarViewModelMonthsSectionsCount(){
        let calendarViewModel: CalendarViewModel = CalendarViewModel()
        let date = Date()
        let startDate = date.dateByAdding(months: -12)
        let endDate = date.dateByAdding(months: 12)
        calendarViewModel.createMonths(for: startDate, and: endDate)
        
        XCTAssertEqual(calendarViewModel.months.count, 24, "calendarViewModel should have 24 calendarMonthViewModel instances")
    }
    
    func testCalendarViewModelStartDate(){
        let calendarViewModel: CalendarViewModel = CalendarViewModel()
        let date = Date()
        let startDate = date.dateByAdding(months: 1)
        let endDate = date.dateByAdding(months: 2)
        calendarViewModel.createMonths(for: startDate, and: endDate)
        
        XCTAssertEqual(calendarViewModel.startDate, startDate)
    }
    
    func testCalendarViewModelEndDate(){
        let calendarViewModel: CalendarViewModel = CalendarViewModel()
        let date = Date()
        let startDate = date.dateByAdding(months: 1)
        let endDate = date.dateByAdding(months: 2)
        calendarViewModel.createMonths(for: startDate, and: endDate)
        XCTAssertEqual(calendarViewModel.endDate, endDate)
    }
    
    func testCalendarViewModelEndadateLessThanStartDate(){
        let calendarViewModel: CalendarViewModel = CalendarViewModel()
        let date = Date()
        let startDate = date.dateByAdding(months: 1)
        let endDate = date.dateByAdding(months: -1)
        calendarViewModel.createMonths(for: startDate, and: endDate)
        XCTAssertEqual(calendarViewModel.months.count, 0, "calendarViewModel should have 0 calendarMonthViewModel instances since the end date is less then start date")
    }
    
    func testCalendarViewModelMonthsSectionsCountSameStartAndEndDate(){
        let calendarViewModel: CalendarViewModel = CalendarViewModel()
        let date = Date()
        calendarViewModel.createMonths(for: date, and: date)
        XCTAssertEqual(calendarViewModel.months.count, 0, "calendarViewModel should have 0 calendarMonthViewModel instances since start and end date is same")
    }
}
