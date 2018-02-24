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
    
    static func load(fromDate: Date,
                     toDate: Date,
                    onCompletion: @escaping ([EKEvent]?) -> Void) {
        
        let mainQueue = DispatchQueue.main
        guard EKEventStore.authorizationStatus(for: .event) == .authorized else {
            
            return EventsLoader.store.requestAccess(to: EKEntityType.event,
                                                    completion: {(granted, error) -> Void in
                guard granted else {
                    return mainQueue.async { onCompletion(nil) }
                }
                EventsLoader.fetch(from: fromDate,
                                   to: toDate) { events in
                    mainQueue.async { onCompletion(events) }
                }
            })
        }
        
        EventsLoader.fetch(from: fromDate, to: toDate) { events in
            mainQueue.async { onCompletion(events) }
        }
    }
    
    private static func fetch(from fromDate: Date, to toDate: Date, complete onComplete: @escaping ([EKEvent]) -> Void) {
        
        let predicate = store.predicateForEvents(withStart: fromDate, end: toDate, calendars: nil)
        let events = store.events(matching: predicate)
        onComplete(events)
    }
}
