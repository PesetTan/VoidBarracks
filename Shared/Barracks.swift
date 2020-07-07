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
            if let user = users.first, let armies = (user.armies as! Set<Army>).sorted{$0.lastModified! > $1.lastModified!} {
                if (armies.isEmpty) {
                    HStack {
                        Spacer()
                        Text("No Armies Found")
                        Spacer()
                    }
                } else {
                    ForEach(armies, id:\.self) { army in
                        LazyLoad(BarracksCell(army: army))
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let army = armies[index]
                            context.delete(army)
                        }
                        try! context.save()
                    }
                }

            } else {
                VStack {
                    Spacer()
                    Text("No User Found")
                    Spacer()
                }
            }
        }
        .listStyle(InsetListStyle())
    }
}

struct BarracksCell: View {
    @ObservedObject var army: Army
    private let dateFormatter = DateFormatter()
    @State private var isActive: Bool = false

    var body: some View {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return NavigationLink(destination: ArmyBuilder(armyId: army.id!, isActive: $isActive)
                                .accentColor(Color("color.\(army.shortName!)")),
                       isActive: $isActive) {

            if army.customName! == "" {
                Label {
                    VStack(alignment: .leading) {
                        Text("\(army.name!)")
                            .font(.title2)
                        Text("\(dateFormatter.string(from: army.lastModified!))")
                            .font(.caption)
                    }
                } icon: {
                    Image("logo.\(army.shortName!)")
                        .resizable()
                        .frame(width: 45, height: 45, alignment: .center)
                        .padding(30)
                }
            } else {
                Label {
                    VStack(alignment: .leading) {
                        Text("\(army.customName!)")
                            .font(.title2)
                        Text("\(dateFormatter.string(from: army.lastModified!))")
                            .font(.caption)
                    }

                } icon: {
                    Image("logo.\(army.shortName!)")
                        .resizable()
                        .frame(width: 45, height: 45, alignment: .center)
                        .padding(30)
                }
            }
        }
    }
}
