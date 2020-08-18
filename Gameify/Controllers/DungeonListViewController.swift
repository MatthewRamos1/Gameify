//
//  DungeonListViewController.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/17/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

class DungeonListViewController: UIViewController {
    
    @IBOutlet weak var dungeonListTV: UITableView!
    
    let dungeonList = DungeonList.dungeonList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dungeonListTV.delegate = self
        dungeonListTV.dataSource = self

    }
}

extension DungeonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dungeonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dungeonListCell", for: indexPath) as? DungeonListCell else {
            return UITableViewCell()
        }
        let dungeon = dungeonList[indexPath.row]
        cell.configureCell(dungeon: dungeon)
        return cell
    }
}

extension DungeonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
}
