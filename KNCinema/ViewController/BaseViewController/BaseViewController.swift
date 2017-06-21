//
//  BaseViewController.swift
//  KNCinema
//
//  Created by kienND9 on 6/19/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit
import Firebase
import SystemConfiguration
import FirebaseDatabase

class BaseViewController: UIViewController {
    //let fireBaseRef:
    let fireBaseRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func startLoading() {
        
    }
    
    func stopLoading() {
        
    }
}
