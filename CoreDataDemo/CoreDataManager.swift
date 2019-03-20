//
//  CoreDataManager.swift
//  CoreDataDemo
//
//  Created by MAC on 2019/3/19.
//  Copyright © 2019 zk. All rights reserved.
//

import UIKit
import CoreData
class CoreDataManager: NSObject {

    static let shared = CoreDataManager()
   
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "ooxx", withExtension: "momd")
        let managedObjectModel = NSManagedObjectModel.init(contentsOf: modelURL!)
        return managedObjectModel!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator.init(managedObjectModel: managedObjectModel)
        
        let sqliteURL = documentDir.appendingPathComponent("ooxx.sqlite")
        let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
        var failureReason = "There was an error creating or loading the application's saved data."
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: sqliteURL, options: options)
        } catch {
            // Report any error we got.
            var dict = [String: Any]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as Any?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as Any?
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 6666, userInfo: dict)
            print("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return persistentStoreCoordinator
    }()
    
    lazy var documentDir: URL = {
        let documentDir = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
        return documentDir!
    }()
    lazy var context: NSManagedObjectContext = {
        let context = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()

}

extension CoreDataManager {
    
   
    
    func save(for ctn:String,value:Double, exchange:String) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Rate")
        let predicate = NSPredicate(format: "(ctn = %@) AND (exchange = %@)",ctn,exchange)
        request.predicate = predicate;
        
        let asyncFecthRequest = NSAsynchronousFetchRequest(fetchRequest: request) { (result:NSAsynchronousFetchResult) in
            let fetchObj = result.finalResult! as! [Rate]
            for rate in fetchObj {
                rate.value = value
                self.saveContext()
            }
            if fetchObj.count == 0 {
                self.insert(ctn: ctn, value: value, exchange: exchange)
            }
        }
        do {
            try context.execute(asyncFecthRequest)
            
        }catch {
            
        }
        
    }
    
    
    
    
    func rate(for ctn:String, in exchange:String) -> Double? {
        //声明数据的请求
        let fetchRequest = NSFetchRequest<Rate>(entityName:"Rate")
 
        let predicate = NSPredicate(format: "(ctn = %@) AND (exchange = %@)", ctn,exchange)
        fetchRequest.predicate = predicate
        //查询
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            print(fetchedObjects.first?.value as Any)
            return fetchedObjects.first?.value
        }
        catch {
            fatalError("不能查询：\(error)")
        }
    }
    
}

extension CoreDataManager {
    fileprivate func saveContext() {
        do {
            try  context.save()
        } catch {
            
        }
    }
    
    
    fileprivate func insert(ctn: String, value: Double,exchange:String) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Rate", into: context) as! Rate
        entity.value = value
        entity.ctn = ctn
        entity.exchange = exchange
        saveContext()
    }
}
