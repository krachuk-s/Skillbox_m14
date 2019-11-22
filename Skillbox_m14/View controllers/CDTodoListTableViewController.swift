//
//  CDTodoListTableViewController.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 20.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import UIKit
import CoreData

class CDTodoListTableViewController: FetchedResultsTableViewController {

    //var fetchedResultsController: NSFetchedResultsController<CDTodoList>!
    
    var editingRow: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
        tableView.tableFooterView = UIView()
        
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<CDTodoList>(entityName: "CDTodoList") as! NSFetchRequest<NSManagedObject>
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: viewManagedContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController!.delegate = self
        
        do {
            try fetchedResultsController!.performFetch()
        } catch {
            print(error)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchedResultsController?.delegate = self
        try? fetchedResultsController?.performFetch()
        
        tableView.reloadData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        fetchedResultsController?.delegate = nil
    }
    
    func object(at indexPath: IndexPath) -> CDTodoList? {
        return fetchedResultsController?.object(at: indexPath) as? CDTodoList
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if let sectionInfo = fetchedResultsController?.sections?[section] {
                return sectionInfo.numberOfObjects
            } else {
                return 0
            }
        default:
            return 0
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell")!
        
        let todoList = object(at: indexPath)!
        
        cell.textLabel?.text = todoList.name
        cell.detailTextLabel?.text = "todos: \(todoList.todoItems?.count ?? 0)"
        if todoList.hexColor != nil {
            cell.textLabel?.textColor = UIColor.hexColor(hex: todoList.hexColor!)
        }
        cell.accessoryType = .disclosureIndicator
        cell.editingAccessoryType = .detailButton
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    @IBAction func cdUnwindSegue(_ segue: UIStoryboardSegue) {
        
        if segue.identifier == "TodoListDoneEditing", let vc = segue.source as? TodoListEditViewController {
         
            if let editingRow = editingRow {
                
                let todoList = object(at: editingRow)!
                viewManagedContext.perform {
                    todoList.name = vc.name
                    todoList.hexColor = vc.color.toHex
                    
                    try? viewManagedContext.save()
                }
                
            } else {
                persistentContainer.performBackgroundTask{ cntxt in
                    
                    cntxt.automaticallyMergesChangesFromParent = true
                    
                    let newList = CDTodoList(context: cntxt)
                    newList.name = vc.name
                    newList.hexColor = vc.color.toHex
                    
                    try? cntxt.save()
                }
            }
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowTodoItems":

            let vc = segue.destination as! CDTodoItemsTableViewController

            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!

            vc.todoList = object(at: indexPath)

        case "EditTodoListSegue":

            let vc = (segue.destination as! UINavigationController).topViewController as! TodoListEditViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            
            vc.name = object(at: indexPath)!.name!
            vc.color = UIColor.hexColor(hex: object(at: indexPath)!.hexColor!)
            
            editingRow = indexPath

        default:
            break
        }
    }
    
}

