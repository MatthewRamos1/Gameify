//
//  Item.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/17/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

struct Equipment {
    
    enum EquipmentType {
        case weapon
        case armor
    }
    
    enum Rarity {
        case common
        case uncommon
        case rare
        case exotic
        case legendary
    }
    
    let name: String
    let description: String
    let strBonus: Int?
    let conBonus: Int?
    let intBonus: Int?
    let wisBonus: Int?
    let dexBonus: Int?
    let chaBonus: Int?
    let equipmentType: EquipmentType
    let rarity: Rarity
    
}
