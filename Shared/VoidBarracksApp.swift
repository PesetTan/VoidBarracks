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

        _ = Timer.scheduledTimer(withTimeInterval: 900, repeats: true) { [self] timer in
            print("Timer fired!")

            let _ = WarcasterData(persistantContainer)

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
        }


        if #available(iOS 14.0, *) {
            // iOS 14 doesn't have extra separators below the list by default.
        } else {
            // To remove only extra separators below the list:
            UITableView.appearance().tableFooterView = UIView()
        }

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = UIColor.clear
    }

    var body: some Scene {
        return WindowGroup {
            ContentView().environment(\.managedObjectContext, persistantContainer.viewContext)
        }
    }
}
