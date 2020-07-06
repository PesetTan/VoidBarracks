//
//  FactionPicker.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct FactionPicker: View {
    @FetchRequest(entity: Store.entity(), sortDescriptors: []) var stores: FetchedResults<Store>

    var body: some View {
        NavigationView {
            VStack{
                if let stores = stores {
                    if let store = stores.first {
                        if let army = (store.armies as! Set<Army>) {
                            ForEach(army.sorted{$0.name! < $1.name!}, id:\.id) { army in
                                if let army = army {
                                    LazyLoad(FactionCell(army: army).accentColor(Color("color.\(army.shortName!)")))
                                }

                            }
                        }
                    }
                }

            }
            .frame(maxHeight: .infinity)
//            .background(Color(UIColor.systemBackground))
            .background(Color.gray.opacity(0.2))
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
        .shadow(color: Color.gray.opacity(0.2), radius: 10, x: -5, y: -5)
        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 10, y: 10)
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
                    .foregroundColor(.white)
            } icon: {
                Image("logo.\(shortName)")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 45, height: 45, alignment: .center)
            }
        }
        
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.accentColor.opacity(0.7))
        .cornerRadius(10)
        .padding()
    }

}
