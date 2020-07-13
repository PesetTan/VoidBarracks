//
//  SquadBuilder.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct SquadBuilder: View {
    var fetchRequest: FetchRequest<SquadViewModel>
    var squadViewModel: SquadViewModel {
        fetchRequest.wrappedValue.first ?? SquadViewModel()
    }
    @Binding var isActive: Bool
    @Binding var refresh: Bool
    @State var isPresented: Bool = false

    init(squadId: String, isActive: Binding<Bool>, refresh: Binding<Bool>) {
        let predicate = NSPredicate(format: "uuid == %@", squadId)
        self.fetchRequest = FetchRequest(entity: SquadViewModel.entity(), sortDescriptors: [], predicate: predicate)

        self._isActive = isActive
        self._refresh = refresh
    }

    var body: some View {
        VStack {

            Form {
                Section {
                    SquadNameField(squadViewModel: squadViewModel)
                }

                Section(header: Text("Attachments")) {
                    AttachmentList(attachments: squadViewModel.attachmentViewModelsArray)
                }

                Section {
                    SaveSquadButton(squadViewModel: squadViewModel, isActive: $isActive)
                }
            }

        }
        .navigationTitle(Text("\(squadViewModel.name ?? "Missing Name" )"))
        .navigationBarItems(trailing: UnitInfoButton(unit: squadViewModel))
        .onAppear { refresh = false }
        .onDisappear { refresh = true }
    }
}

struct SquadNameField: View{
    var squadViewModel: SquadViewModel

    var body: some View {
        TextField("Custom Squad Name", text: Binding<String>(
            get: { squadViewModel.customName ?? "" },
            set: { squadViewModel.customName = $0 }
        ))
    }
}


struct SaveSquadButton: View {
    var squadViewModel: SquadViewModel
    @Binding var isActive: Bool
    @Environment(\.managedObjectContext) var context

    var body: some View {
        HStack {
            Spacer()
            Button {
                squadViewModel.addToCustomSquadViewModels(squadViewModel.copy())
                isActive = false
            } label: {
                Text("Save")
            }
            Spacer()
        }
    }
}
