//
//  ItemTableViewCell.swift
//  Food Tracker
//
//  Created by Bernd Plontsch on 07.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import UIKit
import TrackerKit

class ItemTableViewCell: UITableViewCell {
    
    var item:Item! = nil
    
    @IBOutlet weak var itemCategoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
