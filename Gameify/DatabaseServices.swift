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
    static let taskCollection = "tasks"
    static let recentlyCompletedCollection = "recentlyCompleted"
    static let friendCollection = "friends"
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
        db.collection(DatabaseServices.userCollection).document(uid).collection(DatabaseServices.statsCollection).document(uid).setData(["level": 0, "strength": 0, "constitution": 0, "intelligence": 0, "wisdom": 0, "dexAgi": 0, "charisma": 0, "strengthExp": 0, "constitutionExp": 0, "intelligenceExp": 0, "wisdomExp": 0, "dexAgiExp": 0, "charismaExp": 0, "strengthCap": 1, "constitutionCap": 1, "intelligenceCap": 1, "wisdomCap": 1, "dexAgiCap": 1, "charismaCap": 1, "gold": 0]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func updateUserStats(dict: [String:Any], completion: @escaping (Result<Bool, Error>) -> ())  {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection(DatabaseServices.userCollection).document(uid).collection(DatabaseServices.statsCollection).document(uid).updateData(dict) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func createUserTask(uid: String, task: Task, completion: @escaping (Result<Bool, Error>) -> ()) {
        db.collection(DatabaseServices.userCollection).document(uid).collection(DatabaseServices.taskCollection).document(task.id).setData(["title": task.title, "description": task.description, "imageURL": task.imageURL ?? nil , "rating": task.rating, "statUps": task.statUps.first!.rawValue, "repeatable": task.repeatable.rawValue, "id": task.id]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func createRecentlyCompletedTask(task: Task, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection(DatabaseServices.userCollection).document(uid).collection(DatabaseServices.recentlyCompletedCollection).document(task.id).setData(["title": task.title, "description": task.description, "imageURL": task.imageURL ?? nil , "rating": task.rating, "statUps": task.statUps.first!.rawValue, "id": task.id, "completionDate": Date()]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func updateUserTask(task: Task, dict: [String:Any], completion: @escaping (Result <Bool, Error>) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection(DatabaseServices.userCollection).document(uid).collection(DatabaseServices.taskCollection).document(task.id).updateData(dict) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func deleteUserTask(task: Task, completion: @escaping (Result <Bool, Error>) -> ()) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        db.collection(DatabaseServices.userCollection).document(currentUser.uid).collection(DatabaseServices.taskCollection).document(task.id).delete { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func deleteRecentlyCompletedTask(task: Task, completion: @escaping (Result <Bool, Error>) -> ()) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        db.collection(DatabaseServices.userCollection).document(currentUser.uid).collection(DatabaseServices.recentlyCompletedCollection).document(task.id).delete { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func addUserFriend(id: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        db.collection(DatabaseServices.userCollection).document(currentUser.uid).collection(DatabaseServices.friendCollection).document(id).setData(["id": id]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func getUser(completion: @escaping (Result <User, Error>) -> ())  {
        
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        db.collection(DatabaseServices.userCollection).document(currentUser.uid).collection(DatabaseServices.statsCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let user = snapshot.documents.map { User($0.data())}
                completion(.success(user.first!))
            }
        }
    }
    
    public func getFriendsList(completion: @escaping (Result <[Friend], Error>) -> ())  {
        
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        db.collection(DatabaseServices.userCollection).document(currentUser.uid).collection(DatabaseServices.friendCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let friends = snapshot.documents.map { Friend($0.data())}
                completion(.success(friends))
            }
        }
    }
}
