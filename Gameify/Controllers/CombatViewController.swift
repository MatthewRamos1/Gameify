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
    @IBOutlet weak var attackCombatUIButton: UIButton!
    @IBOutlet weak var talkCombatUIButton: UIButton!
    @IBOutlet weak var itemCombatUIButton: UIButton!
    @IBOutlet weak var escapeCombatUIButton: UIButton!
    @IBOutlet weak var combatUILabel: UILabel!
    
    var dungeon: Dungeon?
    var enemy: Enemy!
    var userStats: User!
    var dungeonProgress: Int!
    
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
            toggleCombatUIButtons()
            enemyDamageLabel.text = String(damage)
            combatUILabel.text = "You hit \(enemy.name) for \(damage) damage!"
            enemy.currentHealth = enemy.currentHealth - damage
            let healthFloat = (Float(enemy.currentHealth)) / (Float(enemy.maxHealth))
                UIView.animate(withDuration: 0.6, delay: 0.2, animations: {
                    self.enemyHealthProgress.setProgress(healthFloat, animated: true)
                    if self.enemy.currentHealth <= 0 {
                        self.enemyIV.alpha = 0
                        self.enemyHealthProgress.alpha = 0
                    }
                }, completion: nil)
            UIView.transition(with: enemyIV, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: { self.enemyIV.image = UIImage(named: self.enemy.name + "2")}) {
                completion in
                if self.enemy.currentHealth > 1 {
                    UIView.transition(with: self.enemyIV, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseIn], animations: { self.enemyIV.image = UIImage(named: self.enemy.name)}, completion: nil)

                }
            }
            UIView.animate(withDuration: 0.4, delay: 0.2 , animations: {
                self.enemyDamageLabel.alpha = 1
            }) { completion in
                UIView.animate(withDuration: 0.2, delay: 0.2 , animations: {
                    self.enemyDamageLabel.alpha = 0
                })
            }
        case false:
            userDamageLabel.text = String(damage)
            combatUILabel.text! += "\n \(enemy.name) hit you for \(damage) damage!"
            userStats.currentHealth = userStats.currentHealth - damage
            let healthFloat = (Float(userStats.currentHealth)) / (Float(userStats.maxHealth))
            UIView.animate(withDuration: 0.8, delay: 0.2, animations: {
                self.userHealthProgress.setProgress(healthFloat, animated: true)
            }, completion: nil)
            UIView.animate(withDuration: 0.4, delay: 0.2 , animations: {
                self.userDamageLabel.alpha = 1
            }) { completion in
                UIView.animate(withDuration: 0.3, delay: 0.2 , animations: {
                    self.userDamageLabel.alpha = 0
                }) { completion in
                    self.toggleCombatUIButtons()
                }
            }
        }
    }
    
    private func dungeonStatusToDict() -> [String: Any] {
        let dict = ["dungeon1": 0, "dungeon2": 0, "dungeon3": 0, "dungeon4": 0]
        return dict //implement enum for dungeons
    }
    
    private func toggleCombatUIButtons() {
        attackCombatUIButton.isHidden.toggle()
        talkCombatUIButton.isHidden.toggle()
        itemCombatUIButton.isHidden.toggle()
        escapeCombatUIButton.isHidden.toggle()
        combatUILabel.isHidden.toggle()
        if combatUILabel.isHidden == true {
            combatUILabel.text = nil
        }
    }
    
    @IBAction func attackButtonPressed(_ sender: UIButton) {
        guard let playerStats = userStats else {
            return
        }
        damageCalculation(attackerStrength: playerStats.strength, defenderConstitution: enemy.constitution, playerWeaponAttack: nil, playerArmorDefense: nil, playerAttacking: true)
        if enemy.currentHealth > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.damageCalculation(attackerStrength: self.enemy.strength, defenderConstitution: self.userStats.constitution, playerWeaponAttack: nil, playerArmorDefense: nil, playerAttacking: false)
            }
        } else {
            let goldDrop = CombatFormulas.goldCalculation(gold: enemy.goldDrop)
            combatUILabel.text! += "\n You defeated \(enemy.name)!"
            userStats.gold += goldDrop
            let tempDict = User.userToDict(user: userStats)
            DatabaseServices.shared.updateUserStats(dict: tempDict) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Error", message: error.localizedDescription)
                    }
                case .success:
                    DatabaseServices.shared.updateDungeonProgressData(dict: ["":""]) { (result) in
                        switch result {
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self?.showAlert(title: "Error", message: error.localizedDescription)
                            }
                        case .success:
                            print("updated progress")
                        }
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.combatUILabel.text! += "\n You found \(goldDrop) gold!"
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                self.navigationController?.popViewController(animated: true)
            }
        }
}

}
