//
//  AgendaViewModel_Tests.swift
//  CalendarTests
//
//  Created by Vinodh Govind Swamy on 2/19/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import XCTest
import EventKit
@testable import Calendar

class AgendaViewModel_Tests: XCTestCase {
    
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
    
    func testPopulateEventsFromCount() {
        let agendaModel = AgendaViewModel()
        let dateRange = DateRange(start: dateJan262020().dateByAdding(months: 0),
                                  months: 12,
                                  years: 0)
        agendaModel.days = agendaModel.createDaysFor(dateRange: dateRange)
        _ = agendaModel.populateEventsFrom(events: sampleEvents(Count: 3))
        XCTAssertEqual(agendaModel.days.count, 366)
    }
    
    func testPopulateEventsFromDay1() {
        let agendaModel = AgendaViewModel()
        let dateRange = DateRange(start: dateJan262020().dateByAdding(months: 0),
                                  months: 12,
                                  years: 0)
        agendaModel.days = agendaModel.createDaysFor(dateRange: dateRange)
        _ = agendaModel.populateEventsFrom(events: sampleEvents(Count: 13))
        let day = agendaModel.days[0]
        XCTAssertFalse(day.hasEvents)
        XCTAssertEqual(day.events.count, 0)
    }
    
    func testPopulateEventsFromDay2() {
        let agendaModel = AgendaViewModel()
        let dateRange = DateRange(start: dateJan262020().dateByAdding(months: 0),
                                  months: 12,
                                  years: 0)
        agendaModel.days = agendaModel.createDaysFor(dateRange: dateRange)
        _ = agendaModel.populateEventsFrom(events: sampleEvents(Count: 27))
        let day = agendaModel.days[1]
        XCTAssertEqual(day.events.count, 6)
    }
    
    func testPopulateEventsFromDay3() {
        let agendaModel = AgendaViewModel()
        let dateRange = DateRange(start: dateJan262020().dateByAdding(months: 0),
                                  months: 12,
                                  years: 0)
        agendaModel.days = agendaModel.createDaysFor(dateRange: dateRange)
        _ = agendaModel.populateEventsFrom(events: sampleEvents(Count: 27))
        let day = agendaModel.days[2]
        XCTAssertEqual(day.events.count, 6)
    }
    
    func testPopulateEventsFromDay7() {
        let agendaModel = AgendaViewModel()
        let dateRange = DateRange(start: dateJan262020().dateByAdding(months: 0),
                                  months: 12,
                                  years: 0)
        agendaModel.days = agendaModel.createDaysFor(dateRange: dateRange)
        _ = agendaModel.populateEventsFrom(events: sampleEvents(Count: 13))
        let day = agendaModel.days[60]
        XCTAssertFalse(day.hasEvents)
        XCTAssertEqual(day.events.count, 0)
    }
    
    func testIndexPathFOrDateNil() {
        let agendaModel = AgendaViewModel()
        let dateRange = DateRange(start: dateJan262020().dateByAdding(months: 0),
                                  months: 3,
                                  years: 0)
        agendaModel.days = agendaModel.createDaysFor(dateRange: dateRange)
        let indexPath = agendaModel.indexPathFor(date: dateApr142021())
        XCTAssertNil(indexPath)
    }
    
    func testIndexPathFOrDate() {
        let agendaModel = AgendaViewModel()
        let dateRange = DateRange(start: dateJan262020().dateByAdding(months: 0),
                                  months: 24,
                                  years: 0)
        agendaModel.days = agendaModel.createDaysFor(dateRange: dateRange)
        let indexPath = agendaModel.indexPathFor(date: dateApr142021())
        XCTAssertEqual(indexPath?.section, 444)
        XCTAssertEqual(indexPath?.row, 0)
    }
    
    func testIndexPathForDate48Months() {
        let agendaModel = AgendaViewModel()
        let dateRange = DateRange(start: dateFeb142018().dateByAdding(months: 0),
                                  months: 48,
                                  years: 0)
        agendaModel.days = agendaModel.createDaysFor(dateRange: dateRange)
        let indexPath = agendaModel.indexPathFor(date: dateJan262020())
        XCTAssertEqual(indexPath?.section, 711)
        XCTAssertEqual(indexPath?.row, 0)
    }
    
    func testDateForIndexPathDate18() {
        let agendaModel = AgendaViewModel()
        
        //starting from feb 14 2018 the days have been created till the jan 2022, we can test piching any indexpath, to get the valid date
        
        let dateRange = DateRange(start: dateFeb142018().dateByAdding(months: 0),
                                  months: 48,
                                  years: 0)
        agendaModel.days = agendaModel.createDaysFor(dateRange: dateRange)
        let date = agendaModel.dateFor(indexPath: IndexPath(row: 26, section: 4))
        let components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        XCTAssertEqual(components.day, 18)
        XCTAssertEqual(components.year, 2018)
        XCTAssertEqual(components.month, 2)
    }
    
    func testDateForIndexPathDate31() {
        let agendaModel = AgendaViewModel()
        
        //starting from feb 14 2018 the days have been created till the jan 2022, we can test piching any indexpath, to get the valid date
        
        let dateRange = DateRange(start: dateFeb142018().dateByAdding(months: 0),
                                  months: 48,
                                  years: 0)
        agendaModel.days = agendaModel.createDaysFor(dateRange: dateRange)
        let date = agendaModel.dateFor(indexPath: IndexPath(row: 41, section: 45))
        let components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        XCTAssertEqual(components.day, 31)
        XCTAssertEqual(components.year, 2018)
        XCTAssertEqual(components.month, 3)
    }
    
    func testDateForIndexPathDate89() {
        let agendaModel = AgendaViewModel()
        
        //starting from feb 14 2018 the days have been created till the jan 2022, we can test piching any indexpath, to get the valid date
        
        let dateRange = DateRange(start: dateFeb142018().dateByAdding(months: 0),
                                  months: 48,
                                  years: 0)
        agendaModel.days = agendaModel.createDaysFor(dateRange: dateRange)
        let date = agendaModel.dateFor(indexPath: IndexPath(row: 0, section: 38))
        let components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        XCTAssertEqual(components.day, 24)
        XCTAssertEqual(components.year, 2018)
        XCTAssertEqual(components.month, 3)
    }
    
    func sampleEvents(Count:Int) -> [EKEvent] {
        var events : [EKEvent] = []
        
        let dateRange = DateRange(start: dateJan262020().dateByAdding(months: 0),
                                  months: 12,
                                  years: 0)
        

        var date = dateRange.start
        for eventIndex in 0 ..< Count {
            // skiping the 7th day for not adding events so we can test the no event
            // increase the date by one day if there are 7 events already cretaed
            if eventIndex % 7 == 0 {
                date = date.dateByAdding(days: 1)
            }
            // else create the events on those days
            else if eventIndex % 7 != 0 {
                let event = EKEvent(eventStore: store)
                event.startDate = date
                event.endDate = date.addingTimeInterval(TimeInterval(3600 * (arc4random() % 12)))
                event.title = "\(event.startDate) : \(event.endDate)"
                events.append(event)
            }
        }
        
        return events
    }
    
    func dateApr142021() -> Date {
        var date = Date()
        var components =  Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.month = 4
        components.day = 14
        components.year = 2021
        date = Calendar.current.date(from: components)!
        return date
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
