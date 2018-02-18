//
//  EventViewModel.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/18/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

protocol EventViewDatasource {
    var startDate: Date { get }
    var endDate: Date { get }
    var title: String { get }
}

class EventViewModel: EventViewDatasource {
    
    var startDate: Date{
        return calendarEvent.startDate
    }
    
    var endDate: Date {
        return calendarEvent.endDate
    }
    
    var title: String {
        return calendarEvent.title
    }
    
    var calendarEvent: CalendarEvent
    
    init(calendarEvent:CalendarEvent) {
        self.calendarEvent = calendarEvent
    }
}
