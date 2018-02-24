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
        let monthlabelFrame = CGRect(x: 0,
                                y: 0,
                                width: self.bounds.size.width,
                                height: self.bounds.size.height)
        
        let label = UILabel(frame: monthlabelFrame)
        label.backgroundColor = UIColor.red
        label.textAlignment = .center
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        let margins = safeAreaLayoutGuide
        label.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: kPaddingDist).isActive = true
        label.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -kPaddingDist).isActive = true
        
        return label
    }()
}
