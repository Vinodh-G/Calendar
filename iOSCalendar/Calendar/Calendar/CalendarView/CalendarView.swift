//
//  CalendarView.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

let kDayCellId = "DayCellId"

class CalendarView: UIView {
    var headerView     : CalendarHeaderView!
    var collectionView : UICollectionView!
    var viewModel      : CalendarViewDataSource = CalendarViewModel()
    
    var calendarLayout : CalendarMonthLayout {
        return self.collectionView.collectionViewLayout as! CalendarMonthLayout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUp()
    }
    
    func setUp() {
        clipsToBounds = true
        headerView = CalendarHeaderView()
        headerView.backgroundColor = UIColor.gray
        self.addSubview(headerView)
        
        let layout = CalendarMonthLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = cellSize(in: self.bounds)

        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(UINib(nibName: "CalendarDayCell", bundle: nil), forCellWithReuseIdentifier: kDayCellId)
        self.addSubview(collectionView)
    }
    
    override open func layoutSubviews() {
        
        super.layoutSubviews()
        headerView.frame = CGRect(x:0.0,
                                  y:0.0,
                                  width: bounds.size.width,
                                  height: 80)
        
        collectionView.frame = CGRect(x: 0.0,
                                      y: headerView.bounds.size.height,
                                      width: bounds.size.width,
                                      height: bounds.size.height - headerView.bounds.size.height)
        
        calendarLayout.itemSize = cellSize(in: self.bounds)
        collectionView.invalidateIntrinsicContentSize()
    }
    
    private func cellSize(in bounds: CGRect) -> CGSize {
        return CGSize(
            width:  bounds.size.width / 7.0,
            height: (bounds.size.height - headerView.bounds.size.height) / 6.0 > CalendarView.dayCellMaxHeight ? CalendarView.dayCellMaxHeight : (bounds.size.height - headerView.bounds.size.height) / 6.0
        )
    }
}

extension UICollectionView {
    override open var contentSize : CGSize{
        didSet {
            print(contentSize)
        }
    }
}
