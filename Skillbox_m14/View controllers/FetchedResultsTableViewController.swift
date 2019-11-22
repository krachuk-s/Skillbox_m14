//
//  FetchedResultsTableViewController.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 21.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import UIKit
import CoreData

class FetchedResultsTableViewController: UITableViewController {

    var fetchedResultsController: NSFetchedResultsController<NSManagedObject>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
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

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let obj = fetchedResultsController?.object(at: indexPath) {
                viewManagedContext.perform {
                    viewManagedContext.delete(obj)
                    try? viewManagedContext.save()
                }
            }
        }    
    }

}


extension FetchedResultsTableViewController: NSFetchedResultsControllerDelegate {
    
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
            fatalError("Additional unknown case")
        }
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}
