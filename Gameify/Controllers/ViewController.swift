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
    
    var userStats: User? {
        didSet {
            DispatchQueue.main.async {
                self.levelLabel.text = "Level: \(self.userStats!.level)"
                self.strengthLabel.text = "Strength: \(self.userStats!.strength)"
                self.constitutionLabel.text = "Constitution: \(self.userStats!.constitution)"
                self.intelligenceLabel.text = "Intelligence: \(self.userStats!.intelligence)"
                self.wisdomLabel.text = "Wisdom: \(self.userStats!.wisdom)"
                self.dexAgiLabel.text = "Dex/Agi: \(self.userStats!.dexAgi)"
                self.charismaLabel.text = "Charisma: \(self.userStats!.charisma)"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
       
    }
    
    private func fetchUser() {
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
    
    private func expCap(level: Int) -> Int {
        var val = level / 10
        let mod = level % 10
        var total = mod * (val + 2)
        while val != 0 {
            total += (val + 1) * 10
            val = val - 1
        }
        return total
    }


}

