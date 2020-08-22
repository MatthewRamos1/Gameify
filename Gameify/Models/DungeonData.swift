//
//  DungeonData.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/17/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

class Dungeon {
    let name: String
    let enemies: [Enemy]
    let cellBackground: String
    let background: String
    let index: Int
    let remainingEnemies: Int
    
    init(name: String, enemies: [Enemy], cellBackground: String, background: String, index: Int, remainingEnemies: Int) {
        self.name = name
        self.enemies = enemies
        self.cellBackground = cellBackground
        self.background = background
        self.index = index
        self.remainingEnemies = remainingEnemies
    }
    
}

struct DungeonList {
    static let dungeon1 = Dungeon(name: "Dungeon 1", enemies: dungeon1Enemies, cellBackground: "", background: "", index: 0, remainingEnemies: 6)
    static let dungeon2 = Dungeon(name: "Dungeon 2", enemies: dungeon2Enemies, cellBackground: "", background: "", index: 0, remainingEnemies: 8)
    
    static let dungeon1Enemies = [Enemy(name: "Slime", level: 1, currentHealth: 10, maxHealth: 10, strength: 1, constitution: 1, intelligence: 1, wisdom: 1, dexAgi: 1, charisma: 1, encounterRange: 0...50, goldDrop: 1, itemDrops: nil), Enemy(name: "Goblin", level: 2, currentHealth: 12, maxHealth: 12, strength: 2, constitution: 2, intelligence: 1, wisdom: 0, dexAgi: 4, charisma: 3, encounterRange: 51...100, goldDrop: 1, itemDrops: nil)]
    static let dungeon2Enemies = [Enemy(name: "Slime2", level: 1, currentHealth: 10, maxHealth: 10, strength: 1, constitution: 1, intelligence: 1, wisdom: 1, dexAgi: 1, charisma: 1, encounterRange: 0...50, goldDrop: 1, itemDrops: nil)]
    static let dungeonList = [dungeon1, dungeon2]
    
    static public func getEnemy(dungeon: Dungeon) -> Enemy {
        let enemies = dungeon.enemies
        let randomVal = Int.random(in: 0...100)
        for enemy in enemies {
            if enemy.encounterRange.contains(randomVal) {
                return enemy
    }
}
        return enemies.first!
}
}
