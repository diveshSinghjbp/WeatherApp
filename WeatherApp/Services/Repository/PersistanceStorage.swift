//
//  PersistanceStorage.swift
//  WeatherApp
//
//  Created by Divesh Singh on 3/7/21.
//

import Foundation
import CoreData

final class PersistanceStorage {
    
    
    static var shared = PersistanceStorage()
    private init() {
        
    }
    lazy var context = persistentContainer.viewContext
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    func saveContext () {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getManagedObject<T: NSManagedObject>(ofType : T.Type) -> [T]?{
        do {
            guard let result = try PersistanceStorage.shared.context.fetch(T.fetchRequest()) as? [T] else {return nil}
            return result
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}
