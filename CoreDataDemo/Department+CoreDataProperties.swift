//
//  Department+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by MAC on 2019/3/20.
//  Copyright © 2019 zk. All rights reserved.
//
//

import Foundation
import CoreData


extension Department {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Department> {
        return NSFetchRequest<Department>(entityName: "Department")
    }

    @NSManaged public var ceateDate: NSDate?
    @NSManaged public var departName: String?
    @NSManaged public var employee: NSSet?

}

// MARK: Generated accessors for employee
extension Department {

    @objc(addEmployeeObject:)
    @NSManaged public func addToEmployee(_ value: Employee)

    @objc(removeEmployeeObject:)
    @NSManaged public func removeFromEmployee(_ value: Employee)

    @objc(addEmployee:)
    @NSManaged public func addToEmployee(_ values: NSSet)

    @objc(removeEmployee:)
    @NSManaged public func removeFromEmployee(_ values: NSSet)

}
