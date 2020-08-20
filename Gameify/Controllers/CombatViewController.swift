//
//  CombatViewController.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/17/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

class CombatViewController: UIViewController {

    @IBOutlet weak var backgroundIV: UIImageView!
    @IBOutlet weak var enemyIV: UIImageView!
    @IBOutlet weak var enemyHealthProgress: UIProgressView!
    
    var dungeon: Dungeon?
    var enemy: Enemy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func attackButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.6, delay: 0.0, options: [.transitionCrossDissolve], animations: {
            self.enemyIV.alpha = 0
        }, completion: nil)
    }
    
}
