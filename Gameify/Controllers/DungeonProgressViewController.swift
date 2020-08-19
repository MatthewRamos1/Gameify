//
//  DungeonProgressViewController.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/17/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

class DungeonProgressViewController: UIViewController {
    
    var dungeon: Dungeon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        navigationController?.pushViewController(combatVC, animated: true)
    }
}
