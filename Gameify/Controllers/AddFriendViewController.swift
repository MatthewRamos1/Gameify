//
//  AddFriendViewController.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/21/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController {
    
    @IBOutlet weak var addFriendTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFriendTextField.delegate = self
        
    }
    
}

extension AddFriendViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let friendCode = textField.text else {
            return true
        }
        DatabaseServices.shared.getUserName(id: friendCode) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            case.success(let username):
                DatabaseServices.shared.addUserFriend(id: friendCode, username: username) { [weak self] (result) in
                    switch result {
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.showAlert(title: "Error", message: error.localizedDescription)
                        }
                    case .success:
                        DispatchQueue.main.async {
                            self?.showAlert(title: "Success", message: "Friend Added")
                        }
                    }
                }
            }
        }
        return true
    }
}
