//
//  AVAudioPlayer + Extensions.swift
//  Gameify
//
//  Created by Matthew Ramos on 10/7/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation
import AVFoundation

enum VcId: String {
    case combat = "battleTheme1"
    case guild = "canon14"
}

extension AVAudioPlayer {
    
    static func setBackgroundPlayer(VcId: VcId) -> AVAudioPlayer? {
        let music = Bundle.main.path(forResource: VcId.rawValue, ofType: "wav")
        do {
            let backgroundPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: music!))
            return backgroundPlayer
        } catch {
            print("error")
            return nil
        }
    }
}
