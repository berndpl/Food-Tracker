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
        viewModel.didTap(preset:viewModel.state.presets[0], shouldUpdate: true)
        healthViewModel.didTapToAdd(itemCategory: .sweets)
    }
    
    @IBAction func didTapMeal(_ sender: Any) {
        viewModel.didTap(preset:viewModel.state.presets[1], shouldUpdate: true)
        healthViewModel.didTapToAdd(itemCategory: .meal)
    }
    
    @IBAction func didTapDrink(_ sender: Any) {
        viewModel.didTap(preset:viewModel.state.presets[2], shouldUpdate: true)
        healthViewModel.didTapToAdd(itemCategory: .drink)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel(callback: { [unowned self] state in
            self.sweetsButton.badgeCount = state.count(title: state.presets[0].title)
            self.mealButton.badgeCount = state.count(title: state.presets[1].title)
            self.drinkButton.badgeCount = state.count(title: state.presets[2].title)
            
            self.sweetsButton.setTitle(self.viewModel.state.presets[0].title, for: UIControl.State.normal)
            self.mealButton.setTitle(self.viewModel.state.presets[1].title, for: UIControl.State.normal)
            self.drinkButton.setTitle(self.viewModel.state.presets[2].title, for: UIControl.State.normal)
        })
        
        //configureButton()
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
