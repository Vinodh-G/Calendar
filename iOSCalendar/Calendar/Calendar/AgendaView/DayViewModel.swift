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
    var hasEvents: Bool { get }
    var events: [EventViewDatasource] { get set }
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

    var hasEvents: Bool {
        return events.count > 0 ? true : false
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
