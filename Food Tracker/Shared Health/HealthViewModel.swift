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
    
    public func isHidden()->Bool {
        return !HKHealthStore.isHealthDataAvailable()
    }
    
    public func didTapToAdd(itemCategory:ItemCategory) {
        if Storage.isHealthLogEnabled() {
        switch itemCategory {
        case .drink:
            healthStore?.addCalories(calories: drinksCalories, foodName: "Beverage")
        case .meal:
            healthStore?.addCalories(calories: mealCalories, foodName: "Meal")
        case .sweets:
            healthStore?.addCalories(calories: sweetsCalories, foodName: "Sweets")
        }
        } else {
            print("Health Log Disabled")
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
    
    public func healthLogLabelText()->String {
        switch authorizationStatus() {
        case .sharingDenied:
            return "Open Settings to allow logging"
        default:
            return "Log to Health App"
        }
    }
    
    func authorizationStatus()->HKAuthorizationStatus {
        let state = healthStore?.authorizationStatus(for: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)!)
        return state!
    }
    
    public func healthLogSwitchIsOn()->Bool {
        switch authorizationStatus() {
        case .sharingAuthorized:
            if Storage.isHealthLogEnabled() {
                return true
            } else {
                return false
            }
        default:
            return false
        }
    }
    
    public func healthLogSwitchIsEnabled()->Bool {
        switch authorizationStatus() {
        case .sharingDenied:
            return false
        default:
            return true
        }
    }
    
}
