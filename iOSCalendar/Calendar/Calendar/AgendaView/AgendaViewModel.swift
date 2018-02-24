//
//  AgendaViewModel.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/18/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation
import EventKit

struct DateRange {
    var start:Date
    var months:Int = 0
    var years:Int = 0
    
    var end:Date {
        let totalMonths = months + years * 12
        return start.dateByAdding(months: totalMonths)
    }
}

typealias loadEventsCompletionBlock = (_ loadEventsResponse:loadEventsResponseParam) -> Void

struct loadEventsRequestParam{
    let dateRange : DateRange
}

struct loadEventsResponseParam{
    let success: Bool
    let events: [DayViewDatasource]?
    let updates: AgendaViewUpdate
    let error: Error?
}

protocol AgendaViewDataSource {
    var selectedDate: Date { get set }
    var days: [DayViewDatasource] { get set }
    func indexPathFor(date: Date) -> IndexPath?
    func dateFor(indexPath: IndexPath) -> Date
    func loadEvents(requestParam: loadEventsRequestParam, completionBlock: @escaping loadEventsCompletionBlock)
}

class AgendaViewModel: AgendaViewDataSource{
    var selectedDate: Date = Date()
    var days: [DayViewDatasource] = []
    var daysCache: [String: DayViewDatasource] = [:]
    
    func indexPathFor(date: Date) -> IndexPath?{
        guard let day = daysCache[DateFormatter.shared.dateTitleFor(date: date)] else { return nil }
        guard let index = days.index(where: {$0.date == day.date}) else { return nil }
        return IndexPath(item: 0, section: index)
    }
    
    func dateFor(indexPath: IndexPath) -> Date {
        let day = days[indexPath.section]
        return day.date
    }
    
    func loadEvents(requestParam:loadEventsRequestParam,
                    completionBlock:@escaping loadEventsCompletionBlock) {
        
        let startDate = requestParam.dateRange.start
        let endDate = requestParam.dateRange.end
        days = createDaysFor(dateRange: requestParam.dateRange)
        
        EventsLoader.load(fromDate: startDate,
                          toDate: endDate){ (events) in
                            if events != nil {
                                let updates = self.populateEventsFrom(events: events!)
                                let response = loadEventsResponseParam(success: true,
                                                                       events: self.days,
                                                                       updates: updates,
                                                                       error: nil)
                                completionBlock(response)
                            }
        }
    }
    
    func createDaysFor(dateRange:DateRange) -> [DayViewDatasource] {
        var days: [DayViewDatasource] = []
        let formatter = DateFormatter.shared
        let numOfDays = Date.daysBetween(startDate: dateRange.start,
                                         endDate: dateRange.end)
        let startDate = dateRange.start
        for dayIndex in stride(from: 0, to: numOfDays, by: 1) {
            let date = startDate.dateByAdding(days: dayIndex)
            let dayVM = DayViewModel(date: date)
            daysCache[formatter.dateTitleFor(date: date)] = dayVM
            days.append(dayVM)
        }
        return days
    }
    
    // TODO: This api designed to make use of AgendaViewUpdate to generate the
    // tableview sections and rows update when filling the calendar events data into the viewmodel data source
    // This AgendaViewUpdate is currently not used
    func populateEventsFrom(events:[EKEvent]) -> AgendaViewUpdate {
        
        let viewUpdate = AgendaViewUpdate()
        let sortedEvents = events.sorted { (event1, event2) -> Bool in
            return event1.startDate < event2.startDate
        }
        
        let formatter = DateFormatter.shared
        for event in sortedEvents {
            
            if let dayVM = daysCache[formatter.dateTitleFor(date: event.startDate)] {
                let eventVM = EventViewModel(calendarEvent: event)
                dayVM.add(event: eventVM)
            }
        }
        return viewUpdate
    }
}
