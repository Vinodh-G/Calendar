//
//  CalendarEvent.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/18/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

class CalendarEvent  {
    var startDate: Date
    var endDate: Date
    var title: String
    var isAllDay: Bool = false
    var attendees: [EventAttendee] = []
    init(startDate:Date, endDate:Date, title:String) {
        self.startDate = startDate
        self.endDate = endDate
        self.title = title
    }
}

class EventAttendee {
    var name: String
    var emailId: String
    var avatarUrl: String
    init(name:String, emailId:String, avatarUrl:String) {
        self.name = name
        self.emailId = emailId
        self.avatarUrl = avatarUrl
    }
}
