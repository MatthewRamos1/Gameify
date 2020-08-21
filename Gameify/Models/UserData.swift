//
//  UserData.swift
//  Gameify
//
//  Created by Matthew Ramos on 3/8/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

class User {
    var level: Int
    var strength: Int
    var constitution: Int
    var intelligence: Int
    var wisdom: Int
    var dexAgi: Int
    var charisma: Int
    var strengthExp: Int
    var constitutionExp: Int
    var intelligenceExp: Int
    var wisdomExp: Int
    var dexAgiExp: Int
    var charismaExp: Int
    var strengthCap: Int
    var constitutionCap: Int
    var intelligenceCap: Int
    var wisdomCap: Int
    var dexAgiCap: Int
    var charismaCap: Int
    var gold: Int
    
    init(_ dictionary: [String: Any]) {
        self.level = dictionary["level"] as? Int ?? 0
        self.strength = dictionary["strength"] as? Int ?? 0
        self.constitution = dictionary["constitution"] as? Int ?? 0
        self.intelligence = dictionary["intelligence"] as? Int ?? 0
        self.wisdom = dictionary["wisdom"] as? Int ?? 0
        self.dexAgi = dictionary["dexAgi"] as? Int ?? 0
        self.charisma = dictionary["charisma"] as? Int ?? 0
        self.strengthExp = dictionary["strengthExp"] as? Int ?? 0
        self.constitutionExp = dictionary["constitutionExp"] as? Int ?? 0
        self.intelligenceExp = dictionary["intelligenceExp"] as? Int ?? 0
        self.wisdomExp = dictionary["wisdomExp"] as? Int ?? 0
        self.dexAgiExp = dictionary["dexAgiExp"] as? Int ?? 0
        self.charismaExp = dictionary["charismaExp"] as? Int ?? 0
        self.strengthCap = dictionary["strengthCap"] as? Int ?? 0
        self.constitutionCap = dictionary["constitutionCap"] as? Int ?? 0
        self.intelligenceCap = dictionary["intelligenceCap"] as? Int ?? 0
        self.wisdomCap = dictionary["wisdomCap"] as? Int ?? 0
        self.dexAgiCap = dictionary["dexAgiCap"] as? Int ?? 0
        self.charismaCap = dictionary["charismaCap"] as? Int ?? 0
        self.gold = dictionary["gold"] as? Int ?? 0
    }
}
