//
//  CypherCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct CypherCell: View {
    @ObservedObject var viewModel: CypherViewModel
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var context

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack {
                Text("\(viewModel.name!)")
                Spacer()
                CypherToggle(viewModel: viewModel)
            }
        }
        .sheet(isPresented: $isPresented) {
            CypherInfo(cypherId: viewModel.id!, isPresented: $isPresented).environment(\.managedObjectContext, context)
        }
    }
}
