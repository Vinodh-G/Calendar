//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

protocol CalendarViewDataSource {
    var months : Int { get }
    func daysFor(month:Int) -> Int
}

class CalendarViewModel: NSObject, CalendarViewDataSource {
    
    var selectedDate : Date = Date() {
        didSet {
        }
    }

    var months: Int {
        return 5
    }
    
    func daysFor(month: Int) -> Int {
        return 42
    }
}
