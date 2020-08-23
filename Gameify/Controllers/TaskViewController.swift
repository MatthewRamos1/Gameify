//
//  TaskViewController.swift
//  Gameify
//
//  Created by Matthew Ramos on 7/26/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class TaskViewController: UIViewController {
    
    @IBOutlet weak var taskTV: UITableView!
    
    var tasks = [Task]() {
        didSet {
            sortedTasks = getSections()
        }
    }
    
    var sortedTasks = [[Task]]() {
        didSet {
            taskTV.reloadData()
        }
    }
    
    var tasksListener: ListenerRegistration?
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        taskTV.dataSource = self
        taskTV.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupTasksListener()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        tasksListener?.remove()
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
    
    private func updateUser(dict: [String: Any], alertString: String) {
        DatabaseServices.shared.updateUserStats(dict: dict) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Task Cleared!", message: alertString)
                }
            }
        }
    }
    
    private func userToDict(user: User) -> [String:Any] {
        let dict = ["level": user.level, "strength": user.strength, "constitution": user.constitution, "intelligence": user.intelligence, "wisdom": user.wisdom, "dexAgi": user.dexAgi, "charisma": user.charisma, "strengthExp": user.strengthExp, "constitutionExp": user.constitutionExp, "intelligenceExp": user.intelligenceExp, "wisdomExp": user.wisdomExp, "dexAgiExp": user.dexAgiExp, "charismaExp": user.charismaExp, "strengthCap": user.strengthCap, "constitutionCap": user.constitutionCap, "intelligenceCap": user.intelligenceCap, "wisdomCap": user.wisdomCap, "dexAgiCap": user.dexAgiCap, "charismaCap": user.charismaCap, "gold": user.gold]
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
    
    private func taskCompletion(_ task: Task) -> String {
        let experience = ratingExpConversion(rating: task.rating)
        var alertString = "\(experience) experience gained!"
        var statGained: Stat? {
            didSet {
                alertString = "\(experience) \(statGained?.rawValue ?? "") experience gained!"
            }
        }
        var wasStatGained = false {
            didSet {
                alertString += "\n \(statGained?.rawValue ?? "") up!"
            }
        }
        switch task.statUps.first {
        case .strength:
            statGained = .strength
            user.strengthExp += experience
            if user.strengthExp >= user.strengthCap {
                let diff = user.strengthExp - user.strengthCap
                user.strength += 1
                wasStatGained.toggle()
                user.strengthExp = diff
                user.strengthCap = expCap(level: user.strength)
            }
        case .constitution:
            statGained = .constitution
            user.constitutionExp += experience
            if user.constitutionExp >= user.constitutionCap {
                let diff = user.constitutionExp - user.constitutionCap
                user.constitution += 1
                wasStatGained.toggle()
                user.constitutionExp = diff
                user.constitutionCap = expCap(level: user.constitution)
            }
        case .intelligence:
            statGained = .intelligence
            user.intelligenceExp += experience
            if user.intelligenceExp >= user.intelligenceCap {
                let diff = user.intelligenceExp - user.intelligenceCap
                user.intelligence += 1
                wasStatGained.toggle()
                user.intelligenceExp = diff
                user.intelligenceCap = expCap(level: user.intelligence)
            }
        case .wisdom:
            statGained = .wisdom
            user.wisdomExp += experience
            if user.wisdomExp >= user.wisdomCap {
                let diff = user.wisdomExp - user.wisdomCap
                user.wisdom += 1
                wasStatGained.toggle()
                user.wisdomExp = diff
                user.wisdomCap = expCap(level: user.wisdom)
            }
        case .dexAgi:
            statGained = .dexAgi
            user.dexAgiExp += experience
            if user.dexAgiExp >= user.dexAgiCap {
                let diff = user.dexAgiExp - user.dexAgiCap
                user.dexAgi += 1
                wasStatGained.toggle()
                user.dexAgiExp = diff
                user.dexAgiCap = expCap(level: user.dexAgi)
            }
        default:
            statGained = .charisma
            user.charismaExp += experience
            if user.charismaExp >= user.charismaCap {
                let diff = user.charismaExp - user.charismaCap
                user.charisma += 1
                wasStatGained.toggle()
                user.charismaExp = diff
                user.charismaCap = expCap(level: user.charisma)
            }
        }
        let totalLevel = user.strength + user.constitution + user.intelligence + user.wisdom + user.dexAgi + user.charisma
        if (totalLevel / 6) > user.level {
            user.level += 1
        }
        return alertString
    }
    
    private func ratingExpConversion (rating: Int) -> Int {
        switch rating {
        case 1, 2, 3:
            return rating
        case 4:
            return 5
        case 5:
            return 7
        case 6:
            return 10
        case 7:
            return 14
        case 8:
            return 20
        case 9:
            return 32
        case 10:
            return 50
        default:
            return 0
        }
    }
    
    private func dailyStreakCalculation (completionDate: Date) -> Bool {
        let calendar = NSCalendar.current
        let tempCreationDate = calendar.startOfDay(for: completionDate)
        let currentDate = calendar.startOfDay(for: Date())
        
        let components = calendar.dateComponents([.day], from: tempCreationDate, to: currentDate)
        if components.day! == 1 {
            return true
        }
        return false
    }
    
    private func deleteTask(task: Task) {
        DatabaseServices.shared.deleteUserTask(task: task) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            case .success:
                print("nice")
            }
        }
    }
    
    private func getSections() -> [[Task]] {
        let sortedTasks = tasks.sorted { $0.rating > $1.rating }
        var sections = Array(repeating: [Task](), count: 5)
        for task in sortedTasks {
            switch task.rating {
            case 10, 9:
                sections[0].append(task)
            case 8, 7:
                sections[1].append(task)
            case 6, 5:
                sections[2].append(task)
            case 4, 3:
                sections[3].append(task)
            case 2, 1:
                sections[4].append(task)
            default:
                return [[Task]]()
            }
        }
        var index = 0
        for section in sections {
            if section.isEmpty {
                sections.remove(at: index)
            } else {
                index += 1
            }
        }
        return sections
    }
    
    private func taskToDict(task: Task) -> [String:Any] {
        let dict = ["title": task.title, "description": task.description, "rating": task.rating, "statUps": task.statUps.first!.rawValue, "repeatable": task.repeatable.rawValue, "dayStreak": task.dayStreak, "creationDate": task.creationDate, "id": task.id] as! [String:Any]
        return dict
    }
}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortedTasks[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sortedTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        let task = sortedTasks[indexPath.section][indexPath.row]
        cell.configureCell(task)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sortedTasks[section].first?.rating {
        case 10, 9:
            return "5 Star"
        case 8, 7:
            return "4 Star"
        case 6, 5:
            return "3 Star"
        case 4, 3:
            return "2 Star"
        case 2, 1:
            return "1 Star"
        default:
            return "Error"
        }
    }
    
    
}

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = sortedTasks[indexPath.section][indexPath.row]
        let alertString = taskCompletion(task)
        let statsDict = userToDict(user: user)
        updateUser(dict: statsDict, alertString: alertString)
        if task.repeatable == .daily && dailyStreakCalculation(completionDate: task.creationDate!) {
            task.dayStreak += 1
        }
        if task.repeatable == .daily && dailyStreakCalculation(completionDate: task.creationDate!) {
            task.dayStreak = 0
        }
        let dict = taskToDict(task: task)
        DatabaseServices.shared.updateUserTask(task: task, dict: dict) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Error", message: error.localizedDescription)
            case .success:
                print("added streak counter")
            }
        }
        
        if task.repeatable == .oneshot {
            deleteTask(task: task)
            DatabaseServices.shared.createRecentlyCompletedTask(task: task) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                case .success:
                    print("nice")
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let task = sortedTasks[indexPath.section][indexPath.row]
        if editingStyle == .delete {
            DatabaseServices.shared.deleteUserTask(task: task) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Error", message: error.localizedDescription)
                    }
                case .success:
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Success", message: "Task Deleted")
                    }
                }
            }
            
        }
    }
}

extension TaskViewController: editTaskButtonDelegate {
    func buttonWasPressed(_ cell: TaskCell, _ task: Task) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createTaskVC = storyboard.instantiateViewController(identifier: "CreateTaskViewController") as! CreateTaskViewController
        createTaskVC.task = task
        navigationController?.pushViewController(createTaskVC, animated: true)
    }
    
    
}
