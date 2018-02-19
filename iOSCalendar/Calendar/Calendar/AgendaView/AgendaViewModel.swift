//
//  AgendaViewModel.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/18/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

struct DateRange {
    var start:Date
    var months:Int = 0
    var years:Int = 0
    
    var endDate:Date {
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
    var days: [DayViewDatasource] { get set }
    func indexSetFor(date: Date) -> IndexPath?
    func loadEvents(requestParam: loadEventsRequestParam, completionBlock: @escaping loadEventsCompletionBlock)
}

class AgendaViewModel: AgendaViewDataSource{
        
    var days: [DayViewDatasource] = []
    var daysCache: [String: DayViewDatasource] = [:]
    
    func indexSetFor(date: Date) -> IndexPath?{
        guard let day = daysCache[DateFormatter.shared.dateTitleFor(date: date)] else { return nil }
        guard let index = days.index(where: {$0.date == day.date}) else { return nil }
        return IndexPath(item: 0, section: index)
    }
    
    func loadEvents(requestParam:loadEventsRequestParam, completionBlock:@escaping loadEventsCompletionBlock) {
        
        let startDate = requestParam.dateRange.start
        let endDate = requestParam.dateRange.endDate
        EventsLoader.load(from: startDate,
                          to: endDate){ (events) in
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
    
    func populateEventsFrom(events:[CalendarEvent]) -> AgendaViewUpdate {
        
        var viewUpdate = AgendaViewUpdate()
        
        let sortedEvents = events.sorted { (event1, event2) -> Bool in
            return event1.startDate < event2.startDate
        }
        
        let formatter = DateFormatter.shared
        for event in sortedEvents {
         
            var dayVM = daysCache[formatter.dateTitleFor(date: event.startDate)]
            if dayVM == nil {
                dayVM = DayViewModel(date: event.startDate)
                daysCache[formatter.dateTitleFor(date: event.startDate)] = dayVM
                days.append(dayVM!)
                
                let sectionIndex = days.count - 1
                let indexSet = IndexSet(integer:sectionIndex)
                let sectionUpdate = SectionUpdate(type: .insert, sectionIndex: indexSet)
                viewUpdate.sectionsUpdate.append(sectionUpdate)
            }
            
            let eventVM = EventViewModel(calendarEvent: event)
            dayVM?.events.append(eventVM)
        }
        
        return viewUpdate
    }
}
