//
//  DungeonData.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/17/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

struct Dungeon {
    let name: String
    let enemies: [Enemy]
    let cellBackground: String
    let background: String
    let index: Int
}

struct DungeonList {
    let dungeon1 = Dungeon(name: "Dungeon 1", enemies: dungeon1Enemies, cellBackground: "", background: "", index: 0)
    static let dungeon1Enemies = [Enemy(name: "Slime", level: 1, strength: 1, constitution: 1, intelligence: 1, wisdom: 1, dexAgi: 1, charisma: 1, goldDrop: 1, itemDrops: nil)]
}
