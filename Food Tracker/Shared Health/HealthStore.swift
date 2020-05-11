//
//  HealthKitStore.swift
//  Drip
//
//  Created by Bernd Plontsch on 09/10/2016.
//  Copyright © 2016 Bernd Plontsch. All rights reserved.
//

import HealthKit

class HealthStore: NSObject {

    var healthStore:HKHealthStore?
    
    override init() {
        if HKHealthStore.isHealthDataAvailable() {
            self.healthStore = HKHealthStore()
        } else {
            print("[HealthKit] Not available")
        }
    }

}

extension HKHealthStore {

    class func createCaloriesSample(calories:Double)->HKQuantitySample {
        let type = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)!
        let quantity = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: calories)
        let currentDate = NSDate()
        let currentDevice = HKDevice.local()
        let name = "Consumed Snack"
        let metadata = [HKMetadataKeyFoodType:name,
                          HKMetadataKeyWasUserEntered:true] as [String : Any]
        let sample = HKQuantitySample(type: type, quantity: quantity, start: currentDate as Date, end: currentDate as Date, device: currentDevice, metadata: metadata)
        
        return sample
    }
    
    // MARK: Add
    
    func addCalories(calories:Double, completion:(()->(Void))?=nil)->Void {
        let sample = HKHealthStore.createCaloriesSample(calories: calories)
        print("[HealthKit] Add")
        
        self.save(sample, withCompletion: { (success, error) in
            if success {
                print("\t Add Success (\(sample.quantity)) \(sample.startDate)")
                //completion!()
            }
            if error != nil {
                print("\t Add Error saving \(String(describing: error))")
            }
        })
    }
    
}
