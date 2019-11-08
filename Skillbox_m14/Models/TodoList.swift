//
//  ToDoList.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 07.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import Foundation
import RealmSwift

class TodoList: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var createdAt = Date()
    
    let todoItems = List<TodoItem>()
    
}
