//
//  CalendarView+AutoLayout.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/24/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

extension CalendarView {
    
    func setUpHeaderView() {
        let layoutMargins = safeAreaLayoutGuide
        headerView = CalendarHeaderView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: CalendarView.headerHieght))
        headerView.backgroundColor = UIColor.gray
        headerView.didTapOnHeaderBlock = { [unowned self] (sender) in
            self.expandMonthView(expand: self.isMonthViewVisibile)
        }
        addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: layoutMargins.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: layoutMargins.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: layoutMargins.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: CalendarView.headerHieght).isActive = true
    }
    
    func setUpWeekTitileView() {
        let layoutMargins = safeAreaLayoutGuide
        weekTitleView = WeekDaysTitleView()
        weekTitleView.backgroundColor = UIColor.gray
        addSubview(weekTitleView)
        
        weekTitleView.translatesAutoresizingMaskIntoConstraints = false
        weekTitleView.topAnchor.constraint(equalTo: layoutMargins.topAnchor, constant:CalendarView.headerHieght).isActive = true
        weekTitleView.leadingAnchor.constraint(equalTo: layoutMargins.leadingAnchor).isActive = true
        weekTitleView.trailingAnchor.constraint(equalTo: layoutMargins.trailingAnchor).isActive = true
        weekTitleView.heightAnchor.constraint(equalToConstant: CalendarView.weekTitleHieght).isActive = true
    }
    
    func setUpCollectionView() {
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
        
        let layoutMargins = safeAreaLayoutGuide

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: layoutMargins.topAnchor, constant:CalendarView.headerHieght + CalendarView.weekTitleHieght).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: layoutMargins.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: layoutMargins.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: layoutMargins.bottomAnchor).isActive = true
    }
}
