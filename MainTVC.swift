//
//  MainTVC.swift
//  MedsNotification
//
//  Created by Khalid Naseem on 25/07/2016.
//  Copyright © 2016 Khalid Naseem. All rights reserved.
//

import UIKit
import CoreData

class MainTVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let moc : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var frc = NSFetchedResultsController()
    
    func fetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "Rx")
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
        
    }
    
    func getFRC() -> NSFetchedResultsController {
        
        frc = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        return frc
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frc = getFRC()
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch {
            print("Initial fetch failed")
            return
        }
        
        // cell properties
        
        self.tableView.rowHeight = 65
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "bg.png"))
        
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        let numberOfSections = frc.sections?.count
        
        return numberOfSections!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let numberOfRowsInSection = frc.sections?[section].numberOfObjects
        
        return numberOfRowsInSection!
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        // set alternating alphas
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.clearColor()
        } else {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
            cell.detailTextLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        }
        
        // Configure the cell...
        
        let rx = frc.objectAtIndexPath(indexPath) as! Rx
        cell.textLabel?.text = rx.name
        let prescribedBy = rx.prescribedBy
        let dosagemg = rx.dosagemg
        let dosageml = rx.dosageml
        let time = rx.time
        
        cell.detailTextLabel?.text = "\(dosagemg!) mg. Or \(dosageml!) ml. at \(time!) by \(prescribedBy!)."
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let managedObject : NSManagedObject = frc.objectAtIndexPath(indexPath) as! NSManagedObject
        
        moc.deleteObject(managedObject)
        
        do {
            try moc.save()
        } catch {
            print("Failed to save.")
            return
        }
        
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "edit" {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let rxController : AddEditVC = segue.destinationViewController as! AddEditVC
            
            let newRx : Rx = frc.objectAtIndexPath(indexPath!) as! Rx
            
            rxController.newRx = newRx
            
        }
        
    }
    
    
}


