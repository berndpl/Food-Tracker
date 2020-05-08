//
//  LocalNotification.swift
//  TrackerKit
//
//  Created by Bernd Plontsch on 08.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import Foundation
import UserNotifications

public class LocalNotification {
        
    public class func addNotification(title:String, hour:Int, minute:Int) {
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.hour = minute
        
        let lunchTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let notificationRequest = UNNotificationRequest(identifier: "LunchTimeNotification", content: content(title: title), trigger: lunchTrigger)
        
        removeAllNotifications()
        print("Added Notification")
        addNotification(request: notificationRequest)
    }
    
    // Notification Contruction
    
    class func content(title:String)->UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "Log a snack?"
        content.categoryIdentifier = "memo"
        return content
    }
    
    class func addNotification(request:UNNotificationRequest) {
        print("Add Notification")
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("\(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    public class func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    public class func currentNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            print("[Current Notifications] Pending \(requests.count)")
            for request in requests {
                if let trigger:UNTimeIntervalNotificationTrigger = request.trigger as? UNTimeIntervalNotificationTrigger {
                    print("\t[Current Notifications] Interval \(request.content.title) \(String(describing: trigger.nextTriggerDate())) \(String(describing: trigger.timeInterval))")
                }
            }
        }
    }
    
}
