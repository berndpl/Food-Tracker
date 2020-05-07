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
        shouldRestore()
        NotificationCenter.default.addObserver(self, selector: #selector(shouldRestore), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @IBAction func didTapCheck(_ sender: Any) {
        shouldRestore()
        self.tableView.reloadData()
        print("Current state \(viewModel.state)")
    }
    
    @objc func shouldRestore() {
        viewModel.shouldRestore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Will Appear")
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
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        print("Edit \(editingStyle) \(indexPath)")
//        if editingStyle == .delete {
//            viewModel.didDeleteMemo(indexPath:indexPath)
//            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
//        }
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackedItem", for: indexPath) as! ItemTableViewCell
        let item:Item = viewModel.state.items[indexPath.row]
        cell.itemCategoryLabel.text = ("\(item.itemCategory)")
        cell.dateLabel.text = ("\(item.createDate)")
        cell.item = item
        return cell
    }
    
}
