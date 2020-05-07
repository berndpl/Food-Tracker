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
        shouldReload()
        NotificationCenter.default.addObserver(self, selector: #selector(shouldReload), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @IBAction func didTapCheck(_ sender: Any) {
        shouldReload()
        self.tableView.reloadData()
        print("Current state \(viewModel.state)")
    }
    
    @objc func shouldReload() {
        viewModel.shouldReload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Will Appear")
    }
    
    // MARK: - Show Entry View Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEntry" {
            let entry = segue.destination as! EntryViewController
            //let entry = navigationController.viewControllers.first as! EntryViewController
            entry.viewModel = viewModel
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
        print("Edit \(editingStyle) \(indexPath)")
        if editingStyle == .delete {
            viewModel.didTapDeleteItem(item:indexPath.item, row:indexPath.row)
            //tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
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
