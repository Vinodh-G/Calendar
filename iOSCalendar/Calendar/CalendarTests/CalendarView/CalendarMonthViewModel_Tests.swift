//
//  CalendarMonthViewModel_Tests.swift
//  CalendarTests
//
//  Created by Vinodh Govind Swamy on 2/19/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import XCTest
@testable import Calendar

class CalendarMonthViewModel_Tests: XCTestCase {
    
    var date : Date!
    override func setUp() {
        super.setUp()
        let date = Date()
        
        // create date 26th Jan
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 1
        components.day = 26
        components.year = 2018
        self.date = Calendar.current.date(from: components)!
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCalendarMonthViewModelForDatesVMCount(){
        
        let calendarMonthModel = CalendarMonthViewModel(inDate: self.date)
        // The Month layout can have maximum 42 day slots in which months date ranges between the these 0..42 slots
        XCTAssertEqual(calendarMonthModel.dates.count, 42)
    }
    
    // Every month date should fall in between these below 42 slots, based the start day of month the month rages value is calculated.
    
    //  S   M   T   W   T   F   S
    //  0   1   2   3   4   5   6
    //  7   8   9   10  11  12  13
    //  14  15  16  17  18  19  20
    //  21  22  23  24  25  26  27
    //  28  29  30  31  32  33  34
    //  35  36  37  38  39  40  41
    
    func testCalendarMonthViewModelForMonthsRangeJan18(){
        
        let calendarMonthModel = CalendarMonthViewModel(inDate: self.date)
        let monthRange = calendarMonthModel.monthRange
        XCTAssertEqual(monthRange, 1..<32) // The month range should start from 1 to 32 in the available 42 slots, the first of jan came on monday which is why it starts at 1.
    }
    
    func testCalendarMonthViewModelForMonthsRangeFeb18(){
        
        var date = Date()
        
        // create date 19th Feb
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 2
        components.day = 19
        components.year = 2018
        date = Calendar.current.date(from: components)!
        let calendarMonthModel = CalendarMonthViewModel(inDate: date)
        let monthRange = calendarMonthModel.monthRange
        XCTAssertEqual(monthRange, 4..<32) // The month range should start from 4 to 32 in the available 42 slots, the first of feb came on thursday which is why it starts at 4.
    }
    
    func testCalendarMonthViewModelForMonthsRangeDec20(){
        
        var date = Date()
        
        // create date 19th Feb
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 12
        components.day = 19
        components.year = 2020
        date = Calendar.current.date(from: components)!

        let calendarMonthModel = CalendarMonthViewModel(inDate: date)
        let monthRange = calendarMonthModel.monthRange
        XCTAssertEqual(monthRange, 2..<33) // The month range should start from 2 to 33 in the available 42 slots, the first of dec came on tuesday which is why it starts at 6.
    }
    
    func testCalendarMonthViewModelForMonthsRangeNov00(){
        
        var date = Date()
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 11
        components.day = 1
        components.year = 0000
        date = Calendar.current.date(from: components)!
        
        let calendarMonthModel = CalendarMonthViewModel(inDate: date)
        let monthRange = calendarMonthModel.monthRange
        XCTAssertEqual(monthRange,4..<34)
    }
    
    func testCalendarMonthViewModelForDayStringMonthJan18()  {
        let calendarMonthModel = CalendarMonthViewModel(inDate: date)
        var monthIndex = 1
        for slot in 1 ..< 32 {
            XCTAssertEqual(calendarMonthModel.dayStringFor(slot: slot), "\(monthIndex)")
            monthIndex = monthIndex + 1
        }
    }
    
    func testCalendarMonthViewModelForDayStringMonthFeb23()  {
        
        var date = Date()
        
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 2
        components.day = 1
        components.year = 2023
        date = Calendar.current.date(from: components)!
        
        let calendarMonthModel = CalendarMonthViewModel(inDate: date)
        var monthIndex = 1
        for slot in 3 ..< 31 {
            XCTAssertEqual(calendarMonthModel.dayStringFor(slot: slot), "\(monthIndex)")
            monthIndex = monthIndex + 1
        }
    }
    
    func testCalendarMonthViewModelForMonthTitleJan() {
        let calendarMonthModel = CalendarMonthViewModel(inDate: date)
        XCTAssertEqual(calendarMonthModel.monthTitle, "January")
    }
    
    func testCalendarMonthViewModelForMonthTitleJuly() {
        var date = Date()
        
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 7
        components.day = 1
        components.year = 2023
        date = Calendar.current.date(from: components)!
        let calendarMonthModel = CalendarMonthViewModel(inDate: date)
        XCTAssertEqual(calendarMonthModel.monthTitle, "July")
    }
    
    func testCalendarMonthViewModelForMonthTitleDec() {
        var date = Date()
        
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 12
        components.day = 1
        components.year = 1998
        date = Calendar.current.date(from: components)!
        let calendarMonthModel = CalendarMonthViewModel(inDate: date)
        XCTAssertEqual(calendarMonthModel.monthTitle, "December")
    }
}

