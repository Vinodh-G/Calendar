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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
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
        
        if let indexPaths = tableView.indexPathsForVisibleRows,
            indexPaths.count > 0 {
            let topCellIndexPath = indexPaths[0] 
            let date = viewModel.dateFor(indexPath: topCellIndexPath)
            guard let calendarView = calendarMonthView else { return }
            calendarView.scrollTo(date: date, animated: true)
        }
    }
}

extension AgendaViewController {
    func expandCalendarMonthView(expand:Bool) {
        
        let topHeight = expand ? view.bounds.size.height * AgendaViewConfig.defaultConfig.heightFactor : AgendaViewConfig.defaultConfig.headerHieght
        let animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.8) {
            self.view.bringSubview(toFront: self.agendaContainerView)
            self.agendaViewTopConstriant.constant = topHeight
            self.view.layoutIfNeeded()
        }
        animator.startAnimation()
    }
}
