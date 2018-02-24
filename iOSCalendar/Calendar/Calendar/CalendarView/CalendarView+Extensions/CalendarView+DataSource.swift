//
//  CalendarView+DataSource.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation
import UIKit

extension CalendarView : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.months.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let monthViewModel = viewModel.months[section]
        return monthViewModel.numOfDaySlot()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kDayCellId, for: indexPath) as! CalendarDayCell
        let monthViewModel = viewModel.months[indexPath.section]
        if monthViewModel.canDisplayDayFor(slot: indexPath.item) {
            let dayViewModel = monthViewModel.days[indexPath.item]
            cell.dayTitleLabel.text = dayViewModel.dayString
            
            if viewModel.selectedDay != nil, dayViewModel == viewModel.selectedDay {
                cell.set(selected: true)
            }
        }
        return cell
    }
}
