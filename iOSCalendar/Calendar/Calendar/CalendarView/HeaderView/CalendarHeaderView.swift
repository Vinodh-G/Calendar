//
//  CalendarHeaderView.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit
typealias CalendarHeaderViewActionBlock = (_ sender:Any?) -> Void
protocol CalendarHeaderViewAction {
    var didTapOnHeaderBlock:CalendarHeaderViewActionBlock? { get set }
}

class CalendarHeaderView: UIView, CalendarHeaderViewAction {
    
    var didTapOnHeaderBlock: CalendarHeaderViewActionBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CalendarHeaderView.handleTap(sender:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    lazy var monthTitleView: MonthTitleView = {
        let monthTitleFrame = CGRect(x: 0,
                                  y: 0,
                                  width: self.bounds.size.width,
                                  height: self.bounds.size.height)
        
        let view = MonthTitleView(frame: monthTitleFrame)
        self.addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        monthTitleView.layoutIfNeeded()
        monthTitleView.backgroundColor = UIColor.blue
    }
 
    @objc func handleTap(sender:Any?) {
        if didTapOnHeaderBlock != nil {
            didTapOnHeaderBlock!(sender)
        }
    }
    
    func setMonth(title:String) {
        monthTitleView.monthLabel.text = title
    }
}
