//
//  EventCellViewModel_Tests.swift
//  CalendarTests
//
//  Created by Vinodh Govind Swamy on 2/25/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import XCTest
import EventKit
@testable import Calendar

class EventCellViewModel_Tests: XCTestCase {
    
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
    
    func testStartDate() {
        let event = sampleEvent()
        let eventCellVM = EventCellViewModel(calendarEvent: event)
        XCTAssertEqual(eventCellVM.startDate, "07:30");
    }
    
    func testEndDate() {
        let event = sampleEvent()
        let eventCellVM = EventCellViewModel(calendarEvent: event)
        XCTAssertEqual(eventCellVM.endDate, "08:30");
    }
    
    func testTitleDate() {
        let event = sampleEvent()
        let eventCellVM = EventCellViewModel(calendarEvent: event)
        XCTAssertEqual(eventCellVM.title, "@018 Product Town hall");
    }
    
    func testNotesDate() {
        let event = sampleEventWithNotes()
        let eventCellVM = EventCellViewModel(calendarEvent: event)
        XCTAssertEqual(eventCellVM.detail, "Town Hall - A forum where members of Congress give legislative updates and answer open questions from constituents.");
    }
    
    func testLocationDate() {
        let event = sampleEventWithLocation()
        let eventCellVM = EventCellViewModel(calendarEvent: event)
        XCTAssertEqual(eventCellVM.detail, "(Democratic) MA, Senate");
    }
    
    func testisFullDayFalse() {
        let event = sampleEvent()
        let eventCellVM = EventCellViewModel(calendarEvent: event)
        XCTAssertFalse(eventCellVM.isAllDay)
    }
    
    func testallDayTitle() {
        let event = sampleEvent()
        event.isAllDay = true
        let eventCellVM = EventCellViewModel(calendarEvent: event)
        XCTAssertTrue(eventCellVM.isAllDay)
        XCTAssertEqual(eventCellVM.alldayTitle, "all-day")
    }
    
    func testNoEventsCellTitle() {
        let noeventCell = NoEventsViewModel()
        XCTAssertEqual(noeventCell.title, "No Events")
    }
    
    func dateJan262018() -> Date {
        var date = Date()
        // create date 26th Jan
        var components =  Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        components.month = 1
        components.day = 26
        components.year = 2018
        components.hour = 07
        components.minute  = 30
        date = Calendar.current.date(from: components)!
        return date
    }
    
    func sampleEvent() -> EKEvent {
        let event = EKEvent(eventStore: store)
        event.startDate = dateJan262018()
        event.endDate = event.startDate.addingTimeInterval(60*60)
        event.title = "@018 Product Town hall"
        return event
    }
    
    func sampleEventWithNotes() -> EKEvent {
        let event = EKEvent(eventStore: store)
        event.startDate = dateJan262018()
        event.endDate = event.startDate.addingTimeInterval(60*60)
        event.title = "@018 Product Town hall"
        event.notes = "Town Hall - A forum where members of Congress give legislative updates and answer open questions from constituents."
        return event
    }
    
    func sampleEventWithLocation() -> EKEvent {
        let event = EKEvent(eventStore: store)
        event.startDate = dateJan262018()
        event.endDate = event.startDate.addingTimeInterval(60*60)
        event.title = "@018 Product Town hall"
        event.location = "(Democratic) MA, Senate"
        return event
    }
}
