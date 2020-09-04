//
//  TaskCell.swift
//  Gameify
//
//  Created by Matthew Ramos on 7/26/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit
import Kingfisher

protocol editTaskButtonDelegate: AnyObject {
       func buttonWasPressed(_ cell: TaskCell, _ task: Task)
   }

protocol cellLongPressDelegate: AnyObject {
    func longPressActivated(_ task: Task)
}

class TaskCell: UITableViewCell {

    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var taskIV: UIImageView!
    @IBOutlet weak var repeatableRep: UIImageView!
    @IBOutlet weak var statRep1: UIImageView!
    @IBOutlet weak var oneStar: UIImageView!
    @IBOutlet weak var twoStar: UIImageView!
    @IBOutlet weak var threeStar: UIImageView!
    @IBOutlet weak var fourStar: UIImageView!
    @IBOutlet weak var fiveStar: UIImageView!
    var cellTask: Task!
    var longPressRecognizer: UILongPressGestureRecognizer!
    
    weak var delegate: editTaskButtonDelegate?
    weak var longPressDelegate: cellLongPressDelegate?
    
    func configureCell(_ task: Task) {
        longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressActivated))
        addGestureRecognizer(longPressRecognizer)
        cellTask = task
        taskName.text = task.title
        descriptionLabel.text = task.description
        statRep1.image = UIImage(named: task.statUps.first!.rawValue)
        if let imageURL = task.imageURL {
            let url = URL(string: imageURL)
            taskIV.kf.setImage(with: url)
        } else {
            taskIV.image = UIImage(named: task.statUps.first!.rawValue)
        }
        setIdentifiers(task: task)
        setStreakLabel(task: task)
    }
    
    private func setIdentifiers(task: Task) {
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
               
               switch task.rating {
               case 1:
                   oneStar.image = UIImage(systemName: "star.lefthalf.fill")
               case 2:
                   oneStar.image = UIImage(systemName: "star.fill")
               case 3:
                   oneStar.image = UIImage(systemName: "star.fill")
                   twoStar.image = UIImage(systemName: "star.lefthalf.fill")
               case 4:
                   oneStar.image = UIImage(systemName: "star.fill")
                   twoStar.image = UIImage(systemName: "star.fill")
               case 5:
                   oneStar.image = UIImage(systemName: "star.fill")
                   twoStar.image = UIImage(systemName: "star.fill")
                   threeStar.image = UIImage(systemName: "star.lefthalf.fill")
               case 6:
                   oneStar.image = UIImage(systemName: "star.fill")
                   twoStar.image = UIImage(systemName: "star.fill")
                   threeStar.image = UIImage(systemName: "star.fill")
               case 7:
                   oneStar.image = UIImage(systemName: "star.fill")
                   twoStar.image = UIImage(systemName: "star.fill")
                   threeStar.image = UIImage(systemName: "star.fill")
                   fourStar.image = UIImage(systemName: "star.lefthalf.fill")
               case 8:
                   oneStar.image = UIImage(systemName: "star.fill")
                   twoStar.image = UIImage(systemName: "star.fill")
                   threeStar.image = UIImage(systemName: "star.fill")
                   fourStar.image = UIImage(systemName: "star.fill")
                   
               case 9:
                   oneStar.image = UIImage(systemName: "star.fill")
                   twoStar.image = UIImage(systemName: "star.fill")
                   threeStar.image = UIImage(systemName: "star.fill")
                   fourStar.image = UIImage(systemName: "star.fill")
                   fiveStar.image = UIImage(systemName: "star.lefthalf.fill")
               default:
                   oneStar.image = UIImage(systemName: "star.fill")
                   twoStar.image = UIImage(systemName: "star.fill")
                   threeStar.image = UIImage(systemName: "star.fill")
                   fourStar.image = UIImage(systemName: "star.fill")
                   fiveStar.image = UIImage(systemName: "star.fill")
               }
    }
    
    private func setStreakLabel(task: Task) {
        if task.dayStreak >= 3 {
            descriptionLabel.text! += "\n \(task.dayStreak) Day Streak!"
        }
    }
    
    @objc
    func longPressActivated() {
        longPressDelegate?.longPressActivated(cellTask)
    }
    
    @IBAction func editTaskPressed(_ sender: UIButton) {
        delegate?.buttonWasPressed(self, cellTask)
    }
    
    
}
