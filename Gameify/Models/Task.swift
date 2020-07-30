//
//  Task.swift
//  Gameify
//
//  Created by Matthew Ramos on 7/26/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

class Task {
    
    enum Stat {
        case strength
        case constitution
        case intelligence
        case wisdom
        case dexAgi
        case charisma
    }
    
    enum Repeatable {
        case daily
        case oneshot
        case always
    }
    
    var title: String
    var description: String
    var rating: Int
    var statUps: [Stat]
    var repeatable: Repeatable
    
    init(title: String, description: String, rating: Int, statUps: [Stat], repeatable: Repeatable) {
        self.title = title
        self.description = description
        self.rating = rating
        self.statUps = statUps
        self.repeatable = repeatable
    }
}

