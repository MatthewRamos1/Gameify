//
//  Friend.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/21/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

class Friend {
    let id: String
    let username: String
    
    init(_ dict: [String: Any]) {
        self.id = dict["id"] as? String ?? ""
        self.username = dict["username"] as? String ?? ""
    }
}
