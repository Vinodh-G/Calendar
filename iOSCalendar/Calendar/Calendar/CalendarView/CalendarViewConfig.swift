//
//  CalendarViewConfig.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/25/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

internal let kHeaderHeightiPhone: CGFloat = 44.0
internal let kHeaderHeightiPad: CGFloat = 44.0
internal let kWeekTitleHeightiPhone: CGFloat = 20.0
internal let kWeekTitleHeightiPad: CGFloat = 20.0

class CalendarViewConfig {
    
    public static let defaultConfig: CalendarViewConfig = {
        let instance = CalendarViewConfig()
        return instance
    }()
    
    //Header

    var headerHieght: CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone: return kHeaderHeightiPhone
        default: return kHeaderHeightiPad
        }
    }
    
    var weekTitleTopPadding: CGFloat = 10;
    
    var weekTitleHieght: CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone: return kWeekTitleHeightiPhone
        default : return kWeekTitleHeightiPad
        }
    }
    
    //Header
    public var headerTitleColor = UIColor.darkText
    public var headerFont: UIFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
    
    public var weekTitleColor = UIColor.lightGray
    public var weekHeaderFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)

    
    // Day CollectionView
    public var dayTitleColor = UIColor(displayP3Red: 31.0/255, green: 31.5/255, blue: 31.0/255, alpha: 1)
    public var dayHighlightTitleColor = UIColor.white
    public var dayTitleFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    public var dayhighlightColor = UIColor(displayP3Red: 24.0/255, green: 165.5/255, blue: 211.0/255, alpha: 1)
}
