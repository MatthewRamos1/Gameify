//
//  ViewController.swift
//  Gameify
//
//  Created by Matthew Ramos on 3/8/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
       
    }
    
    public func fetchUser() {
        DatabaseServices.shared.getUser { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            case .success(let user):
                self?.userStats = user
            }
        }
    }
    
    private func updateStats(stats: User) {
        levelLabel.text = "Level: \(stats.level)"
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
        dexAgiExp.text = createExpProgressText(exp: stats.dexAgiExp, cap: stats.dexAgiCap)
        
    }
    
    private func updateProgressBars(stats: User) {
        strengthProgress.progress = (Float(stats.strengthExp)) / (Float(stats.strengthCap))
        dexAgiProgress.progress = (Float(stats.dexAgiExp)) / (Float(stats.dexAgiCap))
    }
    
    private func createExpProgressText(exp: Int, cap: Int) -> String {
        return "\(String(exp)) / \(String(cap))"
    }


}

