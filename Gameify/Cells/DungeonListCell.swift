//
//  DungeonListCell.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/18/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

class DungeonListCell: UITableViewCell {

    @IBOutlet weak var dungeonImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    func configureCell(dungeon: Dungeon) {
        dungeonImageView.image = UIImage(named: dungeon.cellBackground)
        titleLabel.text = dungeon.name
        detailLabel.text = ""
        
    }
    
}
