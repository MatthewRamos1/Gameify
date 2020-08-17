//
//  DungeonData.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/17/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

struct Dungeon {
    let enemies: [Enemy]
    let background: String
}

struct DungeonList {
    let dungeon1 = Dungeon(enemies: dungeon1Enemies, background: "")
    static let dungeon1Enemies = [Enemy(name: "Slime", level: 1, strength: 1, constitution: 1, intelligence: 1, wisdom: 1, dexAgi: 1, charisma: 1, goldDrop: 1, itemDrops: nil)]
}
