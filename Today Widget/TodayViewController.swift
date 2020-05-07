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
    
    @IBOutlet weak var drinksLabelBackgroundView: UIView!
    @IBOutlet weak var drinksLabel: UILabel!
    @IBOutlet weak var mealLabel: UILabel!
    @IBOutlet weak var mealLabelBackgroundView: UIView!
    @IBOutlet weak var sweetsLabel: UILabel!
    @IBOutlet weak var sweetsLabelBackgroundView: UIView!
    
    @IBAction func didTapSweets(_ sender: Any) {
        viewModel.didTap(itemCategory:ItemCategory.sweets)
    }
    
    @IBAction func didTapMeal(_ sender: Any) {
        viewModel.didTap(itemCategory:ItemCategory.meal)
    }
    
    @IBAction func didTapDrink(_ sender: Any) {
        viewModel.didTap(itemCategory:ItemCategory.drink)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel(callback: { [unowned self] state in
            self.drinksLabel.text = state.countLabel(itemCategory: .drink)
            self.drinksLabelBackgroundView.isHidden = state.countLabelisHidden(itemCategory: .drink)
            
            self.mealLabel.text = state.countLabel(itemCategory: .meal)
            self.mealLabelBackgroundView.isHidden = state.countLabelisHidden(itemCategory: .meal)
            
            self.sweetsLabel.text = state.countLabel(itemCategory: .sweets)
            self.sweetsLabelBackgroundView.isHidden = state.countLabelisHidden(itemCategory: .sweets)
        })
        
        print("\(viewModel.state)")
        viewModel.shouldReload()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
