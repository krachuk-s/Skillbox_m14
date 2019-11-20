//
//  CDTodoItem+CoreDataProperties.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 20.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//
//

import Foundation
import CoreData


extension CDTodoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTodoItem> {
        return NSFetchRequest<CDTodoItem>(entityName: "CDTodoItem")
    }

    @NSManaged public var todo: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var list: CDTodoList?

}
