//
//  DungeonStatus.swift
//  Gameify
//
//  Created by Matthew Ramos on 9/4/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

class DungeonStatus {
    var dungeon1: Int
    var dungeon2: Int
    var dungeon3: Int
    var dungeon4: Int
    
    init(_ dict: [String:Any]) {
        self.dungeon1 = dict["dungeon1"] as? Int ?? 0
        self.dungeon2 = dict["dungeon2"] as? Int ?? 0
        self.dungeon3 = dict["dungeon3"] as? Int ?? 0
        self.dungeon4 = dict["dungeon4"] as? Int ?? 0
    }
    
    public func updateStatus(enemyCount: Int, dungeonRep: DungeonRep) {
        switch dungeonRep {
        case .dungeon1:
            dungeon1 += 1
            if enemyCount == dungeon1 {
                dungeon1 = 0
            }
        case .dungeon2:
            dungeon2 += 1
            if enemyCount == dungeon2 {
                dungeon2 = 0
            }
        case .dungeon3:
            dungeon3 += 1
            if enemyCount == dungeon3 {
                dungeon3 = 0
            }
        case .dungeon4:
            dungeon4 += 1
            if enemyCount == dungeon4 {
                dungeon4 = 0
            }
        }
    }
}
