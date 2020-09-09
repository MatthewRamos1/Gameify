//
//  ViewController.swift
//  Gameify
//
//  Created by Matthew Ramos on 3/8/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {

    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var currentLvlLabel: UILabel!
    @IBOutlet weak var nextLvlLabel: UILabel!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var constitutionLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var wisdomLabel: UILabel!
    @IBOutlet weak var dexAgiLabel: UILabel!
    @IBOutlet weak var charismaLabel: UILabel!
    @IBOutlet weak var strengthExp: UILabel!
    @IBOutlet weak var constitutionExp: UILabel!
    @IBOutlet weak var intelligenceExp: UILabel!
    @IBOutlet weak var wisdomExp: UILabel!
    @IBOutlet weak var dexAgiExp: UILabel!
    @IBOutlet weak var charismaExp: UILabel!
    @IBOutlet weak var levelProgress: UIProgressView!
    @IBOutlet weak var strengthProgress: UIProgressView!
    @IBOutlet weak var constitutionProgress: UIProgressView!
    @IBOutlet weak var intelligenceProgress: UIProgressView!
    @IBOutlet weak var wisdomProgress: UIProgressView!
    @IBOutlet weak var dexAgiProgress: UIProgressView!
    @IBOutlet weak var charismaProgress: UIProgressView!
    
    var userStats: User? {
        didSet {
            DispatchQueue.main.async {
                self.updateStats(stats: self.userStats!)
                self.updateExpProgress(stats: self.userStats!)
                self.updateProgressBars(stats: self.userStats!)
            }
        }
    }
    
    var statsListener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupStatListener()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        statsListener?.remove()
    }
    
    private func updateStats(stats: User) {
        levelLabel.text = "Level: \(stats.level)"
        currentLvlLabel.text = "Lv. \(stats.level)"
        nextLvlLabel.text = "Lv. \(stats.level + 1)"
        strengthLabel.text = "Strength: \(stats.strength)"
        constitutionLabel.text = "Constitution: \(stats.constitution)"
        intelligenceLabel.text = "Intelligence: \(stats.intelligence)"
        wisdomLabel.text = "Wisdom: \(stats.wisdom)"
        dexAgiLabel.text = "Dex/Agi: \(stats.dexAgi)"
        charismaLabel.text = "Charisma: \(stats.charisma)"
    }
    
    private func updateExpProgress(stats: User) {
        strengthExp.text = createExpProgressText(exp: stats.strengthExp, cap: stats.strengthCap )
        constitutionExp.text = createExpProgressText(exp: stats.constitutionExp, cap: stats.constitutionCap )
        intelligenceExp.text = createExpProgressText(exp: stats.intelligenceExp, cap: stats.intelligenceCap)
        wisdomExp.text = createExpProgressText(exp: stats.wisdomExp, cap: stats.wisdomCap)
        dexAgiExp.text = createExpProgressText(exp: stats.dexAgiExp, cap: stats.dexAgiCap)
        charismaExp.text = createExpProgressText(exp: stats.charismaExp, cap: stats.charismaCap)
        
    }
    
    private func updateProgressBars(stats: User) {
        let totalLevel = Float(stats.strength + stats.constitution + stats.intelligence + stats.wisdom + stats.dexAgi + stats.charisma)
        let experienceDiff = totalLevel - Float(stats.level * 6)
        levelProgress.progress = experienceDiff / Float(6)
        levelProgress.editProgressColor(progress: levelProgress.progress)
        strengthProgress.progress = (Float(stats.strengthExp)) / (Float(stats.strengthCap))
        strengthProgress.editProgressColor(progress: strengthProgress.progress)
        constitutionProgress.progress = (Float(stats.constitutionExp)) / (Float(stats.constitutionCap))
        constitutionProgress.editProgressColor(progress: constitutionProgress.progress)
        intelligenceProgress.progress = (Float(stats.intelligenceExp)) / (Float(stats.intelligenceCap))
        intelligenceProgress.editProgressColor(progress: intelligenceProgress.progress)
        wisdomProgress.progress = (Float(stats.wisdomExp)) / (Float(stats.wisdomCap))
        wisdomProgress.editProgressColor(progress: wisdomProgress.progress)
        dexAgiProgress.progress = (Float(stats.dexAgiExp)) / (Float(stats.dexAgiCap))
        dexAgiProgress.editProgressColor(progress: dexAgiProgress.progress)
        charismaProgress.progress = (Float(stats.charismaExp)) / (Float(stats.charismaCap))
        charismaProgress.editProgressColor(progress:  charismaProgress.progress)
        
    }
    
    private func createExpProgressText(exp: Int, cap: Int) -> String {
        return "\(String(exp)) / \(String(cap))"
    }
    
    private func setupStatListener() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        statsListener = Firestore.firestore().collection(DatabaseServices.userCollection).document(uid).collection(DatabaseServices.statsCollection).addSnapshotListener( { (snapshot, error) in
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription)
            } else if let snapshot = snapshot {
                let stats =  snapshot.documents.map { User($0.data())}
                self.userStats = stats.first!
                
            }
        })
    }
    @IBAction func equipmentButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            UIViewController.showViewController(storyBoardName: "LoginView", viewControllerId: "LoginViewController")
            
            
            
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let username = textField.text else {
            return false
        }
        DatabaseServices.shared.updateDatabaseUser(username: username) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            case .success:
                return
            }
        }
        return true
    }
    
}

