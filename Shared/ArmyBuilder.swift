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
        return ScrollView {
            if refresh {
                EmptyView()
            } else {
                EmptyView()
            }
            
            if let army = army {
                Section {
                    nameField .customCell()
                    Text("")
                    Text("")
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)

                Section(header: heroHeader) {
                    if let heros = (army.heros as! Set<Hero>) {
                        HeroList(heros: heros.sorted{$0.name! < $1.name!})
                            .environmentObject(army)
                            .customCell()
                    }
                    Text("")
                    Text("")
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)



                Section(header: soloHeader) {
                    if let solos = (army.solos as! Set<Solo>) {
                        SoloList(solos: solos.sorted{$0.name! < $1.name!})
                            .environmentObject(army)
                            .customCell()
                    }

                    Text("")
                    Text("")
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)



                Section(header: jackHeader) {
                    if let jacks = (army.jacks as! Set<Jack>) {
                        JackList(jacks: jacks.sorted{$0.name! < $1.name!}, refresh: $refresh)
                            .environmentObject(army)
                    }

                    Text("")
                    Text("")
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)



                Section(header: squadHeader) {
                    if let squads = (army.squads as! Set<Squad>) {
                        SquadList(squads: squads.sorted{$0.name! < $1.name!}, refresh: $refresh)
                            .environmentObject(army)
                    }

                    Text("")
                    Text("")
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)



                Section (header: rackHeader, footer: rackStats) {
                    RackBuilder()
                        .environmentObject(army)
                        .customCell()
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)

                Section  {
                    SaveArmyButton(army: army, isActive: $isActive)
                        .customCell()
                }
                .padding(10)
                .navigationBarTitle(Text("\(army.name!)"))
            }
        }
        .background(Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all))
    }

    var rackStats: some View {
        let rack = armies.first{$0.id == armyId}!.rack!
        return HStack {
            Spacer()
            Text("F:\(rack.furyCount)  G:\(rack.geometricCount)  H:\(rack.harmonicCount)  O:\(rack.overdriveCount)")
                .font(.footnote)
            Spacer()
        }.padding()
    }

    var rackHeader: some View {
        let rack = armies.first{$0.id == armyId}!.rack!
        return HStack{
            Image(systemName: "book")
            Text("Rack")
            Spacer()
            let totalCypherCount = rack.furyCount + rack.geometricCount + rack.harmonicCount + rack.overdriveCount
            if totalCypherCount > 15 {
                Text("\(totalCypherCount - 15) Cyphers Over")
                    .font(.caption)
            } else {
                Text("\(totalCypherCount)/\(15) Cyphers")
                    .font(.caption)
            }

        }
    }

    var heroHeader: some View {
        let army = armies.first{$0.id == armyId}!
        return HStack{
            Image(systemName: "star")
            Text("Heros")
            Spacer()
            if army.heroCount > army.heroMax {
                if army.heroCount - army.heroMax == 1 {
                    Text("\(army.heroCount - army.heroMax) Hero Point Over")
                        .font(.caption)
                } else {
                    Text("\(army.heroCount - army.heroMax) Hero Points Over")
                        .font(.caption)
                }
            } else {
                Text("\(army.heroCount)/\(army.heroMax) Heros")
                    .font(.caption)
            }

        }
    }

    var soloHeader: some View {
        let army = armies.first{$0.id == armyId}!
        return HStack{
            Image(systemName: "person")
            Text("Solos")
            Spacer()
            if army.unitCount > army.unitMax {
                if army.unitCount - army.unitMax == 1 {
                    Text("\(army.unitCount - army.unitMax) Unit Point Over")
                        .font(.caption)
                } else {
                    Text("\(army.unitCount - army.unitMax) Unit Points Over")
                        .font(.caption)
                }
            } else {
                Text("\(army.unitCount)/\(army.unitMax) Units")
                    .font(.caption)
            }
        }
    }

    var jackHeader: some View {
        let army = armies.first{$0.id == armyId}!
        return HStack{
            Image(systemName: "wrench")
            Text("'Jacks")
            Spacer()
            if army.unitCount > army.unitMax {
                if army.unitCount - army.unitMax == 1 {
                    Text("\(army.unitCount - army.unitMax) Unit Point Over")
                        .font(.caption)
                } else {
                    Text("\(army.unitCount - army.unitMax) Unit Points Over")
                        .font(.caption)
                }
            } else {
                Text("\(army.unitCount)/\(army.unitMax) Units")
                    .font(.caption)
            }
        }
    }

    var squadHeader: some View {
        let army = armies.first{$0.id == armyId}!
        return HStack{
            Image(systemName: "person.3")
            Text("Squads")
            Spacer()
            if army.unitCount > army.unitMax {
                if army.unitCount - army.unitMax == 1 {
                    Text("\(army.unitCount - army.unitMax) Unit Point Over")
                        .font(.caption)
                } else {
                    Text("\(army.unitCount - army.unitMax) Unit Points Over")
                        .font(.caption)
                }
            } else {
                Text("\(army.unitCount)/\(army.unitMax) Units")
                    .font(.caption)
            }
        }
    }

    var nameField: some View {
        let army = (armies.first{$0.id == armyId})

        return TextField("Custom Army Name", text: Binding<String>(
                    get: { army!.customName ?? "" },
                    set: { army!.customName = $0 }
                    )) { changed in
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

//    NSPredicate(format: "someField = %d", id)
    @Environment(\.managedObjectContext) var context
    //    var user: User
    var army: Army
    @Binding var isActive: Bool

    var body: some View {
        HStack {
            Spacer()
            Button {
                print("Save Clicked")
                if let user = users.first {
                    if (user.armies as! Set<Army>).first(where: {$0.id == army.id}) == nil {
                        user.addToArmies(army.copy())
                        print("adding copy to armies")
                    }

                    try! context.save()
                    print("saved")
                    isActive.toggle()
                }
            } label: {
                Text("Recruit")
            }
            Spacer()
        }
    }
}
