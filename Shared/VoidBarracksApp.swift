//
//  VoidBarracksApp.swift
//  Shared
//
//  Created by Peset Tan on 6/29/20.
//

import SwiftUI
import CoreData
//import os

@main
struct VoidBarracksApp: App {
//    @FetchRequest(entity: User.entity(), sortDescriptors: []) var user: FetchedResults<User>
    let persistantContainer = PersistentCloudKitContainer.persistentContainer

    init() {
        PersistentCloudKitContainer.deleteContext()
        let warcasterData = WarcasterData(persistantContainer)
        warcasterData.setStore()

        let context = persistantContainer.viewContext
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

        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        UITableView.appearance().separatorStyle = .none
//        UITableView.appearance().tableFooterView = UIView()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some Scene {
        return WindowGroup {
            ContentView().environment(\.managedObjectContext, persistantContainer.viewContext)
        }
    }
}
