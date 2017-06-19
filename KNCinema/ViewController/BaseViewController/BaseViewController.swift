//
//  BaseViewController.swift
//  KNCinema
//
//  Created by kienND9 on 6/19/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        if isIpad(){
            return .landscape
        }
        return .portrait
    }
}
