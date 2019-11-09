//
//  TodoListController.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 08.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import Foundation
import RealmSwift

class TodoListsController {
    
    private var notificationToken: NotificationToken?
    
    private (set) var results: Results<TodoList>!
    
    weak var delegate: TodoListControllerDelegate?
    
    private var realm: Realm {
        (UIApplication.shared.delegate as! AppDelegate).mainRealm
    }
    
    init() {
        
        results = realm.objects(TodoList.self)
        
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    func beginObserve() {
        notificationToken = results.observe{[weak self] changes in
           
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
    
    
    func append(_ newElement: TodoList) {
        do {
            try realm.write {
                realm.add(newElement)
            }
        } catch {
            print(error)
        }
    }
    
    func remove(at index: Int) {
        try! realm.write{
            realm.delete(results[index])
        }
    }
    
    func update(at index: Int, withName name: String, color: UIColor) {
        try! realm.write {
            
            results[index].name = name
            results[index].color = color
            
        }
    }
    
}

protocol TodoListControllerDelegate: class {
    func didUpdateLists(controller: TodoListsController)
    func didUpdateLists(controller: TodoListsController,
                        changes: BatchUpdate)
}
