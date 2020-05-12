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

    class func createCaloriesSample(calories:Double, foodName:String)->HKQuantitySample {
        let type = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)!
        let quantity = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: calories)
        let currentDate = NSDate()
        let currentDevice = HKDevice.local()
        let name = foodName
        let metadata = [HKMetadataKeyFoodType:name,
                          HKMetadataKeyWasUserEntered:true] as [String : Any]
        let sample = HKQuantitySample(type: type, quantity: quantity, start: currentDate as Date, end: currentDate as Date, device: currentDevice, metadata: metadata)
        
        return sample
    }
    
    // MARK: Add
    
    func addCalories(calories:Double, foodName:String)->Void {
        let sample = HKHealthStore.createCaloriesSample(calories: calories, foodName:foodName)
        print("[HealthKit] Add \(sample.uuid)")
        
        self.save(sample, withCompletion: { (success, error) in
            if success {
                print("\t Add Success (\(sample.quantity)) \(sample.startDate)")
            }
            if error != nil {
                print("\t Add Error saving \(String(describing: error))")
            }
        })
    }
    
    func deleteCurrentEntries(completion:(()->(Void))?=nil) {
        let caffeineType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCaffeine)!
        let currentDate = NSDate()
        let earliestDate = currentDate.addingTimeInterval(-10 * 60)
        let predicate:NSPredicate = NSPredicate(format:"startDate > %@",earliestDate)
        
        self.deleteObjects(of: caffeineType, predicate: predicate, withCompletion: { (success, index, error) in
            if success {
                if completion != nil {
                    completion!()
                }
            }
            if error != nil {
                print("\t Error \(String(describing: error))")
            }
        })
    }
    
    func deleteSample(healthSampleIdentifier:UUID) {
        let type = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)!
        let predicate = HKQuery.predicateForObject(with: healthSampleIdentifier)
        
        self.deleteObjects(of: type, predicate: predicate, withCompletion: { (success, index, error) in
            if success {
                print("\t Success, item deleted")
            }
            if error != nil {
                print("\t Error \(String(describing: error))")
            }
        })
    }
        
    
    
}
