//
//  CalendarHeaderView.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit
typealias CalendarHeaderViewActionBlock = (_ sender:Any?) -> Void
protocol CalendarHeaderViewAction {
    var didTapOnHeaderBlock:CalendarHeaderViewActionBlock? { get set }
}

let kPaddingDist: CGFloat = 20.0

class CalendarHeaderView: UIView, CalendarHeaderViewAction {
    
    var didTapOnHeaderBlock: CalendarHeaderViewActionBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CalendarHeaderView.handleTap(sender:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    lazy var monthTitleView: MonthTitleView = {
        let monthTitleFrame = CGRect(x: 0,
                                  y: 0,
                                  width: self.bounds.size.width,
                                  height: self.bounds.size.height)
        
        let view = MonthTitleView(frame: monthTitleFrame)
        self.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let margins = safeAreaLayoutGuide
        view.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: margins.leadingAnchor,
                                      constant: CalendarHeaderView.buttonSize.width + CalendarHeaderView.marginPadding).isActive = true
        view.trailingAnchor.constraint(equalTo: margins.trailingAnchor,
                                       constant: -(CalendarHeaderView.buttonSize.width + CalendarHeaderView.marginPadding)).isActive = true
        return view
    }()
    
    var leftButton: UIButton? {
        
        didSet {
            guard let button = leftButton else { return }
            self.addSubview(button)
            let margins = layoutMarginsGuide
            button.translatesAutoresizingMaskIntoConstraints = false
            button.leadingAnchor.constraint(equalTo: margins.leadingAnchor,  constant:0).isActive = true
            button.heightAnchor.constraint(equalToConstant: CalendarHeaderView.buttonSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: CalendarHeaderView.buttonSize.width).isActive = true
            button.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        }
    }
    
    var rightButton: UIButton? {
        
        didSet {
            guard let button = rightButton else { return }
            self.addSubview(button)
            let margins = layoutMarginsGuide
            button.translatesAutoresizingMaskIntoConstraints = false
            button.trailingAnchor.constraint(equalTo: margins.trailingAnchor,  constant:0).isActive = true
            button.heightAnchor.constraint(equalToConstant: CalendarHeaderView.buttonSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: CalendarHeaderView.buttonSize.width).isActive = true
            button.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        monthTitleView.layoutIfNeeded()
        monthTitleView.backgroundColor = UIColor.blue
    }
 
    @objc func handleTap(sender:Any?) {
        if didTapOnHeaderBlock != nil {
            didTapOnHeaderBlock!(sender)
        }
    }
    
    func setMonth(title:String) {
        monthTitleView.monthLabel.text = title
    }
}

extension CalendarHeaderView {
    static var buttonSize : CGSize {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone : return CGSize(width: 30, height: 30)
        default : return CGSize(width: 40, height: 40)
        }
    }
    
    static var marginPadding : CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone : return 20
        default : return 20
        }
    }
}
