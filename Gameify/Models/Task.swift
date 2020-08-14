//
//  Task.swift
//  Gameify
//
//  Created by Matthew Ramos on 7/26/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

enum Repeatable: String{
       case daily = "daily"
       case oneshot = "oneshot"
       case always = "always"
       case error = "error"
   }

enum Stat: String {
    case strength = "strength"
    case constitution = "constitution"
    case intelligence = "intelligence"
    case wisdom = "wisdom"
    case dexAgi = "dexAgi"
    case charisma = "charisma"
}

class Task {
    
    var title: String
    var description: String
    var imageURL: String?
    var rating: Int
    var statUps: [Stat]
    var repeatable: Repeatable
    var id: String
    
    init(title: String, description: String, imageURL: String?, rating: Int, statUps: [Stat], repeatable: Repeatable, id: String) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.rating = rating
        self.statUps = statUps
        self.repeatable = repeatable
        self.id = id
    }
    
    init(_ dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? "No Title"
        self.description = dictionary["description"] as? String ?? "No Description"
        self.imageURL = dictionary["imageURL"] as? String ?? nil
        self.rating = dictionary["rating"] as? Int ?? -1
        let rawValString = dictionary["statUps"] as! String
        let stat = Stat(rawValue: rawValString)
        var array = [Stat]()
        array.append(stat!)
        self.statUps = array
        let repeatableString = dictionary["repeatable"] as? String ?? "error"
        self.repeatable = Repeatable(rawValue: repeatableString)!
        self.id = dictionary["id"] as? String ?? ""
    }
    }
