//
//  EditViewController.swift
//  Food Tracker
//
//  Created by Bernd Plontsch on 09.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import UIKit
import TrackerKit

class EditItemViewController:UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!

    var item:Item!
    var viewModel:ViewModel!
    var healthViewModel:HealthViewModel = HealthViewModel()
    
    @IBAction func didTapDelete(_ sender: Any) {
        self.dismiss(animated: true) {
            self.viewModel.didTapDelete(item: self.item)
        }
    }
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var snackLabel: UILabel!
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
        configure()
    }
    
    func configure() {
        self.snackLabel.text = item.title
        self.caloriesLabel.text = Measurement(value: item.calories, unit: UnitEnergy.calories).description
        self.datePicker.setDate(item.createDate, animated: true)
    }
    
    @objc func dateDidChange(datePicker: UIDatePicker) {
        viewModel.didChangeDate(selectedItem:item, date:datePicker.date)
    }
    
}
