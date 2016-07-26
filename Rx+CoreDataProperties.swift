//
//  Rx+CoreDataProperties.swift
//  MedsNotification
//
//  Created by Khalid Naseem on 26/07/2016.
//  Copyright © 2016 Khalid Naseem. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Rx {

    @NSManaged var dosage: String?
    @NSManaged var name: String?
    @NSManaged var time: String?
    @NSManaged var prescribedBy: String?

}
