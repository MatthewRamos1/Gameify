//
//  TaskCell.swift
//  Gameify
//
//  Created by Matthew Ramos on 7/26/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var taskIV: UIImageView!
    @IBOutlet weak var repeatableRep: UIImageView!
    @IBOutlet weak var statRep1: UIImageView!
    @IBOutlet weak var statRep2: UIImageView!
    
    func configureCell(_ task: Task) {
        taskName.text = task.title
        descriptionLabel.text = task.description
        switch task.repeatable {
        case .always:
            repeatableRep.image = UIImage(systemName: "repeat")
        case .daily:
            repeatableRep.image = UIImage(systemName: "repeat.1")
        case .oneshot:
            repeatableRep.image = nil
        default:
            repeatableRep.image = UIImage(systemName: "gear")
        }
    }
}
