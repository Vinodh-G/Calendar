//
//  AgendaViewConfig.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/25/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

internal let kCalendarMonthViewHeightFactoriPhone: CGFloat = 0.48
internal let kCalendarMonthViewHeightFactoriPad: CGFloat = 0.33
internal let kDefaultTableCellHeight: CGFloat = 44.0
internal let kAgendaViewHeaderHeightiPhone: CGFloat = 74.0
internal let kAgendaViewHeaderHeightiPad: CGFloat = 78.0

class AgendaViewConfig {
    
    public static let defaultConfig : AgendaViewConfig = {
        let instance = AgendaViewConfig()
        return instance
    }()
    
    //Header
    
    var heightFactor : CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone : return kCalendarMonthViewHeightFactoriPhone
        default : return kCalendarMonthViewHeightFactoriPad
        }
    }
    
    var weekTitleHieght : CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone : return kWeekTitleHeightiPhone
        default : return kWeekTitleHeightiPad
        }
    }
    
    var headerHieght : CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone : return kAgendaViewHeaderHeightiPhone
        default : return kAgendaViewHeaderHeightiPad
        }
    }
    
    //Event Cell
    public var eventTitleColor = UIColor.black
    public var eventTitleFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
    public var eventDetailTitleColor = UIColor.darkGray
    public var eventDetailTitleFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    
    public var startTimeLabelColor = UIColor.black
    public var startTimeLabelFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .semibold)

    public var endTimeLabelColor = UIColor.darkGray
    public var endTimeLabelFont: UIFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
    
    public var statusViewColorConfirmed = UIColor(displayP3Red: 40.0/255, green: 206.5/255, blue: 102.0/255, alpha: 1)
    public var statusViewColorNotConfirmed = UIColor(displayP3Red: 144.0/255, green: 152.5/255, blue: 179.0/255, alpha: 1)

    //Agenda
    public var agendaviewShadowRadius: CGFloat = 2
    public var agendaviewShadowOpacity: Float = 0.3
    public var agendaviewShadowOffset = CGSize(width: 0, height: -4)
}
