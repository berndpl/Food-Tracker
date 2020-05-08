//
//  Date+Extension.swift
//  TrackerKit
//
//  Created by Bernd Plontsch on 09.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import Foundation

extension Date {

    var isToday:Bool {
        return Calendar.current.isDateInToday(self)
    }
    var isYesterday:Bool {
        return Calendar.current.isDateInYesterday(self)
    }

}
