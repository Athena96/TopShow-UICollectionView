

import UIKit

protocol ShowLayoutDelegate {
    // Method to ask the delegate for the height of the image
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath , withWidth:CGFloat) -> CGFloat
}

final class ShowLayoutAttributes: UICollectionViewLayoutAttributes {
    
    // Custom attribute
    var photoHeight: CGFloat = 0.0
    
    // Override copyWithZone to conform to NSCopying protocol
    override func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = super.copyWithZone(zone) as! ShowLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    // Override isEqual
    override func isEqual(object: AnyObject?) -> Bool {
        if let attributtes = object as? ShowLayoutAttributes {
            if( attributtes.photoHeight == photoHeight  ) {
                return super.isEqual(object)
            }
        }
        return false
    }
    
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
        
        return CGRectGetWidth(collectionV.bounds) - (collectionV.contentInset.left + collectionV.contentInset.right)
    }
    
    override func prepareLayout() {
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
            var yOffset = [CGFloat](count: numberOfColumns, repeatedValue: 0)
            
            
            //  Iterates through the list of items in the first section
            for item in 0 ..< collectionV.numberOfItemsInSection(0) {
                
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                
                //  Asks the delegate for the height of the picture and the annotation and calculates the cell frame.
                let width = columnWidth - cellPadding * 2
                let photoHeight = delegate.collectionView(collectionV, heightForPhotoAtIndexPath: indexPath , withWidth:width)
                let height = cellPadding +  photoHeight  + cellPaddingBottom
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = CGRectInset(frame, cellPadding, cellPadding)
                
                // Creates an UICollectionViewLayoutItem with the frame and add it to the cache
                let attributes = ShowLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.photoHeight = photoHeight
                attributes.frame = insetFrame
                cache.append(attributes)
                
                //  Updates the collection view content height
                contentHeight = max(contentHeight, CGRectGetMaxY(frame))
                yOffset[column] = yOffset[column] + height
                
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
                
            } // end for....
            
        } // end the cache check
        
    } // end prep layout
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes  in cache {
            if CGRectIntersectsRect(attributes.frame, rect ) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override class func layoutAttributesClass() -> AnyClass {
        return ShowLayoutAttributes.self
    }
    
}
