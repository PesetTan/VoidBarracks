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
                    nameField
                }

                Section(header: heroHeader) {
                    if let heros = (army.heros as! Set<Hero>) {
                        HeroList(heros: heros.sorted{$0.name! < $1.name!})
                    }
                }

                Section(header: soloHeader) {
                    if let solos = (army.solos as! Set<Solo>) {
                        SoloList(solos: solos.sorted{$0.name! < $1.name!})
                    }
                }

                Section(header: jackHeader) {
                    if let jacks = (army.jacks as! Set<Jack>) {
                        JackList(jacks: jacks.sorted{$0.name! < $1.name!}, refresh: $refresh)
                    }
                }

                Section(header: squadHeader) {
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

    var heroHeader: some View {
        HStack{
            Image(systemName: "star")
            Text("Heros")
        }
    }

    var soloHeader: some View {
        HStack{
            Image(systemName: "person")
            Text("Solos")
        }
    }

    var jackHeader: some View {
        HStack{
            Image(systemName: "wrench")
            Text("'Jacks")
        }
    }

    var squadHeader: some View {
        HStack{
            Image(systemName: "person.3")
            Text("Squads")
        }
    }

    var nameField: some View {
        let army = (armies.first{$0.id == armyId})

        return TextField("Custom Army Name", text: Binding<String>(
                            get: { army!.customName ?? "" },
                    set: {
                        army!.customName = $0
                    })) { changed in
            if changed {
                print("chenged")
            }
        } onCommit: {
            print("committed")
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
                Text("Recruit")
            }
            Spacer()
        }
    }
}
