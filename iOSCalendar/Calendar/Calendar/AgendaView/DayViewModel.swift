//
//  DaysViewModel.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/18/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

protocol DayViewDatasource {

    var title: String { get }
    var date: Date { get set }
    func eventsCount() -> Int
    func eventFor(index: Int) -> EventViewDatasource
    func add(event:EventViewDatasource)
    func remove(event:EventViewDatasource)
}

class DayViewModel: DayViewDatasource {

    var date: Date
    var events: [EventViewDatasource] = []
    
    init(date:Date) {
        self.date = date
    }
    
    var title: String {
        return DateFormatter.shared.dateTitleFor(date: date)
    }
    
    func eventsCount() -> Int {
        // If there is not event for a given day, we are returning 1 as event count
        // for displaying "No Events"
        return events.count > 0 ? events.count : 1
    }
    
    func eventFor(index: Int) -> EventViewDatasource {
        if events.count > 0 {
            return events[index]
        } else {
            return NoEventViewModel(date: date)
        }
    }
    
    func add(event:EventViewDatasource) {
        events.append(event)
    }
    
    func remove(event:EventViewDatasource) {
        if let index = events.index(where:{ $0.eventId == event.eventId }){
            events.remove(at: index)
        }
    }
    
    static func ==(lhs: DayViewModel, rhs: DayViewModel) -> Bool {
        return lhs.date < rhs.date
    }
}
