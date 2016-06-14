//
//  ImageStore.swift
//  Homepwner
//
//  Created by Ivan Soriano on 6/7/16.
//  Copyright © 2016 Guavabot. All rights reserved.
//

import UIKit

class ImageStore {
    
    let cache = NSCache()
    
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key)
        
        let imageURL = imageURLForKey(key)
        if let data = UIImageJPEGRepresentation(image, 0.7) {
            data.writeToURL(imageURL, atomically: true)
        }
    }
    
    func imageForKey(key: String) -> UIImage? {
        if let existingImage = cache.objectForKey(key) as? UIImage {
            return existingImage
        }
        
        let imageUrl = imageURLForKey(key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageUrl.path!) else {
            return nil
        }
        cache.setObject(imageFromDisk, forKey: key)
        return imageFromDisk
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObjectForKey(key)
        
        let imageUrl = imageURLForKey(key)
        do {
            try NSFileManager.defaultManager().removeItemAtURL(imageUrl)
        }
        catch let deleteError {
            print("Error remove image from disk: \(deleteError)")
        }
    }
    
    func imageURLForKey(key: String) -> NSURL {
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.URLByAppendingPathComponent(key)
    }
}
