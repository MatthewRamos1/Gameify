//
//  QuestBoardController.swift
//  Gameify
//
//  Created by Matthew Ramos on 9/1/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class QuestBoardController: UIViewController {

    @IBOutlet weak var questBoardCollectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var tasksListener: ListenerRegistration?
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questBoardCollectionView.dataSource = self
        questBoardCollectionView.delegate = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupTasksListener()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        tasksListener?.remove()
    }
    
    private func setupTasksListener() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        tasksListener = Firestore.firestore().collection(DatabaseServices.userCollection).document(uid).collection(DatabaseServices.taskCollection).addSnapshotListener( { (snapshot, error) in
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription)
            } else if let snapshot = snapshot {
                let tempTasks =  snapshot.documents.map { Task($0.data())}
                self.tasks = tempTasks
                
            }
        })
    }
}

extension QuestBoardController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
    
    
}

extension QuestBoardController: UICollectionViewDelegateFlowLayout {
    
}
