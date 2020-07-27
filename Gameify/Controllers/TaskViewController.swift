//
//  TaskViewController.swift
//  Gameify
//
//  Created by Matthew Ramos on 7/26/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet weak var taskTV: UITableView!
    
    var tasks = [Task(title: "Work on Passion Project", description: "Duration: 1 Hour", rating: 4, statUps: [.constitution])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTV.dataSource = self

    }
    

}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "someCell", for: indexPath)
        return cell
    }
    
    
}
