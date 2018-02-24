//
//  DayViewModel_Tests.swift
//  CalendarTests
//
//  Created by Vinodh Govind Swamy on 2/25/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import XCTest
import EventKit
@testable import Calendar

class DayViewModel_Tests: XCTestCase {

    let store = EKEventStore()

    override func setUp() {
        super.setUp()
        store.requestAccess(to: EKEntityType.event) {(granted, error) -> Void in
            guard granted else {
                return
            }
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDayViewModelTitleJan26() {
        let dayViewModel = DayViewModel(date: dateJan262018())
        XCTAssertEqual(dayViewModel.title, "Jan 26, 2018")
    }
    
    func testDayViewModelTitleFeb14() {
        let dayViewModel = DayViewModel(date: dateFeb142019())
        XCTAssertEqual(dayViewModel.title, "Feb 14, 2019")
    }
    
    func testDayViewModelCountWhenNoEvents() {
        let dayViewModel = DayViewModel(date: dateJan262018())
        XCTAssertEqual(dayViewModel.eventsCount(), 1) // By default if there is no events in the dayviewmodel, the count will be 1, which will return NoEventViewmodel
    }
    
    func testDayViewModelCountWithOneEvents() {
        let dayViewModel = DayViewModel(date: dateJan262018())
        XCTAssertEqual(dayViewModel.eventsCount(), 1) // By default if there is no events in the dayviewmodel, the count will be 1, which will return NoEventViewmodel
        let eventModel = EventViewModel(calendarEvent: EKEvent(eventStore: store))
        dayViewModel.add(event: eventModel)
        
        XCTAssertEqual(dayViewModel.eventsCount(), 1) // the event count is one becuase when there is valid event, no event count doesnt matter,
    }
    
    func testDayViewModelCountRemoveEvent() {
        let dayViewModel = DayViewModel(date: dateJan262018())
        let eventModel = EventViewModel(calendarEvent: EKEvent(eventStore: store))
        dayViewModel.add(event: eventModel)
        XCTAssertEqual(dayViewModel.eventsCount(), 1) // one valid event view model
        dayViewModel.remove(event: eventModel)
        XCTAssertEqual(dayViewModel.eventsCount(), 1) // one NO event EVent view model
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
    
    func dateFeb142019() -> Date {
        var date = Date()
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 2
        components.day = 14
        components.year = 2019
        date = Calendar.current.date(from: components)!
        return date
    }
}
