//
//  ShowCollectionViewCell.swift
//  TopShow
//
//  Created by Jared Franzone on 8/19/16.
//  Copyright © 2016 Jared Franzone. All rights reserved.
//

import UIKit

class ShowCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var showImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var imageHeightConstraint: NSLayoutConstraint!
    
    var show: Show? {
        didSet {
            if let newShow = show {
                showImageView.image = newShow.image
                titleLabel.text = newShow.title
                ratingLabel.text = String(repeating: ("★" as Character), count: newShow.rating)
            }
        }
    }
    
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        
        super.apply(layoutAttributes)
        
        if let attributes = layoutAttributes as? ShowLayoutAttributes {
            imageHeightConstraint.constant = attributes.photoHeight
            
            // Uncomment to have rounded corners on your cell.
//            self.clipsToBounds = true
//            self.layer.cornerRadius = CGFloat(7)
            
        }
    }

    
    
}
