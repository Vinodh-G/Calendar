//
//  CalendarView.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

let kDayCellId = "DayCellId"

protocol CalendarViewDatasource {
    func startDate() -> Date
    func endDate() -> Date
}

protocol CalendarViewDelegate {
    func didSelectedDate(date:Date)
}

class CalendarView: UIView {
    
    var headerView: CalendarHeaderView!
    var weekTitleView: WeekDaysTitleView!
    var collectionView: UICollectionView!

    var delegate: CalendarViewDelegate?
    var datasource: CalendarViewDatasource? {
        didSet {
            configureViewModel()
            collectionView.reloadData()
        }
    }
    var viewModel: CalendarViewModel = CalendarViewModel()
    var isMonthViewVisibile: Bool = true
    var calendarLayout: CalendarMonthLayout {
        return self.collectionView.collectionViewLayout as! CalendarMonthLayout
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        configureViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
        configureViewModel()
    }
    
    func set(selectedDate:Date, animated:Bool) {
        viewModel.set(selectedDate: selectedDate)
        guard let selectedDay = viewModel.selectedDay else { return }
        scrollTo(selectedDay: selectedDay, animated: animated)
        
        if let month = visibleMonthForCurrentOffset() {
            updateMonthTitleFor(visibleMonth: month)
        }
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

        autoresizesSubviews = true
        translatesAutoresizingMaskIntoConstraints = true
    }
    
    func configureViewModel() {
        if let dataSource = self.datasource {
            viewModel.createMonths(for: dataSource.startDate(), and: dataSource.endDate())
        }
        
        viewModel.updateBlock = { [unowned self] (update: CalendarViewUpdate) in
            if update.isUpdated {
                self.collectionView.reloadItems(at: update.rowsUpdate)
            }
        }
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
        if let month = visibleMonthForCurrentOffset() {
            updateMonthTitleFor(visibleMonth: month)
        }
    }
    
    private func cellSize(in bounds: CGRect) -> CGSize {
        return CGSize(
            width:  bounds.size.width / 7.0,
            height: collectionView.bounds.size.height / 6.0
        )
    }
    
    func visibleMonthForCurrentOffset() -> CalendarMonthViewModel? {
        guard viewModel.months.count > 0 else { return nil }
        
        let conentOffset = self.collectionView.contentOffset
        let sectionIndex = calendarLayout.scrollDirection == .horizontal ? Int(conentOffset.x) / Int(collectionView.bounds.size.width) : Int(conentOffset.y) / Int(collectionView.bounds.size.height)
        let visbileMonth = viewModel.months[sectionIndex]
        return visbileMonth
    }
    
    func updateMonthTitleFor(visibleMonth:CalendarMonthViewModel) {
        headerView.setMonth(title: visibleMonth.monthTitle)
    }
   
    func scrollTo(selectedDay:CalendarDayCellViewModel, animated:Bool) {
        guard let month = viewModel.monthFor(date: selectedDay.date) else { return }
        guard let monthIndex = viewModel.months.index(where: { $0.startDate == month.startDate }) else { return }
        collectionView.scrollToItem(at: IndexPath(item: 0, section: monthIndex), at: .left, animated: animated)
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
}
