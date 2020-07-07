//
//  StoreController.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/6/20.
//

import Foundation
import CoreData
import Combine
import os

class StoreController {
    private let logger = Logger(subsystem: "VoidBarracks", category: "StoreController")
    private var context: NSManagedObjectContext
    private var warcasterStore: WarcasterStore
    private var cancellables = Set<AnyCancellable>()
    private let updater = Updater()
    
    init(_ context : NSManagedObjectContext) {
        self.context = context
        self.warcasterStore = WarcasterStore(context)

        self.warcasterStore.$storeUpdated
            .sink{_ in self.checkForUpdates()}
            .store(in: &self.cancellables)
    }

    func checkForUpdates() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        fetchRequest.shouldRefreshRefetchedObjects = true
        let stores = try! context.fetch(fetchRequest)
        logger.notice("Stores Found: \(stores.count)")
        if let store = stores.first {
            if store.lastSourceUpdate == nil {
                store.updateAvailable = true
            } else {
                updater.Check(store.lastSourceUpdate!)
                updater.$updateAvailable
                    .sink{
                        store.updateAvailable = $0
                        self.context.refresh(store, mergeChanges: true)
                    }
                    .store(in: &self.cancellables)
            }
        }
    }

    func addNewUserIfNeeded() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let results = try! context.fetch(request) as! [User]
        if !results.isEmpty {
            results.first!.lastModified = Date()
            try! context.save()
        } else {
            let newUser: User = User(context: context)
            newUser.id = UUID().uuidString
            newUser.lastModified = Date()
            context.insert(newUser)

            try! context.save()
        }
    }

    func addStoreIfNeeded() {

        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        fetchRequest.shouldRefreshRefetchedObjects = true
        let stores = try! context.fetch(fetchRequest)
        if stores.count == 0 {
            warcasterStore.updateStore()
        }
    }
}
