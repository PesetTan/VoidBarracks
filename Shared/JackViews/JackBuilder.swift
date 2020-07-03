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
        let jack = (jacks.first{$0.uuid == jackId})
        return VStack {
            if let jack = jack {
                Form {
                    Section {
                        JackNameField(jack: jack)
                    }

                    Section(header: Text("Cortex")) {
                        if let cortexes = (jack.optionsForCortex as! Set<Cortex>) {
                            CortexList(cortexes: cortexes)
                        }
                    }

                    if let weapons = (jack.optionsForArm1 as! Set<Weapon>), !weapons.isEmpty {
                        Section(header: Text("Arm 1")) {
                            JackWeaponList(weapons: weapons)
                        }
                    }

                    if let weapons = (jack.optionsForArm2 as! Set<Weapon>), !weapons.isEmpty {
                        Section(header: Text("Arm 2")) {
                            JackWeaponList(weapons: weapons)
                        }
                    }

                    if let weapons = (jack.optionsForShoulder1 as! Set<Weapon>), !weapons.isEmpty {
                        Section(header: Text("Shoulder 1")) {
                            JackWeaponList(weapons: weapons)
                        }
                    }

                    if let weapons = (jack.optionsForShoulder2 as! Set<Weapon>), !weapons.isEmpty {
                        Section(header: Text("Shoulder 2")) {
                            JackWeaponList(weapons: weapons)
                        }
                    }

                    Section {
                        SaveJackButton(jackId: jack.uuid!, isActive: $isActive)
                    }
                }
            }
        }
        .navigationTitle(Text("\(jack?.name! ?? "Missing Name") \(jack?.weaponPoints ?? 0)"))
        .navigationBarItems(trailing: JackInfoButton(jack: jack, isPresented: $isPresented))
        .onAppear { refresh = false }
        .onDisappear { refresh = true }
    }
}

struct JackNameField: View{
    var jack: Jack

    var body: some View {
        TextField("Custom Jack Name", text: Binding<String>(
        get: { jack.customName ?? "" },
        set: {
            jack.customName = $0
        })) { changed in
            if changed {
                print("chenged")
            }
        } onCommit: {
            print("committed")
        }
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

struct JackInfoButton: View {
    var jack: Jack?
    @Binding var isPresented: Bool

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Image(systemName: "info")
        }
        .sheet(isPresented: $isPresented) {
            if jack != nil && jack!.uuid != nil {
                JackInfo(jack: jack!, isPresented: $isPresented)
            }
        }
    }
}

