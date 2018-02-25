//
//  EventCell_Tests.swift
//  CalendarTests
//
//  Created by Vinodh Govind Swamy on 2/25/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import XCTest
import EventKit
@testable import Calendar


class EventCell_Tests: XCTestCase {
    
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
    
    func testUpdateEventDetailsForTitle() {
        let event = sampleEvent()
        let eventVM = EventCellViewModel(calendarEvent: event)
        let cell = eventCell()
        cell.viewModel = eventVM
        
        XCTAssertEqual(cell.eventTitleLabel.text, eventVM.title)
    }
    
    func testUpdateEventDetailsForStartDate() {
        let event = sampleEvent()
        let eventVM = EventCellViewModel(calendarEvent: event)
        let cell = eventCell()
        cell.viewModel = eventVM
        
        XCTAssertEqual(cell.startTimeLabel.text, "07:30-08:30")
    }
    
    func testUpdateEventDetailsForStartDateForAllDay() {
        let event = sampleEvent()
        event.isAllDay = true
        let eventVM = EventCellViewModel(calendarEvent: event)
        let cell = eventCell()
        cell.viewModel = eventVM
        
        XCTAssertEqual(cell.startTimeLabel.text, "all-day")
    }
    
    func testUpdateEventDetailsForDetailTextNil() {
        let event = sampleEvent()
        let eventVM = EventCellViewModel(calendarEvent: event)
        let cell = eventCell()
        cell.viewModel = eventVM
        
        XCTAssertEqual(cell.eventDetailLabel.text, "")
    }
    
    func testUpdateEventDetailsForStartDateEventWithNotes() {
        let event = sampleEventWithNotes()
        let eventVM = EventCellViewModel(calendarEvent: event)
        let cell = eventCell()
        cell.viewModel = eventVM
        
        XCTAssertEqual(cell.startTimeLabel.text, "07:30")
    }
    
    func testUpdateEventDetailsForEndDateEventWithNotes() {
        let event = sampleEventWithNotes()
        let eventVM = EventCellViewModel(calendarEvent: event)
        let cell = eventCell()
        cell.viewModel = eventVM
        
        XCTAssertEqual(cell.endTimeLabel.text, "08:30")
    }
    
    func testUpdateEventDetailsForEndDate() {
        let event = sampleEvent()
        let eventVM = EventCellViewModel(calendarEvent: event)
        let cell = eventCell()
        cell.viewModel = eventVM
        
        XCTAssertEqual(cell.endTimeLabel.text, nil)
    }
    
    func testUpdateEventDetailsForBackgrounColor() {
        let event = sampleEvent()
        let eventVM = EventCellViewModel(calendarEvent: event)
        let cell = eventCell()
        cell.viewModel = eventVM
        
        XCTAssertEqual(cell.statusView.backgroundColor, AgendaViewConfig.defaultConfig.statusViewColorNotConfirmed)
    }
    
    func eventCell() -> EventCell{
        let eventCell = EventCell()
        let label = UILabel()
        eventCell.eventTitleLabel = label
        eventCell.contentView.addSubview(label)
        
        let detaillabel = UILabel()
        eventCell.eventDetailLabel = detaillabel
        eventCell.contentView.addSubview(detaillabel)
        
        let start = UILabel()
        eventCell.startTimeLabel = start
        eventCell.contentView.addSubview(start)
        
        let end = UILabel()
        eventCell.endTimeLabel = end
        eventCell.contentView.addSubview(end)
        
        let view = UIView()
        eventCell.statusView = view
        eventCell.contentView.addSubview(view)
        return eventCell
    }
    
    func sampleEventWithNotes() -> EKEvent {
        let event = EKEvent(eventStore: store)
        event.startDate = dateJan262018_7_30()
        event.endDate = event.startDate.addingTimeInterval(60*60)
        event.title = "@018 Product Town hall"
        event.notes = "Town Hall - A forum where members of Congress give legislative updates and answer open questions from constituents."
        return event
    }
    
    func sampleEvent() -> EKEvent {
        let event = EKEvent(eventStore: store)
        event.startDate = dateJan262018_7_30()
        event.endDate = event.startDate.addingTimeInterval(60*60)
        event.title = "@018 Product Town hall"
        return event
    }
    
    func dateJan262018_7_30() -> Date {
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
}
