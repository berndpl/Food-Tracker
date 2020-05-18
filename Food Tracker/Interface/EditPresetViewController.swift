//
//  EditTypeViewController.swift
//  Food Tracker
//
//  Created by Bernd Plontsch on 13.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import UIKit
import TrackerKit

class EditPresetViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel:ViewModel!
    var preset:Preset!
    
    @IBOutlet weak var caloriesTextField: UITextField!
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBAction func didTapDone(_ sender: Any) {
        dismiss()
    }
    
    func dismiss() {
        self.dismiss(animated: true) {
            print("Dismissing")
            //self.viewModel.shouldReload()
        }
    }
    
    override func viewDidLoad() {
        print("Did Load")
    }    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("-------Edit Will Appear-------")
        configure()
    }
    
    func configure() {
        self.emojiTextField?.text = preset.title//item.itemCategory.description
        self.caloriesTextField?.text = preset.caloriesLabel
        self.emojiTextField.delegate = self
        self.caloriesTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            print("Did Begin: Title")
        case 2:
            print("Did Begin: Calories")
            textField.text = preset.calories.description
        default:
            print("Other textfield?")
        }
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
    }
        
    @IBAction func caloriesDidChange(_ sender: UITextField) {
        
        let numberAsInt = Int(sender.text!)
        let number = NSNumber(value: numberAsInt!)
        print("Cal \(number) -- \(number.doubleValue.caloriesString)")
        viewModel.didUpdatePreset(preset: preset, title: preset.title, calories: number.doubleValue)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 1:
            viewModel.didUpdatePreset(preset: preset, title: textField.text!, calories: preset.calories)
            print("Did End: Title")
        case 2:
//            let numberAsInt = Int(textField.text!)
//            let number = NSNumber(value: numberAsInt!)
//            //let number:NSNumber = NSNumber.number init(textField.text)
//            viewModel.didUpdatePreset(preset: preset, title: preset.title, calories: number.doubleValue)
//            textField.text = preset.calories.description
            print("Did End: Calories")
        default:
            print("Other textfield?")
        }
        return true
    }
    
}

extension Double {
    public var caloriesString:String {
        return Measurement(value: self, unit: UnitEnergy.calories).description
    }
}
