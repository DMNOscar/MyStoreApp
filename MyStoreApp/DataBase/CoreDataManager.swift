//
//  CoreDataManager.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 13/01/25.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyStoreApp")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Error al cargar el contenedor de Core Data: \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Error al guardar el contexto: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
