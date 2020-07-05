//
//  JackBuilder.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct JackBuilder: View {
    var jackId: String
    @Binding var isActive: Bool
    @Binding var refresh: Bool
    @State var isPresented: Bool = false

    @FetchRequest(
        entity: Jack.entity(),
        sortDescriptors: []
    ) var jacks: FetchedResults<Jack>

    var body: some View {
        let jack = jacks.first{$0.uuid == jackId}!
        return VStack {
            if let jack = jack {
                Form {
//                    Section {
//                        JackNameField(jack: jack)
//                    }

                    Section(header: cortexHeader) {
                        if let cortexes = (jack.optionsForCortex as! Set<Cortex>) {
                            CortexList(cortexes: cortexes, jack: jack)
                        }
                    }

                    if let weapons = (jack.optionsForArm1 as! Set<Weapon>), !weapons.isEmpty {
                        Section(header:arm1Header) {
                            JackWeaponList(weapons: weapons, jack: jack)
                        }
                    }

                    if let weapons = (jack.optionsForArm2 as! Set<Weapon>), !weapons.isEmpty {
                        Section(header: arm2Header) {
                            JackWeaponList(weapons: weapons, jack: jack)
                        }
                    }

                    if let weapons = (jack.optionsForShoulder1 as! Set<Weapon>), !weapons.isEmpty {
                        Section(header: shoulder1Header) {
                            JackWeaponList(weapons: weapons, jack: jack)
                        }
                    }

                    if let weapons = (jack.optionsForShoulder2 as! Set<Weapon>), !weapons.isEmpty {
                        Section(header: shoulder2Header) {
                            JackWeaponList(weapons: weapons, jack: jack)
                        }
                    }

                    Section(header: saveHeader) {
                        SaveJackButton(jackId: jack.uuid!, isActive: $isActive)
                    }
                }
            }
        }
        .navigationTitle(Text("\(jack.name ?? "Missing Name")"))
        .navigationBarItems(trailing: UnitInfoButton(unit: jack, isPresented: $isPresented))
        .onAppear { refresh = false }
        .onDisappear { refresh = true }
    }

    var cortexHeader: some View {
        let jack = jacks.first{$0.uuid == jackId}!

        return HStack {
            Text("Cortex")
            Spacer()

            if (jack.optionsForCortex as! Set<Cortex>).filter{$0.selected}.count == 0 {
                Text("Select a cortex")
            }
        }
    }

    var arm1Header: some View {
        let jack = jacks.first{$0.uuid == jackId}!

        return HStack {
            Text("Arm 1")
            Spacer()

            if (jack.optionsForArm1 as! Set<Weapon>).filter{$0.selected}.count == 0 {
                Text("Equip Arm 1")
            } else if (jack.remainingPoints > 0) {
                Text("\(jack.remainingPoints)/\(jack.weaponPoints) points available")
            } else if (jack.remainingPoints < 0) {
                if jack.remainingPoints * -1 == 1{
                    Text("\(jack.remainingPoints * -1) point over the limit")
                } else {
                    Text("\(jack.remainingPoints * -1) points over the limit")
                }            }
        }
    }

    var arm2Header: some View {
        let jack = jacks.first{$0.uuid == jackId}!

        return HStack {
            Text("Arm 1")
            Spacer()

            if (jack.optionsForArm2 as! Set<Weapon>).filter{$0.selected}.count == 0 {
                Text("Equip Arm 2")
            } else if (jack.remainingPoints > 0) {
                Text("\(jack.remainingPoints)/\(jack.weaponPoints) points available")
            } else if (jack.remainingPoints < 0) {
                if jack.remainingPoints * -1 == 1{
                    Text("\(jack.remainingPoints * -1) point over the limit")
                } else {
                    Text("\(jack.remainingPoints * -1) points over the limit")
                }            }
        }
    }

    var shoulder1Header: some View {
        let jack = jacks.first{$0.uuid == jackId}!

        return HStack {
            Text("Shoulder 1")
            Spacer()

            if (jack.optionsForShoulder1 as! Set<Weapon>).filter{$0.selected}.count == 0 {
                Text("Equip Shoulder 1")
            } else if (jack.remainingPoints > 0) {
                Text("\(jack.remainingPoints)/\(jack.weaponPoints) points available")
            } else if (jack.remainingPoints < 0) {
                if jack.remainingPoints * -1 == 1{
                    Text("\(jack.remainingPoints * -1) point over the limit")
                } else {
                    Text("\(jack.remainingPoints * -1) points over the limit")
                }
            }
        }
    }

    var shoulder2Header: some View {
        let jack = jacks.first{$0.uuid == jackId}!

        return HStack {
            Text("Shoulder 2")
            Spacer()

            if (jack.optionsForShoulder2 as! Set<Weapon>).filter{$0.selected}.count == 0 {
                Text("Equip Shoulder 2")
            } else if (jack.remainingPoints > 0) {
                Text("\(jack.remainingPoints)/\(jack.weaponPoints) points available")
            } else if (jack.remainingPoints < 0) {
                if jack.remainingPoints * -1 == 1{
                    Text("\(jack.remainingPoints * -1) point over the limit")
                } else {
                    Text("\(jack.remainingPoints * -1) points over the limit")
                }
            }
        }
    }

    var saveHeader: some View {
        let jack = jacks.first{$0.uuid == jackId}!

        return VStack{
            HStack {
                if (jack.remainingPoints < 0) {
                    Spacer()
                    Text("Weapon Points Exceed Limit").foregroundColor(.red)
                    Spacer()
                }
            }
            HStack {
                if ((jack.optionsForCortex as! Set<Cortex>).filter{$0.selected}.count == 0) {
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
    var jackId: String
    @Binding var isActive: Bool
    @Environment(\.managedObjectContext) var context

    @FetchRequest(
        entity: Jack.entity(),
        sortDescriptors: []
    ) var jacks: FetchedResults<Jack>

    var body: some View {
        HStack {
            Spacer()
            Button {
                let jack = jacks.first{$0.uuid == jackId}!
                jack.addToCustomJacks(jack.copy())
                isActive = false
            } label: {
                Text("Save")
            }
            Spacer()
        }
    }
}

