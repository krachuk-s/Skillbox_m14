//
//  CDTodoListTableViewController.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 20.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import UIKit
import CoreData

class CDTodoListTableViewController: UITableViewController {

    var fetchedResultsController: NSFetchedResultsController<CDTodoList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        
        let fetchRequest: NSFetchRequest<CDTodoList> = CDTodoList.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: viewManagedContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        
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
        
        let todoList = fetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = todoList.name
        cell.detailTextLabel?.text = "todos: \(todoList.todoItems?.count ?? 0)"
        if todoList.hexColor != nil {
            cell.textLabel?.textColor = UIColor.hexColor(hex: todoList.hexColor!)
        }
        cell.accessoryType = .disclosureIndicator
        cell.editingAccessoryType = .detailButton
        
        return cell
    }
    
    // MARK: - Navigation
    
    @IBAction func cdUnwindSegue(_ segue: UIStoryboardSegue) {
        
        if segue.identifier == "TodoListDoneEditing", let vc = segue.source as? TodoListEditViewController {
         
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


extension CDTodoListTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            tableView.insertSections([sectionIndex], with: .automatic)
        case .delete:
            tableView.deleteSections([sectionIndex], with: .automatic)
        default:
            break
        }
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
            
        case .delete:
            
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            
        case .move:
            
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
            
        case .update:
            
            tableView.reloadRows(at: [indexPath!], with: .automatic)
            
        @unknown default:
            fatalError("Additional unknon case")
        }
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}
