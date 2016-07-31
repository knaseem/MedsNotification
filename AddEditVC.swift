//
//  AddEditVC.swift
//  MedsNotification
//
//  Created by Khalid Naseem on 25/07/2016.
//  Copyright © 2016 Khalid Naseem. All rights reserved.
//

import UIKit
import CoreData

class AddEditVC: UIViewController, UITextFieldDelegate {
    
    var newRx : Rx? = nil
    
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var timeToTake = "Morning"
    
    @IBOutlet weak var rxName: UITextField!
    @IBOutlet weak var rxPrescribedBy: UITextField!
    
    @IBOutlet weak var rxDosageMG: UITextField!
    
    @IBOutlet weak var rxDosageML: UITextField!
    @IBOutlet weak var rxTime: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if newRx != nil {
            
            rxName.text = newRx?.name
            rxPrescribedBy.text = newRx?.prescribedBy
            rxDosageMG.text = newRx?.dosagemg
            rxDosageML.text = newRx?.dosageml
            timeToTake = (newRx?.time)!
            
            if timeToTake == "Morning" {
                rxTime.selectedSegmentIndex = 0
            } else if timeToTake == "Afternoon" {
                rxTime.selectedSegmentIndex = 1
            } else if timeToTake == "Evening" {
                rxTime.selectedSegmentIndex = 2
            } else if timeToTake == "Bedtime" {
                rxTime.selectedSegmentIndex = 3
            }
            
        }
        
        // set delegates for textfields
        rxName.delegate = self
        rxPrescribedBy.delegate = self
        rxDosageMG.delegate = self
        rxDosageMG.delegate = self
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        rxName.resignFirstResponder()
        rxPrescribedBy.resignFirstResponder()
        rxDosageMG.resignFirstResponder()
        rxDosageML.resignFirstResponder()
        
        return true
    }
    
    func dismissVC() {
        
        navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func timeDidChange(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            timeToTake = "Morning"
        case 1:
            timeToTake = "Afternoon"
        case 2:
            timeToTake = "Evening"
        case 3:
            timeToTake = "Bedtime"
        default:
            break
        }
        
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        
        if newRx == nil {
            addRx()
        } else {
            editRx()
        }
        
        dismissVC()
    }
    
    func addRx() {
        
        let ent = NSEntityDescription.entityForName("Rx", inManagedObjectContext: moc)
        
        let newRx = Rx(entity: ent!, insertIntoManagedObjectContext: moc)
        
        newRx.name = rxName.text!
        newRx.prescribedBy = rxPrescribedBy.text!
        newRx.dosagemg = rxDosageMG.text!
        newRx.dosageml = rxDosageML.text!
        newRx.time = timeToTake
        
        do {
            try moc.save()
        } catch {
            print("Failed to save new rx")
            return
        }
        
    }
    
    func editRx() {
        
        newRx?.name = rxName.text!
        newRx?.prescribedBy = rxPrescribedBy.text
        newRx?.dosagemg = rxDosageMG.text
        newRx?.dosageml = rxDosageML.text
        
        switch rxTime {
            
        case "Morning":
            rxTime.selectedSegmentIndex = 0
        case "Afternoon":
            rxTime.selectedSegmentIndex = 1
        case "Evening":
            rxTime.selectedSegmentIndex = 2
        case "Bedtime":
            rxTime.selectedSegmentIndex = 3
        default:
            break
            
        }
        
        newRx!.time = timeToTake
        
        do {
            try moc.save()
        } catch {
            print("Error saving edit")
            return
        }
        
    }
    
    
    
    
    
    
    
    
}
