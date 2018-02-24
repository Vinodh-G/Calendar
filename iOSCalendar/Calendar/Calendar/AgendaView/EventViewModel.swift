//
//  EventViewModel.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/18/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation
import EventKit

protocol EventViewDatasource {
    var eventId: String { get }
    var startDate: Date { get }
    var endDate: Date { get }
    var title: String { get }
}

class EventViewModel: EventViewDatasource {

    var eventId: String
    var startDate: Date{
        return calendarEvent.startDate
    }
    
    var endDate: Date {
        return calendarEvent.endDate
    }
    
    var title: String {
        return calendarEvent.title
    }
    
    var calendarEvent: EKEvent
    
    init(calendarEvent:EKEvent) {
        self.calendarEvent = calendarEvent
        eventId = ProcessInfo.processInfo.globallyUniqueString
    }
}

let kNoEventsTitle: String = "No Events"

class NoEventViewModel: EventViewDatasource {
    
    var eventId: String
    var startDate: Date
    var endDate: Date
    
    var title: String {
        return kNoEventsTitle
    }
    
    init(date:Date) {
        startDate = date
        endDate = date
        eventId = ProcessInfo.processInfo.globallyUniqueString
    }
}
