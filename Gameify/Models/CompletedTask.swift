//
//  CompletedTask.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/29/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

class CompletedTask {
    
    var title: String
    var description: String
    var imageURL: String?
    var rating: Int
    var statUps: [Stat]
    var id: String
    var completionDate: Date
    
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
        self.id = dictionary["id"] as? String ?? ""
        self.completionDate = dictionary["completionDate"] as? Date ?? Date()
    }}
