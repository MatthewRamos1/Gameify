//
//  DatabaseServices.swift
//  Gameify
//
//  Created by Matthew Ramos on 7/20/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DatabaseServices {
    
    static let userCollection = "users"
    static let statsCollection = "stats"
    
    private let db = Firestore.firestore()
    
    static let shared = DatabaseServices()
    
    public func createDatabaseUser(authDataResult: AuthDataResult, completion: @escaping (Result<String, Error>) -> ()) {
        
        let user = authDataResult.user
        let uid = authDataResult.user.uid
        
        db.collection(DatabaseServices.userCollection).document(uid).setData(["email" : user.email ?? "", "userId": user.uid, "username": user.displayName ?? ""]) { (error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(uid))
            }
        }
    }
    
    public func createUserStats(uid: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        db.collection(DatabaseServices.userCollection).document(uid).collection(DatabaseServices.statsCollection).document(uid).setData(["level": 0, "strength": 0, "constitution": 0, "intelligence": 0, "wisdom": 0, "dexAgi": 0, "charisma": 0 ]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}
