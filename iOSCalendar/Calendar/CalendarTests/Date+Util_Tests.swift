//
//  Date+Util_Tests.swift
//  CalendarTests
//
//  Created by Vinodh Govind Swamy on 2/14/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import XCTest
import Calendar

class Date_Util_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStartDateDay() {
        let date = Date()
        let startDate = Date.startDateOfMonthFor(date:date)
        let components =  Calendar.current.dateComponents([.year, .month, .day], from: startDate)
        XCTAssertEqual(components.day, 1)
    }
    
    func testStartDateDay1() {
        var date = Date()
        
        // create date with day already as 1
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.day = 1
        date = Calendar.current.date(from: components)!
        
        // should return start date as 1 itself
        let startDate = Date.startDateOfMonthFor(date:date)
        components =  Calendar.current.dateComponents([.year, .month, .day], from: startDate)
        XCTAssertEqual(components.day, 1)
    }
    
    func testEndDateJan() {
        var date = Date()
        
        // create date 26th Jan
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 1
        components.day = 26
        date = Calendar.current.date(from: components)!
        
        // should return end date of 31st Jan
        let endDate = Date.endDateOfMonthFor(date:date)
        components =  Calendar.current.dateComponents([.year, .month, .day], from: endDate)
        XCTAssertEqual(components.day, 31)
    }
    
    func testEndDateFeb() {
        var date = Date()
        
        // create date 27th Feb
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 2
        components.day = 27
        date = Calendar.current.date(from: components)!
        
        // should return end date of 31st Jan
        let endDate = Date.endDateOfMonthFor(date:date)
        components =  Calendar.current.dateComponents([.year, .month, .day], from: endDate)
        XCTAssertEqual(components.day, 28)
    }
    
    func testEndDateFebLeapYear() {
        var date = Date()
        
        // create date 27th Feb
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 2
        components.day = 1
        components.year = 2016
        date = Calendar.current.date(from: components)!
        
        // should return end date of 31st Jan
        let endDate = Date.endDateOfMonthFor(date:date)
        components =  Calendar.current.dateComponents([.year, .month, .day], from: endDate)
        XCTAssertEqual(components.day, 29)
    }
    
    func testWeekDay() {
        var date = Date()
        // create date 14th Feb
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 2
        components.day = 14
        date = Calendar.current.date(from: components)!
        
        // should return end date of 31st Jan
        let weekDay = Date.weekDayFor(date:date)
        XCTAssertEqual(weekDay, 4)
    }
    
    func testDateByAddingDaysPositiveSameMonth() {
        var date = Date()
        // create date 14th Feb
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 2
        components.day = 14
        date = Calendar.current.date(from: components)!
        
        let newDate = date.dateByAdding(days:3)
        components =  Calendar.current.dateComponents([.year, .month, .day], from: newDate)
        XCTAssertEqual(components.day, 17)
    }
    
    func testDateByAddingDaysNegativeSameMonth() {
        var date = Date()
        // create date 14th Feb
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 2
        components.day = 14
        date = Calendar.current.date(from: components)!
        
        let newDate = date.dateByAdding(days:-3)
        components =  Calendar.current.dateComponents([.year, .month, .day], from: newDate)
        XCTAssertEqual(components.day, 11)
    }
    
    func testDateByAddingDaysPositiveNextMonth() {
        var date = Date()
        // create date 14th Feb
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 2
        components.day = 27
        components.year = 2018
        date = Calendar.current.date(from: components)!
        
        let newDate = date.dateByAdding(days:7)
        components =  Calendar.current.dateComponents([.year, .month, .day], from: newDate)
        XCTAssertEqual(components.day, 6)
        XCTAssertEqual(components.month, 3)
    }
    
    func testDateByAddingDaysNegativePreviousMonth() {
        var date = Date()
        // create date 3rd Feb
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 2
        components.day = 3
        components.year = 2018
        date = Calendar.current.date(from: components)!
        
        let newDate = date.dateByAdding(days:-4)
        components =  Calendar.current.dateComponents([.year, .month, .day], from: newDate)
        XCTAssertEqual(components.day, 30)
        XCTAssertEqual(components.month, 1)
    }
    
    func testDateByAddingDaysNegativePreviousMonthYear() {
        var date = Date()
        // create date 3rd Jan
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 1
        components.day = 3
        components.year = 2018
        date = Calendar.current.date(from: components)!
        
        let newDate = date.dateByAdding(days:-4)
        components =  Calendar.current.dateComponents([.year, .month, .day], from: newDate)
        XCTAssertEqual(components.day, 30)
        XCTAssertEqual(components.month, 12)
        XCTAssertEqual(components.year, 2017)
    }
    
    func testDateByAddingDays365() {
        var date = Date()
        // create date 3rd Jan
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 1
        components.day = 3
        components.year = 2018
        date = Calendar.current.date(from: components)!
        
        let newDate = date.dateByAdding(days:365)
        components =  Calendar.current.dateComponents([.year, .month, .day], from: newDate)
        XCTAssertEqual(components.day, 3)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.year, 2019)
    }
    
    func testDateByAddingDaysNeagative366() {
        var date = Date()
        // create date 1rd Jan
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 1
        components.day = 1
        components.year = 2018
        date = Calendar.current.date(from: components)!
        
        let newDate = date.dateByAdding(days:-366)
        components =  Calendar.current.dateComponents([.year, .month, .day], from: newDate)
        XCTAssertEqual(components.day, 31)
        XCTAssertEqual(components.month, 12)
        XCTAssertEqual(components.year, 2016)
    }

    func testDateByAddingMonths() {
        var date = Date()
        // create date 3rd Feb
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 1
        components.day = 3
        components.year = 2018
        date = Calendar.current.date(from: components)!
        
        let newDate = date.dateByAdding(months:24)
        components =  Calendar.current.dateComponents([.year, .month, .day], from: newDate)
        XCTAssertEqual(components.year, 2020)
        XCTAssertEqual(components.month, 1)
    }
    
    func testMonthsBetweenDates() {
        var date = Date()
        // create date 3rd Jan
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 1
        components.day = 1
        components.year = 2018
        let startdate = Calendar.current.date(from: components)!
        
        date = Date()
        // create date 3rd Feb
        components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 12
        components.day = 10
        components.year = 2018
        let enddate = Calendar.current.date(from: components)!
        let months = Date.monthsBetween(startDate:startdate, endDate:enddate)
        XCTAssertEqual(months, 11)
    }
}
