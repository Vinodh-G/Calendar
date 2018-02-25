//
//  EventViewModel.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/18/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation
import EventKit

enum EventViewModelStatus {
    case confirmed
    case notConfirmed
}

protocol EventViewDatasource {
    var eventId: String { get }
    var startDate: String { get }
    var endDate: String { get }
    var title: String { get }
    var detail: String { get }
    var status: EventViewModelStatus { get }
    var isAllDay: Bool { get }
    var alldayTitle: String { get }
}

class EventCellViewModel: EventViewDatasource {
    
    var eventId: String
    var startDate: String {
        return DateFormatter.shared.timeStringFor(date:calendarEvent.startDate,
                                                  format: k24TimeFormat)
    }
    
    var endDate: String {
        return DateFormatter.shared.timeStringFor(date:calendarEvent.endDate,
                                                  format: k24TimeFormat)
    }
    
    var title: String {
        return calendarEvent.title
    }
    
    var alldayTitle: String {
        return "all-day"
    }
    
    var detail: String {
        
        guard let notes = calendarEvent.notes else {
            guard let location = calendarEvent.location else { return "" }
            return location.trimmingCharacters(in: .whitespaces)
        }
        return notes.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var status: EventViewModelStatus {
        switch calendarEvent.status {
        case .confirmed, .tentative:
            return .confirmed
        default:
            return .notConfirmed
        }
    }
    
    var isAllDay: Bool {
        return calendarEvent.isAllDay
    }
    
    var calendarEvent: EKEvent
    
    init(calendarEvent:EKEvent) {
        self.calendarEvent = calendarEvent
        eventId = ProcessInfo.processInfo.globallyUniqueString
    }
}

let kNoEventsTitle: String = "No Events"

class NoEventsViewModel {
    
    var date: Date
    
    var title: String {
        return kNoEventsTitle
    }
    
    init(inDate: Date? = Date()) {
        date = inDate!
    }
}
