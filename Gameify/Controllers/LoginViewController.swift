//
//  LoginViewController.swift
//  Gameify
//
//  Created by Matthew Ramos on 7/30/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let authSession = AuthenticationSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func createDatabaseUser(authDataResult: AuthDataResult) {
        DatabaseServices.shared.createDatabaseUser(authDataResult: authDataResult) { [weak self](result) in
            switch result {
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Account error", message: error.localizedDescription)
                }
            case .success(let uid):
                DatabaseServices.shared.createUserStats(uid: uid) { (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Error", message: error.localizedDescription)
                    }
                case .success:
                    print("nice")
                    DispatchQueue.main.async {
                        self?.navigateToTaskVC()
                    }
                }
            }
        }
    }
    }
    
    private func navigateToTaskVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        present(vc!, animated: true)
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        authSession.createNewUser(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            case .success(let result):
                    self?.createDatabaseUser(authDataResult: result)
                    
            }
        }
    }
    
    
}
