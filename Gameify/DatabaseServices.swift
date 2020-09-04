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
    static let dungeonProgressCollection = "dungeonProgress"
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
        db.collection(DatabaseServices.userCollection).document(uid).collection(DatabaseServices.statsCollection).document(uid).setData(["level": 0, "currentHealth": 10, "maxHealth": 10, "strength": 0, "constitution": 0, "intelligence": 0, "wisdom": 0, "dexAgi": 0, "charisma": 0, "strengthExp": 0, "constitutionExp": 0, "intelligenceExp": 0, "wisdomExp": 0, "dexAgiExp": 0, "charismaExp": 0, "strengthCap": 1, "constitutionCap": 1, "intelligenceCap": 1, "wisdomCap": 1, "dexAgiCap": 1, "charismaCap": 1, "gold": 0]) { (error) in
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
        db.collection(DatabaseServices.userCollection).document(uid).collection(DatabaseServices.taskCollection).document(task.id).setData(["title": task.title, "description": task.description, "imageURL": task.imageURL ?? nil , "rating": task.rating, "statUps": task.statUps.first!.rawValue, "repeatable": task.repeatable.rawValue, "id": task.id, "dayStreak": 0, "creationDate": task.creationDate]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func createRecentlyCompletedTask(userName: String, task: Task, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection(DatabaseServices.userCollection).document(uid).collection(DatabaseServices.recentlyCompletedCollection).document(task.id).setData(["userName": userName, "title": task.title, "description": task.description, "imageURL": task.imageURL ?? nil , "rating": task.rating, "statUps": task.statUps.first!.rawValue, "id": task.id, "completionDate": Date()]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func createDungeonProgressData(completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection(DatabaseServices.userCollection).document(uid).collection(DatabaseServices.dungeonProgressCollection).document(uid).setData(["dungeon1": 0, "dungeon2": 0, "dungeon3": 0, "dungeon4": 0]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func updateDungeonProgressData(dict: [String: Any], completion: @escaping (Result <Bool, Error>) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection(DatabaseServices.userCollection).document(uid).collection(DatabaseServices.dungeonProgressCollection).document(uid).updateData(dict) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func getDungeonProgressData(completion: @escaping (Result <DungeonStatus, Error>) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection(DatabaseServices.userCollection).document(uid).collection(DatabaseServices.dungeonProgressCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let dungeonStatusArray = snapshot.documents.map { DungeonStatus($0.data())}
                let dungeonStatus = dungeonStatusArray.first!
                completion(.success(dungeonStatus))
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
    
    public func getFriendRecentlyCompletedTasks(friendUid: String, completion: @escaping (Result <[Update], Error>) -> ())  {
        
        db.collection(DatabaseServices.userCollection).document(friendUid).collection(DatabaseServices.recentlyCompletedCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let tasks = snapshot.documents.map { Update($0.data())}
                completion(.success(tasks))
            }
        }
    }
}
