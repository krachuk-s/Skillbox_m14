//
//  TodosRealmTableViewController.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 09.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import UIKit

class TodoItemsRealmTableViewController: UITableViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var todoList: TodoList? {
        get {
            todoItemsController?.todoList
        }
        set {
            guard let todoList = newValue else {
                todoItemsController = nil
                return
            }
            todoItemsController = TodoItemsController(todoList: todoList)
        }
    }
    var todoItemsController: TodoItemsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todoItemsController?.delegate = self
        
        tableView.tableFooterView = UIView()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        todoItemsController?.beginObserve()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        todoItemsController?.stopObserve()
    }
    
    func updateUI() {
        
        navigationItem.title = todoList?.name
        
        addButton.isEnabled = todoList != nil
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        let newItem = TodoItem()
        newItem.todo = "New item"
        
        todoItemsController?.append(newItem)
        
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? (todoList?.todoItems.count ?? 0) : 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)

        cell.textLabel?.text = todoList?.todoItems[indexPath.row].todo

        return cell
    }


}


extension TodoItemsRealmTableViewController: TodoItemsControllerDelegate {
    func didUpdateLists(controller: TodoItemsController, changes: BatchUpdate) {
        
        switch changes {
        case .initial:
            tableView.reloadData()
        case .update(let deletions, let insertion, let modifications):
            
            tableView.beginUpdates()
            
            tableView.insertRows(at: insertion.map({IndexPath(row: $0, section: 0)}), with: .automatic)
            tableView.deleteRows(at: deletions.map({IndexPath(row: $0, section: 0)}), with: .automatic)
            tableView.reloadRows(at: modifications.map({IndexPath(row: $0, section: 0)}), with: .automatic)
            
            tableView.endUpdates()
            
        case .error(let error):
            print(error)
        }
        
    }
    
    func didUpdateLists(controller: TodoItemsController) {
        
        tableView.reloadData()
    }
}
