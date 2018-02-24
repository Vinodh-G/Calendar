//
//  CalendarView.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

let kDayCellId = "DayCellId"
let kHeaderHeightiPhone: CGFloat = 44.0
let kHeaderHeightiPad: CGFloat = 64.0
let kWeekTitleHeightiPhone: CGFloat = 20.0
let kWeekTitleHeightiPad: CGFloat = 24.0

protocol CalendarViewDatasource {
    func startDate() -> Date
    func endDate() -> Date
}

protocol CalendarViewDelegate {
    func didSelectedDate(date:Date)
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
    
    func set(selectedDate: Date, animated: Bool) {
        viewModel.set(selectedDate: selectedDate)
        guard let selectedDay = viewModel.selectedDay else { return }
        scrollTo(day: selectedDay, animated: animated)
        
        if let month = visibleMonthForCurrentOffset() {
            updateMonthTitleFor(visibleMonth: month)
        }
    }
    
    func setUp() {
        clipsToBounds = true
        setUpHeaderView()
        setUpWeekTitileView()
        setUpCollectionView()
        backgroundColor = .black
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
        layoutIfNeeded()
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
   
    private func scrollTo(day: CalendarDayCellViewModel, animated: Bool) {
        guard let month = viewModel.monthFor(date: day.date) else { return }
        guard let monthIndex = viewModel.months.index(where: { $0.startDate == month.startDate }) else { return }
        collectionView.scrollToItem(at: IndexPath(item: 0, section: monthIndex), at: .left, animated: animated)
    }
    
    func scrollTo(date: Date, animated: Bool) {
        guard let month = viewModel.monthFor(date: date) else { return }
        guard let monthIndex = viewModel.months.index(where: { $0.startDate == month.startDate }) else { return }
        collectionView.scrollToItem(at: IndexPath(item: 0, section: monthIndex), at: .left, animated: animated)
    }
    
    func expandMonthView(expand:Bool) {
        
        let newHeight = expand ? 343 : CalendarView.headerHieght
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
    static var headerHieght : CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone : return kHeaderHeightiPhone
        default : return kHeaderHeightiPad
        }
    }
    
    static var weekTitleHieght : CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone : return kWeekTitleHeightiPhone
        default : return kWeekTitleHeightiPad
        }
    }
}
