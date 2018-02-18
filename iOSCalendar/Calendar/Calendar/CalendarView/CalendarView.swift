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
    var headerView: CalendarHeaderView!
    var weekTitleView: WeekDaysTitleView!
    var collectionView: UICollectionView!
    var viewModel: CalendarViewModel = CalendarViewModel()
    var isMonthViewVisibile: Bool = true
    var calendarLayout: CalendarMonthLayout {
        return self.collectionView.collectionViewLayout as! CalendarMonthLayout
    }
    
    var startPoint     : CGPoint = CGPoint.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUp()
        // TODO: to be removed, added just for testing.
        viewModel.startDate = Date()
        viewModel.endDate = viewModel.startDate.dateByAdding(months: 48)
        viewModel.createMonths(for: viewModel.startDate, and: viewModel.endDate)
    }
    
    func setUp() {
        clipsToBounds = true
        headerView = CalendarHeaderView()
        headerView.backgroundColor = UIColor.gray
        weak var weakSelf = self
        headerView.didTapOnHeaderBlock = {(sender) in
            if let strongSelf = weakSelf {
                strongSelf.expandMonthView(expand: !strongSelf.isMonthViewVisibile)
            }
        }
        addSubview(headerView)
        
        weekTitleView = WeekDaysTitleView()
        weekTitleView.backgroundColor = UIColor.gray
        addSubview(weekTitleView)
        
        let layout = CalendarMonthLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(UINib(nibName: "CalendarDayCell", bundle: nil), forCellWithReuseIdentifier: kDayCellId)
        addSubview(collectionView)
        addPanGesture()
        
        autoresizesSubviews = true
        translatesAutoresizingMaskIntoConstraints = true
    }
    
    override open func layoutSubviews() {
        
        super.layoutSubviews()
        headerView.frame = CGRect(x:0.0,
                                  y:0.0,
                                  width: bounds.size.width,
                                  height: 44)
        
        weekTitleView.frame = CGRect(x:0.0,
                                     y:headerView.bounds.size.height,
                                     width: bounds.size.width,
                                     height: 24)
        
        collectionView.frame = CGRect(x: 0.0,
                                      y: headerView.bounds.size.height + weekTitleView.bounds.size.height,
                                      width: bounds.size.width,
                                      height: bounds.size.height - (headerView.bounds.size.height + weekTitleView.bounds.size.height))
        
        calendarLayout.itemSize = cellSize(in: self.bounds)
        collectionView.invalidateIntrinsicContentSize()
        let month = visibleMonthForCurrentOffset()
        updateCalendarViewFor(visibleMonth: month)
    }
    
    private func cellSize(in bounds: CGRect) -> CGSize {
        return CGSize(
            width:  bounds.size.width / 7.0,
            height: collectionView.bounds.size.height / 6.0
        )
    }
    
    func visibleMonthForCurrentOffset() -> CalendarMonthViewDataSource {
        let conentOffset = self.collectionView.contentOffset
        let sectionIndex = calendarLayout.scrollDirection == .horizontal ? Int(conentOffset.x) / Int(collectionView.bounds.size.width) : Int(conentOffset.y) / Int(collectionView.bounds.size.height)
        let visbileMonth = viewModel.months[sectionIndex]
        return visbileMonth
    }
    
    func updateCalendarViewFor(visibleMonth:CalendarMonthViewDataSource) {
        headerView.setMonth(title: visibleMonth.monthTitle)
    }
    
    func expandMonthView(expand:Bool) {
        
        let newHeight = expand ? 343 : headerView.bounds.size.height
        let newFrame = CGRect(x: self.frame.origin.x,
                              y: self.frame.origin.y,
                              width: self.frame.width,
                              height: newHeight)
        self.isMonthViewVisibile = expand
                
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = newFrame
        },
                       completion:nil)
    }
}

extension CalendarView {
    
    func addPanGesture() {
        let pangesture = UIPanGestureRecognizer(target: self, action: #selector(CalendarView.handlePan(gesture:)))
        addGestureRecognizer(pangesture)
    }
    
    @objc func handlePan(gesture:UIPanGestureRecognizer) {
        let point = gesture.location(in: self)
        let translation = gesture.translation(in: self)
        switch gesture.state {
        case .began:
            startPoint = point
        case .changed:
            print(translation)
        default: break
        }
    }
}
