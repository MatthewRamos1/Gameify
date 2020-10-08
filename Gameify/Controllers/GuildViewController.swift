//
//  GuildViewController.swift
//  Gameify
//
//  Created by Matthew Ramos on 9/16/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit
import AVFoundation

class GuildViewController: UIViewController {
    
    private var backgroundPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func itemShopButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShopViewController")
        show(vc, sender: self)
    }
    
}
