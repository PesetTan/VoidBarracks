//
//  ArmyBuilderFromBarracks.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI
import CoreData

struct ArmyBuilder: View {
    var armyFetchRequest: FetchRequest<Army>
    var army: Army? {
        armyFetchRequest.wrappedValue.first ?? nil
    }

    var viewModelFetchRequest: FetchRequest<ArmyViewModel>
    var viewModel: ArmyViewModel? {
        viewModelFetchRequest.wrappedValue.first ?? nil
    }

    @Binding var isActive: Bool
    @State var refresh: Bool = true

    init(viewModelId: String, factionId: String, isActive: Binding<Bool>) {
        let viewModelPredicate = NSPredicate(format: "id == %@", viewModelId)
        self.viewModelFetchRequest = FetchRequest(entity: ArmyViewModel.entity(), sortDescriptors: [], predicate: viewModelPredicate)

        let armyPredicate = NSPredicate(format: "factionId == %@", factionId)
        self.armyFetchRequest = FetchRequest(entity: Army.entity(), sortDescriptors: [], predicate: armyPredicate)
        
        self._isActive = isActive
    }

    var body: some View {
        ScrollView {
            if refresh {
                EmptyView()
            } else {
                EmptyView()
            }

            if let viewModel = viewModel {
                Section {
                    nameField
                        .customCell()
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 20)

                GamePicker(viewModel: viewModel)
                    .customCell()
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .padding(.bottom, 20)

                unitsView

                VStack {
                    Section (header: rackHeader, footer: rackStats) {
                        RackBuilder()
                            .environmentObject(viewModel)
                            .customCell()
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 20)

                Section(footer: Text("Recruit will also save to clipboard.").font(.caption))  {
                    SaveArmyButton(viewModel: viewModel, isActive: $isActive)
                        .customCell()
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                .navigationBarTitle(Text("\(viewModel.fullName!)"))
            }
        }
        .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
    }

    var unitsView: some View {
        if let viewModel = viewModel {
            return VStack {
                VStack {
                    if viewModel.gameType == "Normal Game" {
                        HeroSection(viewModel: viewModel)
                    }
                }
                .padding(.bottom, 20)


                VStack {
                    Section(header: soloHeader) {
                        SoloList(viewModels: viewModel.solosViewModelsArray)
                            .environmentObject(viewModel)
                            .customCell()
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 20)


                VStack {
                    Section(header: jackHeader) {
                        JackList(jacks: viewModel.jacksViewModelsArray, refresh: $refresh)
                            .environmentObject(viewModel)
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 20)


                VStack {
                    Section(header: squadHeader) {
                        SquadList(squadsViewModels: viewModel.squadsViewModelsArray, refresh: $refresh)
                            .environmentObject(viewModel)
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 20)
            }
            .eraseToAnyView()
        } else {
            return Text("ERROR").eraseToAnyView()
        }
    }

    var rackStats: some View {
        HStack {
            if let army = army, let rack = army.rack {
                Spacer()
                Text("F:\(rack.furyCount)  G:\(rack.geometricCount)  H:\(rack.harmonicCount)  O:\(rack.overdriveCount)")
                    .font(.footnote)
                Spacer()
            }
        }.padding()
    }

    var rackHeader: some View {
        HStack{
            if let army = army, let rack = army.rack {
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
    }



    var soloHeader: some View {
        HStack{
            if let army = army {
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
    }

    var jackHeader: some View {
         HStack{
            if let army = army {
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
    }

    var squadHeader: some View {
        HStack{
            if let army = army {
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
    }

    var nameField: some View {
        VStack {
            if let viewModel = viewModel {
                TextField("Custom Army Name", text: Binding<String>(
                    get: { viewModel.customName ?? "" },
                    set: { viewModel.customName = $0 }
                )) { changed in
                    if changed {
                        print("chenged")
                    }
                } onCommit: {
                    print("committed")
                }
            }
        }
    }
}
