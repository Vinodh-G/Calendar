//
//  CalendarDayCell.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

class CalendarDayCell: UICollectionViewCell {
    
    @IBOutlet weak var dayTitleLabel: UILabel!
    @IBOutlet weak var highlightView: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayTitleLabel.text = nil
        highlightView.isHidden = true
    }
    
    func set(selected:Bool) {
        highlightView.isHidden = !selected
    }
}
