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
    let level: Int
    let id: Int
    let strBonus: Int?
    let conBonus: Int?
    let intBonus: Int?
    let wisBonus: Int?
    let dexBonus: Int?
    let chaBonus: Int?
    let sellValue: Int
    let equipmentType: EquipmentType
    let rarity: Rarity
}

struct DropEquipmentList {
    let item0 =  Equipment(name: "Jelly Sword", description: "", level: 0, id: 0, strBonus: 0, conBonus: nil, intBonus: nil, wisBonus: nil, dexBonus: nil, chaBonus: nil, sellValue: 1, equipmentType: .weapon, rarity: .common)
    let item1 = Equipment(name: "Gas-Powered Stick", description: "", level: 1, id: 1, strBonus: 1, conBonus: nil, intBonus: nil, wisBonus: nil, dexBonus: nil, chaBonus: nil, sellValue: 1, equipmentType: .weapon, rarity: .common)
    let item2 = Equipment(name: "Goblin Shiv", description: "", level: 2, id: 2, strBonus: 2, conBonus: nil, intBonus: nil, wisBonus: nil, dexBonus: 1, chaBonus: nil, sellValue: 3, equipmentType: .weapon, rarity: .uncommon)
}

struct ShopEquipmentList {
    static let list = [Equipment(name: "Iron Dagger", description: "", level: 1, id: -1, strBonus: 1, conBonus: nil, intBonus: nil, wisBonus: nil, dexBonus: 1, chaBonus: 0, sellValue: 3, equipmentType: .weapon, rarity: .common), Equipment(name: "Buckler", description: "", level: 1, id: -2, strBonus: nil, conBonus: 2, intBonus: nil, wisBonus: nil, dexBonus: nil, chaBonus: nil, sellValue: 3, equipmentType: .armor, rarity: .common)]
}
