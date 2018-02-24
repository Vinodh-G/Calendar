//
//  CalendarView+Delegate.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation
import UIKit

extension CalendarView : UICollectionViewDelegate, UIScrollViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let monthViewModel = viewModel.months[indexPath.section]
        guard monthViewModel.canSelectDayFor(slot: indexPath.item) else { return }
        
        let dayViewModel = monthViewModel.days[indexPath.item]
        viewModel.update(newSelectedDay: dayViewModel)
        
        if delegate != nil {
            delegate?.didSelectedDate(date: dayViewModel.date)
        }
    }
    
    
    //Mark: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let month = visibleMonthForCurrentOffset() {
            updateMonthTitleFor(visibleMonth: month)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if let month = visibleMonthForCurrentOffset() {
            updateMonthTitleFor(visibleMonth: month)
        }
    }
}
