//
//  ScavengerHuntItem.swift
//  ScavengerHunt
//
//  Created by Keith Abdulla on 1/24/15.
//  Copyright (c) 2015 Keith Abdulla. All rights reserved.
//


import UIKit

class ScavengerHuntItem: NSObject, NSCoding {
    
    let NameKey = "nameKey"
    let PhotoKey = "photoKey"
    let DateKey = "dateKey"
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: NameKey)
        if let thePhoto = photo {
            aCoder.encodeObject(photo, forKey: PhotoKey)
        }
        if let theDate = date {
            aCoder.encodeObject(date, forKey: DateKey)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey(NameKey) as String
        photo = aDecoder.decodeObjectForKey(PhotoKey) as? UIImage
        date = aDecoder.decodeObjectForKey(DateKey) as? String
    }
    
    
    let name: String
    // dont need to provide initializer since it's optional
    var photo: UIImage?
    
    var date: String?
    
    var isComplete: Bool {
        get {
            return photo != nil
        }
    }
    
    init(name: String) {
        self.name = name;
    }
    
}