//
//  DungeonProgressViewController.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/17/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

class DungeonProgressViewController: UIViewController {
    
    @IBOutlet weak var spriteLeadingConstraint: NSLayoutConstraint!
    var dungeon: Dungeon? {
        didSet {
            fetchDungeonProgress()
        }
    }
    var dungeonProgress: Int? {
        didSet {
            UIView.animate(withDuration: 4, animations: {
                self.spriteLeadingConstraint.constant += self.constraintIncreaseCalculation()
            })
        }
    }
    var dungeonStatus: DungeonStatus?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func fetchDungeonProgress() {
        DatabaseServices.shared.getDungeonProgressData() { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            case .success(let status):
                self?.dungeonStatus = status
                switch self?.dungeon?.name {
                case "Dungeon 1":
                    self?.dungeonProgress = status.dungeon1
                default:
                    self?.dungeonProgress = 0
                }
            }
            
        }
    }
    
    private func constraintIncreaseCalculation() -> CGFloat {
        guard let enemyCount = dungeon?.enemyCount else {
            showAlert(title: "Error", message: "No Dungeon Loaded")
            return 0.0
        }
        let increaseIncrement = UIScreen.main.bounds.width / CGFloat(enemyCount)
        let constraintIncrease = increaseIncrement * CGFloat(dungeonProgress!)
        return constraintIncrease
    }
    
    @IBAction func embarkButtonPressed(_ sender: UIButton) {
        guard let tempDungeon = dungeon else {
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let combatVC = storyboard.instantiateViewController(withIdentifier: "CombatViewController") as? CombatViewController else {
            return
        }
        combatVC.dungeon = tempDungeon
        combatVC.enemy = DungeonList.getEnemy(dungeon: tempDungeon)
        combatVC.dungeonProgress = dungeonProgress
        navigationController?.pushViewController(combatVC, animated: true)
    }
}
