//
//  Barracks.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct Barracks: View {

    var body: some View {
        NavigationView {
            BarrackArmies()
                .navigationTitle("Barracks")
        }

    }
}

struct BarrackArmies: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: []) private var users: FetchedResults<User>
    @Environment(\.managedObjectContext) private var context

    var body: some View {
        List {
            if let user = users.first, let armies = (user.armies as! Set<Army>).sorted{$0.name! < $1.name!} {
                if (armies.isEmpty) {
                    HStack {
                        Spacer()
                        Text("No Armies Found")
                        Spacer()
                    }

                } else {
                    ForEach(armies, id:\.self) { army in
                        BarracksCell(armyId: army.id!, armyName: army.name!, customName: army.customName!)
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let army = armies[index]
                            context.delete(army)
                        }
                        try! context.save()
                    }
                }

            }
        }
    }
}

struct BarracksCell: View {
    var armyId: String
    var armyName: String
    var customName: String
    @State private var isActive: Bool = false

    var body: some View {
        NavigationLink(destination: LazyLoad(ArmyBuilder(armyId: armyId, isActive: $isActive)),
                       isActive: $isActive) {

            if customName == "" {
                Text("\(armyName)")
            } else {
                Text("\(customName)")
            }

        }
    }
}
