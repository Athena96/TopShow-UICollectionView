//
//  Show.swift
//  TopShow
//
//  Created by Jared Franzone on 3/22/16.
//  Copyright © 2016 Jared Franzone. All rights reserved.
//

import Foundation
import UIKit

class Show {
    
    // Properties of our show
    var title: String
    var rating: Int
    var image: UIImage
    
    // we call this whenever we need to make a new show
    init(title: String, rating: Int, image: UIImage) {
        self.title = title;
        self.rating = rating;
        self.image = image;
    }
    
}