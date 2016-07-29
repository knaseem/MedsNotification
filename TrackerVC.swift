//
//  TrackerVC.swift
//  MedsNotification
//
//  Created by Khalid Naseem on 25/07/2016.
//  Copyright © 2016 Khalid Naseem. All rights reserved.
//

import UIKit

class TrackerVC: UIViewController {
    
    
    @IBOutlet weak var switchMorning: UISwitch!
    @IBOutlet weak var switchNoon: UISwitch!
    @IBOutlet weak var switchEvening: UISwitch!
    @IBOutlet weak var switchBedtime: UISwitch!
    
    
    @IBOutlet weak var switchReminderMorning: UISwitch!
    @IBOutlet weak var switchReminderNoon: UISwitch!
    @IBOutlet weak var switchReminderEvening: UISwitch!
    @IBOutlet weak var switchReminderBedtime: UISwitch!
    
    var storedDate = ""
    var currentDate = ""
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dateRecorded = defaults.stringForKey("storedDate") {
            storedDate = dateRecorded
        }
        
        currentDate = getDate()
        if currentDate == storedDate {
            if let _ = defaults.stringForKey("takenMorning") {
                switchMorning.setOn(true, animated: true)
            }
            if let _ = defaults.stringForKey("takenNoon") {
                switchNoon.setOn(true, animated: true)
            }
            if let _ = defaults.stringForKey("takenEvening") {
                switchEvening.setOn(true, animated: true)
            }
            if let _ = defaults.stringForKey("takenBedtime") {
                switchBedtime.setOn(true, animated: true)
            }
            
        } else if currentDate != storedDate {
            defaults.removeObjectForKey("takenMorning")
            switchMorning.setOn(false, animated: true)
            
            defaults.removeObjectForKey("takenNoon")
            switchNoon.setOn(false, animated: true)
            
            defaults.removeObjectForKey("takenEvening")
            switchEvening.setOn(false, animated: true)
            
            defaults.removeObjectForKey("takenBedtime")
            switchBedtime.setOn(false, animated: true)
        }
        
