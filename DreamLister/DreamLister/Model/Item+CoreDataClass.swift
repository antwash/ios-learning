//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Anthony Washington on 9/8/16.
//  Copyright © 2016 Anthony Washington. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {

    // when item created/inserted -- method is called 
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }
}
