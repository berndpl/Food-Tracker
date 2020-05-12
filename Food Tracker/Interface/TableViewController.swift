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
    var healthViewModel:HealthViewModel = HealthViewModel()

    @IBOutlet weak var healthLogLabel: UILabel!
    @IBAction func didToggleHealthLogSwitch(_ sender: Any, forEvent event: UIEvent) {
        healthViewModel.didTapSwitch()
    }
    
    @IBOutlet weak var healthLogSwitch: UISwitch!
    
    @IBAction func didTapSweets(_ sender: Any) {
        print("new \(viewModel.state.items.count)")
        viewModel.didTap(itemCategory:ItemCategory.sweets, shouldUpdate: false)
        tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: UITableView.RowAnimation.automatic)
        healthViewModel.didTapToAdd(itemCategory: .sweets)
    }
    
    @IBAction func didTapMeal(_ sender: Any) {
        viewModel.shouldReload()
        viewModel.didTap(itemCategory:ItemCategory.meal, shouldUpdate: false)
        tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: UITableView.RowAnimation.automatic)
        healthViewModel.didTapToAdd(itemCategory: .meal)
    }
    
    @IBAction func didTapDrink(_ sender: Any) {
        viewModel.didTap(itemCategory:ItemCategory.drink, shouldUpdate: false)
        tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: UITableView.RowAnimation.automatic)
        healthViewModel.didTapToAdd(itemCategory: .drink)
    }
    
    @IBAction func didTapEdit(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing {
            sender.title = "Done"
        } else {
            sender.title = "Edit"
        }
    }
    
    @IBAction func didTapDeleteAll(_ sender: Any) {
        viewModel.didTapDeleteAll()
    }
    
    override func viewDidLoad() {
        print("Did Load")
        viewModel = ViewModel(callback: { [unowned self] state in
            print("\(state)")
            self.tableView.reloadData()
        })
        NotificationCenter.default.addObserver(self, selector: #selector(shouldReload), name: UIApplication.willEnterForegroundNotification, object: nil)
            shouldReload()
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("-------Table Will Appear-------")
        print("Items \(viewModel.state.items.count)")
        
        
        healthLogSwitch.isOn = healthViewModel.isSwitchOn()
    }
    
    // MARK: - Show Entry View Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEntry" {
            let entry = segue.destination as! EntryViewController
            entry.viewModel = viewModel
        } else if segue.identifier == "showEdit" {
            let edit = segue.destination as! EditViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            let selectedItem = viewModel.selectedItem(section: selectedIndexPath!.section, item: selectedIndexPath!.item)
            edit.viewModel = viewModel
            edit.item = selectedItem
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.state.items.count
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
        let item:Item = viewModel.state.items[indexPath.item] //viewModel.state.items[indexPath.row]
        cell.itemCategoryLabel.text = ("\(item.itemCategory)")
        cell.dateLabel.text = item.createDate.shortRelativeWithTime
        cell.item = item
        return cell
    }
    
}
