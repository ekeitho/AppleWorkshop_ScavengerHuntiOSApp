//
//  ItemsManager.swift
//  ScavengerHunt
//
//  Created by Keith Abdulla on 1/24/15.
//  Copyright (c) 2015 Keith Abdulla. All rights reserved.
//

import Foundation

class ItemsManger {

    var items = [ScavengerHuntItem]()
    
    // lazy cache's the result of this, which means
    // this is exhaustive but only ever called once
    lazy private var archivePath: String = {
        let fileManager = NSFileManager.defaultManager()
        let documentDirectoryURLs = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        
        let archiveURL = documentDirectoryURLs.first!.URLByAppendingPathComponent("ScavangerHuntItems", isDirectory: false)
        return archiveURL.path!
        
    }()
    
    func save() {
        NSKeyedArchiver.archiveRootObject(items, toFile: archivePath)
    }
    
    private func unarchiveSavedItems() {
        if NSFileManager.defaultManager().fileExistsAtPath(archivePath) {
            let savedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(archivePath) as [ScavengerHuntItem]
            items = savedItems
        }
    }
    
    init() {
        unarchiveSavedItems()
    }
    
}
