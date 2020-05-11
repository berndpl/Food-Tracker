//
//  HealthModel.swift
//  Drip
//
//  Created by Bernd Plontsch on 10.05.17.
//  Copyright © 2017 Bernd Plontsch. All rights reserved.
//

import Foundation
import HealthKit
import TrackerKit

public class HealthViewModel:NSObject {

    var healthStore:HKHealthStore? = HKHealthStore()
    var healthCaloriesType:HKQuantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)!
    
    let sweetsCalories = 230.0
    let drinksCalories = 140.0
    let mealCalories = 560.0
    
    public func didTapToAdd(itemCategory:ItemCategory) {
        switch itemCategory {
        case .drink:
            healthStore?.addCalories(calories: drinksCalories)
        case .meal:
            healthStore?.addCalories(calories: mealCalories)
        case .sweets:
            healthStore?.addCalories(calories: sweetsCalories)
        }
    }
    
    public func didTapSwitch() {
        if Storage.isHealthLogEnabled() == false {
            if HKHealthStore().authorizationStatus(for: healthCaloriesType) == .notDetermined {
                requestPermission()
            }
           Storage.toggleHealthLog(isEnabled:true)
        } else {
           Storage.toggleHealthLog(isEnabled:false)
        }
    }
    
    public func isSwitchOn()->Bool {
        return Storage.isHealthLogEnabled()
    }
    
    func requestPermission() {
        print("Request Health Permissions")
        let types = Set([HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)!])
        HKHealthStore().requestAuthorization(toShare: types, read: types) { (success, error) in
            print("Done \(success)")
        }
    }
    
}
