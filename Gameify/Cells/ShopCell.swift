//
//  ShopCell.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/30/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

class ShopCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    public func configureCell(equipment: Equipment) {
        itemNameLabel.text = equipment.name
        priceLabel.text = "\(String(equipment.sellValue * 2))g"
    }
}
