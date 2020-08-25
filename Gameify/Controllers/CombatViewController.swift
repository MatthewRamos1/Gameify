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
    @IBOutlet weak var enemyDamageLabel: UILabel!
    @IBOutlet weak var userHealthProgress: UIProgressView!
    @IBOutlet weak var userDamageLabel: UILabel!
    
    var dungeon: Dungeon?
    var enemy: Enemy!
    var userStats: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        enemyHealthProgress.progress = 1.0
        userHealthProgress.progress = 1.0
        enemyDamageLabel.alpha = 0.0
        enemyDamageLabel.textColor = .systemRed
        userDamageLabel.alpha = 0.0
        userDamageLabel.textColor = .systemRed
        enemyIV.image = UIImage(named: enemy.name)
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
    
    private func damageCalculation(attackerStrength: Int, defenderConstitution: Int, playerWeaponAttack: Int?, playerArmorDefense: Int?, playerAttacking: Bool) {
        let damage = CombatFormulas.damageCalculation(strength: attackerStrength, constitution: defenderConstitution, weaponAttack: nil, armorDefense: nil)
        switch playerAttacking {
        case true:
            enemyDamageLabel.text = String(damage)
            enemy.currentHealth = enemy.currentHealth - damage
            let healthFloat = (Float(enemy.currentHealth)) / (Float(enemy.maxHealth))
                UIView.animate(withDuration: 0.8, delay: 0.2, animations: {
                    self.enemyHealthProgress.setProgress(healthFloat, animated: true)
                    if self.enemy.currentHealth <= 0 {
                        self.enemyIV.alpha = 0
                        self.enemyHealthProgress.alpha = 0
                    }
                }, completion: nil)
            UIView.animate(withDuration: 0.4, delay: 0.2 , animations: {
                self.enemyDamageLabel.alpha = 1
            }) { completion in
                UIView.animate(withDuration: 0.3, delay: 0.2 , animations: {
                    self.enemyDamageLabel.alpha = 0
                })
            }
        case false:
            userDamageLabel.text = String(damage)
        }
    }
    
    @IBAction func attackButtonPressed(_ sender: UIButton) {
        guard let playerStats = userStats else {
            return
        }
        damageCalculation(attackerStrength: playerStats.strength, defenderConstitution: enemy.constitution, playerWeaponAttack: nil, playerArmorDefense: nil, playerAttacking: true)
        damageCalculation(attackerStrength: enemy.strength, defenderConstitution: playerStats.constitution, playerWeaponAttack: nil, playerArmorDefense: nil, playerAttacking: false)
    
}

}
