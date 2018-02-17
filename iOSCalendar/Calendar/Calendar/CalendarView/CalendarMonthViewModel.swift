//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

protocol CalendarMonthViewDataSource {
    var  dates: [CalendarDayCellViewModel] { get set }
    func numOfDaySlot() -> Int
    func dayStringFor(slot: Int) -> String
    var  monthTitle: String { get }
}

class CalendarMonthViewModel: CalendarMonthViewDataSource {
    
    var date : Date
    var dates: [CalendarDayCellViewModel] = []
    var monthRange : Range<Int> = 0..<1
    
    init(inDate:Date) {
        date = inDate
        generateDatesForMonthFrom(date: date)
    }
    
    func generateDatesForMonthFrom(date:Date) {
        // TODO: Generate the 42 CalendarDayCellViewModel  for the available month slots
        // record the date range for the month so that only month date is displayed.
        let startDate = Date.startDateOfMonthFor(date: date)
        let startDayIndex = Date.weekDayFor(date: startDate)
        var slotDateDay =  0 - startDayIndex + 1
        for _ in stride(from: 0, to: 42, by: 1) {
            let date = startDate.dateByAdding(days: slotDateDay)
            dates.append(CalendarDayCellViewModel(inDate: date))
            slotDateDay = slotDateDay + 1
        }
        let endDate = Date.endDateOfMonthFor(date: date)
        let endDayIndex =  Date.endDayOfMonthFor(date: endDate)
        monthRange = (startDayIndex - 1)..<(endDayIndex + startDayIndex - 1)
    }
    
    func numOfDaySlot()-> Int{
        return 42
    }
    
    func dayStringFor(slot:Int) -> String {
        var dayString = ""
        if monthRange.contains(slot) {
            dayString = dayString.appending("\(slot + 1 - monthRange.lowerBound)")
            return  dayString
        } else{
            return dayString
        }
    }
    
    var monthTitle: String {
        return DateFormatter.shared.monthTitleFor(date: date)
    }
}
