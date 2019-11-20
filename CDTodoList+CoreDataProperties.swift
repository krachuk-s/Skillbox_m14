//
//  CDTodoList+CoreDataProperties.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 20.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//
//

import Foundation
import CoreData


extension CDTodoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTodoList> {
        return NSFetchRequest<CDTodoList>(entityName: "CDTodoList")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var hexColor: String?
    @NSManaged public var todoItems: NSSet?

}

// MARK: Generated accessors for todoItems
extension CDTodoList {

    @objc(addTodoItemsObject:)
    @NSManaged public func addToTodoItems(_ value: CDTodoItem)

    @objc(removeTodoItemsObject:)
    @NSManaged public func removeFromTodoItems(_ value: CDTodoItem)

    @objc(addTodoItems:)
    @NSManaged public func addToTodoItems(_ values: NSSet)

    @objc(removeTodoItems:)
    @NSManaged public func removeFromTodoItems(_ values: NSSet)

}
