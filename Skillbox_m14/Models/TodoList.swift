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
    @objc dynamic var hexColor: String = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1).toHex
    
    var color: UIColor {
        get {
            return UIColor.hexColor(hex: hexColor)
        }
        set {
            hexColor = newValue.toHex
        }
    }
    
    let todoItems = List<TodoItem>()
    
}
