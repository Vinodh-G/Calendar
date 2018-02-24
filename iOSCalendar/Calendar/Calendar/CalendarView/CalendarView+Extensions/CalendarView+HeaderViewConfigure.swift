//
//  CalendarView+HeaderViewConfigure.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/24/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

extension CalendarView : CalendarHeaderViewConfigure {
    
    func configureRight(barButton: UIButton) {
        headerView.rightButton = barButton
    }
    
    func configureLeft(barButton: UIButton) {
        headerView.leftButton = barButton
    }
    
    
}
