//
//  CalendarView.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

class CalendarView: UIView {
    var headerView     : CalendarHeaderView!
    var collectionView : UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUp()
    }
    
    func setUp() {
        
        headerView = CalendarHeaderView()
        headerView.backgroundColor = UIColor.gray
        self.addSubview(headerView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
    }
    
    override open func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.headerView.frame = CGRect(x:0.0,
                                       y:0.0,
                                       width: self.frame.size.width,
                                       height: 80)
    }
}
