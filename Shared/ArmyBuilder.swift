//
//  ArmyBuilderFromBarracks.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI
import CoreData

struct ArmyBuilder: View {
    var armyId: String
    @Binding var isActive: Bool
    @State var refresh: Bool = true

    @FetchRequest(
        entity: Army.entity(),
        sortDescriptors: []
    ) var armies: FetchedResults<Army>

    var body: some View {
        let army = (armies.first{$0.id == armyId})
        return Form {
            if refresh {
                EmptyView()
            } else {
                EmptyView()
            }
            
            if let army = army {
                Section {
                    if let heros = (army.heros as! Set<Hero>) {
                        HeroList(heros: heros.sorted{$0.name! < $1.name!})
                    }
                }

                Section {
                    if let solos = (army.solos as! Set<Solo>) {
                        SoloList(solos: solos.sorted{$0.name! < $1.name!})
                    }
                }

                Section {
                    if let jacks = (army.jacks as! Set<Jack>) {
                        JackList(jacks: jacks.sorted{$0.name! < $1.name!}, refresh: $refresh)
                    }
                }

                Section {
                    if let squads = (army.squads as! Set<Squad>) {
                        SquadList(squads: squads.sorted{$0.name! < $1.name!}, refresh: $refresh)
                    }
                }

                Section {
                    if let rack = army.rack {
                        RackBuilder(rack: rack)
                    }
                }

                Section {
                    SaveArmyButton(army: army, isActive: $isActive)
                }
                .navigationBarTitle(Text("\(army.name!)"))
            }
        }
    }
}


struct SaveArmyButton: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: []) private var users: FetchedResults<User>
    @Environment(\.managedObjectContext) var context
    //    var user: User
    var army: Army
    @Binding var isActive: Bool

    var body: some View {
        HStack {
            Spacer()
            Button {
                if let user = users.first {
                    user.addToArmies(army.copy())
                    try! context.save()
                    isActive.toggle()
                }
            } label: {
                Text("Save and Copy to Clipboard")
            }
            Spacer()
        }
    }
}
