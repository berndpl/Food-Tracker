//
//  ItemEntryViewController.swift
//  Food Tracker
//
//  Created by Bernd Plontsch on 07.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import UIKit
import TrackerKit

class ItemEntryViewController:UIViewController {
    
    var viewModel:ViewModel!
    
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
        print("Did Load")
        viewModel = ViewModel(callback: { [unowned self] state in
            print("\(state)")
        })
        print("\(viewModel.state)")
        
        shouldRestore()
        NotificationCenter.default.addObserver(self, selector: #selector(shouldRestore), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Will Appear")
    }
    
    @objc func shouldRestore() {
        viewModel.shouldRestore()
    }
}
