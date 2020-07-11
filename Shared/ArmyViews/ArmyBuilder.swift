//
//  ArmyBuilderFromBarracks.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI
import CoreData

struct ArmyBuilder: View {
    var fetchRequest: FetchRequest<Army>
    var army: Army {
        fetchRequest.wrappedValue.first ?? Army()
    }
    @Binding var isActive: Bool
    @State var refresh: Bool = true

    init(armyId: String, isActive: Binding<Bool>) {
        let predicate = NSPredicate(format: "id == %@", armyId)
        self.fetchRequest = FetchRequest(entity: Army.entity(), sortDescriptors: [], predicate: predicate)
        self._isActive = isActive
    }

    var body: some View {

        return ScrollView {
            if refresh {
                EmptyView()
            } else {
                EmptyView()
            }

            if let army = army {
                Section {
                    nameField .customCell()
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 20)

                GamePicker(army: army)
                    .customCell()
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .padding(.bottom, 20)

                VStack {
                    if army.gameType == "Normal Game" {
                        HeroSection(army: army)
                    }
                }
                .padding(.bottom, 20)


                VStack {
                    Section(header: soloHeader) {
                        SoloList(solos: army.solosArray)
                            .environmentObject(army)
                            .customCell()
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 20)


                VStack {
                    Section(header: jackHeader) {
                        JackList(jacks: army.jacksArray, refresh: $refresh)
                            .environmentObject(army)
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 20)


                VStack {
                    Section(header: squadHeader) {
                        SquadList(squads: army.squadsArray, refresh: $refresh)
                            .environmentObject(army)
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 20)


                VStack {
                    Section (header: rackHeader, footer: rackStats) {
                        RackBuilder()
                            .environmentObject(army)
                            .customCell()
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 20)

                Section(footer: Text("Recruit will also save to clipboard.").font(.caption))  {
                    SaveArmyButton(army: army, isActive: $isActive)
                        .customCell()
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                .navigationBarTitle(Text("\(army.name!)"))
            }
        }
        .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
    }

    var rackStats: some View {
        let rack = army.rack!
        return HStack {
            Spacer()
            Text("F:\(rack.furyCount)  G:\(rack.geometricCount)  H:\(rack.harmonicCount)  O:\(rack.overdriveCount)")
                .font(.footnote)
            Spacer()
        }.padding()
    }

    var rackHeader: some View {
        let rack = army.rack!
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



    var soloHeader: some View {
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
        return TextField("Custom Army Name", text: Binding<String>(
                    get: { army.customName ?? "" },
                    set: { army.customName = $0 }
                    )) { changed in
            if changed {
                print("chenged")
            }
        } onCommit: {
            print("committed")
        }
    }
}
