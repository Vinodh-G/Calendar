//
//  NoEventsCell.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/25/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

class NoEventsCell: UITableViewCell {

    static let kNoEventsCellId: String = "noEventsCellId"
    
    @IBOutlet weak var noEventsTitleLabel: UILabel!
    
    var viewModel: NoEventsViewModel? {
        didSet {
            updateCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(){
        guard let cellModel = viewModel else { return }
        noEventsTitleLabel.text = cellModel.title
    }
}
