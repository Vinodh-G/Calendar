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

extension DateFormatter {

    static let shared : DateFormatter = {
        let instance = DateFormatter()
        instance.dateStyle = .medium
        instance.dateFormat = kFullDateFormat
        return instance
    }()
}
