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
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertView(title: title, message: message, delegate: self, cancelButtonTitle: "OK")
        alert.show()
    }
    
    // Show error info form Firebase
    func showErrorFirebase(title: String,error: NSError) {
        self.showAlert(title: title, message: error.localizedDescription)
        self.view.isUserInteractionEnabled = true
    }
}
