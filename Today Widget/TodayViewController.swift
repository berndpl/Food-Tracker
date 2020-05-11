//
//  TodayViewController.swift
//  Today Widget
//
//  Created by Bernd Plontsch on 06.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import UIKit
import NotificationCenter
import TrackerKit

class TodayViewController: UIViewController, NCWidgetProviding {
        
    var viewModel:ViewModel!
    var healthViewModel:HealthViewModel = HealthViewModel()
    
    @IBOutlet weak var sweetsButton: SnackButton!
    @IBOutlet weak var mealButton: SnackButton!
    @IBOutlet weak var drinkButton: SnackButton!
    
    @IBAction func didTapSweets(_ sender: Any) {
        viewModel.didTap(itemCategory:ItemCategory.sweets, shouldUpdate: true)
        healthViewModel.didTapToAdd(itemCategory: .sweets)
    }
    
    @IBAction func didTapMeal(_ sender: Any) {
        viewModel.didTap(itemCategory:ItemCategory.meal, shouldUpdate: true)
        healthViewModel.didTapToAdd(itemCategory: .meal)
    }
    
    @IBAction func didTapDrink(_ sender: Any) {
        viewModel.didTap(itemCategory:ItemCategory.drink, shouldUpdate: true)
        healthViewModel.didTapToAdd(itemCategory: .drink)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel(callback: { [unowned self] state in
            print(state.count(itemCategory: .sweets))
            self.sweetsButton.badgeCount = state.count(itemCategory: .sweets)
            self.drinkButton.badgeCount = state.count(itemCategory: .drink)
            self.mealButton.badgeCount = state.count(itemCategory: .meal)
        })
        
        print("\(viewModel.state)")
        viewModel.todayWidgetDidLoad()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
