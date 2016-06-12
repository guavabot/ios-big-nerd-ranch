//
//  ItemStore.swift
//  Homepwner
//
//  Created by Ivan Soriano on 5/30/16.
//  Copyright © 2016 Guavabot. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    let itemArchiveUrl: NSURL = {
        let docDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let docDirectory = docDirectories.first!
        return docDirectory.URLByAppendingPathComponent("items.archive")
    }()
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(itemArchiveUrl.path!) as? [Item] {
            allItems += archivedItems
        }
    }
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItems.indexOf(item) {
            allItems.removeAtIndex(index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if (fromIndex == toIndex) {
            return
        }
        
        let movedItem = allItems.removeAtIndex(fromIndex)
        allItems.insert(movedItem, atIndex: toIndex)
    }
    
    func saveChanges() -> Bool {
        print("Saving items to \(itemArchiveUrl.path!)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveUrl.path!)
    }
}
