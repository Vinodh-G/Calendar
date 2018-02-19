//
//  CalendarDayCellViewModel.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/15/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

class CalendarDayCellViewModel {
    var date:Date
    init(inDate:Date) {
        date = inDate
    }
    
    var dayString : String {
        let components = Calendar.current.dateComponents([.day], from: date)
        
        return "\(components.day as! Int)"
    }
}
