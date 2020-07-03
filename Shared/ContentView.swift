//
//  ContentView.swift
//  Shared
//
//  Created by Peset Tan on 6/29/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FactionPicker().tabItem {
                Label("Recruit", systemImage: "person.2")
            }

            Barracks().tabItem {
                Label("Barracks", systemImage: "house")
            }
        }
    }
}
