//
//  FactionPicker.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct FactionPicker: View {
    @FetchRequest(entity: Store.entity(), sortDescriptors: []) var store: FetchedResults<Store>

    var body: some View {
        NavigationView {
            List {
                if let factions = (store.first!.factions as! Set<Army>) {
                    ForEach(factions.sorted{$0.name! < $1.name!}, id:\.id) { army in
                        if let army = army {
                            FactionCell(army: army).accentColor(Color("color.\(army.shortName!)"))
                        }

                    }
                }
            }
            .listStyle(InsetListStyle())
        }
    }
}

struct FactionCell: View {
    var army: Army
    @State private var isActive = false

    var body: some View {
        NavigationLink(destination: ArmyBuilder(armyId: army.id!, isActive: $isActive)
                        .accentColor(Color("color.\(army.shortName!)")),
                       isActive: $isActive) {
            Label {
                Text("\(army.name!)")
                    .padding()
                    .font(.title2)
            } icon: {
                Image("logo.\(army.shortName!)")
                    .resizable()
                    .frame(width: 45, height: 45, alignment: .center)
                    .padding(20)
            }
            .navigationBarTitle(Text("Recruit"))
        }
    }
}
