//
//  TypeMovie.swift
//  KNCinema
//
//  Created by kienND9 on 7/3/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit

class TypeMovie: NSObject {
    var typeID: String?
    var movies :[Movie]?
    
    init?(id: String, movies: [Movie]) {
        self.typeID = id
        self.movies = movies
    }
}
