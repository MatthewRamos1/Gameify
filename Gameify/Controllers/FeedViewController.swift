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
    private var friendsList = [Friend]()
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
