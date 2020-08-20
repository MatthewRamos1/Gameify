//
//  CombatViewController.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/17/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

class CombatViewController: UIViewController {

    @IBOutlet weak var backgroundIV: UIImageView!
    @IBOutlet weak var enemyIV: UIImageView!
    @IBOutlet weak var enemyHealthProgress: UIProgressView!
    
    var dungeon: Dungeon?
    var enemy: Enemy!
    var userStats: User?
    
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
    
    @IBAction func attackButtonPressed(_ sender: UIButton) {
        guard let playerStats = userStats else {
            return
        }
        let damage = CombatFormulas.damageCalculation(strength: playerStats.strength, constitution: enemy.constitution, weaponAttack: nil, armorDefense: nil)
        enemy.currentHealth = enemy.currentHealth - damage
        enemyHealthProgress.progress = (Float(enemy.currentHealth)) / (Float(enemy.maxHealth))
        print(damage)
        
//        UIView.animate(withDuration: 0.6, delay: 0.0, options: [.transitionCrossDissolve], animations: {
//            self.enemyIV.alpha = 0
//        }, completion: nil)
    }
    
}
