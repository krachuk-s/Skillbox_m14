//
//  ToDoListRealmTableViewController.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 07.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import UIKit

class TodoListRealmTableViewController: UITableViewController {

    var toDoLists: [TodoList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    }

    // MARK: Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        if toDoLists.count == 0 {
            let list = TodoList()
            list.name = "First list"
            toDoLists.append(list)
        }
        
        let todo = TodoItem()
        
        toDoLists.last?.todoItems.append(todo)
        
        tableView.reloadData()
        
    }
    
    
    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return toDoLists.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoLists[section].todoItems.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return toDoLists[section].name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! TodoItemCell

        cell.textLabel?.text = toDoLists[indexPath.section].todoItems[indexPath.row].todo

        return cell
    }
    


}
