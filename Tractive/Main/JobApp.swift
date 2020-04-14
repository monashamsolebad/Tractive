//
//  JobApp.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-31.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit
import CoreData

class JobApp: NSManagedObject {
    static func addApplication(id: UUID, date: Date, email: String, link: URL?, name: String, note: String, phone: String?, position: String, responsiblePerson: String? , status : Int16 , platform : String) {
        let jobApp = JobApp(context: CoreDataManager.shared.persistentContainer.viewContext)
        jobApp.id = UUID()
        jobApp.date = date
        jobApp.email = email
        jobApp.link = link
        jobApp.name = name
        jobApp.note = note
        jobApp.phone = phone
        jobApp.position = position
        jobApp.responsiblePerson = responsiblePerson
        jobApp.status = status
        jobApp.platform = platform
        
        CoreDataManager.shared.saveContext()
    }
    static func editApplication(id: UUID, date: Date, email: String, link: URL?, name: String, note: String, phone: String?, position: String, responsiblePerson: String? , status : Int16 , platform : String) {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        do {
            let fetchRequest : NSFetchRequest<JobApp> = JobApp.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
            let fetchedResults = try context.fetch(fetchRequest)
            if let jobApp = fetchedResults.first {
                
                jobApp.id = id
                jobApp.date = date
                jobApp.email = email
                jobApp.link = link
                jobApp.name = name
                jobApp.note = note
                jobApp.phone = phone
                jobApp.position = position
                jobApp.responsiblePerson = responsiblePerson
                jobApp.status = status
                jobApp.platform = platform
                
                CoreDataManager.shared.saveContext()
            }
        } catch {
            print ("fetch task failed", error)
        }
        
    }
}
