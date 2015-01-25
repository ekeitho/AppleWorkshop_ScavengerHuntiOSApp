//
//  CollectionViewController.swift
//  ScavengerHunt
//
//  Created by Keith Abdulla on 1/24/15.
//  Copyright (c) 2015 Keith Abdulla. All rights reserved.
//
import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var itemsManager = ItemsManger()
    
    @IBOutlet var collectionView: UICollectionView?
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsManager.items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ccell", forIndexPath: indexPath) as CollectionCell
        
        let item = itemsManager.items[indexPath.row]
        
        cell.backgroundColor = UIColor.blackColor()
        cell.textLabel?.text = item.name
        cell.imageView?.image = item.photo
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}