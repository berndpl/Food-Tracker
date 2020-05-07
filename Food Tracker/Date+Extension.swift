//
//  Date+Extension.swift
//  TrackerKit
//
//  Created by Bernd Plontsch on 07.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//
import Foundation

extension Date {
    var short:String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        
        return dateFormatter.string(from: self)
    }

    var shortRelativeWithTime:String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        
        return dateFormatter.string(from: self)
    }

    var shortRelative:String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.doesRelativeDateFormatting = true
        
        return dateFormatter.string(from: self)
    }
}
