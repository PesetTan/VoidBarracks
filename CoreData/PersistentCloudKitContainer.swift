//
//  PersistentCloudKitContainer.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/29/20.
//

import CoreData

public class PersistentCloudKitContainer {

    // MARK: - Define Constants / Variables
    public static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    // MARK: - Initializer
    private init() {}
    // MARK: - Core Data stack
    public static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AppModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    // MARK: - Core Data Saving support
    public static func saveContext () {
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

    // MARK: - Core Data Deleting support
    public static func deleteStore () {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<Store>(entityName: "Store")
        let results = try! context.fetch(request)

        results.forEach { result in
            context.delete(result)
        }
    }

    // MARK: - Core Data Deleting support
    public static func deleteRules () {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<Rule>(entityName: "Rule")
        let results = try! context.fetch(request)

        results.forEach { result in
            context.delete(result)
        }
    }

    // MARK: - Core Data Deleting support
    public static func deleteArmies () {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<Army>(entityName: "Army")
        let results = try! context.fetch(request)

        results.forEach { result in
            context.delete(result)
        }
    }

    // MARK: - Core Data Deleting support
    public static func deleteFactions () {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<Faction>(entityName: "Faction")
        let results = try! context.fetch(request)

        results.forEach { result in
            context.delete(result)
        }
    }

    // MARK: - Core Data Deleting support
    public static func deleteWeapons () {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<Weapon>(entityName: "Weapon")
        let results = try! context.fetch(request)

        results.forEach { result in
            context.delete(result)
        }
    }

    // MARK: - Core Data Deleting support
    public static func deleteCortex () {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<Cortex>(entityName: "Cortex")
        let results = try! context.fetch(request)

        results.forEach { result in
            context.delete(result)
        }
    }

    // MARK: - Core Data Deleting support
    public static func deleteUnit () {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<Unit>(entityName: "Unit")
        let results = try! context.fetch(request)

        results.forEach { result in
            context.delete(result)
        }
    }
}
