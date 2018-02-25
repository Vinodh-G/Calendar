//
//  AgendaViewController+Decorator.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/25/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit


extension AgendaViewController {
    func addShadow(to subView:UIView) {
        view.bringSubview(toFront: subView)
        subView.layer.masksToBounds = false
        subView.layer.shadowOffset = AgendaViewConfig.defaultConfig.agendaviewShadowOffset
        subView.layer.shadowRadius = AgendaViewConfig.defaultConfig.agendaviewShadowRadius
        subView.layer.shadowOpacity = AgendaViewConfig.defaultConfig.agendaviewShadowOpacity
    }
}
