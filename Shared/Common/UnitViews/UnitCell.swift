//
//  UnitCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct UnitCell: View {
    @ObservedObject var viewModel: UnitViewModel
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var context

    var body: some View {
        HStack {
            Button {
                isPresented.toggle()
            } label: {
                HStack {
                    unitName
                    cortexName
                }
            }
            .sheet(isPresented: $isPresented) {
                LazyLoad(UnitInfo(unitId: viewModel.id!, viewModelId: viewModel.uuid!, isPresented: $isPresented)
                            .environment(\.managedObjectContext, context)
                )
            }

            Spacer()

            if viewModel is HeroViewModel {
                UnitCounter(viewModel: viewModel, maxCount: 1)
            } else {
                UnitCounter(viewModel: viewModel, maxCount: 3)
            }
        }
    }

    var unitName: some View {
        if viewModel.name == nil {
            return Text("Missing Unit Name")
        }
        
        if viewModel.customName == nil || viewModel.customName! == "" {
            return Text(viewModel.name!)
        } else {
            return Text(viewModel.customName!)
        }
    }

    var cortexName: some View {
        if let jack = viewModel as? JackViewModel {
            if let cortex = jack.cortexOptionsArray.first(where: {$0.count > 0}) {
                return Text(cortex.name!).font(.caption)
            } else {
                return Text("")
            }
        } else {
            return Text("")
        }
    }
}
