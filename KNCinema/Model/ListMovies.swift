//
//  ListMovies.swift
//  KNCinema
//
//  Created by kienND9 on 6/30/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit

class ListMovies: NSObject {
    var typeMovie: String?
    var movies: [String: AnyObject]?
    
    init?(id: String, jsonData: [String: AnyObject]) {
        self.typeMovie = id
        
//        if let conversationsData = JsonData["conversations"] as? [String:AnyObject] {
//            for item in conversationsData {
//                guard let conversation = Conversations(key: item.key, JsonData: item.value as! [String:AnyObject]) else {return}
//                self.conversations.append(conversation)
//            }
//        }
        
//        if let movies = jsonData["Movies"] as? [String: AnyObject]{
//            for movies in movies{
//                
//            }
//        }
        
    }
}
