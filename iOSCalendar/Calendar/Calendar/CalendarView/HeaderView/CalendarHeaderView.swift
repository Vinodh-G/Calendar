//
//  CalendarHeaderView.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

class CalendarHeaderView: UIView {
    
    lazy var weekTitleView : WeekTitleView = {
        
        let weekDayFrame = CGRect(x: 0,
                                  y: self.bounds.size.height - 40,
                                  width: self.bounds.size.width,
                                  height: 40)
        
        let view = WeekTitleView(frame: weekDayFrame)
        self.addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        weekTitleView.layoutIfNeeded()
    }
}
