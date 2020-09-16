//
//  FactionPicker.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI
import os

struct FactionPicker: View {
    private let logger = Logger(subsystem: "VoidBarracks", category: "FactionPicker")
    @FetchRequest(entity: Store.entity(), sortDescriptors: []) var stores: FetchedResults<Store>
    @Environment(\.managedObjectContext) private var context

    var body: some View {
        NavigationView {
            VStack{
                if let stores = stores {
                    if let store = stores.first {
                        if store.updateAvailable {
                            updateButton
                        }
                        if let viewModels = store.viewModelsArray {
                            ForEach(viewModels, id:\.id) { viewModel in
                                LazyLoad(FactionCell(viewModel: viewModel)
                                            .accentColor(Color("color.\(viewModel.shortName!)")))
                            }
                        }
                    }
                    else {
                        ProgressView {
                            Text("Updating...")
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }


            }
            .padding()
            .frame(maxHeight: .infinity)
            .background(Color.gray.opacity(0.2))
        }

    }

    var updateButton: some View {
        Button(action: {
            PersistentCloudKitContainer.deleteStore()
            PersistentCloudKitContainer.deleteRules()
            PersistentCloudKitContainer.deleteFactions()
            PersistentCloudKitContainer.deleteWeapons()
            PersistentCloudKitContainer.deleteCortex()
            PersistentCloudKitContainer.deleteUnit()
            
            sleep(4)
            let warcasterStore = WarcasterStore(context)
            warcasterStore.updateStore()
            logger.notice("UPDATING")
        }, label: {
            HStack {
                Image(systemName: "arrow.2.circlepath")
                Text("Update Available")
            }.padding()
        })
    }
}

struct FactionCell: View {
    var viewModel: ArmyViewModel
    @State private var isActive = false

    var body: some View {
        NavigationLink(destination: ArmyBuilder(viewModelId: viewModel.id!, factionId: viewModel.factionId!, isActive: $isActive)
                        .accentColor(Color("color.\(viewModel.shortName!)")),
                       isActive: $isActive) {

            Cell(armyName: viewModel.fullName!, shortName: viewModel.shortName!)
        }
        .navigationBarTitle(Text("Recruit"))
        .shadow(color: Color.gray.opacity(0.2), radius: 10, x: -5, y: -5)
        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 10, y: 10)
    }
}

struct Cell: View {
    var armyName: String
    var shortName: String

    var body: some View {
            HStack {
                Image("logo.\(shortName)")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 45, height: 45, alignment: .center)
//                Text("\(armyName)")
//                    .padding()
//                    .font(.system(size: 15))
//                    .foregroundColor(.white)


            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor.opacity(1.0))
            .cornerRadius(10)
            .padding()
    }

}
