//
//  CDTodoItem+CoreDataProperties.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 21.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//
//

import Foundation
import CoreData


extension CDTodoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTodoItem> {
        return NSFetchRequest<CDTodoItem>(entityName: "CDTodoItem")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var todo: String?
    @NSManaged public var uuid: UUID?
    @NSManaged public var list: CDTodoList?

}
