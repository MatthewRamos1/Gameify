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
    
    init(title: String, description: String, imageURL: String?, rating: Int, statUps: [Stat], id: String, completionDate: Date ) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.rating = rating
        self.statUps = statUps
        self.id = id
        self.completionDate = completionDate
    }
}
