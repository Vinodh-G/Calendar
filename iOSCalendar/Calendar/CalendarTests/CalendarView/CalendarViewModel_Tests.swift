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
    
    func testMonthForDateNotNil() {
        let calendarViewModel: CalendarViewModel = CalendarViewModel()
        let date = Date()
        let startDate = date.dateByAdding(months: -1)
        let endDate = date.dateByAdding(months: 2)
        calendarViewModel.createMonths(for: startDate, and: endDate)
        
        XCTAssertNotNil(calendarViewModel.monthFor(date: date))
    }
    
    func testMonthForDateNil() {
        let calendarViewModel: CalendarViewModel = CalendarViewModel()
        var date = Date()
        let startDate = date.dateByAdding(months: -1)
        let endDate = date.dateByAdding(months: 2)
        calendarViewModel.createMonths(for: startDate, and: endDate)
        date = date.dateByAdding(months: 4)
        XCTAssertNil(calendarViewModel.monthFor(date: date))
    }
    
    func testSetSelectedDateverifySelectedDay() {
        let calendarViewModel: CalendarViewModel = CalendarViewModel()
        let date = Date()
        let startDate = date.dateByAdding(months: -1)
        let endDate = date.dateByAdding(months: 2)
        calendarViewModel.createMonths(for: startDate, and: endDate)
        calendarViewModel.set(selectedDate: date)
        XCTAssertNotNil(calendarViewModel.selectedDay)
    }
    
    func testSetSelectedDateverifySelectedDayDate() {
        let calendarViewModel: CalendarViewModel = CalendarViewModel()
        let date = Date().startDateFor(date: Date())
        let startDate = date.dateByAdding(months: -1)
        let endDate = date.dateByAdding(months: 2)
        calendarViewModel.createMonths(for: startDate, and: endDate)
        calendarViewModel.set(selectedDate: date)
        XCTAssertEqual(calendarViewModel.selectedDay?.date, date)
    }
    
    func testUpdateNewSelectedDayReloadIndexPathsCount() {
        
        let date = dateJan262018()
        // view model with 3 months dec - 17, jan - 18, feb- 18
        let calendarViewModel = calendarViewModel3Months(forDate: date)
        
        let expectation = XCTestExpectation(description: "CalendarViewUpdateCalled")
        
        // Mocked Day
        let newSelectedDate = date.dateByAdding(days: 4)
        let month = calendarViewModel.monthFor(date: newSelectedDate)
        let day = month?.dayFor(date: newSelectedDate)
        calendarViewModel.updateBlock = {(update:CalendarViewUpdate) in
            expectation.fulfill()
            XCTAssertEqual(update.rowsUpdate.count, 2)
        }
        calendarViewModel.update(newSelectedDay: day!)
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testUpdateNewSelectedDayReloadNewDayIndexPathOld() {
        let date = dateJan262018()
        // view model with 3 months dec - 17, jan - 18, feb- 18
        let calendarViewModel = calendarViewModel3Months(forDate: date)
        
        let expectation = XCTestExpectation(description: "CalendarViewUpdateCalled")
        
        // Mocked Day
        let newSelectedDate = date.dateByAdding(days: 4)
        let month = calendarViewModel.monthFor(date: newSelectedDate)
        let day = month?.dayFor(date: newSelectedDate)
        calendarViewModel.updateBlock = {(update:CalendarViewUpdate) in
            expectation.fulfill()
            let indexPath = update.rowsUpdate[0]
            XCTAssertEqual(indexPath.section, 1)
            XCTAssertEqual(indexPath.item, 26)
        }
        calendarViewModel.update(newSelectedDay: day!)
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testUpdateNewSelectedDayReloadNewDayIndexPathNew() {
        let date = dateFeb142018()
        // view model with 3 months dec - 17, jan - 18, feb- 18
        let calendarViewModel = calendarViewModel3Months(forDate: date)
        
        let expectation = XCTestExpectation(description: "CalendarViewUpdateCalled")
        
        // Mocked Day adding 4 days which is Feb 18
        let newSelectedDate = date.dateByAdding(days: 4)
        let month = calendarViewModel.monthFor(date: newSelectedDate)
        let day = month?.dayFor(date: newSelectedDate)
        calendarViewModel.updateBlock = {(update:CalendarViewUpdate) in
            expectation.fulfill()
            let indexPath = update.rowsUpdate[1]
            XCTAssertEqual(indexPath.section, 1) // feb month section
            XCTAssertEqual(indexPath.item, 21)  // location of feb 18 in month section
        }
        calendarViewModel.update(newSelectedDay: day!)
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testUpdateNewSelectedDayReloadNewDayIndexPathDiferentMonths() {
        let date = dateFeb142018()
        // view model with 3 months dec - 17, jan - 18, feb- 18
        let calendarViewModel = calendarViewModel3Months(forDate: date)
        
        let expectation = XCTestExpectation(description: "CalendarViewUpdateCalled")
        
        // Mocked Day adding 4 days which is Feb 18
        let newSelectedDate = dateJan262018()
        let month = calendarViewModel.monthFor(date: newSelectedDate)
        let day = month?.dayFor(date: newSelectedDate)
        calendarViewModel.updateBlock = {(update:CalendarViewUpdate) in
            expectation.fulfill()
            //old day index Path
            var indexPath = update.rowsUpdate[0]
            XCTAssertEqual(indexPath.section, 1) // feb month section
            XCTAssertEqual(indexPath.item, 17)  // location of feb 14 in month section is 17
            
            indexPath = update.rowsUpdate[1]
            XCTAssertEqual(indexPath.section, 0) // jan month section newly selceted date
            XCTAssertEqual(indexPath.item, 26)
        }
        calendarViewModel.update(newSelectedDay: day!)
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testUpdateNewSelectedDayVerifyUpdateCallBack() {
        let date = dateFeb142018()
        // view model with 3 months  jan - 18, feb - 18, mar - 18
        let calendarViewModel = calendarViewModel3Months(forDate: date)
        
        let expectation = XCTestExpectation(description: "CalendarViewUpdateCalled")
        
        // Mocked Day
        let newSelectedDate = date.dateByAdding(days: 4)
        let month = calendarViewModel.monthFor(date: newSelectedDate)
        let day = month?.dayFor(date: newSelectedDate)
        calendarViewModel.updateBlock = {(update:CalendarViewUpdate) in
            expectation.fulfill()
        }
        calendarViewModel.update(newSelectedDay: day!)
        wait(for: [expectation], timeout: 3.0)
    }
    
    func dateJan262018() -> Date {
        var date = Date()
        // create date 26th Jan
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 1
        components.day = 26
        components.year = 2018
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
    
    func calendarViewModel3Months(forDate:Date) -> CalendarViewModel {
        let startDate = forDate.dateByAdding(months: -1)
        let endDate = forDate.dateByAdding(months: 2)
        let calendarViewModel: CalendarViewModel = CalendarViewModel()
        calendarViewModel.createMonths(for: startDate, and: endDate)
        calendarViewModel.set(selectedDate: forDate)
        return calendarViewModel
    }
}
