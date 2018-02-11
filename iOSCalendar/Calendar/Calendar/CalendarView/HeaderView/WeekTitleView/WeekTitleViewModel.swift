//
//  WeekTitleViewModel.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

protocol WeekTitleDataSource {
    var startDay : Int { get }
    var endDay : Int { get }
    var numOfDays:Int { get }
    func titleFor(day:Int) -> String
}

enum TitleType : Int {
    case firstLetter = 0
    case firstThreeLetter
}

class WeekTitleViewModel: NSObject, WeekTitleDataSource{
    
    let formatter = DateFormatter.shared
    let titleType : TitleType = .firstLetter
    
    var numOfDays: Int {
        return 7
    }
    
    var startDay: Int {
        return 0
    }
    
    var endDay: Int {
        return 6
    }
    
    func titleFor(day: Int) -> String {
        let weekDay = formatter.shortWeekdaySymbols[(day % 7)]
        switch titleType {
        case .firstLetter:
            if let ch = weekDay.first {
                return String(describing:ch)
            }
            return weekDay
            
        case .firstThreeLetter:
            return weekDay
        }
    }
    
    
}
