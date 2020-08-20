//
//  CombatFormulas.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/19/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

struct CombatFormulas {
    
    static func damageCalculation (strength: Int, enemyConstitution: Int, weaponAttack: Int?, armorDefense: Int?) -> Int {
        let attackPower = strength + (weaponAttack ?? 0)
        let defensePower = enemyConstitution + (armorDefense ?? 0)
        let baseDamage = attackPower - (defensePower/2)
        let range = (baseDamage / 16) + 1
        let dmgMin = baseDamage - range
        let dmgMax = baseDamage + range
        let damage = Int.random(in: dmgMin...dmgMax)
        return damage
        
        
    }
    
    static func evasionCalculation() {
        
    }
    
    static func charmCalculation() {
        
    }
}
