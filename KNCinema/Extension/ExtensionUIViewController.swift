//
//  ExtensionUIViewController.swift
//  KNCinema
//
//  Created by kienND9 on 6/19/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit

extension UIViewController{
    func isIpad() -> Bool {
        let horizontal = UIScreen.main.traitCollection.horizontalSizeClass
        let vertical = UIScreen.main.traitCollection.verticalSizeClass
        if horizontal == .regular && vertical == .regular{
            return true
        }
        return false
        
    }
}
