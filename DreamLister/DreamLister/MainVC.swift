//
//  MainVC.swift
//  DreamLister
//
//  Created by Anthony Washington on 9/8/16.
//  Copyright © 2016 Anthony Washington. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private var FRC: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //self.generateTestData()
        self.attemptFetch()
    }
    
    
    // MARK: - TableView delegate methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = FRC.sections {
                let sectionInfo = sections[section]
            return  sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = FRC.sections {
            return sections.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    // attempt fetch
    func attemptFetch() {
    
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let priceSort = NSSortDescriptor(key: "price", ascending: true)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        
        if segment.selectedSegmentIndex == 0 {
            fetchRequest.sortDescriptors = [dateSort]
        }
        else if segment.selectedSegmentIndex == 1 {
            fetchRequest.sortDescriptors = [priceSort]
        }
        else if segment.selectedSegmentIndex == 2 {
            fetchRequest.sortDescriptors = [titleSort]
        }
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            controller.delegate = self
        
        self.FRC = controller
        
        do {
            try controller.performFetch()
        
        }catch {
            
            let error = error as NSError
                print("\(error)")
        }
    }
    
    @IBAction func segmentChanged(_ sender: AnyObject) {
        self.attemptFetch()
        self.tableView.reloadData()
    }
    
    
    func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
    
        // update cell
        let item = FRC.object(at: indexPath as IndexPath)
        
        cell.configureCell(item: item)
    }
    
    
    // listen for changes
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    // listen once content is changes
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
            
        case.insert:
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
            
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            if let indexPath = newIndexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let object = FRC.fetchedObjects , object.count > 0 {
            
            let item = object[indexPath.row]
            performSegue(withIdentifier: "itemDetailsVC", sender: item)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemDetailsVC" {
            if let destination = segue.destination as? ItemDetailVC {
               if let item = sender as? Item {
                    destination.itemToEdit = item
                }
            }
        }
    }
    
    
// -----------------------------------------------------------------------------------
    
    // -- GENERATE TEST DATA ---
    func generateTestData() {
    
        let item = Item(context: context)
            item.title = "MacBook Pro"
            item.price = 1800
            item.details = "New Macbook pro coming out soon Sept. will let us know."
    
        let item1 = Item(context: context)
            item1.title = "Bose hp"
            item1.price = 300
            item1.details = "New Bose hp cost to much :-) "
        
        ad.saveContext()
    }
 
}

