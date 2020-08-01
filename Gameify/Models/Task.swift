//
//  Task.swift
//  Gameify
//
//  Created by Matthew Ramos on 7/26/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

class Task {
    
    enum Stat: String {
        case strength = "strength"
        case constitution = "constitution"
        case intelligence = "intelligence"
        case wisdom = "wisdom"
        case dexAgi = "dexAgi"
        case charisma = "charisma"
    }
    
    enum Repeatable: String{
        case daily = "daily"
        case oneshot = "oneshot"
        case always = "always"
    }
    
    var title: String
    var description: String
    var rating: Int
    var statUps: [Stat]
    var repeatable: Repeatable
    var id: String
    
    init(title: String, description: String, rating: Int, statUps: [Stat], repeatable: Repeatable, id: String) {
        self.title = title
        self.description = description
        self.rating = rating
        self.statUps = statUps
        self.repeatable = repeatable
        self.id = id
    }
}

