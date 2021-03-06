//
//  ItemTableViewController.swift
//  Food Tracker
//
//  Created by Bernd Plontsch on 06.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import UIKit
import TrackerKit

class TableViewController:UITableViewController {
    var viewModel:ViewModel!

    @IBOutlet weak var healthToggleView: UIView!
    var healthViewModel:HealthViewModel = HealthViewModel()
    @IBOutlet weak var sweetsButton: SnackButton!
    @IBOutlet weak var mealButton: SnackButton!
    @IBOutlet weak var drinksButton: SnackButton!
    
    @IBOutlet weak var healthLogLabel: UILabel!
    @IBAction func didToggleHealthLogSwitch(_ sender: Any, forEvent event: UIEvent) {
        healthViewModel.didTapSwitch()
    }
    
    @IBOutlet weak var healthLogSwitch: UISwitch!
    
    @IBAction func didTapSweets(_ sender: Any) {
        if tableView.isEditing {
            presentEditPreset(preset: viewModel.state.presets[0], viewModel: viewModel)
        } else {
            viewModel.didTap(preset:viewModel.state.presets[0] , shouldUpdate: true)
            tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: UITableView.RowAnimation.automatic)
            healthViewModel.didTapToAdd(itemCategory: .sweets)
        }
    }
    
    @IBAction func didTapMeal(_ sender: Any) {
        if tableView.isEditing {
            presentEditPreset(preset: viewModel.state.presets[1], viewModel: viewModel)
        } else {
            viewModel.shouldReload()
            viewModel.didTap(preset:viewModel.state.presets[1] , shouldUpdate: true)
            healthViewModel.didTapToAdd(itemCategory: .meal)
            tableView.insertRows(at: [IndexPath()], with: UITableView.RowAnimation.automatic)
            //tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: UITableView.RowAnimation.automatic)
        }
    }
    
    @IBAction func didTapDrink(_ sender: Any) {
        if tableView.isEditing {
            presentEditPreset(preset: viewModel.state.presets[2], viewModel: viewModel)
        } else {
            viewModel.didTap(preset:viewModel.state.presets[2] , shouldUpdate: true)
            tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: UITableView.RowAnimation.automatic)
            healthViewModel.didTapToAdd(itemCategory: .drink)
        }
    }
    
    func presentEditPreset(preset:Preset, viewModel:ViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editTypeViewController = storyboard.instantiateViewController(identifier:"EditPresetViewController") as! EditPresetViewController
        editTypeViewController.viewModel = viewModel
        editTypeViewController.preset = preset
        self.present(editTypeViewController, animated: true, completion: {
            print("ho")
            editTypeViewController.configure()
        })
    }
    
    @IBAction func didTapEdit(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing {
            sender.title = "Done"
        } else {
            sender.title = "Edit"
        }
        sweetsButton.editing = tableView.isEditing
        mealButton.editing = tableView.isEditing
        drinksButton.editing = tableView.isEditing
    }
    
    @IBAction func didTapDeleteAll(_ sender: Any) {
        viewModel.didTapDeleteAll()
    }
    
    override func viewDidLoad() {
        print("Did Load")
        viewModel = ViewModel(callback: { [unowned self] state in
            print("\(state)")
            self.sweetsButton.badgeCount = state.count(title: state.presets[0].title)
            self.mealButton.badgeCount = state.count(title: state.presets[1].title)
            self.drinksButton.badgeCount = state.count(title: state.presets[2].title)
            
            self.sweetsButton.descriptionString = self.viewModel.state.presets[0].caloriesLabel
            self.mealButton.descriptionString = self.viewModel.state.presets[1].caloriesLabel
            self.drinksButton.descriptionString = self.viewModel.state.presets[2].caloriesLabel
            
            self.sweetsButton.setTitle(self.viewModel.state.presets[0].title, for: UIControl.State.normal)
            self.mealButton.setTitle(self.viewModel.state.presets[1].title, for: UIControl.State.normal)
            self.drinksButton.setTitle(self.viewModel.state.presets[2].title, for: UIControl.State.normal)
        })
        NotificationCenter.default.addObserver(self, selector: #selector(shouldReload), name: UIApplication.willEnterForegroundNotification, object: nil)
            shouldReload()
        configureButtons()
        healthToggleView.isHidden = healthViewModel.isHidden()
    }
    
    func configureButtons() {
        drinksButton.primaryColor = drinksButton.backgroundColor!
        mealButton.primaryColor = mealButton.backgroundColor!
        sweetsButton.primaryColor = sweetsButton.backgroundColor!
        sweetsButton.badgeCount = 0
    }
    
    @IBAction func didTapCheck(_ sender: Any) {
        shouldReload()
        self.tableView.reloadData()
        print("Current state \(viewModel.state)")
    }
    
    @objc func shouldReload() {
        viewModel.todayWidgetDidLoad()
        healthLogLabel.text = healthViewModel.healthLogLabelText()
        healthLogSwitch.isOn = healthViewModel.healthLogSwitchIsOn()
        healthLogSwitch.isEnabled = healthViewModel.healthLogSwitchIsEnabled()
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("-------Table Will Appear-------")
        print("Items \(viewModel.state.items.count)")
        
        
        healthLogSwitch.isOn = healthViewModel.isSwitchOn()
    }
    
    // MARK: - Show Entry View Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "showEdit" {
            let edit = segue.destination as! EditItemViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            let selectedItem = viewModel.selectedItem(section: selectedIndexPath!.section, item: selectedIndexPath!.item)
            edit.viewModel = viewModel
            edit.item = selectedItem
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section:section)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Delete \(editingStyle) \(indexPath)")
            viewModel.didTapDeleteItem(section:indexPath.section, item:indexPath.item)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackedItem", for: indexPath) as! ItemTableViewCell
        let item:Item = viewModel.itemForIndexPath(section: indexPath.section, row: indexPath.row) //state.items [indexPath.item] //viewModel.state.items[indexPath.row]
        cell.itemCategoryLabel.text = ("\(item.title)")
        cell.dateLabel.text = item.createDate.shortRelativeWithTime
        cell.item = item
        return cell
    }
    
}
