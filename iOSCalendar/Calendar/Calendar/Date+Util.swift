//
//  Date+Util.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/14/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

extension Date {
    public static func startDateOfMonthFor(date:Date) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.day = 1
        guard let startDate = Calendar.current.date(from: components) else { return date }
        return startDate
    }
    
    public static func endDateOfMonthFor(date:Date) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        guard let range = Calendar.current.range(of: .day, in: .month, for: date) else { return date }
        components.day = range.count
        guard let endDate = Calendar.current.date(from: components) else { return date }
        return endDate
    }
    
    public static func weekDayFor(date:Date) -> Int {
        var components = Calendar.current.dateComponents([.weekday], from: date)
        guard let weekDay = components.weekday else { return -1 }
        return weekDay
    }
    
    public static func endDayOfMonthFor(date:Date) -> Int {
        guard let range = Calendar.current.range(of: .day, in: .month, for: date) else { return -1 }
        return range.count
    }
    
    public func dateByAdding(days:Int) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        components.day = components.day! + days
        guard let newDate = Calendar.current.date(from: components) else { return self }
        return newDate
    }
}
