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
    var strength: Int
    var constitution: Int
    var intelligence: Int
    var wisdom: Int
    var dexAgi: Int
    var charisma: Int
    var goldDrop: Int
    var itemDrops: [Item]?
    
    init(name: String, level: Int, strength: Int, constitution: Int, intelligence: Int, wisdom: Int, dexAgi: Int, charisma: Int, goldDrop: Int, itemDrops: [Item]?) {
        self.name = name
        self.level = level
        self.strength = strength
        self.constitution = constitution
        self.intelligence = intelligence
        self.wisdom = wisdom
        self.dexAgi = dexAgi
        self.charisma = charisma
        self.goldDrop = goldDrop
        self.itemDrops = itemDrops
    }
}
