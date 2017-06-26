//
//  LoginViewController.swift
//  KNCinema
//
//  Created by kienND9 on 6/19/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

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
        if isConnectedToNetwork(){
            startLoading()
            guard let email = txtUserName.text, let pw = txtPassword.text else {
                return
            }
            
            if checkValidateValue(){
                FIRAuth.auth()?.signIn(withEmail: email, password: pw, completion: {(user, error) in
                    if let error = error{
                        self.stopLoading()
                        self.showErrorFirebase(title: "Error Server", error: error as NSError)
                    }
                    
                    
                    if let _ = user{
                        self.txtUserName.text = ""
                        self.txtPassword.text = ""
                        NotificationCenter.default.addObserver(self, selector: #selector(self.pushHome), name: NSNotification.Name(rawValue: "SuccessLoading"), object: nil)
                    }
                })
            }else{
                stopLoading()
                showAlert(title: "Error Login", message: "Login fail!")
            }
        }else{
            stopLoading()
            showAlert(title: "Error Network", message: "Please check connect to network")
        }
    }
    
    @IBAction func signInWithFBBtn(_ sender: Any) {
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        let vc = RegisterViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @objc private func pushHome(){
        let vc = HomeViewController()
        navigationController?.pushViewController(vc, animated: true)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "SuccessLoading"), object: nil)
        stopLoading()
    }
    
    private func checkValidateValue() -> Bool {
        guard let email:String = txtUserName.text,
            let pw:String = txtPassword.text
            else { return false }
        
        if email == "" {
            showAlert(title: "Login", message: "please input email")
            txtUserName.becomeFirstResponder()
            return false
        } else if !isValidEmail(emailStr: email) {
            txtUserName.text = ""
            txtUserName.becomeFirstResponder()
            showAlert(title: "Login", message: "Email not correct")
            return false
        }
        
        if pw == "" {
            txtPassword.becomeFirstResponder()
            showAlert(title: "Login", message: "Please input password")
            return false
        }
        
        return true
        
    }
    
}
