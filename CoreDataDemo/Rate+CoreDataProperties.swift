//
//  Rate+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by MAC on 2019/3/19.
//  Copyright © 2019 zk. All rights reserved.
//
//

import Foundation
import CoreData


extension Rate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rate> {
        return NSFetchRequest<Rate>(entityName: "Rate")
    }

    @NSManaged public var value: Double
    @NSManaged public var ctn: String?
    @NSManaged public var exchange: String?

}
