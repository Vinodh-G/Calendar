//
//  AgendaViewUpdate.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/19/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation

enum UpdateType: Int {
    case insert
    case delete
    case update
}

struct AgendaViewUpdate {
    var sectionsUpdate:[SectionUpdate] = []
    var rowsUpdate:[RowUpdate]  = []
}

struct SectionUpdate {
    var type: UpdateType
    var sectionIndex: IndexSet
}

struct RowUpdate {
    var type: UpdateType
    var indexPath: IndexPath
}
