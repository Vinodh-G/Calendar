//
//  DateFormatter+Util_Tests.swift
//  CalendarTests
//
//  Created by Vinodh Govind Swamy on 2/25/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import XCTest
import Calendar

class DateFormatter_Util_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTimeStringFor01_00() {
        var date = Date()
        var components =  Calendar.current.dateComponents([.hour], from: date)
        components.hour = 1
        date = Calendar.current.date(from: components)!
        XCTAssertEqual(DateFormatter.shared.timeStringFor(date: date,
                                                          format: k24TimeFormat), "01:00")
    }
    
    func testTimeStringFor14_35() {
        var date = Date()
        var components =  Calendar.current.dateComponents([.hour, .minute],
                                                          from: date)
        components.hour = 14
        components.minute = 35
        date = Calendar.current.date(from: components)!
        XCTAssertEqual(DateFormatter.shared.timeStringFor(date: date,
                                                          format: k24TimeFormat), "14:35")
    }
    
    func testTimeStringFor24_00() {
        var date = Date()
        var components =  Calendar.current.dateComponents([.hour, .minute],
                                                          from: date)
        components.hour = 24
        components.minute = 00
        date = Calendar.current.date(from: components)!
        XCTAssertEqual(DateFormatter.shared.timeStringFor(date: date,
                                                          format: k24TimeFormat), "00:00")
    }
    
    func testTimeStringFor23_59() {
        var date = Date()
        var components =  Calendar.current.dateComponents([.hour, .minute],
                                                          from: date)
        components.hour = 23
        components.minute = 59
        date = Calendar.current.date(from: components)!
        XCTAssertEqual(DateFormatter.shared.timeStringFor(date: date,
                                                          format: k24TimeFormat), "23:59")
    }
    
    func testTimeStringFor00_00() {
        var date = Date()
        var components =  Calendar.current.dateComponents([.hour, .minute],
                                                          from: date)
        components.hour = 00
        components.minute = 00
        date = Calendar.current.date(from: components)!
        XCTAssertEqual(DateFormatter.shared.timeStringFor(date: date,
                                                          format: k24TimeFormat), "00:00")
    }
}
