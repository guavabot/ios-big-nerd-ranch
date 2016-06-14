//
//  Item.swift
//  Homepwner
//
//  Created by Ivan Soriano on 5/30/16.
//  Copyright © 2016 Guavabot. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: NSDate
    let itemKey: String
    
    init(name: String, valueInDollars: Int, serialNumber: String?) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        self.itemKey = NSUUID().UUIDString
        
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Stinky", "Hungry", "Bothery"]
            let nouns = ["Eaglet", "Nest", "Fishie"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNum = NSUUID().UUIDString.componentsSeparatedByString("-").first!
            
            self.init(name: randomName, valueInDollars: randomValue, serialNumber: randomSerialNum)
        }
        else {
            self.init(name: "", valueInDollars: 0, serialNumber: nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        valueInDollars = aDecoder.decodeIntegerForKey("valueInDollars")
        serialNumber = aDecoder.decodeObjectForKey("serialNumber") as! String?
        dateCreated = aDecoder.decodeObjectForKey("dateCreated") as! NSDate
        itemKey = aDecoder.decodeObjectForKey("itemKey") as! String
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeInteger(valueInDollars, forKey: "valueInDollars")
        aCoder.encodeObject(serialNumber, forKey: "serialNumber")
        aCoder.encodeObject(dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(itemKey, forKey: "itemKey")
    }
}
