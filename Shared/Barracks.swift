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
            if let user = users.first, let armies = (user.armies as! Set<Army>).sorted{$0.lastModified! < $1.lastModified!} {
                if (armies.isEmpty) {
                    HStack {
                        Spacer()
                        Text("No Armies Found")
                        Spacer()
                    }
                } else {
                    ForEach(armies, id:\.self) { army in
                        BarracksCell(armyId: army.id!, armyName: army.name!, customName: army.customName!, shortName: army.shortName!, lastModified: army.lastModified!)
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
        .listStyle(InsetListStyle())
    }
}

struct BarracksCell: View {
    var armyId: String
    var armyName: String
    var customName: String
    var shortName: String
    var lastModified: Date
    private let dateFormatter = DateFormatter()
    @State private var isActive: Bool = false

    var body: some View {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return NavigationLink(destination: LazyLoad(ArmyBuilder(armyId: armyId, isActive: $isActive)
                                                .accentColor(Color("color.\(shortName)"))),
                       isActive: $isActive) {

                if customName == "" {
                    Label {
                        VStack(alignment: .leading) {
                            Text("\(armyName)")
                                .font(.title2)
                            Text("\(dateFormatter.string(from: lastModified))")
                                .font(.caption)
                        }
                    } icon: {
                        Image("logo.\(shortName)")
                            .resizable()
                            .frame(width: 45, height: 45, alignment: .center)
                            .padding(30)
                    }
                } else {
                    Label {
                        VStack(alignment: .leading) {
                            Text("\(customName)")
                                .font(.title2)
                            Text("\(dateFormatter.string(from: lastModified))")
                                .font(.caption)
                        }

                    } icon: {
                        Image("logo.\(shortName)")
                            .resizable()
                            .frame(width: 45, height: 45, alignment: .center)
                            .padding(30)
                    }
                }


        }
    }
}
