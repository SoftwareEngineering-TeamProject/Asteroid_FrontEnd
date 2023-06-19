//
//  Room+CoreDataClass.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/24/21.
//
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {

    lazy var remindersByMyListRequest: NSFetchRequest<Reminder> = {
        let request = Reminder.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "reminderDate", ascending: true)
        let secondarySortDescriptor = NSSortDescriptor(key: "reminderTime", ascending: true)
        request.sortDescriptors = [sortDescriptor, secondarySortDescriptor]
        request.predicate = NSPredicate(format: "list = %@", self)
        return request
    }()
        
    func sortRemindersByDateAndTime() {
        let sortDescriptor = NSSortDescriptor(key: "reminderDate", ascending: true)
        let secondarySortDescriptor = NSSortDescriptor(key: "reminderTime", ascending: true)
        remindersByMyListRequest.sortDescriptors = [sortDescriptor, secondarySortDescriptor]
        
    }
}



