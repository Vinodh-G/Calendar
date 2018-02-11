//
//  WeekTitleView.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

class WeekTitleView: UIView {
    
    var viewModel : WeekTitleViewModel = WeekTitleViewModel()
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()    }
    
    func setUp(){
        for day in viewModel.startDay...viewModel.endDay {
            let weekdayLabel = UILabel()
            weekdayLabel.font = UIFont.systemFont(ofSize: 14)
            weekdayLabel.text = viewModel.titleFor(day: day)
            weekdayLabel.textAlignment = NSTextAlignment.center
            self.addSubview(weekdayLabel)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frm = self.bounds
        frm.origin.y += 5.0
        
        var weekDaylabelFrame = CGRect(
            x: 0.0,
            y: self.bounds.size.height / 2.0,
            width: self.bounds.size.width / 7.0,
            height: self.bounds.size.height / 2.0
        )
        
        for weekDayLabel in self.subviews {
            
            weekDayLabel.frame = weekDaylabelFrame
            weekDaylabelFrame.origin.x += weekDaylabelFrame.size.width
        }
    }
}
