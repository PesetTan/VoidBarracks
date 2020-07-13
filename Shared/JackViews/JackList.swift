//
//  JackList.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct JackList: View {
    var jacks: [JackViewModel]
    @Binding var refresh: Bool
    
    var body: some View {
        ForEach(jacks, id:\.id) { viewModel in

            if viewModel.uuid != nil {
                JackCell(viewModel: viewModel, refresh: $refresh)
                    .customCell()
                    .foregroundColor(.primary)

                CustomJackList(customJacks: viewModel.customJackViewModelsArray, refresh: $refresh)
                    .frame(height: 70 * CGFloat(viewModel.customJackViewModelsArray.count)).animation(.default)
            }
        }
    }
}

struct CustomJackList: View {
    var customJacks: [JackViewModel]
    @Binding var refresh: Bool
    @Environment(\.managedObjectContext) private var context

    var body: some View {
        List {
            ForEach(customJacks, id:\.uuid) { jack in
                UnitCell(viewModel: jack)
                    .customCell()
                    .foregroundColor(.accentColor)
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let jack = customJacks[index]
                    context.delete(jack)
                    refresh.toggle()
                }
            }
            .listRowBackground(Color("BackgroundColor"))
        }
    }
}
