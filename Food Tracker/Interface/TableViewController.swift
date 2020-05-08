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

    @IBAction func didTapSweets(_ sender: Any) {
        viewModel.didTap(itemCategory:ItemCategory.sweets, shouldUpdate: false)
        tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: UITableView.RowAnimation.automatic)
        //tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    @IBAction func didTapMeal(_ sender: Any) {
        viewModel.didTap(itemCategory:ItemCategory.meal, shouldUpdate: false)
        tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: UITableView.RowAnimation.automatic)
    }
    
    @IBAction func didTapDrink(_ sender: Any) {
        viewModel.didTap(itemCategory:ItemCategory.drink, shouldUpdate: false)
        tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: UITableView.RowAnimation.automatic)
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
        print("\(viewModel.state)")
        //self.tableView.delegate = self
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("-------Table Will Appear-------")
        print("Sections \(viewModel.state.itemSections().count) Items \(viewModel.state.items.count)")
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if viewModel.state.itemSections().count > 0 {
            let itemSection:[Item] = viewModel.state.itemSections()[section]
            return "\(itemSection.first!.createDate.shortRelative)"
        } else {
            return nil
        }
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = UILabel()
//        if viewModel.state.itemSections().count > 0 {
//            let itemSection:[Item] = viewModel.state.itemSections()[section]
//            label.text = "\(itemSection.first!.createDate.shortRelative)"
//        }
//        label.sizeToFit()
//        return label
//    }
//    
//    override func tableView(_ tableView: UITableView,
//                   heightForHeaderInSection section: Int) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    override func tableView(_ tableView: UITableView,
//                   estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 50.0
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.state.itemSections().count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.state.itemSections()[section].count
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
        let item:Item = viewModel.state.itemSections()[indexPath.section][indexPath.row] //viewModel.state.items[indexPath.row]
        cell.itemCategoryLabel.text = ("\(item.itemCategory)")
        cell.dateLabel.text = item.createDate.shortRelativeWithTime
        cell.item = item
        return cell
    }
    
}
