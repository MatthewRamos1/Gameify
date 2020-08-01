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
    
    var userStats = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userStats.charisma += 1
        levelLabel.text = "Level: \(userStats.level)"
        strengthLabel.text = "Strength: \(userStats.strength)"
        constitutionLabel.text = "Constitution: \(userStats.constitution)"
        intelligenceLabel.text = "Intelligence: \(userStats.intelligence)"
        wisdomLabel.text = "Wisdom: \(userStats.wisdom)"
        dexAgiLabel.text = "Dex/Agi: \(userStats.dexAgi)"
        charismaLabel.text = "Charisma: \(userStats.charisma)"
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

