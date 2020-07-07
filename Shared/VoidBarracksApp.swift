//
//  VoidBarracksApp.swift
//  Shared
//
//  Created by Peset Tan on 6/29/20.
//

import SwiftUI
import CoreData
import Combine
import os

@main
struct VoidBarracksApp: App {
    let logger = Logger(subsystem: "VoidBarracks", category: "VoidParracksApp")
    let persistantContainer = PersistentCloudKitContainer.persistentContainer


    init() {
        let storeController = StoreController(persistantContainer.viewContext)

        storeController.addNewUserIfNeeded()

        storeController.addStoreIfNeeded()

        _ = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { timer in
            storeController.checkForUpdates()
        }


//        if #available(iOS 14.0, *) {
//            // iOS 14 doesn't have extra separators below the list by default.
//        } else {
//            // To remove only extra separators below the list:
//            UITableView.appearance().tableFooterView = UIView()
//        }
//
//        // To remove all separators including the actual ones:
//        UITableView.appearance().separatorStyle = .none
//        UITableView.appearance().backgroundColor = UIColor.clear
    }

    var body: some Scene {
        return WindowGroup {
            ContentView().environment(\.managedObjectContext, persistantContainer.viewContext)
        }
    }

}
