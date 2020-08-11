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
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var repeatRepSegmented: UISegmentedControl!
    @IBOutlet weak var createTaskButton: UIButton!
    @IBOutlet weak var oneStar: UIButton!
    @IBOutlet weak var twoStar: UIButton!
    @IBOutlet weak var threeStar: UIButton!
    @IBOutlet weak var fourStar: UIButton!
    @IBOutlet weak var fiveStar: UIButton!
    @IBOutlet weak var strengthButton: UIButton!
    @IBOutlet weak var constitutionButton: UIButton!
    @IBOutlet weak var intelligenceButton: UIButton!
    @IBOutlet weak var wisdomButton: UIButton!
    @IBOutlet weak var dexAgiButton: UIButton!
    @IBOutlet weak var charismaButton: UIButton!
    
    var rating = 0
    var repeatable = Repeatable.oneshot
    var statUps = [Stat]()
    var task: Task? {
        didSet {
            title = "Edit Task"
            rating = task!.rating
            repeatable = task!.repeatable
            statUps = task!.statUps
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        descriptionTextField.delegate = self
        guard let tempTask = task else {
            return
        }
        titleTextField.text = tempTask.title
        descriptionTextField.text = tempTask.description
        configureStarButtons(rating: tempTask.rating)
        configureRepeatRepSegment(repeatable: tempTask.repeatable)
        configureStatButtons(statUps: tempTask.statUps)
        
    }
    
    private func configureStarButtons(rating: Int) {
        switch rating {
        case 1:
            oneStar.setBackgroundImage(UIImage(systemName: "star.lefthalf.fill"), for: .normal)
        case 2:
            oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        case 3:
            oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            twoStar.setBackgroundImage(UIImage(systemName: "star.lefthalf.fill"), for: .normal)
        case 4:
            oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            twoStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        default:
            return
        }
    }
    
    private func configureRepeatRepSegment(repeatable: Repeatable) {
        switch repeatable {
        case .oneshot:
            repeatRepSegmented.selectedSegmentIndex = 0
        case .daily:
            repeatRepSegmented.selectedSegmentIndex = 1
        case .always:
            repeatRepSegmented.selectedSegmentIndex = 2
        default:
            return
        }
    }
    
    private func configureStatButtons(statUps: [Stat]) {
        switch true {
        case statUps.contains(.strength):
            strengthButton.backgroundColor = .darkGray
        case statUps.contains(.constitution):
            constitutionButton.backgroundColor = .darkGray
        case statUps.contains(.intelligence):
            intelligenceButton.backgroundColor = .darkGray
        case statUps.contains(.wisdom):
            wisdomButton.backgroundColor = .darkGray
        case statUps.contains(.dexAgi):
            dexAgiButton.backgroundColor = .darkGray
        case statUps.contains(.charisma):
            charismaButton.backgroundColor = .darkGray
        default:
            return
        }
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
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch repeatRepSegmented.selectedSegmentIndex {
        case 0:
            repeatable = .oneshot
        case 1:
            repeatable = .daily
        default:
            repeatable = .always
            
        }
    }
    
    @IBAction func statUpButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            if statUps.contains(.strength) {
                guard let index = statUps.firstIndex(of: .strength) else {
                    return
                }
                statUps.remove(at: index)
                sender.backgroundColor = nil
            } else if statUps.count <= 1 {
                statUps.append(.strength)
                sender.backgroundColor = .darkGray
            } else {
                showAlert(title: "Can't Assign Stat Up", message: "Max stat ups alread assigned, remove one first before proceeding!")
            }
        case 1:
            if statUps.contains(.constitution) {
                guard let index = statUps.firstIndex(of: .constitution) else {
                    return
                }
                statUps.remove(at: index)
                sender.backgroundColor = nil
            } else if statUps.count <= 1 {
                statUps.append(.constitution)
                sender.backgroundColor = .darkGray
            } else {
                showAlert(title: "Can't Assign Stat Up", message: "Max stat ups alread assigned, remove one first before proceeding!")
            }
        case 2:
            if statUps.contains(.intelligence) {
                guard let index = statUps.firstIndex(of: .intelligence
                    ) else {
                    return
                }
                statUps.remove(at: index)
                sender.backgroundColor = nil
            } else if statUps.count <= 1 {
                statUps.append(.intelligence)
                sender.backgroundColor = .darkGray
            } else {
                showAlert(title: "Can't Assign Stat Up", message: "Max stat ups alread assigned, remove one first before proceeding!")
            }
        case 3:
            if statUps.contains(.wisdom) {
                guard let index = statUps.firstIndex(of: .wisdom) else {
                    return
                }
                statUps.remove(at: index)
                sender.backgroundColor = nil
            } else if statUps.count <= 1 {
                statUps.append(.wisdom)
                sender.backgroundColor = .darkGray
            } else {
                showAlert(title: "Can't Assign Stat Up", message: "Max stat ups alread assigned, remove one first before proceeding!")
            }
        case 4:
            if statUps.contains(.dexAgi) {
                guard let index = statUps.firstIndex(of: .dexAgi) else {
                    return
                }
                statUps.remove(at: index)
                sender.backgroundColor = nil
            } else if statUps.count <= 1 {
                statUps.append(.dexAgi)
                sender.backgroundColor = .darkGray
            } else {
                showAlert(title: "Can't Assign Stat Up", message: "Max stat ups alread assigned, remove one first before proceeding!")
            }
        default:
            if statUps.contains(.charisma) {
                guard let index = statUps.firstIndex(of: .charisma) else {
                    return
                }
                statUps.remove(at: index)
                sender.backgroundColor = nil
            } else if statUps.count <= 1 {
                statUps.append(.charisma)
                sender.backgroundColor = .darkGray
            } else {
                showAlert(title: "Can't Assign Stat Up", message: "Max stat ups alread assigned, remove one first before proceeding!")
            }
        }
    }
    
    @IBAction func createTaskPressed(_ sender: UIButton) {
        guard let title = titleTextField.text, let description = descriptionTextField.text, let uid = Auth.auth().currentUser?.uid else {
            return
        }
        guard let task = task else {
            let task = Task(title: title, description: description, rating: rating, statUps: statUps, repeatable: repeatable, id: UUID().uuidString)
            DatabaseServices.shared.createUserTask(uid: uid, task: task) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                case .success:
                    self?.showAlert(title: "Success", message: "Task Created")
                }
            }
            return
        }
    }
    
}

extension CreateTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

