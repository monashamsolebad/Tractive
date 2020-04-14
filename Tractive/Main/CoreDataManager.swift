//
//  CoreDataManager.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-31.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Tractive")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchJobs() throws -> [JobApp] {
        let request: NSFetchRequest<JobApp> = JobApp.fetchRequest()
        do {
            let jobs = try persistentContainer.viewContext.fetch(request)
            return jobs
        } catch {
            throw error
        }
    }
    
    func searchJobsByCompany(_ searchText : String) throws -> [JobApp] {
        let request: NSFetchRequest<JobApp> = JobApp.fetchRequest()
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@" , searchText)
        do {
            let jobs = try persistentContainer.viewContext.fetch(request)
            return jobs
        } catch {
            throw error
        }
    }
    
    func searchJobsByStatus(_ status : Int16) throws -> [JobApp] {
        let request: NSFetchRequest<JobApp> = JobApp.fetchRequest()
        if status != 3 {
            request.predicate = NSPredicate(format: "status == %d" , status)
        }
        
        do {
            let jobs = try persistentContainer.viewContext.fetch(request)
            return jobs
        } catch {
            throw error
        }
    }
    private let dateFormatter: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        return fmt
    }()
    
    func searchJobsByDate(from date1: String, to date2: String) throws -> [JobApp] {
        let fromdate = "\(date1) 00:00" // add hours and mins to fromdate
        let todate = "\(date2) 23:59" // add hours and mins to todate
        let startDate = dateFormatter.date(from: fromdate)!
        let endDate = dateFormatter.date(from: todate)!
        
        let request: NSFetchRequest<JobApp> = JobApp.fetchRequest()
        request.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", startDate as NSDate, endDate as NSDate)
        
        do {
            let jobs = try persistentContainer.viewContext.fetch(request)
            return jobs
        } catch {
            throw error
        }
    }
    
    func deleteJob(_ job: JobApp) {
        let context = persistentContainer.viewContext
        context.delete(job)
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

