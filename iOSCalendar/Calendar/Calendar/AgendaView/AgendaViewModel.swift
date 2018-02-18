//
//  AgendaViewModel.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/18/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

struct DateRange {
    var start:Date
    var months:Int = 0
    var years:Int = 0
}

typealias loadEventsCompletionBlock = (_ loadEventsResponse:loadEventsResponseParam) -> Void

struct loadEventsRequestParam{
    let dateRange : DateRange
}

struct loadEventsResponseParam{
    let success: Bool
    let events: [DayViewDatasource]?
    let updates: [String:String]
    let error: Error?
}

protocol AgendaViewDataSource {
    var days:[DayViewDatasource] { get set }
    func loadEvents(requestParam:loadEventsRequestParam, completionBlock:loadEventsCompletionBlock)
}

class AgendaViewModel: AgendaViewDataSource{
    
    var days: [DayViewDatasource] = []
    
    func loadEvents(requestParam:loadEventsRequestParam, completionBlock:loadEventsCompletionBlock) {
        
    }
}
