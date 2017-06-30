
//
//  Movie.swift
//  KNCinema
//
//  Created by kienND9 on 6/30/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit

class Movie: NSObject {
    
    var title: String?
    var des: String?
    var logoURL: String?
    var playURL: String?
    var actor: String?
    var director: String?
    var writer: String?
    
    init?(id: String, jsonData: [String: AnyObject]) {
        self.title = id
        if let description = jsonData["description"] as? String {
            self.des = description
        }
        
        if let logoURL = jsonData["logoURL"] as? String {
            self.logoURL = logoURL
        }
        
        if let playURL = jsonData["PlayURL"] as? String {
            self.playURL = playURL
        }
        
        if let actor = jsonData["actor"] as? String {
            self.actor = actor
        }
        
        if let director = jsonData["director"] as? String {
            self.director = director
        }
        
        if let writer = jsonData["writer"] as? String {
            self.writer = writer
        }
        
    }
}
