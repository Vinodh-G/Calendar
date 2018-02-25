//
//  AgendaViewController+Decorator.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/25/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit


extension AgendaViewController {
    func addShadow(to view:UIView) {
        
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: -4)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.3
    }
}
