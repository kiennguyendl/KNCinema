//
//  ListMovies.swift
//  KNCinema
//
//  Created by kienND9 on 6/30/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit

class ListMovies: NSObject {
    var idTypeMovie: String?
    var typeMovies: [TypeMovie]?
    
    init?(id: String, typeMovies: [TypeMovie]) {
        self.idTypeMovie = id
        self.typeMovies = typeMovies
    }
}
