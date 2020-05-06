//
//  ItemTableViewController.swift
//  Food Tracker
//
//  Created by Bernd Plontsch on 06.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import UIKit
import TrackerKit

class ItemTableViewController:UITableViewController {
    var viewModel:ViewModel!
    
    override func viewDidLoad() {
        print("Did Load")
        viewModel = ViewModel(callback: { [unowned self] state in
            print("\(state)")
        })
        print("\(viewModel.state)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Will Appear")
    }
    
}
