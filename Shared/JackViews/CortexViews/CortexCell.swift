//
//  CortexCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct CortexCell: View {
    @ObservedObject var cortexViewModel: CortexViewModel
    @ObservedObject var jackViewModel: JackViewModel
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack{
                Text("\(cortexViewModel.name!)")
                Spacer()
                CortexToggle(count: Binding<Int16>(
                    get: { cortexViewModel.count },
                    set: { cortexViewModel.count = $0 }
                ), jackViewModel: jackViewModel)
            }
        }
        .sheet(isPresented: $isPresented) {
            CortexInfo(cortexId: cortexViewModel.id!, isPresented: $isPresented)
                .environment(\.managedObjectContext, context)
        }
    }
}
