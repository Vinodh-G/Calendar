//
//  SharedDateFormatter.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

public let kFullDateFormat = "yyyy-MM-dd HH:mm:ss"
public let kDateFormat = "yyyy-MM-dd"
public let kDayTitleFormat = "EEE, d MMM-yy"
public let k24TimeFormat = "HH:mm"
public let kFullMonthNameFormat = "MMMM"
extension DateFormatter {

    public static let shared : DateFormatter = {
        let instance = DateFormatter()
        instance.dateStyle = .medium
        instance.dateFormat = kFullDateFormat
        return instance
    }()
    
    public func monthTitleFor(date:Date) -> String {
        self.dateFormat = kFullMonthNameFormat
        let monthTitle = self.string(from: date)
        return monthTitle
    }
    
    public func dateTitleFor(date:Date) -> String {
        self.dateFormat = kDayTitleFormat
        let dateTitle = self.string(from: date)
        return dateTitle
    }
    
    public func timeStringFor(date:Date, format:String) -> String {
        self.dateFormat = format
        let timeString = self.string(from: date)
        return timeString
    }
}
