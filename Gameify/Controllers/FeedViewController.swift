//
//  FeedViewController.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/21/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    private var friendsList = [Friend]() {
        didSet {
            fetchFeedUpdates()
        }
    }
    private var taskUpdates = [Update]() {
        didSet {
            feedCollectionView.reloadData()
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        feedCollectionView.dataSource = self
        feedCollectionView.delegate = self
        fetchFriendsList()
    }
    
    private func fetchFriendsList() {
        DatabaseServices.shared.getFriendsList() { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            case .success(let friendList):
                self?.friendsList = friendList
            }
        }
    }
    
    private func fetchFeedUpdates() {
        for friend in friendsList {
            DatabaseServices.shared.getFriendRecentlyCompletedTasks(friendUid: friend.id) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Error", message: error.localizedDescription)
                    }
                case .success(let tasks):
                    var tempTasks = [Update]()
                    for task in tasks {
                        task.userName = friend.username
                        tempTasks.append(task)
                        
                        //nested loop, too slow
                    }
                    self?.taskUpdates += tempTasks
                }
            }
        }
    }
    
    private func sortFeedUpdatesByDate() {
        let sortedUpdates = taskUpdates.sorted { $0.completionDate > $1.completionDate }
        taskUpdates = sortedUpdates
    }
}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        taskUpdates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as? FeedCell else { return UICollectionViewCell() }
        cell.shadowConfig()
        let completedTask = taskUpdates[indexPath.row]
        cell.configureCell(completedTask: completedTask)
        return cell
    }
    
    
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.9
        let itemHeight: CGFloat = maxSize.height * 0.4
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        40
    }
}
