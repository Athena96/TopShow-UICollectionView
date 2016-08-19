//
//  TopShowCollectionViewController.swift
//  TopShow
//
//  Created by Jared Franzone on 8/19/16.
//  Copyright © 2016 Jared Franzone. All rights reserved.
//

import UIKit
import AVFoundation

final class TopShowCollectionViewController: UICollectionViewController {

    private var shows = Show.createListOfShows()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the ShowLayout delegate
        if let layout = collectionView?.collectionViewLayout as? ShowLayout {
            layout.delegate = self
        }
        
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        self.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: Data Source
    
    // Number of cells in our UICollectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    // How we make each cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowCollectionViewCell", for: indexPath) as? ShowCollectionViewCell {
            cell.show = shows[(indexPath as NSIndexPath).item]
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    // MARK: Delegate
    
    // If we select an item... then toggle the shows rating
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ShowCollectionViewCell {
            shows[indexPath.row].rating = (shows[indexPath.row].rating < 5) ? shows[indexPath.row].rating + 1 : 1
            cell.show = shows[indexPath.row]
        }
        
    }
    
}

extension TopShowCollectionViewController : ShowLayoutDelegate {
    
    // Returns the photo height
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath , withWidth width:CGFloat) -> CGFloat {
        let photo = shows[(indexPath as NSIndexPath).item].image
        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude)
        let rect  = AVMakeRect(aspectRatio: photo.size, insideRect: boundingRect)
        
        return rect.size.height
    }
    
}
