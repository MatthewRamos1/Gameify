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
    
    var tasks = [Task(title: "Work on Passion Project", description: "Duration: 1 Hour", rating: 4, statUps: [.dexAgi], repeatable: .always, id: "0")]
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        taskTV.dataSource = self
        taskTV.delegate = self

    }
    
    public func fetchUser() {
        DatabaseServices.shared.getUser { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            case .success(let user):
                self?.user = user
            }
        }
    }
    
    private func updateUser(dict: [String: Any]) {
        DatabaseServices.shared.updateUserStats(dict: dict) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Success", message: "Stat up!")
                }
            }
        }
    }
    
    private func userToDict(user: User) -> [String:Any] {
        let dict = ["level": user.level, "strength": user.strength, "constitution": user.constitution, "intelligence": user.intelligence, "wisdom": user.wisdom, "dexAgi": user.dexAgi, "charisma": user.charisma, "strengthExp": user.strengthExp, "constitutionExp": user.constitutionExp, "intelligenceExp": user.intelligenceExp, "wisdomExp": user.wisdomExp, "dexAgiExp": user.dexAgiExp, "charismaExp": user.charismaExp, "strengthCap": user.strengthCap, "constitutionCap": user.constitutionCap, "intelligenceCap": user.intelligenceCap, "wisdomCap": user.wisdomCap, "dexAgiCap": user.dexAgiCap, "charismaCap": user.charismaCap]
        return dict
    }
    
    private func expCap(level: Int) -> Int {
        if level == 1 {
            return 2
        }
        var val = level / 10
        let mod = level % 10
        var total = mod * (val + 2)
        while val != 0 {
            total += (val + 1) * 10
            val = val - 1
        }
        return total
    }
    

}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        let task = tasks[indexPath.row]
        cell.configureCell(task)
        return cell
    }
    
    
}

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        user.dexAgiExp += 1
        if user.dexAgiExp >= user.dexAgiCap {
            let diff = user.dexAgiExp - user.dexAgiCap
            user.dexAgi += 1
            user.dexAgiExp = diff
            user.dexAgiCap = expCap(level: user.dexAgi)
            let totalLevel = user.strength + user.constitution + user.intelligence + user.wisdom + user.dexAgi + user.charisma
            if totalLevel >= user.level / 6 {
                user.level += 1
            }
        }
        
        let statsDict = userToDict(user: user)
        updateUser(dict: statsDict)
    }
}
