//
//  DaysViewModel.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/18/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

protocol DayViewDatasource {
    var events: [EventViewModel] { get set }
    var title: String { get }
    var date: Date { get set }
}

class DayViewModel: DayViewDatasource {
    
    var date: Date
    var events: [EventViewModel] = []
    
    init(date:Date) {
        self.date = date
    }
    
    var title: String {
        return DateFormatter.shared.dateTitleFor(date: date)
    }
    
    static func ==(lhs: DayViewModel, rhs: DayViewModel) -> Bool {
        return lhs.date < rhs.date
    }
}
