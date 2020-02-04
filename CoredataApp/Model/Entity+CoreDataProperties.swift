//
//  Entity+CoreDataProperties.swift
//  CoredataApp
//
//  Created by @rtur drohobytskyy on 04/02/2020.
//  Copyright © 2020 @rtur drohobytskyy. All rights reserved.
//
//

import Foundation
import CoreData

extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