        // Code for Notification switches
        if let _ = defaults.stringForKey("reminderMorning") {
            switchReminderMorning.setOn(true, animated: true)
        }
        if let _ = defaults.stringForKey("reminderNoon") {
            switchReminderNoon.setOn(true, animated: true)
        }
        if let _ = defaults.stringForKey("reminderEvening") {
            switchReminderEvening.setOn(true, animated: true)
        }
        if let _ = defaults.stringForKey("reminderBedtime") {
            switchReminderBedtime.setOn(true, animated: true)
        }
    }
    
    // function to get date so we can compare stored and current date
    func getDate() -> String {
        
        let date = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .NoStyle)
        return date
    }
    
    @IBAction func morningTapped(sender: UISwitch) {
        storedDate = getDate()
        
        if switchMorning.on {
            defaults.setObject(storedDate, forKey: "storedDate")
            defaults.setObject(switchMorning.on, forKey: "takenMorning")
            switchMorning.setOn(true, animated: true)
        } else {
            if let _ = defaults.stringForKey("takenMorning") {
                switchMorning.setOn(false, animated: true)
                defaults.removeObjectForKey("takenMorning")
            }
            
        }
        
    }
    
    @IBAction func noonTapped(sender: UISwitch) {
        storedDate = getDate()
        
        if switchNoon.on {
            defaults.setObject(storedDate, forKey: "storedDate")
            defaults.setObject(switchNoon.on, forKey: "takenNoon")
            switchNoon.setOn(true, animated: true)
        } else {
            if let _ = defaults.stringForKey("takenNoon") {
                switchNoon.setOn(false, animated: true)
                defaults.removeObjectForKey("takenNoon")
            }
            
        }
        
    }
    
    @IBAction func eveningTapped(sender: UISwitch) {
        storedDate = getDate()
        
        if switchEvening.on {
            defaults.setObject(storedDate, forKey: "storedDate")
            defaults.setObject(switchEvening.on, forKey: "takenEvening")
            switchEvening.setOn(true, animated: true)
        } else {
            if let _ = defaults.stringForKey("takenEvening") {
                switchEvening.setOn(false, animated: true)
                defaults.removeObjectForKey("takenEvening")
            }
            
        }
        
    }
    
    @IBAction func bedtimeTapped(sender: UISwitch) {
        storedDate = getDate()
        
        if switchBedtime.on {
            defaults.setObject(storedDate, forKey: "storedDate")
            defaults.setObject(switchBedtime.on, forKey: "takenBedtime")
            switchBedtime.setOn(true, animated: true)
        } else {
            if let _ = defaults.stringForKey("takenBedtime") {
                switchBedtime.setOn(false, animated: true)
                defaults.removeObjectForKey("takenBedtime")
            }
            
        }
        
    }
    
    // Reminder Functions
    
    var notifyMorning = UILocalNotification()
    var notifyNoon = UILocalNotification()
    var notifyEvening = UILocalNotification()
    var notifyBedtime = UILocalNotification()
    
    @IBAction func morningReminderTapped(sender: AnyObject) {
        
        if switchReminderMorning.on {
            defaults.setObject(switchReminderMorning.on, forKey: "reminderMorning")
            let theDate = NSDate()
            let cal = NSCalendar.currentCalendar()
            cal.timeZone = NSCalendar.currentCalendar().timeZone
            let fireDate = cal.dateBySettingHour(9, minute: 0, second: 0, ofDate: theDate, options: NSCalendarOptions())
            notifyMorning.alertBody = "Did you take your morning pills/meds today?"
            notifyMorning.repeatInterval = NSCalendarUnit.Day
            notifyMorning.fireDate = fireDate
            notifyMorning.soundName = UILocalNotificationDefaultSoundName
            
            // to schedule notification
            UIApplication.sharedApplication().scheduleLocalNotification(notifyMorning)
            
        } else {
            defaults.removeObjectForKey("reminderMorning")
            UIApplication.sharedApplication().cancelLocalNotification(notifyMorning)
        }
        
    }
    
    @IBAction func noonReminderTapped(sender: UISwitch) {
        if switchReminderNoon.on {
            defaults.setObject(switchReminderNoon.on, forKey: "reminderNoon")
            let theDate = NSDate()
            let cal = NSCalendar.currentCalendar()
            cal.timeZone = NSCalendar.currentCalendar().timeZone
            let fireDate = cal.dateBySettingHour(13, minute: 0, second: 0, ofDate: theDate, options: NSCalendarOptions())
            notifyNoon.alertBody = "Did you take your noon pills/meds today?"
            notifyNoon.repeatInterval = NSCalendarUnit.Day
            notifyNoon.fireDate = fireDate
            notifyNoon.soundName = UILocalNotificationDefaultSoundName
            
            // to schedule notification
            UIApplication.sharedApplication().scheduleLocalNotification(notifyNoon)
            
        } else {
            defaults.removeObjectForKey("reminderNoon")
            UIApplication.sharedApplication().cancelLocalNotification(notifyNoon)
        }
        
    }
    
    @IBAction func eveningReminderTapped(sender: UISwitch) {
        if switchReminderEvening.on {
            defaults.setObject(switchReminderEvening.on, forKey: "reminderEvening")
            let theDate = NSDate()
            let cal = NSCalendar.currentCalendar()
            cal.timeZone = NSCalendar.currentCalendar().timeZone
            let fireDate = cal.dateBySettingHour(18, minute: 0, second: 0, ofDate: theDate, options: NSCalendarOptions())
            notifyEvening.alertBody = "Did you take your evening pills/meds today?"
            notifyEvening.repeatInterval = NSCalendarUnit.Day
            notifyEvening.fireDate = fireDate
            notifyEvening.soundName = UILocalNotificationDefaultSoundName
            
            // to schedule notification
            UIApplication.sharedApplication().scheduleLocalNotification(notifyEvening)
            
        } else {
            defaults.removeObjectForKey("reminderEvening")
            UIApplication.sharedApplication().cancelLocalNotification(notifyEvening)
        }
        
    }
    
    @IBAction func bedtimeReminderTapped(sender: UISwitch) {
        if switchReminderBedtime.on {
            defaults.setObject(switchReminderBedtime.on, forKey: "reminderBedtime")
            let theDate = NSDate()
            let cal = NSCalendar.currentCalendar()
            cal.timeZone = NSCalendar.currentCalendar().timeZone
            let fireDate = cal.dateBySettingHour(21, minute: 0, second: 0, ofDate: theDate, options: NSCalendarOptions())
            notifyBedtime.alertBody = "Did you take your bedtime pills/meds today?"
            notifyBedtime.repeatInterval = NSCalendarUnit.Day
            notifyBedtime.fireDate = fireDate
            notifyBedtime.soundName = UILocalNotificationDefaultSoundName
            
            // to schedule notification
            UIApplication.sharedApplication().scheduleLocalNotification(notifyBedtime)
            
        } else {
            defaults.removeObjectForKey("reminderBedtime")
            UIApplication.sharedApplication().cancelLocalNotification(notifyBedtime)
        }
        
    }
    
}


