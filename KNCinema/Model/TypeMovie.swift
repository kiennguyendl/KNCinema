//
//  TypeMovie.swift
//  KNCinema
//
//  Created by kienND9 on 7/3/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit
import Firebase

class TypeMovie: NSObject {
    let ref = FIRDatabase.database().reference()
    var typeID: String?
    var movies :[Movie] = []
    
    
}
