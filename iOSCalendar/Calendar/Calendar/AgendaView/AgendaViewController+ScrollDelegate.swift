//
//  AgendaViewController+ScrollDelegate.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/24/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

extension AgendaViewController : UIScrollViewDelegate {
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollCalendarViewForVisibleDay()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollCalendarViewForVisibleDay()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollCalendarViewForVisibleDay()
    }
    
    func scrollCalendarViewForVisibleDay() {
        if let topCellIndexPath = self.tableView.indexPathsForVisibleRows?[0] {
            let date = viewModel.dateFor(indexPath: topCellIndexPath)
            guard let calendarView = calendarMonthView else { return }
            calendarView.scrollTo(date: date, animated: true)
        }
    }
}