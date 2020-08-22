//
//  EnemyData.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/17/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

class Enemy {
    var name: String
    var level: Int
    var currentHealth: Int
    var maxHealth: Int
    var strength: Int
    var constitution: Int
    var intelligence: Int
    var wisdom: Int
    var dexAgi: Int
    var charisma: Int
    var encounterChance: Int
    var goldDrop: Int
    var itemDrops: [Item]?
    
    init(name: String, level: Int, currentHealth: Int, maxHealth: Int, strength: Int, constitution: Int, intelligence: Int, wisdom: Int, dexAgi: Int, charisma: Int, encounterChance: Int, goldDrop: Int, itemDrops: [Item]?) {
        self.name = name
        self.level = level
        self.currentHealth = currentHealth
        self.maxHealth = maxHealth
        self.strength = strength
        self.constitution = constitution
        self.intelligence = intelligence
        self.wisdom = wisdom
        self.dexAgi = dexAgi
        self.charisma = charisma
        self.encounterChance = encounterChance
        self.goldDrop = goldDrop
        self.itemDrops = itemDrops
    }
}
