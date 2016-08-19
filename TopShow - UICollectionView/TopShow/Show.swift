//
//  Show.swift
//  TopShow
//
//  Created by Jared Franzone on 8/19/16.
//  Copyright © 2016 Jared Franzone. All rights reserved.
//

import Foundation
import UIKit

struct Show {
    
    var title: String
    
    var rating: Int
    
    var image: UIImage
    
    static func createListOfShows() -> [Show] {
        
        let showList = [
            "House of Cards",
            "How I Met Your Mother",
            "LOST",
            "Mad Men",
            "Parks and Recreation",
            "Seinfeld",
            "Silicon Valley",
            "The Big Bang Theory",
            "The Office"
        ]
        
        var showsToReturn = [Show]()
        
        for show in showList {
            
            guard let image = UIImage(named: show) else {
                return showsToReturn
            }
            
            // Get the title, rating, and image needed to create a show
            let title = show
            let rating = Int(arc4random_uniform((UInt32(5)))) + 1
            
            // Create the show
            let show = Show(title: title, rating: rating, image: image)
            
            // Add it to our array
            showsToReturn.append(show)
        }
        
        // sort the list; greatest to least (by the rating)
        showsToReturn.sort(by: { $0.rating > $1.rating })
        
        return showsToReturn
    }

}
