//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/15/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

protocol CalendarViewDatasource {
    var startDate: Date { get set }
    var endDate: Date { get set }
    var months: [CalendarMonthViewDataSource] { get }
}

class CalendarViewModel: CalendarViewDatasource {
    
    var startDate: Date = Date()
    var endDate: Date = Date()
    
    var months: [CalendarMonthViewDataSource] = []
    
    func createMonths(for inStartdate:Date, and inEndDate:Date) {
        startDate = inStartdate
        endDate = inEndDate
        let monthsCount = Date.monthsBetween(startDate: startDate, endDate: endDate)
        for monthIndex in 0 ..< monthsCount {
            let date = startDate.dateByAdding(months: monthIndex)
            let monthVM = CalendarMonthViewModel(inDate: date)
            months.append(monthVM)
        }
    }
}
