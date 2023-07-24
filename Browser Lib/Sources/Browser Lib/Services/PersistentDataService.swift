//
//  PersistentDataService.swift
//  Browser Lib
//
//  Created by Oleksandr Buhara on 7/21/23.
//

import Foundation
import CoreData

public final class PersistentDataService {
    public init() {

    }

    // MARK: - Core Data stack
    lazy public var persistentContainer: NSPersistentContainer = {
        guard let modelURL = Bundle.module.url(forResource:"Browser_Lib", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }

        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let container = NSPersistentContainer(name: "Browser_Lib", managedObjectModel: model)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

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

    func save(map: some Mappable) -> OrganizationManagedObject? {
        let context = persistentContainer.viewContext
        let type = map.managingType.self
        let entityName = String(describing: type)
        let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context)
        guard let entityDescription = entityDescription else { return nil }
        let managedObject = NSManagedObject(entity: entityDescription, insertInto: context)
        map.setup(managed: managedObject)
        saveContext()
        return managedObject as? OrganizationManagedObject
    }

    func remove(object: OrganizationManagedObject?) {
        guard let object = object else { return }
        let context = persistentContainer.viewContext
        context.delete(object)
        saveContext()
    }

    func favorites(completion: @escaping ([OrganizationManagedObject]) -> Void) {
        let fetchRequest = NSFetchRequest<OrganizationManagedObject>(entityName: "OrganizationManagedObject")
        do {
            let context = persistentContainer.viewContext
            let organizations = try context.fetch(fetchRequest)
            completion(organizations)
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
}
