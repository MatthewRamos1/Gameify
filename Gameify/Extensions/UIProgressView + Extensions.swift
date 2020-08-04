//
//  UIProgressView + Extensions.swift
//  Gameify
//
//  Created by Matthew Ramos on 8/4/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

extension UIProgressView {
    func editProgressColor(progress: Float) {
        
        switch true {
        case progress <= 0.20:
            progressTintColor = .systemRed
        case progress <= 0.40:
            progressTintColor = .systemOrange
        case progress <= 0.60:
            progressTintColor = .systemYellow
        case progress <= 0.80:
            progressTintColor = .systemGreen
        default:
            progressTintColor = .systemTeal
        }
    }
}

