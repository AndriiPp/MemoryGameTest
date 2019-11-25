//
//  User+CoreDataProperties.swift
//  MemoryTestGame
//
//  Created by Andrii Pyvovarov on 11/24/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import Foundation
import CoreData


extension User {
    
    //MARK: - CoreData Model
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var endDate: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var score: Int16
    @NSManaged public var startDate: NSDate?

}
