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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createTaskPressed(_ sender: UIButton) {
        guard let title = titleTextField.text, let description = descriptionTextView.text, let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let task = Task(title: title, description: description, rating: 0, statUps: [.strength], repeatable: .always, id: UUID().uuidString)
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
