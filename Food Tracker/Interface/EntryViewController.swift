//
//  ItemEntryViewController.swift
//  Food Tracker
//
//  Created by Bernd Plontsch on 07.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import UIKit
import TrackerKit

class EntryViewController:UIViewController {
    
    var viewModel:ViewModel!
    
    @IBAction func didTapSweets(_ sender: Any) {
        viewModel.didTap(itemCategory:ItemCategory.sweets)
        dismiss()
    }
    
    @IBAction func didTapMeal(_ sender: Any) {
        viewModel.didTap(itemCategory:ItemCategory.meal)
        dismiss()
    }
    
    @IBAction func didTapDrink(_ sender: Any) {
        viewModel.didTap(itemCategory:ItemCategory.drink)
        dismiss()
    }
    @IBAction func didTapDone(_ sender: Any) {
        dismiss()
    }
    
    func dismiss() {
        self.dismiss(animated: true) {
            print("Dismissing")
        }
    }
    
    override func viewDidLoad() {
        print("Did Load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("-------Entry Will Appear-------")
    }
    
}
