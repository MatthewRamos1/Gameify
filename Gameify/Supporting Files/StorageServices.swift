//
//  StorageServices.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/18/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageServices {
    
    
    static let shared = StorageServices()
    private let storageRef = Storage.storage().reference()
    
     public func uploadPhoto(taskId: String, image: UIImage, completion: @escaping (Result<URL, Error>) -> ()) {
       
       guard let imageData = image.jpegData(compressionQuality: 1.0) else {
         return
       }
       
       var photoReference: StorageReference!
        
         photoReference = storageRef.child("TaskPhotos/\(taskId).jpg")
       
       let metadata = StorageMetadata()
       metadata.contentType = "image/jpg"
       
       let _ = photoReference.putData(imageData, metadata: metadata) { (metadata, error) in
         if let error = error {
           completion(.failure(error))
         } else if let _ = metadata {
           photoReference.downloadURL { (url, error) in
             if let error = error {
               completion(.failure(error))
             } else if let url = url {
               completion(.success(url))
             }
           }
         }
       }
     }
}

