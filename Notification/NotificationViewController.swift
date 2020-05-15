//
//  NotificationViewController.swift
//  Notification
//
//  Created by Bernd Plontsch on 08.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import TrackerKit

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    var viewModel:ViewModel!
    
    @IBOutlet weak var sweetsLabel: UILabel!
    @IBOutlet weak var sweetsLabelBackgroundView: UIView!
    @IBOutlet weak var mealLabel: UILabel!
    @IBOutlet weak var mealLabelBackgroundView: UIView!
    @IBOutlet weak var drinksLabelBackgroundView: UIView!
    @IBOutlet weak var drinksLabel: UILabel!
    
    @IBAction func didTapSweets(_ sender: Any) {
        
    }
    
    @IBAction func didTapMeal(_ sender: Any) {
        
    }
    
    @IBAction func didTapDrink(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let size = self.view.bounds
        preferredContentSize = CGSize(width: size.width, height: size.width / 2.0)
    }
    
    func didReceive(_ notification: UNNotification) {
        viewModel.shouldReload()
    }

}
