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
    func numOfDaySlotFor(month: Int) -> Int
    func dayStringFor(slot: Int) -> String
}

class CalendarMonthViewModel: NSObject, CalendarMonthViewDataSource {
    
    var selectedDate: Date?
    var dates: [CalendarDayCellViewModel] = []
    var daysRange : Range<Int> = 0..<1

    func generateDatesForMonthFrom(date:Date) {
        // TODO: Generate the 42 CalendarDayCellViewModel  for the available month slots
        // record the date range for the month so that only month date is displayed.
    }
    
    func numOfDaySlotFor(month:Int) -> Int{
        return 42
    }
    
    func dayStringFor(slot:Int) -> String {
        var dayString = ""
        if daysRange.contains(slot) {
            dayString = dayString.appending("\(slot + 1 - daysRange.lowerBound)")
            return  dayString
        } else{
            return dayString
            
        }
    }
    
    func updateDayIndexFor(date:Date) {
        // Get the start date of the month so we can get the start Day index, i.e. from which week day the month starts
        let startDate = Date.startDateOfMonthFor(date: date)
        let startDayIndex = Date.weekDayFor(date: startDate)
        // Get the end date so that we can get the ranges of days slots in from total 42 slots
        let endDate = Date.endDateOfMonthFor(date: date)
        let endDayIndex =  Date.endDayOfMonthFor(date: endDate)
        
        // start index -1 because the caollection index starts with 0 but weekday index starts with 1, 
        daysRange = (startDayIndex - 1)..<(endDayIndex + startDayIndex - 1)
    }
}
