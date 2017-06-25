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
import MBProgressHUD

class BaseViewController: UIViewController {
    //let fireBaseRef:
    let fireBaseRef = FIRDatabase.database().reference()
    var keyboardHidden = true
    var hideKeyboardTap:UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        createNotificationCenter()
        hideKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(tapScreen))
        // Do any additional setup after loading the view.
    }

    //start loading indicator
    func startLoading() {
        MBProgressHUD.hide(for: self.view, animated: false)
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    //stop loading indicator
    func stopLoading() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    //check network
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        return isReachable && !needsConnection
        
    }
    
    //check email
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
    }
    
    //handle logout
    func handleLogout() {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
    }
    
    func createNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyBoard(notification:) ), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyBoard(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.tapScreen), name: NSNotification.Name.init("closeKeyboard"), object: nil)
    }
    
    func tapScreen() {
        if !keyboardHidden {
            self.view.endEditing(true)
        }
    }
    
    // MARK: Show Keyboard
    func willShowKeyBoard(notification : NSNotification){
        keyboardHidden = false
        let userInfo: NSDictionary! = notification.userInfo as NSDictionary!
        
        var duration : TimeInterval = 0
        
        duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let keyboardFrame = (userInfo.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue
        
        handleKeyboardWillShow(duration: duration,keyBoardRect: keyboardFrame, userInfo: userInfo)
    }
    
    // MARK: Hide Keyboard
    func willHideKeyBoard(notification : NSNotification){
        keyboardHidden = true
        var userInfo: NSDictionary!
        userInfo = notification.userInfo as NSDictionary!
        
        var duration : TimeInterval = 0
        duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        let keyboardFrame = (userInfo.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue
        
        handleKeyboardWillHide(duration: duration, keyBoardRect: keyboardFrame, userInfo: userInfo)
    }
    
    // MARK: Action of Show Keyboard
    func handleKeyboardWillShow(duration: TimeInterval, keyBoardRect: CGRect, userInfo: NSDictionary) {
        self.view.addGestureRecognizer(hideKeyboardTap)
        // Find which textField is focused
        for focusingView in self.view.subviews {
            if focusingView.isFirstResponder {
                
                let y = focusingView.frame.origin.y
                let offset = y - (view.bounds.height - (keyBoardRect.size.height + 100))
                
                if offset > 0 {
                    UIView.animate(withDuration: duration, delay: 0, options:[], animations: { [weak self] in
                        guard let strongSelf = self else { return }
                        
                        strongSelf.view.frame.origin.y = 0 - offset
                        }, completion: nil)
                }
                
                break
            }
        }
        
    }
    
    // MARK: Action of Hide Keyboard
    func handleKeyboardWillHide(duration: TimeInterval, keyBoardRect: CGRect, userInfo: NSDictionary) {
        
        self.view.removeGestureRecognizer (hideKeyboardTap)
        UIView.animate(withDuration: duration, delay: 0, options:[], animations: { [weak self] in
            
            guard let strongSelf = self else { return }
            strongSelf.view.frame.origin.y = 0
            
            
            }, completion: nil)
    }

    // Remove Observer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
