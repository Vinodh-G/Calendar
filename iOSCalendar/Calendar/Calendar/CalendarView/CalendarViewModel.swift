//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/15/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

typealias CalendarViewUpdateBlock = (_ update:CalendarViewUpdate) -> Void

class CalendarViewModel {
    
    var startDate: Date = Date()
    var endDate: Date = Date()
    var selectedDay: CalendarDayCellViewModel?
    var updateBlock: CalendarViewUpdateBlock?
    var months: [CalendarMonthViewModel] = []
    
    public func createMonths(for inStartdate:Date, and inEndDate:Date) {
        guard inEndDate >= inStartdate else { return }
        startDate = inStartdate
        endDate = inEndDate
        let monthsCount = Date.monthsBetween(startDate: startDate, endDate: endDate)
        for monthIndex in 0 ..< monthsCount {
            let date = startDate.dateByAdding(months: monthIndex)
            let monthVM = CalendarMonthViewModel(inDate: date)
            months.append(monthVM)
        }
    }
    
    public func monthFor(date:Date) -> CalendarMonthViewModel? {
        guard date > startDate || date < endDate else { return nil }
        let startMonthDate = date.startDateOfMonth()
        
        return months.first(where: { $0.startDate == startMonthDate })
    }
    
    func update(newSelectedDay: CalendarDayCellViewModel) {

        guard newSelectedDay != selectedDay else { return }
        
        var viewUpdate = CalendarViewUpdate()
        if selectedDay != nil, let oldIndexPath = indexPathFor(day: selectedDay!) {
            viewUpdate.isUpdated = true
            viewUpdate.rowsUpdate.append(oldIndexPath)
        }
        
        if let newIndexPath = indexPathFor(day: newSelectedDay) {
            viewUpdate.isUpdated = true
            viewUpdate.rowsUpdate.append(newIndexPath)
        }
        selectedDay = newSelectedDay
        if let updateCallBack = updateBlock {
            updateCallBack(viewUpdate)
        }
    }
    
    private func indexPathFor(day:CalendarDayCellViewModel) -> IndexPath?{
        guard let month = monthFor(date: day.date) else { return nil }
        guard let monthIndex = months.index(where: {$0.startDate == month.startDate}) else { return nil }
        guard let dayIndex = month.days.index(where: {$0.date == day.date}) else { return nil }
        return IndexPath(item: dayIndex, section: monthIndex)
    }
    
    func set(selectedDate:Date){
        guard let month = monthFor(date: selectedDate) else { return }
        guard let day = month.dayFor(date: selectedDate) else { return }
        selectedDay = day 
    }
}

struct CalendarViewUpdate {
    var isUpdated: Bool = false
    var rowsUpdate:[IndexPath]  = []
}
