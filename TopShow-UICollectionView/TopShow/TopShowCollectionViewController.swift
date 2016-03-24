//
//  TopShowCollectionViewController.swift
//  TopShow
//
//  Created by Jared Franzone on 3/22/16.
//  Copyright © 2016 Jared Franzone. All rights reserved.
//

import UIKit
import AVFoundation

class TopShowCollectionViewController: UICollectionViewController {

    // Holds our list of shows to display
    var shows = ShowList().getListOfShows()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set the ShowLayout delegate
        if let layout = collectionView?.collectionViewLayout as? ShowLayout {
            layout.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Data Source
    
    // Number of cells in our UICollectionView
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    // How we make each cell
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ShowCollectionViewCell", forIndexPath: indexPath) as! ShowCollectionViewCell
        
        // Sets the "show" property in our ShowCollectionViewCell.swift file
        cell.show = shows[indexPath.item]
        
        return cell
    }
    
    
    // MARK: Delegate
    
    // If we select an item... then toggle the shows rating
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ShowCollectionViewCell
        
        cell.show?.rating = ((cell.show?.rating)! < 5) ? (cell.show?.rating)! + 1 : 1
        
        collectionView.reloadData()
        
    }


}

extension TopShowCollectionViewController : ShowLayoutDelegate {
    
    // Returns the photo height
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath , withWidth width:CGFloat) -> CGFloat {
        let photo = shows[indexPath.item].image
        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect  = AVMakeRectWithAspectRatioInsideRect(photo.size, boundingRect)
        
        return rect.size.height
    }
    
}



