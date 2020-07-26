//
//  Task.swift
//  Gameify
//
//  Created by Matthew Ramos on 7/26/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

class Task {
    var title: String
    var description: String
    var rating: Int
    var statUps: [Stat]
    
    init(title: String, description: String, rating: Int, statUps: [Stat]) {
        self.title = title
        self.description = description
        self.rating = rating
        self.statUps = statUps
    }
}

enum Stat {
    case strength
    case constitution
    case intelligence
    case wisdom
    case dexAgi
    case charisma
}
