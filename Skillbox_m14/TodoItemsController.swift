//
//  TodoItemsController.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 09.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import Foundation
import RealmSwift

class TodoItemsController {
   
    var todoList: TodoList
    
    private var notificationToken: NotificationToken?
    
    private (set) var results: Results<TodoItem>!
    
    var delegate: TodoItemsControllerDelegate?
    
    private var realm: Realm {
        (UIApplication.shared.delegate as! AppDelegate).mainRealm
    }
    
    init(todoList: TodoList) {
        
        self.todoList = todoList
        
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    func beginObserve() {
        notificationToken = todoList.todoItems.observe{[weak self] changes in
           
            guard let weakself = self else { return }
            
            let batchUpdate: BatchUpdate
            
            switch changes {
            case .initial:
                
                batchUpdate = .initial
                
            case .update(_, let deletions, let insertions, let modifications):
                
                batchUpdate = .update(
                    deletions: deletions,
                    insertion: insertions,
                    modifications: modifications)
                
            case .error(let error):
                
                batchUpdate = .error(error)
                
            }
        
            weakself.delegate?.didUpdateLists(controller: weakself, changes: batchUpdate)
            
        }
    }
    
    func stopObserve() {
        notificationToken?.invalidate()
    }
    
    
    func append(_ newElement: TodoItem) {
        
        
        
        do {
            try realm.write {
                todoList.todoItems.append(newElement)
                realm.add(newElement)
            }
        } catch {
            print(error)
        }
    }
    
    func remove(at index: Int) {
        try! realm.write{
            todoList.todoItems.remove(at: index)
        }
    }
}

protocol TodoItemsControllerDelegate {
    func didUpdateLists(controller: TodoItemsController)
    func didUpdateLists(controller: TodoItemsController,
                        changes: BatchUpdate)
}
