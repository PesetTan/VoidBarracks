//
//  JackBuilder.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct JackBuilder: View {
    var fetchRequest: FetchRequest<JackViewModel>
    var jackViewModel: JackViewModel {
        fetchRequest.wrappedValue.first ?? JackViewModel()
    }
    @Binding var isActive: Bool
    @Binding var refresh: Bool
    @Environment(\.managedObjectContext) var context

    init(jackId: String, isActive: Binding<Bool>, refresh: Binding<Bool>) {
        let predicate = NSPredicate(format: "uuid == %@", jackId)
        self.fetchRequest = FetchRequest(entity: JackViewModel.entity(), sortDescriptors: [], predicate: predicate)

        self._isActive = isActive
        self._refresh = refresh
    }

    var body: some View {
            VStack {

                Form {
                    Section(header: cortexHeader) {
                        if let cortexes = jackViewModel.cortexOptionsArray {
                            ForEach(cortexes, id:\.id) { cortex in
                                CortexCell(cortexViewModel: cortex, jackViewModel: jackViewModel)
                            }
                        }
                    }

                    if jackViewModel.armCount > 0, let weapons = jackViewModel.arm1OptionsArray, !weapons.isEmpty {
                        Section(header:arm1Header) {
                            ForEach(weapons, id:\.uuid) { weapon in
                                JackWeaponCell(weaponViewModel: weapon,
                                               weaponViewModels: weapons,
                                               jackViewModel: jackViewModel)
                            }
                        }
                    }

                    if jackViewModel.armCount > 1, let weapons = jackViewModel.arm2OptionsArray, !weapons.isEmpty {
                        Section(header: arm2Header) {
                            ForEach(weapons, id:\.uuid) { weapon in
                                JackWeaponCell(weaponViewModel: weapon,
                                               weaponViewModels: weapons,
                                               jackViewModel: jackViewModel)
                            }
                        }
                    }

                    if jackViewModel.shoulderCount > 0, let weapons = jackViewModel.shoulder1OptionsArray, !weapons.isEmpty {
                        Section(header: shoulder1Header) {
                            ForEach(weapons, id:\.uuid) { weapon in
                                JackWeaponCell(weaponViewModel: weapon,
                                               weaponViewModels: weapons,
                                               jackViewModel: jackViewModel)
                            }
                        }
                    }

                    if jackViewModel.shoulderCount > 1, let weapons = jackViewModel.shoulder2OptionsArray, !weapons.isEmpty {
                        Section(header: shoulder2Header) {
                            ForEach(weapons, id:\.uuid) { weapon in
                                JackWeaponCell(weaponViewModel: weapon,
                                               weaponViewModels: weapons,
                                               jackViewModel: jackViewModel)
                            }
                        }
                    }

                    Section(header: saveHeader) {
                        SaveJackButton(viewModelId: jackViewModel.uuid!, isActive: $isActive)
                    }
                }

            }
            .navigationTitle(Text("\(jackViewModel.name ?? "Missing Name")"))
            .navigationBarItems(trailing: UnitInfoButton(unit: jackViewModel))
            .onAppear { refresh = false }
            .onDisappear { refresh = true }

    }

    var cortexHeader: some View {
        HStack {
            Text("Cortex")
            Spacer()

        }
    }

    var arm1Header: some View {
        HStack {
            Text("Arm 1")
            Spacer()

            if (jackViewModel.remainingPoints > 0) {
                Text("\(jackViewModel.remainingPoints)/\(jackViewModel.weaponPoints) points available")
            } else if (jackViewModel.remainingPoints < 0) {
                if jackViewModel.remainingPoints * -1 == 1{
                    Text("\(jackViewModel.remainingPoints * -1) point over the limit")
                } else {
                    Text("\(jackViewModel.remainingPoints * -1) points over the limit")
                }
                
            }
        }
    }

    var arm2Header: some View {
        HStack {
            Text("Arm 2")
            Spacer()

            if (jackViewModel.remainingPoints > 0) {
                Text("\(jackViewModel.remainingPoints)/\(jackViewModel.weaponPoints) points available")
            } else if (jackViewModel.remainingPoints < 0) {
                if jackViewModel.remainingPoints * -1 == 1{
                    Text("\(jackViewModel.remainingPoints * -1) point over the limit")
                } else {
                    Text("\(jackViewModel.remainingPoints * -1) points over the limit")
                }

            }
        }
    }

    var shoulder1Header: some View {
        HStack {
            Text("Shoulder 1")
            Spacer()

            if (jackViewModel.remainingPoints > 0) {
                Text("\(jackViewModel.remainingPoints)/\(jackViewModel.weaponPoints) points available")
            } else if (jackViewModel.remainingPoints < 0) {
                if jackViewModel.remainingPoints * -1 == 1{
                    Text("\(jackViewModel.remainingPoints * -1) point over the limit")
                } else {
                    Text("\(jackViewModel.remainingPoints * -1) points over the limit")
                }
            }
        }
    }

    var shoulder2Header: some View {
        HStack {
            Text("Shoulder 2")
            Spacer()

            if (jackViewModel.remainingPoints > 0) {
                Text("\(jackViewModel.remainingPoints)/\(jackViewModel.weaponPoints) points available")
            } else if (jackViewModel.remainingPoints < 0) {
                if jackViewModel.remainingPoints * -1 == 1{
                    Text("\(jackViewModel.remainingPoints * -1) point over the limit")
                } else {
                    Text("\(jackViewModel.remainingPoints * -1) points over the limit")
                }
            }
        }
    }

    var saveHeader: some View {
        VStack{
            HStack {
                if jackViewModel.remainingPoints < 0 {
                    Spacer()
                    Text("Weapon Points Exceed Limit").foregroundColor(.red)
                    Spacer()
                }
            }
            HStack {
                if jackViewModel.cortexOptionsArray.first{$0.count > 0} == nil {
                    Spacer()
                    Text("A cortex is missing").foregroundColor(.red)
                    Spacer()
                }
            }
        }
    }
}

struct JackNameField: View{
    var jack: Jack

    var body: some View {
        TextField("Custom Jack Name", text: Binding<String>(
            get: { jack.customName ?? "" },
            set: { jack.customName = $0 }
        ))
    }
}


struct SaveJackButton: View {
    var fetchRequest: FetchRequest<JackViewModel>
    var jackViewModel: JackViewModel {
        fetchRequest.wrappedValue.first ?? JackViewModel()
    }
    @Binding var isActive: Bool

    init(viewModelId: String, isActive: Binding<Bool>) {
        let predicate = NSPredicate(format: "uuid == %@", viewModelId)
        self.fetchRequest = FetchRequest(entity: JackViewModel.entity(), sortDescriptors: [], predicate: predicate)

        self._isActive = isActive
    }

    var body: some View {
        HStack {
            Spacer()
            Button {
                jackViewModel.addToCustomJackViewModels(jackViewModel.copy())
                isActive = false
            } label: {
                Text("Save")
            }
            Spacer()
        }
    }
}

