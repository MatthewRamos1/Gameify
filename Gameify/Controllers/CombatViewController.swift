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
    @IBOutlet weak var damageLabel: UILabel!
    
    var dungeon: Dungeon?
    var enemy: Enemy!
    var userStats: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        enemyHealthProgress.progress = 1.0
        damageLabel.alpha = 0.0
        damageLabel.textColor = .red
        enemyIV.image = UIImage(named: enemy.name)
        print(enemy.name)
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
        damageLabel.text = String(damage)
        enemy.currentHealth = enemy.currentHealth - damage
        let healthFloat = (Float(enemy.currentHealth)) / (Float(enemy.maxHealth))
        print(damage)
            UIView.animate(withDuration: 0.8, delay: 0.2, animations: {
                self.enemyHealthProgress.setProgress(healthFloat, animated: true)
                if self.enemy.currentHealth <= 0 {
                    self.enemyIV.alpha = 0
                    self.enemyHealthProgress.alpha = 0
                }
            }, completion: nil)
        UIView.animate(withDuration: 0.4, delay: 0.2 , animations: {
            self.damageLabel.alpha = 1
        }) { completion in
            UIView.animate(withDuration: 0.3, delay: 0.2 , animations: {
                self.damageLabel.alpha = 0
            })
        }
        
    }
    
}
