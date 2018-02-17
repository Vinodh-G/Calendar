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
        
    }
    
    //Mark: UIScrollViewDelegate
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let month = visibleMonthForCurrentOffset()
        updateCalendarViewFor(visibleMonth: month)
    }
}
