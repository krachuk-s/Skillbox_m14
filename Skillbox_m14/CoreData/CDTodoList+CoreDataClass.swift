//
//  CDTodoList+CoreDataClass.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 22.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CDTodoList)
public class CDTodoList: NSManagedObject {
    public override func awakeFromInsert() {
        createdAt = Date()
        uuid = UUID()
    }
}
