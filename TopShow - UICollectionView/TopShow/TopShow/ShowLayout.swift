//
//  ShowLayout.swift
//  TopShow
//
//  Created by Jared Franzone on 8/19/16.
//  Copyright © 2016 Jared Franzone. All rights reserved.
//

import UIKit

protocol ShowLayoutDelegate {
    // Method to ask the delegate for the height of the image
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath , withWidth:CGFloat) -> CGFloat
}

final class ShowLayoutAttributes: UICollectionViewLayoutAttributes {
    
    // Custom attribute
    var photoHeight: CGFloat = 0.0
    
    // Override copyWithZone to conform to NSCopying protocol
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! ShowLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    /*
    override func copy() -> Any {
        let copy = super.copy() as! ShowLayoutAttributes
        let copy = super.copy(with: zone) as! ShowLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
 */
    /*
    override func copy(with zone: NSZone?) -> AnyObject {
        let copy = super.copy(with: zone) as! ShowLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    */
    
    // Override isEqual
    override func isEqual(_ object: Any?) -> Bool {
        if let attributtes = object as? ShowLayoutAttributes {
            if( attributtes.photoHeight == photoHeight  ) {
                return super.isEqual(object)
            }
        }
        return false
    }    
    /*
    override func isEqual(_ object: AnyObject?) -> Bool {
        if let attributtes = object as? ShowLayoutAttributes {
            if( attributtes.photoHeight == photoHeight  ) {
                return super.isEqual(object)
            }
        }
        return false
    }
 */
    
}

final class ShowLayout: UICollectionViewLayout {
    
    // Layout Delegate
    var delegate:ShowLayoutDelegate!
    
    // Configurable properties
    private var numberOfColumns = 2
    private var cellPadding: CGFloat = 6.0
    private var cellPaddingBottom: CGFloat = 56.0
    
    // Array to keep a cache of attributes.
    private var cache = [ShowLayoutAttributes]()
    
    // Content height and size
    private var contentHeight:CGFloat  = 0.0
    
    private var contentWidth: CGFloat {
        guard let collectionV = collectionView else {
            return 0.0
        }
        return collectionV.bounds.width - (collectionV.contentInset.left + collectionV.contentInset.right)
    }

    override func prepare() {
        //  Only calculate once
        
        guard let collectionV = collectionView else {
            return
        }
        
        if cache.isEmpty {
            
            // Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            for column in 0 ..< numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth )
            }
            var column = 0
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            
            
            //  Iterates through the list of items in the first section
            for item in 0 ..< collectionV.numberOfItems(inSection: 0) {
                
                let indexPath = IndexPath(item: item, section: 0)
                
                //  Asks the delegate for the height of the picture and the annotation and calculates the cell frame.
                let width = columnWidth - cellPadding * 2
                let photoHeight = delegate.collectionView(collectionV, heightForPhotoAtIndexPath: indexPath , withWidth:width)
                let height = cellPadding +  photoHeight  + cellPaddingBottom
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                // Creates an UICollectionViewLayoutItem with the frame and add it to the cache
                let attributes = ShowLayoutAttributes(forCellWith: indexPath)
                attributes.photoHeight = photoHeight
                attributes.frame = insetFrame
                cache.append(attributes)
                
                //  Updates the collection view content height
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
                
            } // end for....
            
        } // end the cache check
        
    } // end prep layout
    
    
    override public func invalidateLayout() {
        self.cache.removeAll()
        super.invalidateLayout()
        
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes  in cache {
            if attributes.frame.intersects(rect ) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override class var layoutAttributesClass: AnyClass {
        return ShowLayoutAttributes.self
    }

}
