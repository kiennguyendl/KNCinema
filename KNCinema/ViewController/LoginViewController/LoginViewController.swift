//
//  LoginViewController.swift
//  KNCinema
//
//  Created by kienND9 on 6/19/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignInWithFacebook: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        if isIpad(){
            return .landscape
        }
        return .portrait
    }

    @IBAction func signInBtn(_ sender: Any) {
        
    }
    
    @IBAction func signInWithFBBtn(_ sender: Any) {
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        let vc = RegisterViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
}
