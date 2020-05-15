//
//  Presets.swift
//  TrackerKit
//
//  Created by Bernd Plontsch on 13.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import Foundation

public struct Preset:Codable, CustomDebugStringConvertible {
    public var title:String
    public let colorLiteral:String
    public let id:UUID = UUID()
    public var calories:Double
    
    init(title: String, calories: Double, colorLiteral:String) {
        self.title = title
        self.calories = calories
        self.colorLiteral = colorLiteral
    }
    
    public var caloriesLabel:String {
        let measurement = Measurement(value: calories, unit: UnitEnergy.calories)
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 0
        return formatter.string(from: measurement)
    }
    public var debugDescription: String {
        return "Preset \(title) \(calories)"
    }
}
