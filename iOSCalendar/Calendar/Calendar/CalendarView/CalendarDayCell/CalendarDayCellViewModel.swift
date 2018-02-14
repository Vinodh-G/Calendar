//
//  CalendarDayCellViewModel.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/15/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

class CalendarDayCellViewModel: NSObject {
    var date:Date
    init(inDate:Date) {
        date = inDate
        super.init()
    }
}
