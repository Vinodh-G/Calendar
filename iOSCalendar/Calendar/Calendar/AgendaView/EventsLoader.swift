//
//  EventsLoader.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/19/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation
import EventKit

class EventsLoader {
    private static let store = EKEventStore()
    
    static func load(from fromDate: Date, to toDate: Date, complete onComplete: @escaping ([CalendarEvent]?) -> Void) {
        
        let mainQueue = DispatchQueue.main
        guard EKEventStore.authorizationStatus(for: .event) == .authorized else {
            
            return EventsLoader.store.requestAccess(to: EKEntityType.event, completion: {(granted, error) -> Void in
                guard granted else {
                    return mainQueue.async { onComplete(nil) }
                }
                EventsLoader.fetch(from: fromDate, to: toDate) { events in
                    mainQueue.async { onComplete(events) }
                }
            })
        }
        
        EventsLoader.fetch(from: fromDate, to: toDate) { events in
            mainQueue.async { onComplete(events) }
        }
    }
    
    private static func fetch(from fromDate: Date, to toDate: Date, complete onComplete: @escaping ([CalendarEvent]) -> Void) {
        
        let predicate = store.predicateForEvents(withStart: fromDate, end: toDate, calendars: nil)
        
//        let secondsFromGMTDifference = TimeInterval(TimeZone.current.secondsFromGMT())

        let events = store.events(matching: predicate).map { (event) -> CalendarEvent in
            let calendarEvent = CalendarEvent(startDate:event.startDate,
                                              endDate: event.endDate,
                                              title: event.title)
            calendarEvent.isAllDay = event.isAllDay
            return calendarEvent
        }
        onComplete(events)
    }
}
