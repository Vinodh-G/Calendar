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
}

class DayViewModel: DayViewDatasource {
    var events: [EventViewModel] = []
}
