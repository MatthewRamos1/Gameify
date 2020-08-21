//
//  CombatFormulas.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/19/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

struct CombatFormulas {
    
    static func damageCalculation (strength: Int, constitution: Int, weaponAttack: Int?, armorDefense: Int?) -> Int {
        let attackPower = strength + (weaponAttack ?? 0)
        let defensePower = constitution + (armorDefense ?? 0)
        let baseDamage = attackPower - (defensePower/2)
        let range = (baseDamage / 16) + 1
        let dmgMin = baseDamage - range
        let dmgMax = baseDamage + range
        let damage = Int.random(in: dmgMin...dmgMax)
        return damage
        
        
    }
    
    static func evasionCalculation(dexAgi: Int, defenderDexAgi: Int) -> Bool {
        let dodgeChance = 5 + (dexAgi / 2) - (defenderDexAgi / 3)
        let dodgeResult = Int.random(in: 0...100)
        if dodgeResult <= dodgeChance {
            return true
        } else {
            return false
        }
    }
    
    static func goldCalculation(gold: Int) -> Int {
        let min = gold - (gold / 4)
        let max = gold + (gold / 3)
        let goldDrop = Int.random(in: min...max)
        return goldDrop
        
    }
    
    static func lootCalculation() {
        
    }
    
    static func charmCalculation() {
        
    }
    
    private func critCalculation() {
        
    }
}
