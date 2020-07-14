//
//  AttachmentCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct AttachmentCell: View {
    @ObservedObject var viewModel: AttachmentViewModel
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var context

    var body: some View {
        if viewModel.name != nil {
            return Button {
                isPresented.toggle()
            } label: {
                HStack {
                    Text("\(viewModel.name!)").foregroundColor(.accentColor)
                    Spacer()
                    UnitSwitch(viewModel: viewModel)
                }
            }
            .sheet(isPresented: $isPresented) {
                UnitInfo(unitId: viewModel.id!, viewModelId: viewModel.uuid!, isPresented: $isPresented)
                    .environment(\.managedObjectContext, context)
            }
            .eraseToAnyView()
        } else {
            return Text("No Attachment").eraseToAnyView()
        }

    }
}
