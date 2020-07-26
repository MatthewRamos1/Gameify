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
    
    private let db = Firestore.firestore()
    
    static let shared = DatabaseServices()
    
    public func createDatabaseUser(authDataResult: AuthDataResult, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        let user = authDataResult.user
        
        db.collection(DatabaseServices.userCollection).document(authDataResult.user.uid).setData(["email" : user.email ?? "", "userId": user.uid, "username": user.displayName ?? ""]) { (error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}
