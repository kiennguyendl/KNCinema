//
//  RegisterViewController.swift
//  KNCinema
//
//  Created by Nguyen Dang Kien on 6/21/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: BaseViewController {

    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tfPassword.isSecureTextEntry = true
        tfConfirmPassword.isSecureTextEntry = true
        
    }

    @IBAction func registerBtn(_ sender: Any) {
        if isConnectedToNetwork(){
            startLoading()
            guard let username = tfUserName.text, let email = tfEmail.text, let passWord = tfPassword.text, let confirmPass = tfConfirmPassword.text else {
                return
            }
            
            if checkInvalid(){
                FIRAuth.auth()?.createUser(withEmail: email, password: passWord, completion: { (user: FIRUser?, error) in
                    if let error = error{
                        self.stopLoading()
                        self.showErrorFirebase(title: "Error", error: error as NSError)
                    }else if let user = user{
                        let updateUser = user.profileChangeRequest()
                        updateUser.displayName = username
                        if let photoURL: URL = URL(string: User.avartar_default){
                            updateUser.photoURL = photoURL
                            //save user into firebase
                            self.addUserToFireBase(user: user, updateUser: updateUser, name: username, email: email, imgUrlStr: photoURL.absoluteString )
                            self.handleLogout()
                            self.stopLoading()
                            let alertController = UIAlertController(title: "Thông báo", message: "Bạn đăng ký tài khoản thành công. Vui lòng xác thực và đăng nhập.", preferredStyle:UIAlertControllerStyle.alert)
                            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self](UIAlertAction) in
                                self?.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alertController, animated: true, completion: nil)
                        }

                    }
                })
            }else{
                stopLoading()
                return
            }
            
        }else{
            showAlert(title: "Network Error", message: "Please check network!")
        }
    }
    
    func addUserToFireBase(user: FIRUser, updateUser: FIRUserProfileChangeRequest, name: String, email: String, imgUrlStr: String) {
        updateUser.commitChanges(completion: {(error) in
            if let error = error {
                self.stopLoading()
                self.showAlert(title: "Error", message: error.localizedDescription)
            }else{
                let userInfo:[String:AnyObject] = [
                    "displayName"       : name as AnyObject,
                    "email"             : email as AnyObject,
                    "avatarUrl"            : imgUrlStr as AnyObject,
                    "provider"          : user.providerID as AnyObject,
                    "lastLogin"         : "\(NSDate().timeIntervalSince1970)" as AnyObject
                ]
                
                self.addUserInfo(user: user, userInfo: userInfo)
                self.stopLoading()
            }
        })
    }
    
    //add user to data firebase
    func addUserInfo(user: FIRUser, userInfo: [String:AnyObject]) {
        
        self.fireBaseRef.child("Accounts").child(user.uid).setValue(userInfo, withCompletionBlock: { (error, data) in
            if error != nil {
                print(error!)
            }
        })
    }

    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkInvalid() -> Bool {
        guard let userName = tfUserName.text, let email = tfEmail.text, let passWord = tfPassword.text, let confirmPass = tfConfirmPassword.text else {
            return false
        }
        if userName == ""{
            tfUserName.becomeFirstResponder()
            showAlert(title: "Register", message: "Please input Username")
            return false
        }
        
        if email == ""{
            tfEmail.becomeFirstResponder()
            showAlert(title: "Register", message: "Please input email")
            return false
        }
        
        if passWord == ""{
            tfPassword.becomeFirstResponder()
            showAlert(title: "Register", message: "Please input password")
            return false
        }
        
        if confirmPass == ""{
            tfConfirmPassword.becomeFirstResponder()
            showAlert(title: "Register", message: "Please input password again")
            return false
        }
        
        if passWord != confirmPass{
            tfConfirmPassword.text = ""
            tfConfirmPassword.becomeFirstResponder()
            showAlert(title: "Register", message: "Password input correct password")
            return false
        }
        return true
    }
}
