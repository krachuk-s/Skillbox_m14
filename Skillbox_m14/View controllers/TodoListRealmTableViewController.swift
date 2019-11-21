//
//  TodoListRealmTableViewController.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 08.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import UIKit

class TodoListRealmTableViewController: UITableViewController {

    var todoListController = TodoListsController()
    var editingRow: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todoListController.delegate = self
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        todoListController.beginObserve()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        todoListController.stopObserve()
    }
    
    
    // MARK: - Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let newList = TodoList()
        newList.name = "Todo list"
        todoListController.append(newList)
        
    }
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListController.results.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        
        cell.textLabel?.text = todoListController.results[indexPath.row].name
        cell.detailTextLabel?.text = "todos: \(todoListController.results[indexPath.row].todoItems.count)"
        cell.textLabel?.textColor = todoListController.results[indexPath.row].color
    
        cell.accessoryType = .disclosureIndicator
        cell.editingAccessoryType = .detailButton
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
        
            todoListController.remove(at: indexPath.row)
            
        default:
            break
        }
        
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "ShowTodoItems":
            
            let vc = (segue.destination as! UINavigationController).topViewController as! TodoItemsRealmTableViewController
            
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            
            vc.todoList = todoListController.results[indexPath.row]
         
        case "EditTodoListSegue":
            
            let vc = (segue.destination as! UINavigationController).topViewController as! TodoListEditViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            
            vc.name = todoListController.results[indexPath.row].name
            vc.color = todoListController.results[indexPath.row].color
            
            editingRow = indexPath
            
        default:
            break
        }
        
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        if segue.identifier == "TodoListDoneEditing", let vc = segue.source as? TodoListEditViewController {
         
            if let editingRow = editingRow {
                
                todoListController.update(at: editingRow.row, withName: vc.name, color: vc.color)
                
            } else {
                let newList = TodoList()
                newList.name = vc.name
                newList.color = vc.color
                todoListController.append(newList)
            }
        }
        
        editingRow = nil
        
    }
    
    
}

extension TodoListRealmTableViewController: TodoListControllerDelegate {
    func didUpdateLists(controller: TodoListsController, changes: BatchUpdate) {
        
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
    
    func didUpdateLists(controller: TodoListsController) {
        
        tableView.reloadData()
    }
}

