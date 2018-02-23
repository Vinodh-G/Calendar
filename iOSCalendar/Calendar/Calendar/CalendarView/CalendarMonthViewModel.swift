//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

class CalendarMonthViewModel {
    
    var startDate : Date
    var days: [CalendarDayCellViewModel] = []
    var monthRange : Range<Int> = 0..<1
    init(inDate:Date) {
        startDate = inDate.startDateOfMonth()
        generateDatesForMonthFrom(date: startDate)
    }
    
    func generateDatesForMonthFrom(date:Date) {
        // TODO: Generate the 42 CalendarDayCellViewModel  for the available month slots
        // record the date range for the month so that only month date is displayed.
        let startDate = date.startDateOfMonth()
        let startDayIndex = startDate.weekDay()
        var slotDateDay =  0 - startDayIndex + 1
        for _ in stride(from: 0, to: 42, by: 1) {
            let date = startDate.dateByAdding(days: slotDateDay)
            days.append(CalendarDayCellViewModel(inDate: date))
            slotDateDay = slotDateDay + 1
        }
        let endDate = date.endDateOfMonth()
        let endDayIndex = endDate.endDayOfMonth()
        monthRange = (startDayIndex - 1)..<(endDayIndex + startDayIndex - 1)
    }
    
    func dayFor(date:Date) -> CalendarDayCellViewModel? {
        let startDate = date.startDay()
        return days.first(where: { $0.date == startDate })
    }
    
    func numOfDaySlot()-> Int{
        return 42
    }
    
    func canDisplayDayFor(slot: Int) -> Bool {
        return monthRange.contains(slot)
    }
    
    func canSelectDayFor(slot: Int) -> Bool {
        return monthRange.contains(slot)
    }
    
    var monthTitle: String {
        return DateFormatter.shared.monthTitleFor(date: startDate)
    }
}
