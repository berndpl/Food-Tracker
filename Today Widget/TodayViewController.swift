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
    
    @IBOutlet weak var drinksLabel: UILabel!
    @IBOutlet weak var mealLabel: UILabel!
    @IBOutlet weak var sweetsLabel: UILabel!
    
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
//            self.drinksLabel = //state.items.today()
//            print("\(state)")
//            
//            if let drinksCount = state.items.filter { (item:Item) -> Bool in
//                return item == .drink
//            }.count
            
        })
        print("\(viewModel.state)")
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
