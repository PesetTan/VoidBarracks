//
//  SquadList.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct SquadList: View {
    var squadsViewModels: [SquadViewModel]
    @Binding var refresh: Bool
    
    var body: some View {
        ForEach(squadsViewModels, id:\.id) { viewModel in
            if viewModel.uuid != nil {
                SquadCell(viewModel: viewModel, refresh: $refresh)
                    .customCell()
                    .foregroundColor(.primary)

                CustomSquadList(customSquads: viewModel.customSquadViewModelsArray, refresh: $refresh)
                    .frame(height: 70 * CGFloat(viewModel.customSquadViewModelsArray.count)).animation(.default)

            }
        }
    }
}


struct CustomSquadList: View {
    var customSquads: [UnitViewModel]
    @Binding var refresh: Bool
    @Environment(\.managedObjectContext) private var context

    var body: some View {
        List {
            ForEach(customSquads, id:\.uuid) { squad in
                UnitCell(viewModel: squad)
                    .customCell()
                    .foregroundColor(.accentColor)
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let squad = customSquads[index]
                    context.delete(squad)
                    refresh.toggle()
                }
            }
            .listRowBackground(Color("BackgroundColor"))
        }
    }
}
