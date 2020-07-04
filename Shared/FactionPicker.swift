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
            VStack{
                if let factions = (store.first!.factions as! Set<Army>) {
                    ForEach(factions.sorted{$0.name! < $1.name!}, id:\.id) { army in
                        if let army = army {
                            FactionCell(army: army).accentColor(Color("color.\(army.shortName!)"))
                        }

                    }
                }
            }
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

            Cell(armyName: army.name!, shortName: army.shortName!)
        }
        .navigationBarTitle(Text("Recruit"))
    }
}

struct Cell: View {
    var armyName: String
    var shortName: String

    var body: some View {
        HStack {
            Label {
                Text("\(armyName)")
                    .padding()
                    .font(.title2)
            } icon: {
                Image("logo.\(shortName)")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 45, height: 45, alignment: .center)
            }
        }
        
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.accentColor.opacity(0.2))
        .cornerRadius(10)
        .padding()
        .shadow(color: .gray, radius: 10, x: 10, y: 10)
    }

}
