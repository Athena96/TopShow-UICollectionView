

import UIKit

final class ShowCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var showImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    @IBOutlet private weak var imageHeightConstraint: NSLayoutConstraint!
    
    var show: Show? {
        didSet {
            if let show = show {
                showImageView.image = show.image
                titleLabel.text = show.title
                ratingLabel.text = String(count: show.rating, repeatedValue:("★" as Character))
                
            }
        }
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        
        super.applyLayoutAttributes(layoutAttributes)
        
        if let attributes = layoutAttributes as? ShowLayoutAttributes {
            imageHeightConstraint.constant = attributes.photoHeight
            
            // Uncomment to have rounded corners on your cell.
            // self.clipsToBounds = true
            // self.layer.cornerRadius = CGFloat(7)
            
        }
    }

    
}
