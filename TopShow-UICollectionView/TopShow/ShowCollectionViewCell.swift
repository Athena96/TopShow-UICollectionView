//
//  ShowCollectionViewCell.swift
//  TopShow
//
//  Created by Jared Franzone on 3/22/16.
//  Copyright © 2016 Jared Franzone. All rights reserved.
//

import UIKit

class ShowCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
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
            

            // self.clipsToBounds = true
            // self.layer.cornerRadius = CGFloat(7)
            
        }
    }

    
}
