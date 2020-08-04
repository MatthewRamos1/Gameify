//
//  CreateTaskViewController.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/1/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit
import FirebaseAuth
class CreateTaskViewController: UIViewController {
    
    @IBOutlet weak var taskImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var repeatRepSegmented: UISegmentedControl!
    @IBOutlet weak var oneStar: UIButton!
    @IBOutlet weak var twoStar: UIButton!
    @IBOutlet weak var threeStar: UIButton!
    @IBOutlet weak var fourStar: UIButton!
    @IBOutlet weak var fiveStar: UIButton!
    
    var rating = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func starButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            if rating == 2 {
                oneStar.setBackgroundImage(UIImage(systemName: "star.lefthalf.fill"), for: .normal)
                rating = 1
            } else {
                oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                twoStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                threeStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                fourStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                fiveStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                rating = 2
            }
        case 1:
            if rating == 4 {
                twoStar.setBackgroundImage(UIImage(systemName: "star.lefthalf.fill"), for: .normal)
                rating = 3
            } else {
                oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                twoStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                threeStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                fourStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                fiveStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                rating = 4
            }
        case 2:
            if rating == 6 {
                threeStar.setBackgroundImage(UIImage(systemName: "star.lefthalf.fill"), for: .normal)
                rating = 5
            } else {
                oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                twoStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                threeStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                fourStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                fiveStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                rating = 6
            }
        case 3:
            if rating == 8 {
                fourStar.setBackgroundImage(UIImage(systemName: "star.lefthalf.fill"), for: .normal)
                rating = 7
            } else {
                oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                twoStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                threeStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                fourStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                fiveStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                rating = 8
            }
        default:
            if rating == 10 {
                fiveStar.setBackgroundImage(UIImage(systemName: "star.lefthalf.fill"), for: .normal)
                rating = 9
            } else {
                oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                twoStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                threeStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                fourStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                fiveStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                rating = 10
            }
        }
    }
    
    @IBAction func createTaskPressed(_ sender: UIButton) {
        guard let title = titleTextField.text, let description = descriptionTextView.text, let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let task = Task(title: title, description: description, rating: rating, statUps: [.strength], repeatable: .always, id: UUID().uuidString)
        DatabaseServices.shared.createUserTask(uid: uid, task: task) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Error", message: error.localizedDescription)
            case .success:
                self?.showAlert(title: "Success", message: "Task Created")
            }
        }
    }
    
}
