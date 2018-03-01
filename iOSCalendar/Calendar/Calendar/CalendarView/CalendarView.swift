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
    func didTapOnHeader()
}

protocol CalendarHeaderViewConfigure {
    func configureRight(barButton: UIButton)
    func configureLeft(barButton: UIButton)
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
    var defaultConfig: CalendarViewConfig = CalendarViewConfig.defaultConfig
    
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
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        calendarLayout.itemSize = cellSize(in: self.bounds)
        collectionView.invalidateIntrinsicContentSize()
        if let month = viewModel.currentVisibleMonth {
            updateMonthTitleFor(visibleMonth: month)
        }
    }
    
    //MARK: Interface
    func set(selectedDate: Date, animated: Bool) {
        viewModel.set(selectedDate: selectedDate)
        guard let selectedDay = viewModel.selectedDay else { return }
        scrollTo(day: selectedDay, animated: animated)
        
        if let month = updatedVisibleMonthForCurrentOffset() {
            updateMonthTitleFor(visibleMonth: month)
        }
    }
    
    func scrollTo(date: Date, animated: Bool) {
        guard let month = viewModel.monthFor(date: date) else { return }
        guard let monthIndex = viewModel.months.index(where: { $0.startDate == month.startDate }) else { return }
        collectionView.scrollToItem(at: IndexPath(item: 0, section: monthIndex), at: .left, animated: animated)
    }
    
    func reloadCalendarView() {
        collectionView.reloadData()
        if let visibleMonth = viewModel.currentVisibleMonth {
            scrollTo(date: visibleMonth.startDate, animated: false)
        }
    }
    
    //MARK: Private
    
    private func setUp() {
        clipsToBounds = true
        setUpHeaderView()
        setUpWeekTitileView()
        setUpCollectionView()
    }
    
    
    private func configureViewModel() {
        if let dataSource = self.datasource {
            viewModel.createMonths(for: dataSource.startDate(), and: dataSource.endDate())
        }
        
        viewModel.updateBlock = { [unowned self] (update: CalendarViewUpdate) in
            if update.isUpdated {
                self.collectionView.reloadItems(at: update.rowsUpdate)
            }
        }
    }
    
    private func cellSize(in bounds: CGRect) -> CGSize {
        return CGSize(
            width:  bounds.size.width / 7.0,
            height: collectionView.bounds.size.height / 6.0
        )
    }
    
    private func scrollTo(day: CalendarDayCellViewModel, animated: Bool) {
        guard let month = viewModel.monthFor(date: day.date) else { return }
        guard let monthIndex = viewModel.months.index(where: { $0.startDate == month.startDate }) else { return }
        collectionView.scrollToItem(at: IndexPath(item: 0, section: monthIndex), at: .left, animated: animated)
    }
    
    internal func updatedVisibleMonthForCurrentOffset() -> CalendarMonthViewModel?{
        guard viewModel.months.count > 0 else { return nil }

        let conentOffset = self.collectionView.contentOffset
        let sectionIndex = calendarLayout.scrollDirection == .horizontal ? Int(conentOffset.x) / Int(collectionView.bounds.size.width) : Int(conentOffset.y) / Int(collectionView.bounds.size.height)
        viewModel.currentVisibleMonth = viewModel.months[sectionIndex]
        return viewModel.currentVisibleMonth
    }
    
//    internal func visibleMonthForCurrentOffset() -> CalendarMonthViewModel? {
//        guard viewModel.months.count > 0 else { return nil }
//
//        let conentOffset = self.collectionView.contentOffset
//        let sectionIndex = calendarLayout.scrollDirection == .horizontal ? Int(conentOffset.x) / Int(collectionView.bounds.size.width) : Int(conentOffset.y) / Int(collectionView.bounds.size.height)
//        let visbileMonth = viewModel.months[sectionIndex]
//        return visbileMonth
//    }
    
    internal func updateMonthTitleFor(visibleMonth:CalendarMonthViewModel) {
        headerView.setMonth(title: visibleMonth.monthTitle)
    }
}
