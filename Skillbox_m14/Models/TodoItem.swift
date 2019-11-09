//
//  ToDoItem.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 07.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import Foundation
import RealmSwift

class TodoItem: Object {
    
    @objc dynamic var todo = ""
    @objc dynamic var createdAt: Date = Date()
    @objc dynamic var isCompleted = false
    
    let lists = LinkingObjects(fromType: TodoList.self, property: "todoItems")
    
    var list: TodoList? {
        return lists.first
    }
    
}
