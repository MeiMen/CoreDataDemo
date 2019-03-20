//
//  Employee+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by MAC on 2019/3/20.
//  Copyright © 2019 zk. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var birthday: NSDate?
    @NSManaged public var height: Float
    @NSManaged public var name: String?
    @NSManaged public var sectionName: String?
    @NSManaged public var department: Department?

}
