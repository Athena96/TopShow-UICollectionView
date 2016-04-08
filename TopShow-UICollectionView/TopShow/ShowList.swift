
import UIKit
import Foundation

final class ShowList {
    
    func getListOfShows() -> [Show] {
        
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
        showsToReturn.sortInPlace({ $0.rating > $1.rating })
        
        return showsToReturn
    }
    
}