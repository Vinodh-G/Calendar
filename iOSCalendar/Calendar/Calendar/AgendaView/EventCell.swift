//
//  EventCell.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/25/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    static let kEventCellId: String = "eventCellId"
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDetailLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    
    var viewModel: EventViewDatasource?{
        didSet {
            updateEventDetails()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        eventTitleLabel.text = nil
        eventDetailLabel.text = nil
        startTimeLabel.text = nil
        endTimeLabel.text = nil
        statusView.backgroundColor = statusView.superview?.backgroundColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateEventDetails(){
        guard let cellModel = viewModel else { return }
        eventTitleLabel.text = cellModel.title
        eventDetailLabel.text = cellModel.detail
        if cellModel.isAllDay {
            startTimeLabel.text = cellModel.alldayTitle
        } else {
            startTimeLabel.text = cellModel.startDate
            endTimeLabel.text = cellModel.endDate
        }
        statusView.backgroundColor = colorFor(status: cellModel.status)
    }
    
    func colorFor(status:EventViewModelStatus) -> UIColor {
        switch status {
        case .confirmed:
            return .green
        default:
            return .gray
        }
    }
}
