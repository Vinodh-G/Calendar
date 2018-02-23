//
//  Date+Util.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/14/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

extension Date {
    
    public func startDateFor(date:Date) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.hour = 0
        components.minute = 0
        components.second = 0
        guard let startDate = Calendar.current.date(from: components) else { return date }
        return startDate
    }
    
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
        var components = DateComponents()
        components.day = days
        guard let newDate = Calendar.current.date(byAdding: components, to: self) else { return self }
        return newDate
    }
    
    public func dateByAdding(months:Int) -> Date {
        var components = DateComponents()
        components.month = months
        guard let newDate = Calendar.current.date(byAdding: components, to: self) else { return self}
        return newDate
    }
    
    public static func monthsBetween(startDate:Date, endDate:Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: startDate, to: endDate)
        var months = 0
        if components.year! > 0 {
            months = components.year! * 12
        } else if components.month! > 0  {
            months = components.month!
        }
        return months
    }    
}
