//
//  MonthTitleView.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/17/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

class MonthTitleView: UIView {
    lazy var monthLabel: UILabel = {
        let monthlabelFrame = CGRect(x: 20,
                                y: 0,
                                width: self.bounds.size.width - 40,
                                height: self.bounds.size.height)
        
        let label = UILabel(frame: monthlabelFrame)
        label.backgroundColor = UIColor.red
        label.textAlignment = .center
        self.addSubview(label)
        return label
    }()
}
