
import Foundation
import UIKit


/**
 * Class because I allow the user to change the state of the
 * object when they tap on a show in the collection view (changing the rating).
 */
final class Show {
    
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