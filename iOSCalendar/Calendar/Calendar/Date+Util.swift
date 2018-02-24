//
//  Date+Util.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/14/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

extension Date {
    
    public func startDay() -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        guard let startDate = Calendar.current.date(from: components) else { return self }
        return startDate
    }
    
    public func startDateOfMonth() -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        components.day = 1
        guard let startDate = Calendar.current.date(from: components) else { return self }
        return startDate
    }
    
    public func endDateOfMonth() -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        guard let range = Calendar.current.range(of: .day, in: .month, for: self) else { return self }
        components.day = range.count
        guard let endDate = Calendar.current.date(from: components) else { return self }
        return endDate
    }
    
    public func weekDay() -> Int {
        var components = Calendar.current.dateComponents([.weekday], from: self)
        guard let weekDay = components.weekday else { return -1 }
        return weekDay
    }
    
    public func endDayOfMonth() -> Int {
        guard let range = Calendar.current.range(of: .day, in: .month, for: self) else { return -1 }
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
    
    public static func daysBetween(startDate:Date, endDate:Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
        guard let days = components.day else { return 0 }
        return days
    }
}
