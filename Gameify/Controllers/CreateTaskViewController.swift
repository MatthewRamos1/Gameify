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
    @IBOutlet weak var deleteTaskButton: UIButton!
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
    
    enum TaskState {
        case create
        case edit
    }
    
    let imagePickerController = UIImagePickerController()
    var selectedImage: UIImage? {
        didSet {
            taskImageView.image = selectedImage
        }
    }
    var rating = 0
    var repeatable = Repeatable.oneshot
    var statUps = [Stat]()
    var currentState = TaskState.create
    var task: Task? {
        didSet {
            title = "Edit Task"
            rating = task!.rating
            repeatable = task!.repeatable
            statUps = task!.statUps
            currentState = .edit
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        descriptionTextField.delegate = self
        imagePickerController.delegate = self
        guard let tempTask = task else {
            return
        }
        deleteTaskButton.isHidden = true
        titleTextField.text = tempTask.title
        descriptionTextField.text = tempTask.description
        configureStarButtons(rating: tempTask.rating)
        configureRepeatRepSegment(repeatable: tempTask.repeatable)
        configureStatButtons(statUps: tempTask.statUps)
        if currentState == .edit {
            createTaskButton.setTitle("Save Edits", for: .normal)
            deleteTaskButton.isHidden = false
        }
        
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
        case 5:
            oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            twoStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            threeStar.setBackgroundImage(UIImage(systemName: "star.lefthalf.fill"), for: .normal)
        case 6:
            oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            twoStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            threeStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        case 7:
            oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            twoStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            threeStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            fourStar.setBackgroundImage(UIImage(systemName: "star.lefthalf.fill"), for: .normal)
        case 8:
            oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            twoStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            threeStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            fourStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        case 9:
            oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            twoStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            threeStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            fourStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            fiveStar.setBackgroundImage(UIImage(systemName: "star.lefthalf.fill"), for: .normal)
        case 10:
            oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            twoStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            threeStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            fourStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            fiveStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
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
    
    private func updateTask(task: Task, dict: [String:Any]) {
        DatabaseServices.shared.updateUserTask(task: task, dict: dict) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Error", message: error.localizedDescription)
            case .success:
                self?.showAlert(title: "Success", message: "Changes Saved")
            }
        }
    }
    
    private func uploadTaskPhoto(task: Task, image: UIImage) -> String {
        var urlString = ""
        StorageServices.shared.uploadPhoto(taskId: task.id, image: image) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            case .success(let url):
                urlString = url.absoluteString
                
            }
        }
        return urlString
    }
    
    private func taskToDict(task: Task) -> [String:Any] {
        let dict = ["title": task.title, "description": task.description, "rating": task.rating, "statUps": task.statUps.first!.rawValue, "repeatable": task.repeatable.rawValue, "id": task.id] as! [String:Any]
        return dict
    }
    
    @IBAction func longPressAction(_ sender: UILongPressGestureRecognizer) {
        let actionController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let camera = UIAlertAction(title: "Camera", style: .default) { actionAlert in
                self.imagePickerController.sourceType = .camera
                self.present(self.imagePickerController, animated: true)
            }
            actionController.addAction(camera)
        }
        let gallery = UIAlertAction(title: "Gallery", style: .default) { actionAlert in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true)
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        actionController.addAction(gallery)
        actionController.addAction(cancel)
        present(actionController, animated: true)
        
        
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
        guard let titleText = titleTextField.text, let description = descriptionTextField.text, let uid = Auth.auth().currentUser?.uid else {
            return
        }
        switch true {
        case rating == 0:
            showAlert(title: "Missing Rating", message: "Please set a valid rating for this task.")
            return
        case titleText.isEmpty:
            showAlert(title: "Missing Field", message: "Please set a valid title for this task.")
            return
        case statUps.isEmpty:
            showAlert(title: "Missing Selections", message: "Please select at least one applicable stat associated with this task.")
            return
        default:
            guard let tempTask = task else {
                
                let task = Task(title: titleText, description: description, imageURL: nil, rating: rating, statUps: statUps, repeatable: repeatable, id: UUID().uuidString, dayStreak: 0, creationDate: Date())
                if let image = selectedImage {
                    task.imageURL = uploadTaskPhoto(task: task, image: image)
                }
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
            tempTask.description = description
            tempTask.title = titleText
            tempTask.rating = rating
            tempTask.statUps = statUps
            tempTask.repeatable = repeatable
            if let image = selectedImage {
                tempTask.imageURL = uploadTaskPhoto(task: tempTask, image: image)
            }
            let dict = taskToDict(task: tempTask)
            updateTask(task: tempTask, dict: dict)
        }
        
        
    }
    
    @IBAction func deleteTaskPressed(_ sender: UIButton) {
        DatabaseServices.shared.deleteUserTask(task: task!) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            case .success:
                DispatchQueue.main.async {
                    self?.dismiss(animated: true)
                }
            }
        }
    }
    
}

extension CreateTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension CreateTaskViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            showAlert(title: "Error", message: "Image was not found")
            return
        }
        selectedImage = image
        dismiss(animated: true)
    }
}

