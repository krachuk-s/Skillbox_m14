//
//  CDTodoItemsTableViewController.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 21.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import UIKit
import CoreData

class CDTodoItemsTableViewController: FetchedResultsTableViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var todoList: CDTodoList!
    
    var addButtonWasPressed = false
    var editingItem: CDTodoItem? {
        didSet {
            if let oldValue = oldValue {
                if let indexPath = fetchedResultsController?.indexPath(forObject: oldValue),
                    let cell = tableView.cellForRow(at: indexPath) as? TodoItemTableViewCell {
                    viewManagedContext.perform {
                        if cell.todoTextView.text.isEmpty {
                            viewManagedContext.delete(oldValue)
                        } else {
                            oldValue.todo = cell.todoTextView.text
                            oldValue.isCompleted = cell.isCompleted
                        }
                        try? viewManagedContext.save()
                    }
                }
            }
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<CDTodoItem>(entityName: "CDTodoItem") as! NSFetchRequest<NSManagedObject>
        fetchRequest.predicate = NSPredicate(format: "%K == %@", "list.uuid", todoList.uuid! as CVarArg)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController<NSManagedObject>(
            fetchRequest: fetchRequest,
            managedObjectContext: viewManagedContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchedResultsController?.delegate = self
        
        try? fetchedResultsController?.performFetch()
        
        updateUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchedResultsController?.delegate = self
        try? fetchedResultsController?.performFetch()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        fetchedResultsController?.delegate = nil
    }
    
    func updateUI() {
        
        navigationItem.title = todoList?.name
        addButton.isEnabled = (todoList != nil && editingItem == nil)
        doneButton.isEnabled = (todoList != nil && editingItem != nil)
        
    }
    
    // MARK: - Table view Data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemTableViewCell") as! TodoItemTableViewCell
        
        let todoItem = fetchedResultsController?.object(at: indexPath) as! CDTodoItem
        
        cell.todoTextView?.text = todoItem.todo
        cell.completionIndicator.color = UIColor.hexColor(hex: todoList.hexColor!)
        cell.isCompleted = todoItem.isCompleted
        cell.delegate = self
        
        return cell
        
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        guard let uuid = todoList.uuid else { return }
        
        persistentContainer.performBackgroundTask { cntxt in
            cntxt.automaticallyMergesChangesFromParent = true
            
            let fetch: NSFetchRequest<CDTodoList> = CDTodoList.fetchRequest()
            fetch.predicate = NSPredicate(format: "uuid == %@", uuid as CVarArg)
            
            if let todoList = try? cntxt.fetch(fetch).first {
                let newItem = CDTodoItem(context: cntxt)
                newItem.list = todoList
                try? cntxt.save()
            }
        }
        
        addButtonWasPressed = true
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        
        editingItem = nil
        
    }
    
}

extension CDTodoItemsTableViewController: TodoItemTableViewCellDelegate {
    
    func todoItemTableViewCellDidBeginEditing(_ cell: TodoItemTableViewCell) {
        let indexPath = tableView.indexPath(for: cell)!
        editingItem = fetchedResultsController?.object(at: indexPath) as? CDTodoItem
    }
    
    func todoItemTableViewCellDidChange(_ cell: TodoItemTableViewCell) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func todoItemTableViewCellDidEndEditing(_ cell: TodoItemTableViewCell) {
       
        let indexPath = tableView.indexPath(for: cell)!
        
        let todoItem = fetchedResultsController?.object(at: indexPath) as! CDTodoItem
        todoItem.todo = cell.todoTextView.text
        todoItem.isCompleted = cell.isCompleted
        
        viewManagedContext.perform {
            try? viewManagedContext.save()
        }
        
    }
}
