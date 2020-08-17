//
//  EnemyData.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/17/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

struct Enemy {
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
}
