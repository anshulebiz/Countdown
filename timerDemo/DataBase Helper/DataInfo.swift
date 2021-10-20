//
//  DataInfo.swift
//  timerDemo
//
//  Created by HariKrishna Kundariya on 19/10/21.
//

import UIKit
import CoreData

class DataInfo {
    
    var id = 0
    var logStore = [LogStore]()
    
    func createData(startDate:Date, endDate:Date){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let endEntity = NSEntityDescription.entity(forEntityName: "LogStore", in: managedContext)!
        let data = retriveAceData()
        for i in data{
            if i.log_id == id{
                id = id + 1
            }
        }
        let logData = LogStore(entity: endEntity, insertInto: managedContext)
        logData.log_id = Int16(id)
        logData.startDate = startDate
        logData.endDate = endDate
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Could not save.\(error), \(error.userInfo)")
        }
    }
    
    func retriveData() -> [LogStore]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<LogStore> = LogStore.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(LogStore.log_id), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        do{
            logStore = try managedContext.fetch(fetchRequest)
            return logStore
        }catch{
            print("Failed")
            return []
        }
    }
    
    func retriveAceData() -> [LogStore]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<LogStore> = LogStore.fetchRequest()
        do{
            logStore = try managedContext.fetch(fetchRequest)
            return logStore
        }catch{
            print("Failed")
            return []
        }
    }
    
}
