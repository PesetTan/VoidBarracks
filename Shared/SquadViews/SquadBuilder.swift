//
//  SquadBuilder.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct SquadBuilder: View {
    var squadId: String
    @Binding var isActive: Bool
    @Binding var refresh: Bool
    @State var isPresented: Bool = false

    @FetchRequest(
        entity: Squad.entity(),
        sortDescriptors: []
    ) var squads: FetchedResults<Squad>

    var body: some View {
        let squad = (squads.first{$0.uuid == squadId})
        return VStack {
            if let squad = squad {
                Form {
                    Section {
                        SquadNameField(squad: squad)
                    }

                    Section(header: Text("Attachments")) {
                        if let attachments = (squad.attachments as! Set<Attachment>) {
                            AttachmentList(attachments: attachments)
                        }
                    }

                    Section {
                        SaveSquadButton(squad: squad, isActive: $isActive)
                    }
                }
            }
        }
        .navigationTitle(Text("\(squad?.name! ?? "Missing Name")"))
        .navigationBarItems(trailing: UnitInfoButton(unit: squad, isPresented: $isPresented))
        .onAppear { refresh = false }
        .onDisappear { refresh = true }
    }
}

struct SquadNameField: View{
    var squad: Squad

    var body: some View {
        TextField("Custom Squad Name", text: Binding<String>(
                    get: { squad.customName ?? "" },
                    set: {
                        squad.customName = $0
                    })) { changed in
            if changed {
                print("chenged")
            }
        } onCommit: {
            print("committed")
        }
    }
}


struct SaveSquadButton: View {
    var squad: Squad
    @Binding var isActive: Bool
    @Environment(\.managedObjectContext) var context

    var body: some View {
        HStack {
            Spacer()
            Button {
                squad.addToCustomSquads(squad.copy())
                isActive = false
            } label: {
                Text("Save")
            }
            Spacer()
        }
    }
}
