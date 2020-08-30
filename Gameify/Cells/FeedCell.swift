//
//  FeedCell.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/28/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    @IBOutlet weak var feedFriendImageView: UIImageView!
    @IBOutlet weak var feedFriendNameLabel: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    public func configureCell(completedTask: Update) {
        descriptionLabel.text = "completed \(completedTask.title)!"
    }
    
}
