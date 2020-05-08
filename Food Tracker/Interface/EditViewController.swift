//
//  EditViewController.swift
//  Food Tracker
//
//  Created by Bernd Plontsch on 09.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import UIKit
import TrackerKit

class EditViewController:UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!

    var item:Item!
    var viewModel:ViewModel!
        
    @IBAction func didChangeValue(_ sender: Any, forEvent event: UIEvent) {
         print("Change \(event)")
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
        datePicker.addTarget(self, action: #selector(dateDidChange(datePicker:)), for: .valueChanged)

    }
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("-------Edit Will Appear-------")
        print("Selected \(item!)")
        self.navigationBar.topItem?.title = item.itemCategory.description
        self.datePicker.setDate(item.createDate, animated: true)
    }
    
    @objc func dateDidChange(datePicker: UIDatePicker) {
        viewModel.didChangeDate(selectedItem:item, date:datePicker.date)
    }
    
}