//
//  User.swift
//  KNCinema
//
//  Created by kienND9 on 6/22/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit

class User: NSObject {
    static let avartar_default = "https://firebasestorage.googleapis.com/v0/b/kncenima.appspot.com/o/Images%2Fdefault_avatar.png?alt=media&token=5811b7ed-bb96-4a74-a7c1-93e5c2e3110c"
    
    var id:String?
    var userName:String?
    var passWord: String?
    var email: String?
    var avartar:String = avartar_default
    var lastLogin:NSDate = NSDate()
    
    init?(id: String, jSonData: [String: AnyObject]) {
        guard let userName = jSonData["userName"] as? String ,
            let email = jSonData["email"] as? String
            else { return nil }
        
        if let passWord = jSonData["passWord"] as? String{
           self.passWord = passWord
        }
        
        if let lastLogin = jSonData["lastLogin"] as? Double{
            self.lastLogin = NSDate(timeIntervalSince1970: lastLogin)
        }
        
        self.id = id
        self.userName = userName
        self.email = email
    }
}
